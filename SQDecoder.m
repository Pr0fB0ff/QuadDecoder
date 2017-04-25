%Housekeeping
warning('off', 'MATLAB:audiovideo:audiowrite:dataClipped'); %silly clipping warning, I replaced it with a diagnostic, seems to not clip often enough to warrant a solution
clear all;
close all;
clc;

%Launches window to choose files to convert
allowedFiles = {'*.wav'; '*.aiff'; '*.aif'; '*.wave'};
[FileName,PathName] = uigetfile(allowedFiles, 'MultiSelect', 'on');

if length(FileName) == 1 && length(PathName) == 1 %case for clicking cancel
    fprintf('How''s about you choose somethin'' hun\n');
    return
    
elseif iscell(FileName) %case for multiple files
    for i = 1:length(FileName)
        SQUnravel(char(FileName(i)), PathName);
    end
    
elseif isvector(FileName) %case for single files
    SQUnravel(FileName, PathName);
end

fprintf('All done\n');