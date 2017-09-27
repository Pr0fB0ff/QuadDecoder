function [] = exporter(out, Fs, OutFileName, PathName)
    %Normalize Audio
    out = mapminmax(rot90(out));
    out = rot90(out, 3);

    %Housekeeping
    warning('off', 'MATLAB:audiovideo:audiowrite:dataClipped'); %anal clipping warning, I replaced it with a diagnostic, seems to not clip often enough to warrant a solution
    
    %Converts export array to wave and spits it out
    ExtentionLoc = strfind(OutFileName,'.');
    OutFileName = OutFileName(1 : ExtentionLoc(end) - 1);
    OutFileName = [OutFileName char('.wav')];

    cd (PathName);
    audiowrite(OutFileName,out,Fs, 'BitsPerSample', 16);
    
    %Housekeeping
    warning('on', 'MATLAB:audiovideo:audiowrite:dataClipped');
end

