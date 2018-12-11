clc;
file = dir('E:\openfoam\0\*.txt');  %文件所在路径

for n = 1:length(file)
    temp = dlmread(['E:\openfoam\0\',file(n).name],' ',0, 0);  %文件所在路径
    writefile(n,1) = temp(501);  %提取所需的元素到writefile列表中
end
% plot(1:1:10,writefile')



    