%画信号的幅频谱和能量谱
%频谱使用matlab例子表示
function [area,h,y_f]=hua_fft(y,fs)
nfft= 2^nextpow2(length(y));%找出大于y的个数的最大的2的指数值（自动进算最佳FFT步长nfft）
%nfft=1024;%人为设置FFT的步长nfft
y=y-mean(y);%去除直流分量
y_ft=fft(y,nfft);%对y信号进行DFT，得到频率的幅值分布
y_p=y_ft.*conj(y_ft)/nfft;%conj()函数是求y函数的共轭复数，实数的共轭复数是他本身。
y_f=fs*(0:nfft/2-1)/nfft;%T变换后对应的频率的序列
% y_p=y_ft.*conj(y_ft)/nfft;%conj()函数是求y函数的共轭复数，实数的共轭复数是他本身。
%a=y_ft;
%b=y_f;
%e=y;
%g=nfft;
h=abs(y_ft(1:nfft/2))/length(y);
g=h.^2;
%plot(y_f,2*abs(y_ft(1:nfft/2))/length(y));%matlab的帮助里画FFT的方法
%area1=trapz(y_f,2*abs(y_ft(1:nfft/2))/length(y))
plot(y_f,g);%matlab的帮助里画FFT的方法
area=trapz(y_f,g)
set(gca,'xlim',[0,20]);
ylabel('幅值^2');xlabel('频率(Hz)');title('能量谱');
%plot(y_f,abs(y_ft(1:nfft/2)));%论坛上画FFT的方法
   
end
