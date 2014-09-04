function fcn_showResults(handles)
% Shows fit results of chosen Data in Fit Info panel

% Get chosen data
dataVal = get(handles.popup_data,'Value');
% Get loaded data
h = handles.figure1;
dataSet = getappdata(h,'dataSet');
% Check if a data Set is selected
if isempty(dataSet) == 1
    return
end
% Get fieldnames of data set
dataSetFldNames = fieldnames(dataSet);
% Get fieldname of selected data
dataFldName = dataSetFldNames{dataVal};
% Check if fit data is available
if isfield(dataSet.(dataFldName),'fit') == 0
    return
end
% Get fit data object
fitData = dataSet.(dataFldName).fit;

%% Create an info string
% Get coeffnames
cNames = coeffnames(fitData);
% Get coeff values
cVals = coeffvalues(fitData);
% Get confints
cConf = confint(fitData);
% Calculate deltas
cDelta = abs(cVals - cConf(1,:));
% Create String
infoString = '';
for i=1:length(cVals)
    infoString = [infoString,cNames{i},': ' ,...
        num2str(cVals(i)),'  (',...
        num2str(cDelta(i)),')\n'];
end
    
%% Write in Fit Info panel
set(handles.text_fitInfo,'String',sprintf(...
    ['Fit Results:\n\n',infoString]));

end