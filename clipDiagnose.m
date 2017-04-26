function [] = clipDiagnose(outPut)
    %spits out proportion of camples that are clipped
    diagnostic = outPut >= 1;
    diagnostic = diagnostic + outPut < -1;
    clip = sum(sum(diagnostic));
    if clip > 0
        fprintf('%d clipped samples out of %d total\n', clip, length(outPut) * 4);
    end
end

