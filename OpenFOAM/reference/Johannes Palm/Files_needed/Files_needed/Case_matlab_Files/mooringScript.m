%----- Calculate effective extension -----%

if inputFromCpp <= 0

   outputToCpp = 0;

else

  outputToCpp = 50*inputFromCpp;

end

%----- Plot the results runtime -----%

plot(ii,inputFromCpp,'k.',ii,outputToCpp,'rs');

hold on

if ii==1
    title('Evolution of actual and effective extension');
    legend('actual extension’,’used extension');
    xlabel('Number of time steps [-]')
    ylabel('Spring extension [m]');
end
