fs=20000;
nfft= 2^nextpow2(length(y));%找出大于y的个数的最大的2的指数值（自动进算最佳FFT步长nfft）
%nfft=1024;%人为设置FFT的步长nfft
y=y-mean(y);%去除直流分量
y_ft=fft(y,nfft);%对y信号进行DFT，得到频率的幅值分布
y_p=y_ft.*conj(y_ft)/nfft;%conj()函数是求y函数的共轭复数，实数的共轭复数是他本身。
y_f=fs*(0:nfft/2-1)/nfft;%T变换后对应的频率的序列
% y_p=y_ft.*conj(y_ft)/nfft;%conj()函数是求y函数的共轭复数，实数的共轭复数是他本身。
        plot(y_f,2*abs(y_ft(1:nfft/2))/length(y));%matlab的帮助里画FFT的方法
        i=1;
 while(y_f(i)<3.0)
     a(i)=y_ft(i);
     b(i)=y_f(i);
     i=i+1;
 end
        %a=2*abs(y_ft(1:nfft/2))/length(y);
        Aera=trapz(b,2*abs(a(1:i-1))/length(y));
        set(gca,'xlim',[0,20]);
        %ylabel('幅值');xlabel('频率');title('信号幅值谱');
        %plot(y_f,abs(y_ft(1:nfft/2)));%论坛上画FFT的方法