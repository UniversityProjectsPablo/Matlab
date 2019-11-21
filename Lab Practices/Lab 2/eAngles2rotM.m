function [R] = eAngles2rotM(yaw, pitch, roll)
% [R] = eAngles2rotM(yaw, pitch, roll)
% Computes the rotation matrix R given the Euler angles (yaw, pitch, roll). 
% Inputs:
%	yaw: angle of rotation around the z axis
%	pitch: angle of rotation around the y axis
%	roll: angle of rotation around the x axis
% Outputs:
%	R: rotation matrix
sin_pitch = sin(pitch);
sin_roll = sin(roll);
sin_yaw = sin(yaw);

cos_pitch = cos(pitch);
cos_roll = cos(roll);
cos_yaw = cos(yaw);

R = [cos_pitch * cos_yaw, cos_yaw*sin_pitch*sin_roll-cos_roll*sin_yaw, cos_yaw*cos_roll*sin_pitch + sin_yaw*sin_roll;
    cos_pitch*sin_yaw, sin_yaw*sin_pitch*sin_roll+cos_roll*cos_yaw, sin_yaw*sin_pitch*cos_roll- cos_yaw*sin_roll;
    -sin_pitch, cos_pitch*sin_roll, cos_pitch*cos_roll];
end




