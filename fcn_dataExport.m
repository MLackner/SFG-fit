function fcn_dataExport(xData,yData,fitresult,options)
    
%% Options
pathname = 'Export Data\';
filename = options.name;
filetype = '.csv';

%% Make dir if doesn't exist
folderCheck = exist(filepath,'dir');
if folderCheck ~= 7
    makedir(filepath)
end

%% Export x,y data
% x data
dlmwrite([pathname,filename,'_x',filetype],xData)
% y data
dlmwrite([pathname,filename,'_y',filetype],yData)

%% Export fit data
output = formula(fitresult);
cNames = coeffnames(fitresult);
cVals = coeffvalues(fitresult);

for ii=1:1:numel(cVals)
    cName = cNames{ii};
    cVal = num2str(cVals(ii));
    output = strrep(output, cName , cVal);
end

% Make more data points in x range
xDataFit = (min(xData):0.1:max(xData)).';

fhandle = @(x) eval(output);
fitData = fhandle(xDataFit);

% Export
dlmwrite([pathname,filename,'_xfit',filetype],xDataFit)
dlmwrite([pathname,filename,'_yfit',filetype],fitData)

end