%作者：毛艳军
%时间：2016年7月15日
%单位：大连理工大学深海研究中心
function sum=area(x,y)
sum=0;
for i=2:1:length(x)
    sum=sum+(x(i)-x(i-1))*((y(i)+y(i-1))/2);
end

end