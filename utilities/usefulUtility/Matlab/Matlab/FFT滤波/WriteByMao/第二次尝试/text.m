clear
f1=2.5;
f3=3.0;
rp=0.1;
rs=2.0;
Fs=20000;
wp=2*pi*f1/Fs;
ws=2*pi*f3/Fs;
% Éè¼ÆÇÐ±ÈÑ©·òÂË²¨Æ÷£»
[n,wn]=cheb1ord(wp/pi,ws/pi,rp,rs);
[bz1,az1]=cheby1(n,rp,wp/pi);