%作者：毛艳军
%时间：2016年7月15日
%单位：大连理工大学深海研究中心
function [SNR,RMSE]=snr(x,y)
 x1=0;
 x2=0;
 x3=0;
for i=1:1:length(x)
    x1=x1+x(i)*x(i);
    x2=x2+x(i)-y(i);
    x3=x3+(x(i)-y(i))^2;
end
SNR=10*log(x1/x2);
RMSE=sqrt(1/i*x3);
end