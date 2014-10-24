function fcn_saveData(handles)
% Saves the data set

%% Open the data set
% Get data set
h = handles.figure1;
dataSet = getappdata(h,'dataSet');

%% Check if data set contains fit data. If not show a question dialog
if isfield(dataSet,'fit') == false
    % Make dialog
    choice = questdlg('Data set does not contain any fit data. Proceed?',...
        'Warning',...
        'Yes','No','No');
    % Handle response
    if strcmp('No',choice) == true
        % Return
        return
    end
end

%% Save the file
% Open save file dialog
[FileName,PathName,FilterIndex] = uiputfile('*.mat','Save Data Set');
% Make file path
filePath = [PathName,FileName];
% Save
save(filePath,'dataSet')
fprintf('Saved data as %s',FileName)

end