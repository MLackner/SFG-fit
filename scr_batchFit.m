%% Create logfile
% Filename
filepath = 'logs\';
filename1 = 'FitLog';
time = clock;
filename2 = [...
    num2str(time(1)), ...      %year
    '-', ...
    num2str(time(2)), ...      %month
    '-', ...
    num2str(time(3)), ...      %day
    '--', ...                   %seperator
    num2str(time(4)), ...      %hour
    '-', ...                    %seperator
    num2str(time(5)), ...      %minute
    '-', ...                    %seperator
    num2str(round(time(6)))];  %seconds
filetype = '.txt';
filename = [filepath,filename1,'_',filename2,filetype];
% Diary on
diary(filename)
diary on
% Write time and date
date = datestr(now);
scriptname = mfilename;
fprintf('LOGFILE "%s"\n%s\n____________________________\n',scriptname,date)

%% Specify the file the data is stored in
dataFilename = 'Data.mat';
% Get a list of all the variable names (strings)
varNames = who('-file', dataFilename);
% Load the file
load(dataFilename)

%%______________________________Edit here_____________________________%%
%% Damping Coefficients
options.G = [10.5 9.5 5.5 9 10.5 8.1 10.1 7.05 10.5];
% Bounds
options.dG = 2;

%% Peak Positions
options.w = [2825.5 2853 2882 2897 2911 2924.5 2945.5 2968.5 3001.5];
% Bounds
options.dw = 8;

%% Fit Model
options.ft = fittype([...
    'C' ... 
    '+ abs(m*x+b' ...  
    '+ A01/(w01 - x - 1i*G01)' ...  
    '+ A02/(w02 - x - 1i*G02)' ...
    '+ A03/(w03 - x - 1i*G03)' ...
    '+ A04/(w04 - x - 1i*G04)' ...
    '+ A05/(w05 - x - 1i*G05)' ...
    '+ A06/(w06 - x - 1i*G06)' ...
    '+ A07/(w07 - x - 1i*G07)' ... 
    '+ A08/(w08 - x - 1i*G08)' ...
    '+ A09/(w09 - x - 1i*G09)' ...
    ').^2'], ...
    'independent', 'x', 'dependent', 'y' );
%%____________________________________________________________________%%


disp(options);

% Make a fit for every data set in file
for i=1:length(varNames)
    cell = eval(varNames{i});
    options.name = varNames{i};
    fprintf('\n_________________________________\n')
    fprintf('Fit Results for ----%s----\n\n',options.name)
    [fitresult, gof, output] = createFit(cell,options)
    coeffVals = coeffvalues(fitresult);
    coeffNames = coeffnames(fitresult);
    coeffNum = numcoeffs(fitresult);
    ci = confint(fitresult);
    rsq(i) = gof.rsquare;
    
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
    newRow{(coeffNum*2)+1} = rsq(i);
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
    'RowNames',varNames);
% Save table
tablePath = 'results\';
tableName1 = 'FitData_';
tableType = '.mat';
tableFileName = [tablePath,tableName1,filename2,tableType];
save(tableFileName,'fitDataTable');

%% Calculate overall goodness
% Mean r squared
rsqMean = sum(rsq)/length(varNames);
% Lowest r squared
[rsqLowVal,rsqLowIdx] = min(rsq);

%% Output Dialog
% Calculate run time
timeEnd = clock;
hours = timeEnd(4) - time(4);   %hours
minutes = timeEnd(5) - time(5); %minutes
seconds = timeEnd(6) - time(6); %seconds
fprintf('\n\nMean value of R squared: %g\n', rsqMean)
fprintf('Lowest value of R squared: %g (%s)\n', rsqLowVal, varNames{rsqLowIdx})

%% End diary
diary off

%% Wait a few seconds and clear workspace and command window
pause(5);
clc
fprintf('Logfile %s created\n',filename)
fprintf('Execution time: %gh%gm%gs\n',hours,minutes,seconds)
fprintf('--------->Complete<---------\n')
clearvars -except fitDataTable