clear all;
h=input('please input water depth h:');
T=input('please input wave proid T:');
D=input('please input the Cylinder Diameter');
H=input('please input the Wave Height');
Cm=input('please input the Cm');
Cd=input('please input the Cd');
rho=input('please input the rho');
b=(9.8*T^2)/(2*pi);
a=b;
L=b*tanh(2*pi/b*h);
i=1;
while i<1000;
    if((L-a)^2<0.000004)
        break;
    else
        a=L;
        L=b*tanh(2*pi/L*h);
        
    end
    i=i+1;
end
z=h+H/2;
k=2*pi/L;
gamma=rho*9.8;
fximax=Cm*(gamma*pi*D^2*k*H)/8*(cosh(k*(z+h))/cosh(k*h));
fxdmax=Cd*(gamma*D*k*H^2/4)*(cosh(k*(z+h))*cosh(k*(z+h))/cosh(k*h));
L
fximax
fxdmax
totalForce=fximax+fxdmax