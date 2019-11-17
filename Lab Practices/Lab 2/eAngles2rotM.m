function [R] = eAngles2rotM(yaw, pitch, roll)
% [R] = eAngles2rotM(yaw, pitch, roll)
% Computes the rotation matrix R given the Euler angles (yaw, pitch, roll). 
% Inputs:
%	yaw: angle of rotation around the z axis
%	pitch: angle of rotation around the y axis
%	roll: angle of rotation around the x axis
% Outputs:
%	R: rotation matrix
R = [cos(pitch)*cos(yaw), cos(yaw)*sin(pitch)*sin(roll)-cos(roll)*sin(yaw), cos(yaw)*cos(roll)*sin(pitch)+ sin(yaw)*sin(roll);
    cos(pitch)*sin(yaw), sin(yaw)*sin(pitch)*sin(roll)+cos(roll)*sin(yaw), sin(yaw)*sin(pitch)*cos(roll)- cos(yaw)*sin(roll);
    -sin(pitch), cos(pitch)*sin(roll), cos(pitch)*cos(roll)];
end




