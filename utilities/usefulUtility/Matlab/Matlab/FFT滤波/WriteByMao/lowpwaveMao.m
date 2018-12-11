%这段例子还调用了我自己写的专门画频谱图的函数，也给出，不然得不出我的结果
D = dir('E:\MATLAB-FFT\SC20_FL20_C1\*.mat');

for i = 1 : length(D)
load(['E:\MATLAB-FFT\SC20_FL20_C1\' D(i).name]);
x=Data;
fs=20000;
t=0:0.00005:DataCount/20000;t=t';t(DataCount+1)=[];
figure;
subplot(211);plot(t,x);
subplot(212);[a,b,e]=hua_fft(x,fs);
f3=input('Please look at the picture,make sure and input the f3=:');
j=1;
 while(b(j)<f3)
     c(j)=a(j);
     d(j)=b(j);
     j=j+1;
 end
AreaOriginal=trapz(d,2*abs(c(1:j-1))/length(e));
%低通测试
% y=filter(bz1,az1,x);
y=lowp(x,2.5,f3,0.1,2,fs);
figure;
subplot(211);plot(t,y);
subplot(212);[a,b,e]=hua_fft(y,fs);
j=1;
 while(b(j)<f3)
     c(j)=a(j);
     d(j)=b(j);
     j=j+1;
 end
 AreaFilter=trapz(d,2*abs(c(1:j-1))/length(e));
error(i)=abs(AreaOriginal-AreaFilter)/AreaOriginal
end