function fcn_rndPlot(handles)

axes(handles.axes_prev)

x = 2800:0.1:3050;

for i=1:5
    A(i) = random('bino',10,0.5);
    G(i) = random('norm',7,2);
    w(i) = random('unif',min(x),max(x));
end

y = abs(A(1)./(w(1)-x-1i*G(1))+A(2)./(w(2)-x-1i*G(2))+A(3)./(w(3)-x-1i*G(3))+A(4)./(w(4)-x-1i*G(4))+A(5)./(w(5)-x-1i*G(5))).^2;

plot(x,y)
grid on

end