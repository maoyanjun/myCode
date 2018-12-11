function [depth,period,height,waveNumber] = readWavePropertiesFile

%  	OPEN & IMPORT OPENFOAM FREE SURFACE ELEVATION FILE
    filename    = '../constant/waveProperties';
    fileID      = fopen(filename,'r');
    
%   SPECIFY SYMBOLS TO REMOVE
    remThings               = {' ';';';'(';')'};
    
%   SPECIFY VARIABLES WE WANT TO EXTRACT
 	% * Note wavenumber is vector, we only get the 1st value
	specVar                 = {'depth';'period';'height';'waveNumber'};
        
    while ~feof(fileID)    
                
        % READ ONE WHOLE LINE AT A TIME
        string                  = fgetl(fileID);
        
        % DISPLAY STRING
        ... disp(string) 
        
		% REMOVE THE SYMBOLS IN STRING
        for i = 1:numel(remThings)
            % FIND THE LOCATION OF SYMBOLS IN STRING
            expr                = remThings(i);
            [matchstart]        = cell2mat( regexpi(string,expr) );
            % REMOVE UNNECESSARY SYMBOLS
            string(matchstart)  = [];
        end
               
		% COMPARE AND GET VALUE FROM STRING         
        for i = 1:numel(specVar)
            % FIND THE VALUE OF VARIABLES
            expr                = specVar(i);
            [matchstart,~,~,~,~,~,splitstring]  = regexpi(string,expr);
            % ASSIGN THE VALUE TO VARIABLES
            if ~isempty(cell2mat(matchstart))
                temp            = splitstring{1};
                specVal(i)      = str2double(temp{2});
            end
        end
        
    end
    
%   assign variables
    depth       = specVal(1);
    period      = specVal(2);
    height      = specVal(3);
    waveNumber  = specVal(4);
    
%   CLOSE FILE
    fclose(fileID);

%   DISPLAY WAVE PROPERTIES
    displayWaveProperties(depth,period,height,waveNumber);
    
end

function displayWaveProperties(depth,period,height,waveNumber)

disp('WAVE PROPERTIES')
disp(' ')
disp(['Water depth, d        : ' num2str( depth )])
disp(['Wave period, T        : ' num2str( period )])
disp(['Wave height, H        : ' num2str( height )])
disp(['Wave number, k        : ' num2str( waveNumber )])
disp(['Wave amplitude, a     : ' num2str( height/2 )])
disp(['Wave frequency, omega : ' num2str( 2*pi/period )])
disp(['Wave steepness, ak    : ' num2str( height/2 * waveNumber )])
disp(['Dispersion, kd        : ' num2str( waveNumber * depth)])
disp(' ')

end
