function fitData = fcn_batchFit(handles)


%% Get data Set
h = handles.figure1;
dataSet = getappdata(h,'dataSet');

%% Get a list of all the variable names (strings)
dataNames = fieldnames(dataSet);



%% Set Peak positions and damp coefficients in case of optimJob
if get(handles.check_runOptim,'Value') == 1
    % Get the data
    h = handles.figure1;
    options.G = getappdata(h,'meanValsG');
    options.w = getappdata(h,'meanValsw');
else
    % Get Damping Coefficients
    options.G = str2num(get(handles.edit_dampCoeff,'String'));
    % Get Peak Positions
    options.w = str2num(get(handles.edit_peakPos,'String'));
end

% Get Bounds
options.dG = str2num(get(handles.edit_dG,'String'));
options.dw = str2num(get(handles.edit_dw,'String'));
% Output
fprintf('Peak positions set to:\n')
disp(options.w)
fprintf('Bounds: %g\n',options.dw)
fprintf('Damping coefficients set to:\n')
disp(options.G)
fprintf('Bounds: %g\n',options.dG)

%% Fit Model
fitModel = getappdata(h,'fitModel');
fitModel = fitModel{1};
options.ft = fittype(fitModel,'independent', 'x', 'dependent', 'y' );

%% Make dummy arrays for Fit Data
rsquared = zeros(1,length(dataNames));          %rsquared

% Make a fit for every data set in file
for i=1:length(dataNames)
    fldName = dataNames{i};
    options.name = dataNames{i};
    % Output
    fprintf('\n_________________________________\n')
    fprintf('Fit Results for ----%s----\n\n',options.name)
    [fitresult, gof, output] = fcn_createFit(dataSet.(fldName),handles,options)
    coeffVals = coeffvalues(fitresult);
    coeffNames = coeffnames(fitresult);
    coeffNum = numcoeffs(fitresult);
    ci = confint(fitresult);
    
    % Collect GOF data
    rsquared(i) = gof.rsquare;                  % rsquared
    
    %% Duplicate raw data
    rawdata = fieldnames(dataSet.(fldName));
    for j=1:numel(rawdata)
        fitData.(fldName).(rawdata{j}) = dataSet.(fldName).(rawdata{j});
    end
    
    %% Write fit result in structure
    fitData.(fldName).fit = fitresult;
    
    %% Update Popup Menu entry
    set(handles.popup_data,'Value',i)
    
    %% Write results in cell
    % Make empty Cell Array in first loop cycle
    if i == 1
        fitDataCell = {};
    end
    % New row
    for k=1:coeffNum
        if k==1
            n = 0;
        end
        newRow{k+n} = coeffVals(k);
        newRow{k+1+n} = coeffVals(k) - ci(1,k);
        n = n + 1;
    end
    newRow{(coeffNum*2)+1} = rsquared(i);
    fitDataCell = cat(1,fitDataCell,newRow);
end

%% Make a table from cell and save it
% Variable Names
for k=1:coeffNum
    if k==1
        n = 0;
    end
    colNames{k+n} = coeffNames{k};
    colNames{k+1+n} = ['d',coeffNames{k}];
    n = n + 1;
end
colNames{(coeffNum*2)+1} = 'rsquared';
fitDataTable = cell2table(fitDataCell,...
    'VariableNames',colNames,...
    'RowNames',dataNames);

%% Save table
if get(handles.check_dataTable) == 1
    tablePath = 'results\';
    tableName1 = 'FitData_';
    filename2 = fcn_gendatename();
    tableType = '.mat';
    tableFileName = [tablePath,tableName1,filename2,tableType];
    save(tableFileName,'fitDataTable');
end

%% Calculate overall goodness
% Mean r squared
rsquaredMean = mean(rsquared);
% Lowest r squared
[rsqLowVal,rsqLowIdx] = min(rsquared);

%% Calculate Mean values of coefficients
% Convert Cell to Matrix
fitDataMat = cell2mat(fitDataCell);
% Get total number of columns in fitDataCell array
sizeFitDataMat = size(fitDataMat);
totalColumns = sizeFitDataMat(2);
% Calculate number of peaks
nPeaks = (totalColumns - 5)/6;
% Mean values
meanValsAll = mean(fitDataMat);
% Dummy array mean values
meanVals = zeros(1,2*nPeaks);
% Write positions in array
for i=1:length(meanVals)
    % Get Positions of interesting Values
    valPos = nPeaks*2 + 2*i - 1;
    if i > length(meanVals)/2
        valPos = valPos + 4;
    end
    meanVals(i) = meanValsAll(valPos);
end
% Output in GUI
% Output string
outputString = [];
for i=1:length(meanVals)
    if i <= length(meanVals)/2
        coeffName = ['G',num2str(i)];
    else
        coeffName = ['w',num2str(i - length(meanVals)/2)];
    end
    outputString = [outputString,[coeffName,': %g\n']];
end
% Set handle
set(handles.text_fitInfo,...
    'String',...
    sprintf(['Fit parameter mean values:\n',outputString,'\n',...
    '_________\n',...
    'mean(rsquared): %g'],...
    meanVals, rsquaredMean))

%% Store mean values
h = handles.figure1;
% Split mean vals in G and w array
% Dummy arrays
meanValsGNew = zeros(1,length(meanVals)/2);
meanValswNew = zeros(1,length(meanValsGNew));
for i=1:length(meanVals)
    if i <= length(meanVals)/2
        meanValsGNew(i) = meanVals(i);
    else
        meanValswNew(i - length(meanValsGNew)) = meanVals(i);
    end
end

% In case of optimization job
if get(handles.check_runOptim,'Value') == 1
    % Read old values
    meanValsGOld = options.G;
    meanValswOld = options.w;
    
    % Compare old and new values and quit job if differece is minimal
    checkDiffG = mean(abs(meanValsGOld - meanValsGNew));
    fprintf('\n#### Mean difference of damping coeffs: %g\n',checkDiffG)
    checkDiffw = mean(abs(meanValswOld - meanValswNew));
    fprintf('#### Mean difference in peak positions: %g\n',checkDiffw)
    if checkDiffG < (options.dG/5) && checkDiffw < (options.dw/5)
        set(handles.check_runOptim,'Value',0)
        fprintf('\n*****Optimization job completed!*****\n')
    end
   
end

% Store new values
setappdata(h,'meanValsG',meanValsGNew)
setappdata(h,'meanValsw',meanValswNew)

%% Output Dialog
fprintf('\n\nMean value of R squared: %g\n', rsquaredMean)
fprintf('Lowest value of R squared: %g (%s)\n', rsqLowVal, dataNames{rsqLowIdx})