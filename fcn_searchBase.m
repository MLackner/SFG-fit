function fcn_searchBase(DataCell)

%% Extract x and y data
xData = DataCell{1};
yData = DataCell{2};

%% Plot raw data
plot(xData,yData,'oy')
hold on

%% Find absolute minimum
% y Value and Index
[yAbsMin,absMinIdx] = min(yData);
% x Value
xAbsMin = xData(absMinIdx);
    % DEBUG plot absolute Minimum
    plot(xAbsMin,yAbsMin,'*r')

hold off