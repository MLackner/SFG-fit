function fcn_findPeaks(DataCell)

xData = DataCell{1};
yData = DataCell{2};

% Plot original data
plot(xData,yData,'^-k');

% Find Baseline (First and last Point)
nDataPnts = numel(xData);
firstPnt = yData(1);
lastPnt = yData(nDataPnts);
% Slope
slope = (lastPnt - firstPnt)/(xData(nDataPnts) - xData(1))
% Y-Axis intersect
yIntersect = yData(1) - slope*xData(1)
% Baseline
baseData = slope*xData + yIntersect;
% Plot
hold on
plot(xData,baseData,'r')

% Find heighest peak
[yDataMax,yDataMaxIdx] = max(yData);
xDataMax = xData(yDataMaxIdx);
plot(xDataMax,yDataMax,'*b');

% Calculate Damping Coefficient for heighest Peak
% Half height
halfHeight = (yDataMax - baseData(yDataMaxIdx))/2;
plot(xDataMax,halfHeight,'*b');
% Search for the four nearest points of yData for the half height.
% Going Index up
i = yDataMaxIdx;
while yData(i) > halfHeight
    nearestUpIdx = i;
    i = i + 1;
end
% Going Index down
i = yDataMaxIdx;
while yData(i) > halfHeight
    nearestDownIdx = i;
    i = i - 1;
end
% Calculate x data
xDataNearestUp = (xData(nearestUpIdx) + xData(nearestUpIdx + 1))/2;
xDataNearestDown = (xData(nearestDownIdx) + xData(nearestDownIdx - 1))/2;

% Plot
plot(xDataNearestUp,halfHeight,'*g')
plot(xDataNearestDown,halfHeight,'*g')

%% Half height and Peak Correction
peakPos = (xDataNearestUp + xDataNearestDown)/2;
% Damping Coefficient
dampC = abs(peakPos - xDataNearestUp);
% Plot
fprintf('Heighest peak: %g\nIndex number: %g\nDamping C: %g\n',peakPos,yDataMaxIdx,dampC);
plot(peakPos,yDataMax,'*c');
plot(peakPos,halfHeight,'*c');

%% Find Peaks
[pks,locs] = findpeaks(yData,'THRESHOLD',1);
% Get x data value at peak locations
i = 1;
iter = numel(locs);
pksLocs = zeros(1,iter);
while i <= iter
    idx = locs(i);
    pksLocs(i) = xData(idx);
    i = i + 1;
end

%% Find local Minima
yDataInv = 1.01*max(yData) - yData;
[mins,locsMin] = findpeaks(yDataInv,'THRESHOLD',1);
% Get x data value at peak locations
i = 1;
iter = numel(locsMin);
minsLocs = zeros(1,iter);
while i <= iter
    idx = locsMin(i);
    minsLocs(i) = xData(idx);
    mins = yData(i);
    i = i + 1;
end

%% Plot
plot(pksLocs,pks,'*b')
plot(minsLocs,mins,'*y')


hold off
    
end