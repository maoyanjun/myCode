clc;
file = dir('E:\openfoam\1\*.txt');  %文件所在路径
filenames = char(file.name);
newfilename = strjust(filenames); %空格对准
[tempfile,order] = sortrows(newfilename);
sortfile = file(order,:);  %文件名排序
for n = 1:length(sortfile)
    temp = dlmread(['E:\openfoam\1\',sortfile(n).name],' ',0, 0);  %文件所在路径
    writefile(n,1) = temp(501);  %提取所需的元素到writefile列表中
end
% plot(1:1:10,writefile')



    