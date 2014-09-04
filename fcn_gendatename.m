function name = fcn_gendatename()

time = clock;

name = [...
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

end