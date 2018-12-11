 %作者：毛艳军
%时间：2016年7月15日
%单位：大连理工大学深海研究中心
%*********************************************************************%
clear;
key=input('please chose the way that you want to deal with the datas ,0 means single Data,1 means several Datas key=');%根据提示输入0,1来选择是批处理还是单个文件处理
%********批处理部分*********************************************%
if key==1
D = dir('E:\MATLAB-FFT\SC20_FL20_C1\*.mat');%读取文件夹地址和内部文件后缀，使用时需手动修改
for i = 1 : length(D)%对文件夹中文件进行循环读取

load(['E:\MATLAB-FFT\SC20_FL20_C1\' D(i).name]);%按照i的顺序载入文件
filename=D(i).name;%下面三行为字符串处理，获取文件名
filename%显示文件名
filename(end-3:end)=[];%消除文件名中的后缀.mat
x=Data;%变量重命名
fs=20000;
t=0:0.00005:length(Data)/20000;t=t';t(length(Data)+1)=[];%根据采样频率设计计算出离散时间数组，时程曲线横坐标
[pksOriginal,locs]=findpeaks(x,'minpeakdistance',24000,'MINPEAKHEIGHT',0.0);%详见程序说明
figure;
subplot(211);plot(t,x);
ylabel('幅值');xlabel('时间');title('sway历时线');
hold on;
plot(locs/fs,pksOriginal,'rp');%应用返回值在时程曲线上标记峰值，红色五角星
subplot(212);
[area,h,y_f]=hua_fft(x,fs);%能量谱的绘制，在子程序内部绘图，幅值谱的平方表示能量谱
h;
%[pksFFTOriginal,locsFFT]=findpeaks(h);可寻找能量谱峰值，暂时未处理好
saveas(gcf,['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(filename),'original.fig']);%应用文件名加original.fig，保存输出图形，保存位置手动设置
f1=input('Please look at the picture,make sure and input the f1= （reference data 2.5） ');%参数输入含义见程序说明
f3=input('f3= （reference data 3.0） ');
rp=input('rp= （reference data 0.1）');%应用hann窗时可注释掉本行
rs=input('rs= （reference data 2.0）');%应用hann窗时可注释掉本行
AreaOriginal=area;%显示滤波前能量谱面积
%*********为对截至频率之前部分进行积分***********%
%j=1;
 %while(b(j)<f1)
  %   c(j)=a(j);
   %  d(j)=b(j);
    % j=j+1;
 %end
%areasss=area(b,2*abs(a(1:g/2))/length(e))%为自编面积积分程序
%AreaOriginalData=trapz(b,2*abs(a(1:g/2))/length(e))
%AreaOriginal=trapz(d,2*abs(c(1:j-1))/length(e))
%c=[];%使用时注意程序的初始化和释放数组
%d=[];
%***********************低通测试**********************%
% y=filter(bz1,az1,x);
y=lowp(x,f1,f3,rp,rs,fs);%应用切比雪夫I进行滤波f1=2.5,f3=3.0,rp=0.1,rs=2.0
%y=hamingFirlowp(x,f1,f3,fs);%应用hanning窗进行滤波
figure;
subplot(211);plot(t,y);%滤波后时程曲线
ylabel('幅值');xlabel('时间');title('sway历时线（afterFilter）');
%yy=y(70000:length(t));%可用于指定时间开始寻找峰值
[pksFilter,locsFilter]=findpeaks(y,'minpeakdistance',24000,'MINPEAKHEIGHT',0.0);
hold on;
plot(locsFilter/fs,pksFilter,'rp');
[mi,MAX,c,C,d,D]=FindHalfPeak(pksFilter,t,locsFilter);%寻找1/2峰值和1/5峰值
plot(locsFilter(c)/fs,pksFilter(c),'ys');%标记1/2峰值位置
plot(locsFilter(d)/fs,pksFilter(d),'g>');%标记1/5峰值位置
subplot(212);
[area,h]=hua_fft(y,fs);
%[pksFFTFilter,locsFFTFilter]=findpeaks(h);无用
saveas(gcf,['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(filename),'Filter.fig']);
AreaFilter=area;
%j=1;
 %while(b(j)<f1)
  %   c(j)=a(j);
   %  d(j)=b(j);
    % j=j+1;
%end
 %AreaFilterData=trapz(b,2*abs(a(1:g/2))/length(e))
 %AreaFilter=trapz(d,2*abs(c(1:j-1))/length(e))
% c=[];%清空数组
 %d=[];%清空数组
 for k=1:1:length(locs)
 errorPeak(k)=(y(locs(k))-pksOriginal(k))/pksOriginal(k);%用于计算滤波前和滤波后峰值误差
 end
%errorFFT=(pksFFTFilter-pksFFTOriginal)/pksFFTOriginal;
error(i)=abs(AreaOriginal-AreaFilter)/AreaOriginal%计算滤波前后能量误差
[SNR,RMSE]=snr(x,y);%输出信噪比和均方误差
SNR
RMSE
%*******************************数据输出*********************%
s1(1).x1='MaxPeak';s1(1).x2=mi;s1(1).x3=MAX;
s1(2).x1='1/2MaxPeak';s1(2).x2=c;s1(2).x3=C;
s1(3).x1='1/5MaxPeak';s1(3).x2=d;s1(3).x3=D;
s1(4).x1='AreaOriginal';s1(4).x2=AreaOriginal;
s1(5).x1='AreaFilter';s1(5).x2=AreaFilter;
s1(6).x1='error';s1(6).x2=error;
s1(7).x1='errorPeak';s1(7).x2=errorPeak;
s1(8).x1='SNR';s1(8).x2=SNR;
s1(9).x1='RMSE';s1(9).x2=RMSE;
save(['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(filename),'ImportData.mat'], 's1');
disp('按任意键继续下一组数据处理')
pause
end
%处理单个文件，需要更改文件地址和文件名，其中文件名需要加‘’，字符串表达方式
else key==0
 %  Addres = input('Please input the Dir Address with the address such as :E:\MATLAB-FFT\scaling长时间规则激励作用（给小毛）\SC20_wave\SC20_L20_C5_wave1\:');
   cd E:\MATLAB-FFT\SC20_FL20_C1;
   D = input('Please input the file name such as 1_3-12.mat');
load(D);
%filename=D.name;
%filename
%D(end-3:end)=[];
x=Data;
fs=20000;
t=0:0.00005:length(Data)/20000;t=t';t(length(Data)+1)=[];
[pksOriginal,locs]=findpeaks(x,'minpeakdistance',24000,'MINPEAKHEIGHT',0.0);
figure;
subplot(211);plot(t,x);
ylabel('幅值');xlabel('时间');title('sway历时线');
hold on;
plot(locs/fs,pksOriginal,'rp');
subplot(212);
[area,h,y_f]=hua_fft(x,fs);
%[pksFFTOriginal,locsFFT]=findpeaks(h);无用
saveas(gcf,['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(D),'original.fig']);
f1=input('Please look at the picture,make sure and input the f1= （reference data 2.5） ');
f3=input('f3= （reference data 3.0） ');
rp=input('rp= （reference data 0.1）');
rs=input('rs= （reference data 2.0）');
AreaOriginal=area;
%j=1;
 %while(b(j)<f1)
  %   c(j)=a(j);
   %  d(j)=b(j);
    % j=j+1;
 %end
%areasss=area(b,2*abs(a(1:g/2))/length(e))
%AreaOriginalData=trapz(b,2*abs(a(1:g/2))/length(e))
%AreaOriginal=trapz(d,2*abs(c(1:j-1))/length(e))
%c=[];
%d=[];
%低通测试
% y=filter(bz1,az1,x);
y=lowp(x,f1,f3,rp,rs,fs);%f1=2.5,f3=3.0,rp=0.1,rs=2.0
%y=hamingFirlowp(x,f1,f3,fs);
figure;
subplot(211);plot(t,y);
ylabel('幅值');xlabel('时间');title('sway历时线（afterFilter）');
%yy=y(70000:length(t));
[pksFilter,locsFilter]=findpeaks(y,'minpeakdistance',24000,'MINPEAKHEIGHT',0.0);
hold on;
plot(locsFilter/fs,pksFilter,'rp');
subplot(212);
[area,h]=hua_fft(y,fs);
%[pksFFTFilter,locsFFTFilter]=findpeaks(h);无用
FindHalfPeak(pksFilter,t,locsFilter);%****
saveas(gcf,['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(D),'Filter.fig']);
AreaFilter=area;
%j=1;
 %while(b(j)<f1)
  %   c(j)=a(j);
   %  d(j)=b(j);
    % j=j+1;
%end
 %AreaFilterData=trapz(b,2*abs(a(1:g/2))/length(e))
 %AreaFilter=trapz(d,2*abs(c(1:j-1))/length(e))
% c=[];%清空数组
 %d=[];%清空数组
 for k=1:1:length(locs)
 erroPeak(k)=(y(locs(k))-pksOriginal(k))/pksOriginal(k);
 end
%errorFFT=(pksFFTFilter-pksFFTOriginal)/pksFFTOriginal;
error=abs(AreaOriginal-AreaFilter)/AreaOriginal
[SNR,RMSE]=snr(x,y);
SNR
RMSE
%*******************************数据输出*********************%
s1(1).x1='MaxPeak';s1(1).x2=mi;s1(1).x3=MAX;
s1(2).x1='1/2MaxPeak';s1(2).x2=c;s1(2).x3=C;
s1(3).x1='1/5MaxPeak';s1(3).x2=d;s1(3).x3=D;
s1(4).x1='AreaOriginal';s1(4).x2=AreaOriginal;
s1(5).x1='AreaFilter';s1(5).x2=AreaFilter;
s1(6).x1='error';s1(6).x2=error;
s1(7).x1='errorPeak';s1(7).x2=errorPeak;
s1(8).x1='SNR';s1(8).x2=SNR;
s1(9).x1='RMSE';s1(9).x2=RMSE;
save(['E:\MATLAB-FFT\SC20_FL20_C1\',num2str(filename),'ImportData.mat'], 's1'); 
end