function [ cells, accel, times ] = import_dir( dirname, start_time )
% Import an entire directory of accelerometer and date-time reads.
% This returns cells, a filewise description of the data, as well
% as two monolithic matrices, accel and times, describing all of the data
% in the directory.
%
% start_time is the time at which data started to be collected. This needs
% to be supplied by the user, as the date/time stamps in the CSV files seem
% to be inaccurate.
%
% accel is a 3xN matrix containing accelerometer data (as int16s) and time
% data (as seconds). cells is a cell containing a number of 1x2 cells, each
% representing a single file and containing accelerometer and time data
% formatted in the same manner.
%
% Due to integer overflow, it is reccomended to convert accel into a larger
% data format when performing arithmetic on it, such as float or double.

% Get filenames to import
listing = dir(dirname);
listing = listing(3:end); % remove . and ..
names = {};
for i=1:length(listing)
    name = listing(i).name;
    if strfind(name, 'DATA') == 1
        names{length(names)+1} = name;
    end
end

%% Collect data from individual files
cells = cell(length(names),1);
parfor i=1:length(names)
    [accel, times] = import_file(strcat(dirname, '/', names{i}));
    cells{i} = {accel, seconds(times)};
end

% Since we need to know the results of the last cell in order to get the
% next one, this next part is done without parallelism
for i=2:length(cells)
    t = cells{i-1}{2}(end);
    cells{i}{2} = cells{i}{2} + t;
end

% Add the start_date to each cell. Needs to be done after we string the
% seconds together because datetimes can't be added
for i=1:length(cells)
    cells{i}{2} = cells{i}{2} + start_time;
end

% String the data together into a monolithic array
accel = [];
times = [];
for i=1:length(cells)
   accel = [accel ; cells{i}{1}];
   times = [times ; cells{i}{2}];
end

end