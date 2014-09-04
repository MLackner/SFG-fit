%% Fitting Parameters for 20:1 EA, SSP, 25 mN/m
w1 = 2849;
A1 = 14.9;
G1 = 9;

w2 = 2876;
A2 = 16.4;
G2 = 8;

w3 = 2920;
A3 = 7.7;
G3 = 9;

w4 = 2939;
A4 = 9.1;
G4 = 8.8;

w5 = 3011;
A5 = 4;
G5 = 8.1;

w6 = 3160;
A6 = 52;
G6 = 100;

% No values for #7 and #8 in ssp

Xnr = 0.13;

%% Make x Data
x = 2700:1:3100;

%% Fitting Function
y = Xnr ...
    + abs(A1./(w1 - x - 1i*G1)).^2 ...
    + abs(A2./(w2 - x - 1i*G2)).^2 ...
    + abs(A3./(w3 - x - 1i*G3)).^2 ...
    + abs(A4./(w4 - x - 1i*G4)).^2 ...
    + abs(A5./(w5 - x - 1i*G5)).^2 ...
    + abs(A6./(w6 - x - 1i*G6)).^2;

%% Plot
plot(x,y)