function [] = fcn_logFile(onoff)
% Creates a log file (1: on 0: off)

if onoff == 1
    % Clear workspace
    clc
    
    %% Setup
    % Set path
    filepath = 'logs\';
    % Set first part of filename
    filename1 = 'FitLog';
    % Generate second part of filename
    filename2 = fcn_gendatename();
    % Set filetype
    filetype = '.log';
    % Complete filename
    filename = [filepath,filename1,'_',filename2,filetype];
    
    %% Make dir if doesn't exist
    folderCheck = exist(filepath,'dir');
    if folderCheck ~= 7
        makedir(filepath)
    end
    
    %% Diary on
    diary(filename)
    diary on
    
    %% Output dialog (Start of logfile)
    date = datestr(now);
    fprintf('LOGFILE \n%s \n____________________________\n',date)
end

if onoff == 0
    % Calculate run time
    timeEnd = clock;
    hours = timeEnd(4);      %hours
    minutes = timeEnd(5);    %minutes
    seconds = timeEnd(6);    %seconds
    %% Wait a few seconds and clear workspace and command window
    pause(3);
    clc
    fprintf('Logfile created\n')
    fprintf('Finished at: %g:%g:%g\n',hours,minutes,seconds)
    % fprintf('Execution time: %gh%gm%gs\n',hours,minutes,seconds)
    fprintf('--------->Complete<---------\n')
end

end