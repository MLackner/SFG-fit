function fcn_saveFile(Data)

% Open save file dialog
[FileName,PathName] = uiputfile('*.mat', 'Save');

% Return if no file was selected
if FileName == 0
    return
end

% Save the file
save([PathName FileName],'Data');

end