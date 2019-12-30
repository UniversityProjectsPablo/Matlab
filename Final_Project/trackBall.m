function varargout = trackBall(varargin)
% TRACKBALL MATLAB code for trackBall.fig
%      TRACKBALL, by itself, creates a new TRACKBALL or raises the existing
%      singleton*.
%
%      H = TRACKBALL returns the handle to a new TRACKBALL or the handle to
%      the existing singleton*.
%
%      TRACKBALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKBALL.M with the given input arguments.
%
%      TRACKBALL('Property','Value',...) creates a new TRACKBALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackBall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackBall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackBall

% Last Modified by GUIDE v2.5 27-Dec-2019 18:04:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackBall_OpeningFcn, ...
                   'gui_OutputFcn',  @trackBall_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before trackBall is made visible.
function trackBall_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackBall (see VARARGIN)


set(hObject,'WindowButtonDownFcn',{@my_MouseClickFcn,handles.axes1});
set(hObject,'WindowButtonUpFcn',{@my_MouseReleaseFcn,handles.axes1});
axes(handles.axes1);

handles.Cube=DrawCube(eye(3));

m0=[0;0];
m0 = calculateM(m0);
handles.m0 = m0;

handles.q0 = [1;0;0;0];

set(handles.axes1,'CameraPosition',...
    [0 0 5],'CameraTarget',...
    [0 0 -5],'CameraUpVector',...
    [0 1 0],'DataAspectRatio',...
    [1 1 1]);

set(handles.axes1,'xlim',[-3 3],'ylim',[-3 3],'visible','off','color','none');

% Choose default command line output for trackBall
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackBall wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trackBall_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function my_MouseClickFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)
    % Mouse over viewport    
    m = calculateM([xmouse; ymouse]);
    handles.m = m;
    
    set(handles.figure1,'WindowButtonMotionFcn',{@my_MouseMoveFcn,hObject});
end
guidata(hObject,handles)

function my_MouseReleaseFcn(obj,event,hObject)
handles=guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn','');
guidata(hObject,handles);

function my_MouseMoveFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)
   % Recalculate new position
    m0 = handles.m0;
    q0 = handles.q0;
    m = handles.m;
    
    q = quaternionFromVectors(m0,m);
    dq = deltaQuaternion(q,q0);
    qk = quaternionMultiplication(dq,q0);
    
    transformAttitudes(qk, handles);
    
    %%% DO things
    % use with the proper R matrix to rotate the cube
    R = [1 0 0; 0 -1 0;0 0 -1];
    R = quaternion2RotationMatrix(qk);
    handles.Cube = RedrawCube(R,handles.Cube);
    
    handles.m0 = m;
    handles.q0 = qk;
    
end
guidata(hObject,handles);

function h = DrawCube(R)

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

h = fill3(x,y,z, 1:6);

for q = 1:length(c)
    h(q).FaceColor = c(q,:);
end

function h = RedrawCube(R,hin)

h = hin;
c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

for q = 1:6
    h(q).Vertices = [x(:,q) y(:,q) z(:,q)];
    h(q).FaceColor = c(q,:);
end



function q0_input_Callback(hObject, eventdata, handles)
% hObject    handle to q0_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q0_input as text
%        str2double(get(hObject,'String')) returns contents of q0_input as a double


% --- Executes during object creation, after setting all properties.
function q0_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q0_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_angle_axis_input_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angle_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_angle_axis_input as text
%        str2double(get(hObject,'String')) returns contents of euler_angle_axis_input as a double


% --- Executes during object creation, after setting all properties.
function euler_angle_axis_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_angle_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_yaw_Callback(hObject, eventdata, handles)
% hObject    handle to euler_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_yaw as text
%        str2double(get(hObject,'String')) returns contents of euler_yaw as a double


