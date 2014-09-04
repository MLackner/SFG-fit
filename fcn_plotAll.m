function fcn_plotAll(DataCell)

xData = DataCell{1};
yData1 = DataCell{2};
yData2 = DataCell{3};
yData3 = DataCell{4};
yData4 = DataCell{5};

%% Find Peaks
[pks,locs] = findpeaks(yData1,'THRESHOLD',3);
% Get x data value at peak locations
i = 1;
iter = numel(locs);
pksLocs = zeros(1,iter);
while i <= iter
    idx = locs(i);
    pksLocs(i) = xData(idx);
    i = i + 1;
end

%% Plot
figure
hold on
% Raw Data
plot(xData,yData1,'b')
plot(xData,yData2,'c')
plot(xData,yData3,'g')
plot(xData,yData4,'k')
% Detected Peak Positions
plot(pksLocs,pks,'*r')
hold off

end