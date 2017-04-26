function [out] = QuadUnravel(soundIn, encodingType)
    %split channels
    leftIn = soundIn(:,1);
    rightIn = soundIn(:,2);

    %Performs 90 degree phase shift and splits into channels
    disp('performing transform');
    soundInImaginairy = imag(hilbert(soundIn));
    jLeft = soundInImaginairy(:,1);
    jRight = soundInImaginairy(:,2);

switch encodingType
    
    case 'SQ'
        %Cobbles rears and fronts together to SQ spec
        disp('decoding rear channels');
        leftRear = -0.7 * jLeft -0.7 * rightIn;
        rightRear = 0.7 * leftIn + 0.7 * jRight;
        left = leftIn;
        right = rightIn;
        
    case 'QS'
        %Cobbles rears and fronts together to QS spec
        disp('decoding channels');
        
        leftRear = 0.92 * jLeft - 0.38 * jRight;
        rightRear = 0.38 * jLeft - 0.92 * jRight;
        left = 0.92 * leftIn + 0.38 * rightIn;
        right = 0.38 * leftIn + 0.92 * rightIn;

    %Builds export array in 5.1 convention
    %3 and 4 are where center and LFE would be, not used here
    disp('assembling export matrix');
    out(:,1) = left;
    out(:,2) = right;
    out(:,5) = leftRear;
    out(:,6) = rightRear;
end