% --- Executes during object creation, after setting all properties.
function euler_yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rotation_vector_input_Callback(hObject, eventdata, handles)
% hObject    handle to rotation_vector_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotation_vector_input as text
%        str2double(get(hObject,'String')) returns contents of rotation_vector_input as a double


% --- Executes during object creation, after setting all properties.
function rotation_vector_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotation_vector_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in quaternions_button.
function quaternions_button_Callback(hObject, eventdata, handles)
% hObject    handle to quaternions_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in euler_angle_axis_button.
function euler_angle_axis_button_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angle_axis_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in euler_angles_button.
function euler_angles_button_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angles_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rotation_vector_button.
function rotation_vector_button_Callback(hObject, eventdata, handles)
% hObject    handle to rotation_vector_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in general_reset_button.
function general_reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to general_reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.Cube=DrawCube(eye(3));
handles.q0 = ([1 0 0 0]');
handles.v0 = ([0 0 0]');
R = eye(3);

handles.Cube = RedrawCube(R,handles.Cube);

function q1_input_Callback(hObject, eventdata, handles)
% hObject    handle to q1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q1_input as text
%        str2double(get(hObject,'String')) returns contents of q1_input as a double


% --- Executes during object creation, after setting all properties.
function q1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q2_input_Callback(hObject, eventdata, handles)
% hObject    handle to q2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q2_input as text
%        str2double(get(hObject,'String')) returns contents of q2_input as a double


% --- Executes during object creation, after setting all properties.
function q2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q3_input_Callback(hObject, eventdata, handles)
% hObject    handle to q3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q3_input as text
%        str2double(get(hObject,'String')) returns contents of q3_input as a double


% --- Executes during object creation, after setting all properties.
function q3_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_pitch_Callback(hObject, eventdata, handles)
% hObject    handle to euler_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_pitch as text
%        str2double(get(hObject,'String')) returns contents of euler_pitch as a double


% --- Executes during object creation, after setting all properties.
function euler_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_roll_Callback(hObject, eventdata, handles)
% hObject    handle to euler_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_roll as text
%        str2double(get(hObject,'String')) returns contents of euler_roll as a double


% --- Executes during object creation, after setting all properties.
function euler_roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rotVec_x_Callback(hObject, eventdata, handles)
% hObject    handle to rotVec_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotVec_x as text
%        str2double(get(hObject,'String')) returns contents of rotVec_x as a double


% --- Executes during object creation, after setting all properties.
function rotVec_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotVec_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rotVec_y_Callback(hObject, eventdata, handles)
% hObject    handle to rotVec_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotVec_y as text
%        str2double(get(hObject,'String')) returns contents of rotVec_y as a double


% --- Executes during object creation, after setting all properties.
function rotVec_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotVec_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rotVec_z_Callback(hObject, eventdata, handles)
% hObject    handle to rotVec_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rotVec_z as text
%        str2double(get(hObject,'String')) returns contents of rotVec_z as a double


% --- Executes during object creation, after setting all properties.
function rotVec_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotVec_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_axis_x_Callback(hObject, eventdata, handles)
% hObject    handle to euler_axis_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_axis_x as text
%        str2double(get(hObject,'String')) returns contents of euler_axis_x as a double


% --- Executes during object creation, after setting all properties.
function euler_axis_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_axis_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_axis_y_Callback(hObject, eventdata, handles)
% hObject    handle to euler_axis_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_axis_y as text
%        str2double(get(hObject,'String')) returns contents of euler_axis_y as a double


% --- Executes during object creation, after setting all properties.
function euler_axis_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_axis_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_axis_z_Callback(hObject, eventdata, handles)
% hObject    handle to euler_axis_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_axis_z as text
%        str2double(get(hObject,'String')) returns contents of euler_axis_z as a double


% --- Executes during object creation, after setting all properties.
function euler_axis_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_axis_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function euler_angle_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of euler_angle as text
%        str2double(get(hObject,'String')) returns contents of euler_angle as a double


% --- Executes during object creation, after setting all properties.
function euler_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to euler_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Functions

function [new_m] = calculateM(m)
x = m(1,1);
y = m(2,1);
r = sqrt(3);

if x*x + y*y < 0.5*r*r
    z = sqrt(r*r - x*x -y*y)';
else
    z = (r*r)/(2*sqrt(x*x + y*y));
    z = (r*r/sqrt(x*x + y*y));
end

new_m = [x;y;z];

function q = quaternionFromVectors(m0,m)
w = cross(m0,m);
q = [1+dot(m0,m); w(1); w(2); w(3)];
q = normalize(q);

function dq = deltaQuaternion(q1,q0)
q0c = [q0(1); -q0(2:4)];
dq = quaternionMultiplication(q1,q0c);

function qp = quaternionMultiplication(q,p)
qp = zeros(4,1);
qp(1) = q(1)*p(1) - q(2:4)'*p(2:4);
qp(2:4) = q(1)*p(2:4) + p(1)*q(2:4) + cross(q(2:4),p(2:4));

function transformAttitudes(qk, handles)

%Quaternion
set(handles.q0_input,'String', num2str(qk(1)));
set(handles.q1_input,'String', num2str(qk(2)));
set(handles.q2_input,'String', num2str(qk(3)));
set(handles.q3_input,'String', num2str(qk(4)));

%Axis and angle
[u, angle] = quaternion2AxisAngle(qk);
set(handles.euler_axis_x,'String', num2str(u(1)));
set(handles.euler_axis_y,'String', num2str(u(2)));
set(handles.euler_axis_z,'String', num2str(u(3)));
set(handles.euler_angle,'String', num2str(angle));

%Rotation vector
rot_vec = angle * u;
set(handles.rotVec_x,'String',num2str(rot_vec(1)));
set(handles.rotVec_y,'String',num2str(rot_vec(2)));
set(handles.rotVec_z,'String',num2str(rot_vec(3)));

%Rotation Matrix
ux = [0 -u(3) u(2);
      u(3) 0  -u(1);
      -u(2) u(1) 0];
R = eye(3) + sind(angle)*ux + (1-cosd(angle))*(ux*ux);

%Euler angles
%[yaw, pitch, roll] = rotM2eAngles(R);
%set(handles.euler_yaw,'String',num2str(yaw));
%set(handles.euler_pitch,'String',num2str(pitch));
%set(handles.euler_roll,'String',num2str(roll));

function [axis, angle] = quaternion2AxisAngle(q)
angle = 2*acosd(q(1));
half_sin = sind(angle * 0.5);
axis(1) = q(2) / half_sin;
axis(2) = q(3) / half_sin;
axis(3) = q(4) / half_sin;

function [yaw, pitch, roll] = rotM2eAngles(R)
    %first we check the two special cases 
    if round(R(3,1),6) == 1
      pitch = pi * 1.5;
      roll = 0;
      yaw = R(2,2) -1;
    elseif round(R(3,1),6) == -1
      pitch = pi* 0.5;
      roll = 0;
      yaw = 1 - R(2,2);
    elseif round(R(3,1),6) == 0
       pitch = pi;
       roll = atan2(R(3,2)/cos(pitch), R(3,3)/cos(pitch));
       yaw = atan2(R(2,1)/cos(pitch), R(1,1)/cos(pitch));
    else
       pitch = asin(-R(3,1));
       roll = atan2(R(3,2)/cos(pitch), R(3,3)/cos(pitch));
       yaw = atan2(R(2,1)/cos(pitch), R(1,1)/cos(pitch));
    end
    
 function R = quaternion2RotationMatrix(q)
 qx = [0 -q(4) q(3);
      q(4) 0  -q(2);
      -q(3) q(2) 0];
 R = (q(1)*q(1) - q(2:4)'*q(2:4)) * eye(3) + 2*q(2:4)*q(2:4)' + 2*q(1)*qx;
    
