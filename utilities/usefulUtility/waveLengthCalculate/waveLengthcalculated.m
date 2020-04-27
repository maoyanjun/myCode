clear all;
h=input('please input water depth h:');
T=input('please input wave proid T:');
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
L
k=2*pi/L
k
disp('按任意键继续下一组数据处理')
pause
