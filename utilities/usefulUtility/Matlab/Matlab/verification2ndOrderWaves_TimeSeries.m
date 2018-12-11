                                                                            %{
===========================================================================
VERIFICATION BETWEEN OPENFOAM AND ANALYTICAL SOLUTION (STOKES 2ND ORDER)
===========================================================================
                                                                            %}
    clc;clear all;

%	GET WAVE PROPERTIES FROM OPENFOAM FILE
	[depth,period,height,waveNumber] = readWavePropertiesFile;
    
%   WAVE PARAMETERS
    d                   = depth;
    T                   = period;
    H                   = height;
    k                   = waveNumber;
    a                   = H/2;
	omega               = 2*pi/T;
        
%   LIST ALL FOLDER RESULTS
    list                = strtrim(ls('../surfaceElevationAnyName'));
    filename            = [ '../surfaceElevationAnyName/surfaceElevation.dat'];
            
%   IMPORT OPENFOAM DATA         
    delimiterIn         = '\t';
    headerlinesIn       = 1;
    A                   = importdata(filename,delimiterIn,headerlinesIn);
    surfaceElevation    = A.data;

%   FIGURE PROPERTIES
    scrsz 	= get(0,'ScreenSize');
    hfig    = figure(   'Renderer','zbuffer', ...
                        'Position',[1 scrsz(4)/4 scrsz(3)/4 scrsz(4)/4]);
    hax     = axes('parent', hfig);
    set(hfig, 'color', 'w')
    xlabel ('x [m]')
    ylabel ('zeta [m]')
    
%   GETFRAME
	f                   = getframe(hfig);
    [im,map]            = rgb2ind(f.cdata,256,'nodither');
    im(1,1,1,20)        = 0;    
    
%   TIME SERIES PLOT
    for  n      = 2:size(surfaceElevation,1)
       
        % CLEAR AXIS
        cla
        
        % TIME
        t       = surfaceElevation(n,1);
        
        % X
        x       = surfaceElevation(1,2:end);
        
        % FREE SURFACE ELEVATION OPENFOAM
        zeta    = surfaceElevation(n,2:end);
        hLine1  = line(x, zeta,	'parent', hax, ...
                                'linestyle', '--', ...
                                'color', 'k');
        
        % FREE SURFACE ELEVATION ANALYTICAL
        sigma 	= tanh (k*d);
        theta 	= k*x - omega*t;
        ZetaAnalytical 	= a * ( cos(theta) + k * a * (3 - sigma^2) / (4 * sigma^3) * cos(2 * theta) );
        hLine2  = line(x, ZetaAnalytical,	'parent', hax, ...
                                            'color', 'k');
        
        % PLOT
        axis([0 18 -1.5*a 1.5*a])
        drawnow
        
        % GETFRAME
        f = getframe(hfig);
        im(:,:,1,n) = rgb2ind(f.cdata,map,'nodither');
                        
    end
    
    % WRITE TO GIF
    imwrite(im,map,'wavePropagation.gif','DelayTime',0,'LoopCount',5)
