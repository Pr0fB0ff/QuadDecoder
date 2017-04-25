function [] = exporter(out, Fs, OutFileName, PathName)
    %Housekeeping
    warning('off', 'MATLAB:audiovideo:audiowrite:dataClipped'); %silly clipping warning, I replaced it with a diagnostic, seems to not clip often enough to warrant a solution
    
    %Converts export array to wave and spits it out
    ExtentionLoc = strfind(OutFileName,'.');
    OutFileName = OutFileName(1 : ExtentionLoc(end) - 1);
    OutFileName = [OutFileName char('.wav')];

    cd (PathName);
    if Fs > 49000 %cuts the sample rate to 44.1k or 48k as appropriate, this came from a record it doesn't need to be that high
        out = resample(out, 1, 2);
        audiowrite(OutFileName,out,Fs/2, 'BitsPerSample', 16);

    else 
        audiowrite(OutFileName,out,Fs, 'BitsPerSample', 16);
        
    end
        
    %Housekeeping
    warning('on', 'MATLAB:audiovideo:audiowrite:dataClipped');
end

