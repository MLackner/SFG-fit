function [file,FileName] = fcn_loadFile(fileType,dlgName)
% Loads a file with an open file dialog

%% Open load file Dialog
% Open Dialog
[FileName,PathName,FilterIndex] = uigetfile(fileType,dlgName);

% Return if no file was selected
if FileName == 0
    file = 'None';
    return
end

%% Load Selected File if it isn't a *.txt file
if strcmp(fileType,'*.txt') == 0
    file = load([PathName FileName]);
else
    file = [PathName FileName];
end

end