function [out] = SQUnravel(FileName, PathName)
    
    %Housekeeping
    firstPath = char(pwd);    
    cd (PathName);
    
    %Pulls in file and splits channels
    OutFileName = char(FileName);
    fprintf('loading file %s\n', FileName);
    [soundIn,Fs] = audioread(OutFileName);
    left = soundIn(:,1);
    right = soundIn(:,2);

    %Performs 90 degree phase shift and splits into channels
    disp('performing transform');
    soundInImaginairy = imag(hilbert(soundIn));
    jLeft = soundInImaginairy(:,1);
    jRight = soundInImaginairy(:,2);

    %Cobbles rears together
    disp('decoding rear channels');
    leftRear = -0.7 * jLeft -0.7 * right;
    rightRear = 0.7 * left + 0.7 * jRight;

    %Builds export array in 5.1 convention
    %3 and 4 are where center and LFE would be, not used here
    disp('assembling export wav');
    out(:,1) = left;
    out(:,2) = right;
    out(:,5) = leftRear;
    out(:,6) = rightRear;

    %Converts export array to wave and spits it out
    OutFileName = OutFileName(1:strfind(OutFileName,'.') - 1);
    OutFileName = [OutFileName char('Quad.wav')]; 
    audiowrite(OutFileName,out,Fs);

    %runs diagnostics
    diagnostic = out >= 1;
    diagnostic = diagnostic + out < -1;
    clip = sum(sum(diagnostic));
    fprintf('%d clipped samples out of %d total\n\n', clip, length(out) * 4);

    %Housekeeping
    cd(firstPath);
end

