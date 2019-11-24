function [yaw, pitch, roll] = rotM2eAngles(R)
% [yaw, pitch, roll] = rotM2eAngles(R)
% Computes the Euler angles (yaw, pitch, roll) given an input rotation matrix R.
% Inputs:
%	R: rotation matrix
% Outputs:
%	yaw: angle of rotation around the z axis
%	pitch: angle of rotation around the y axis
%	roll: angle of rotation around the x axis

    %first we check the two special cases 
    if round(R(3,1),6) == 1
      pitch = pi * 1.5;
      roll = 0;
      yaw = R(2,2) -1;
    elseif round(R(3,1),6) == -1
      pitch = pi* 0.5;
      roll = 0;
      yaw = 1 - R(2,2);
    %then we check when pi or zero cause the division to output a Nan
    elseif round(R(3,1),6) == 0
       pitch = pi;
       roll = atan2(R(3,2)/cos(pitch), R(3,3)/cos(pitch));
       yaw = atan2(R(2,1)/cos(pitch), R(1,1)/cos(pitch));
    %in the last cas we actue normally
    else
       pitch = asin(-R(3,1));
       roll = atan2(R(3,2)/cos(pitch), R(3,3)/cos(pitch));
       yaw = atan2(R(2,1)/cos(pitch), R(1,1)/cos(pitch));
    end
end




