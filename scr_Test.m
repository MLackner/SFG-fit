xData = 2750:1:3050;

NR = -10;

A1 = 20;
G1 = 6;
w1 = 2875;

A2 = 15;
G2 = 11;
w2 = 2950;

yData = NR ...
    + abs(A1*sqrt(2)./(w1 - xData - 1i*G1*sqrt(2))).^2;

%% Plot
hold on
plot(xData,yData,'g')