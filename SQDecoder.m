clear all;
close all;
clc;

[FileName,PathName] = uigetfile('*.*');

cd (PathName)

disp('loading file');
[soundIn,Fs] = audioread(FileName);
left = soundIn(:,1);
right = soundIn(:,2);

disp('performing transform');
xi = imag(hilbert(soundIn));
iLeft = xi(:,1);
iRight = xi(:,2);

disp('decoding rear channels');
leftRear = -0.7 * iLeft -0.7 * right;
rightRear = 0.7 * left + 0.7 * iRight;

disp('assembling export wav');
out(:,1) = left;
out(:,2) = right;
out(:,5) = leftRear;
out(:,6) = rightRear;


FileName = FileName(1:strfind(FileName,'.') - 1);
FileName = [FileName char('Quad.wav')]; 
audiowrite(FileName,out,Fs);

outRear(:,1) = leftRear;
outRear(:,2) = rightRear;

FileName = FileName(1:strfind(FileName,'.') - 1);
FileName = [FileName char('QuadRears.wav')]; 
audiowrite(FileName,out,Fs);