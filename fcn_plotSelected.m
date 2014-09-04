function fcn_plotSelected(handles)

%% Plot Chosen Data set
% Get name of data set
dataString = get(handles.popup_data,'String');
dataVal = get(handles.popup_data,'Value');
dataName = dataString{dataVal};
% Get Data Set data
h = handles.figure1;
dataSet = getappdata(h,'dataSet');
% Define Data
xData = dataSet.(dataName).wn;
yData = dataSet.(dataName).signal;
% Plot
axes(handles.axes_prev)
plot(xData,yData,'.b')
% Plot fitdata if available
if isfield(dataSet.(dataName),'fit')
    hold on
    fit = dataSet.(dataName).fit;
    plot(fit,'-r')
    hold off
end
% Options
scr_plotOptions

end