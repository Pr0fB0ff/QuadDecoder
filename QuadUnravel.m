function [out] = QuadUnravel(soundIn, encodingType, Fs)
    %split channels
    leftIn = soundIn(:,1);
    rightIn = soundIn(:,2);

    %Performs 90 degree phase shift and splits into channels
    disp('decoding channels');

    switch encodingType

        case 'SQ'
            %Cobbles rears and fronts together to SQ spec
            soundInImaginairy = imag(hilbert(soundIn));
            jLeft = soundInImaginairy(:,1);
            jRight = soundInImaginairy(:,2);
            disp('decoding rear channels');
            leftRear = -0.7 * jLeft -0.7 * rightIn;
            rightRear = 0.7 * leftIn + 0.7 * jRight;
            left = leftIn;
            right = rightIn;

        case 'QS'
            %Cobbles rears and fronts together to QS spec
            soundInImaginairy = imag(hilbert(soundIn));
            jLeft = soundInImaginairy(:,1);
            jRight = soundInImaginairy(:,2);
            leftRear = 0.92 * jLeft - 0.38 * jRight;
            rightRear = 0.38 * jLeft - 0.92 * jRight;
            left = 0.92 * leftIn + 0.38 * rightIn;
            right = 0.38 * leftIn + 0.92 * rightIn;

        case 'DY'
            %Cobbles rears and fronts together to DY, or Dynaquad, spec
            leftRear = leftIn - rightIn;
            rightRear = -1 * leftIn + rightIn;
            left = leftIn;
            right = rightIn;

        case 'EV'
            %Cobbles rears and fronts together to EV, or Stereo-4, spec
            %using superior encoder matrix
            leftRear = leftIn - 0.5 * rightIn;
            rightRear = -0.5 * leftIn + rightIn;
            left = leftIn + 0.3 * rightIn;
            right = 0.3 * leftIn + rightIn;
            
            
        case 'EVD'
            %Cobbles rears and fronts together to EV, or Stereo-4, spec
            %using original decoder matrix
            leftRear = leftIn - 0.8 * rightIn;
            rightRear = -0.8 * leftIn + rightIn;
            left = leftIn + 0.2 * rightIn;
            right = 0.2 * leftIn + rightIn;
            
%         case 'CD-4'
%             %Cobbles rears and fronts together to CD-4, or Compatiable Discrete-4, spec
%             leftDifference = fmdemod(leftIn, 30000, Fs)
            
        otherwise
            fprintf('Valid encoding type not entered.\nValid options are ''SQ'' ''QS'' ''DY'' ''EV''\nRemember quotes');
    end

    %Builds export array in 5.1 convention
    %3 and 4 are where center and LFE would be, not used here
    disp('assembling export matrix');
    out(:,1) = left;
    out(:,2) = right;
    out(:,5) = leftRear;
    out(:,6) = rightRear;
    
    %removes DC offset, often found in EV and EVD
    coeff = dcblock(5, Fs);
    b = [1 -1];
    a = [1 coeff];
    out = filter(b, a, out);
end

