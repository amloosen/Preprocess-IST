%% Preprocessing of IST Game
% AL; August 2020
clear all; close all

%% Load data
rep = ('./RawData/');
data = readtable([rep 'prolific_22122020_IGTtask.csv']);%adapt file name
    
%delete undefined ids
idx =  find(strcmp('undefined',data.prolific_id));%remove undefined prolific_IDs; comment out if unwanted
data(idx,:) = [];

%%
sl = unique(data.prolific_id);
for i = 1: size(sl,1)
    [proc_data{i},beh_ist{i}] = proc_ist(sl,i,data);  
end

%% Save data 
filename_istdat = sprintf('PreprocessedData/%sproc_data.mat', datestr(now,'mm-dd-yyyy'));
filename_istbeh = sprintf('PreprocessedData/%sbeh_ist.mat', datestr(now,'mm-dd-yyyy'));

save(filename_istdat,'proc_data');%adapt file name 
save(filename_istbeh,'beh_ist');