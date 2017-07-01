%Housekeeping
clear all;
close all;
clc;

prompt = 'Input decoding scheme\nCurrently supported... ''SQ'', ''QS'', ''DQ'' (Dynaquad), ''EV'' (ElectroVoice)\n';
scheme = input(prompt);
fprintf('Decoding in %s\n', scheme);

%Launches window to choose files to convert
allowedFiles = {'*.wav'; '*.aiff'; '*.aif'; '*.wave'};
[FileName,PathName] = uigetfile(allowedFiles, 'MultiSelect', 'on');

firstPath = char(pwd);

if length(FileName) == 1 && length(PathName) == 1 %case for clicking cancel
    fprintf('How''s about you choose somethin'' hun\n');
    return
    
elseif iscell(FileName) %case for multiple files
    for i = 1:length(FileName)
        %Pulls in file
        cd(PathName);
        OutFileName = char(FileName(i));
        fprintf('loading file %s\n', OutFileName);
        [soundIn,Fs] = audioread(OutFileName);

        cd(firstPath);
        out = QuadUnravel(soundIn, scheme);
        clipDiagnose(out);
        exporter(out, Fs, OutFileName, PathName);
        fprintf('\n');
    end
    
elseif isvector(FileName) %case for single files
    cd (PathName);

    %Pulls in file
    OutFileName = char(FileName);
    fprintf('loading file %s\n', FileName);
    [soundIn,Fs] = audioread(OutFileName);
    
    cd(firstPath);
    out = QuadUnravel(soundIn, scheme);
    clipDiagnose(out);
    exporter(out, Fs, OutFileName, PathName);
end
    
cd(firstPath);
fprintf('All done\n');