function [out] = SQUnravel(soundIn)
    %split channels
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
    disp('assembling export matrix');
    out(:,1) = left;
    out(:,2) = right;
    out(:,5) = leftRear;
    out(:,6) = rightRear;
end

