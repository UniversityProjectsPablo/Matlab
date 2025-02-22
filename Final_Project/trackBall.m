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

% Last Modified by GUIDE v2.5 31-Dec-2019 17:41:50

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
handles.OriginalCube = handles.Cube;

m0=[0;0];
m0 = calculateM(m0);
handles.m0 = m0;
handles.m = m0;

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
    handles.m0 = calculateM([xmouse; ymouse]);
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
    
    m0 = handles.m0;
    q0 = handles.q0;
        
    m = calculateM([xmouse; ymouse]);
    
    dq = quaternionFromVectors(m0,m);
    dq = dq/norm(dq);
    
    qk = quaternionMultiplication(dq,q0);
    
    transformAttitudes(qk, handles);
    
    % use with the proper R matrix to rotate the cube
    R = quaternion2RotationMatrix(qk);
    
    handles.Cube = RedrawCube(R,handles.Cube);

    handles.m0 = m;
    handles.q0 = qk;
end

guidata(hObject,handles);

function h = DrawCube(R)

M0 = [-1 -1  1;   %Node 1
      -1  1  1;   %Node 2
       1  1  1;   %Node 3
       1 -1  1;   %Node 4
      -1 -1 -1;  %Node 5
      -1  1 -1;  %Node 6
       1  1 -1;  %Node 7
       1 -1 -1]; %Node 8

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

M0 = [-1  -1  1;   %Node 1
      -1   1  1;   %Node 2
       1   1  1;   %Node 3
       1  -1  1;   %Node 4
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

%Quaternions
handles.qk(1) = str2double(get(handles.q0_input,'String'));
handles.qk(2) = str2double(get(handles.q1_input,'String'));
handles.qk(3) = str2double(get(handles.q2_input,'String'));
handles.qk(4) = str2double(get(handles.q3_input,'String'));
qk = handles.qk;

%Other attitudes
transformAttitudes(qk,handles);

R = quaternion2RotationMatrix(qk);
handles.Cube = RedrawCube(R,handles.Cube);


% --- Executes on button press in euler_angle_axis_button.
function euler_angle_axis_button_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angle_axis_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
euler_angle = str2double(get(handles.euler_angle,'String'));
euler_axis = [str2double(get(handles.euler_axis_x,'String'));
                str2double(get(handles.euler_axis_y,'String'));
                str2double(get(handles.euler_axis_z,'String'))];

%Quaternions
qk = [cosd(euler_angle*0.5); sind(euler_angle*0.5)*euler_axis];
set(handles.q0_input,'String', qk(1));
set(handles.q1_input,'String', qk(2));
set(handles.q2_input,'String', qk(3));
set(handles.q3_input,'String', qk(4));
handles.q0 = qk;

%Rotation vector
set(handles.rotVec_x,'String', euler_axis(1)*euler_angle);
set(handles.rotVec_y,'String', euler_axis(2)*euler_angle);
set(handles.rotVec_z,'String', euler_axis(3)*euler_angle);

%Rotation Matrix
if euler_angle == 0 || (euler_axis(1) == 0 && euler_axis(2) == 0 && euler_axis(3) == 0)
    R = eye(3);
else
    R = Eaa2rotMat(euler_angle, euler_axis);
end

set(handles.rot_mat_1_1,'String',num2str(R(1,1)));
set(handles.rot_mat_1_2,'String',num2str(R(1,2)));
set(handles.rot_mat_1_3,'String',num2str(R(1,3)));
set(handles.rot_mat_2_1,'String',num2str(R(2,1)));
set(handles.rot_mat_2_2,'String',num2str(R(2,2)));
set(handles.rot_mat_2_3,'String',num2str(R(2,3)));
set(handles.rot_mat_3_1,'String',num2str(R(3,1)));
set(handles.rot_mat_3_2,'String',num2str(R(3,2)));
set(handles.rot_mat_3_3,'String',num2str(R(3,3)));

%Euler angles
[yaw, pitch, roll] = rotM2eAngles(R);
set(handles.euler_yaw,'String',num2str(yaw));
set(handles.euler_pitch,'String',num2str(pitch));
set(handles.euler_roll,'String',num2str(roll));

handles.Cube = RedrawCube(R,handles.Cube);

            
% --- Executes on button press in euler_angles_button.
function euler_angles_button_Callback(hObject, eventdata, handles)
% hObject    handle to euler_angles_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Euler angles
handles.euler_yaw = str2double(get(handles.euler_yaw, 'String'));
handles.euler_pitch = str2double(get(handles.euler_pitch, 'String'));
handles.euler_roll = str2double(get(handles.euler_roll, 'String'));

%Rotation Matrix
R = eAngles2rotM(handles.euler_yaw, handles.euler_pitch,handles.euler_roll);
set(handles.rot_mat_1_1,'String',num2str(R(1,1)));
set(handles.rot_mat_1_2,'String',num2str(R(1,2)));
set(handles.rot_mat_1_3,'String',num2str(R(1,3)));
set(handles.rot_mat_2_1,'String',num2str(R(2,1)));
set(handles.rot_mat_2_2,'String',num2str(R(2,2)));
set(handles.rot_mat_2_3,'String',num2str(R(2,3)));
set(handles.rot_mat_3_1,'String',num2str(R(3,1)));
set(handles.rot_mat_3_2,'String',num2str(R(3,2)));
set(handles.rot_mat_3_3,'String',num2str(R(3,3)));

%Euler angle and axis
[a,u] = rotMat2Eaa(R);
set(handles.euler_axis_x,'String', u(1));
set(handles.euler_axis_y,'String', u(2));
set(handles.euler_axis_z,'String', u(3));
set(handles.euler_angle,'String', a);

%rotation vector
set(handles.rotVec_x,'String', u(1)*a);
set(handles.rotVec_y,'String', u(2)*a);
set(handles.rotVec_z,'String', u(3)*a);

%Quaternion
qk = [cosd(a); sind(a)*u];
set(handles.q0_input,'String', qk(1));
set(handles.q1_input,'String', qk(2));
set(handles.q2_input,'String', qk(3));
set(handles.q3_input,'String', qk(4));
handles.q0 = qk;

handles.Cube = RedrawCube(R,handles.Cube);

% --- Executes on button press in rotation_vector_button.
function rotation_vector_button_Callback(hObject, eventdata, handles)
% hObject    handle to rotation_vector_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Rotation vector
xvec = str2double(get(handles.rotVec_x, 'String'));
yvec = str2double(get(handles.rotVec_y, 'String'));
zvec = str2double(get(handles.rotVec_z, 'String'));
vec = [xvec, yvec, zvec]';

%Rotation Matrix
R = rotateMatVec(vec);
set(handles.rot_mat_1_1,'String',num2str(R(1,1)));
set(handles.rot_mat_1_2,'String',num2str(R(1,2)));
set(handles.rot_mat_1_3,'String',num2str(R(1,3)));
set(handles.rot_mat_2_1,'String',num2str(R(2,1)));
set(handles.rot_mat_2_2,'String',num2str(R(2,2)));
set(handles.rot_mat_2_3,'String',num2str(R(2,3)));
set(handles.rot_mat_3_1,'String',num2str(R(3,1)));
set(handles.rot_mat_3_2,'String',num2str(R(3,2)));
set(handles.rot_mat_3_3,'String',num2str(R(3,3)));

%Euler angles
[yaw, pitch, roll] = rotM2eAngles(R);
set(handles.euler_yaw,'String', num2str(yaw));
set(handles.euler_pitch,'String', num2str(pitch));
set(handles.euler_roll,'String', num2str(roll));

%Euler angle axis
u = vec/norm(vec);
a = norm(vec);
if norm(vec) == 0
    u = [1;0;0];
end
set(handles.euler_axis_x,'String', u(1));
set(handles.euler_axis_y,'String', u(2));
set(handles.euler_axis_z,'String', u(3));
set(handles.euler_angle,'String', a);

%Quaternion
qk = [cosd(a); sind(a)*u];
set(handles.q0_input,'String', qk(1));
set(handles.q1_input,'String', qk(2));
set(handles.q2_input,'String', qk(3));
set(handles.q3_input,'String', qk(4));
handles.q0 = qk;

handles.Cube = RedrawCube(R, handles.Cube);

% --- Executes on button press in general_reset_button.
function general_reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to general_reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

m0=[0;0];
m0 = calculateM(m0);
handles.m0 = m0;
handles.m = m0;

handles.q0 = [1;0;0;0];
handles.qk = [1;0;0;0];
handles.v0 = ([0;0;0]);

%Quaternions
set(handles.q0_input,'String', 1);
set(handles.q1_input,'String', 0);
set(handles.q2_input,'String', 0);
set(handles.q3_input,'String', 0);

%Euler angle axis
set(handles.euler_axis_x,'String', 0);
set(handles.euler_axis_y,'String', 0);
set(handles.euler_axis_z,'String', 0);
set(handles.euler_angle,'String', 0);

%Euler Angles
set(handles.euler_yaw,'String', 0);
set(handles.euler_pitch,'String', 0);
set(handles.euler_roll,'String', 0);

%Rotation vector
set(handles.rotVec_x,'String', 0);
set(handles.rotVec_y,'String', 0);
set(handles.rotVec_z,'String', 0);

%Rotation Matrix
set(handles.rot_mat_1_1,'String', 1);
set(handles.rot_mat_1_2,'String', 0);
set(handles.rot_mat_1_3,'String', 0);
set(handles.rot_mat_2_1,'String', 0);
set(handles.rot_mat_2_2,'String', 1);
set(handles.rot_mat_2_3,'String', 0);
set(handles.rot_mat_3_1,'String', 0);
set(handles.rot_mat_3_2,'String', 0);
set(handles.rot_mat_3_3,'String', 1);

R = eye(3);
handles.Cube = RedrawCube(R,handles.Cube);
guidata(hObject, handles);

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
zNorm = (r*r)/(2*sqrt(x*x + y*y));
totalNorm = norm([x;y;zNorm]);

if x*x + y*y < r*r*0.5
   z = abs(sqrt(r*r - x*x -y*y));
else
   x = r*x/totalNorm;
   y = r*y/totalNorm;
   z = r*zNorm/totalNorm;
end

new_m = [x;y;z];

function q = quaternionFromVectors(m0,m)
length = sqrt(norm(m0) * norm(m));
w = cross(m0,m);
q = [length + dot(m0,m); w];

function qp = quaternionMultiplication(q,p)
qp = zeros(4,1);
qp(1) = (q(1)*p(1)) - (q(2:4)'*p(2:4));
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
R = quaternion2RotationMatrix(qk);

set(handles.rot_mat_1_1,'String',num2str(R(1,1)));
set(handles.rot_mat_1_2,'String',num2str(R(1,2)));
set(handles.rot_mat_1_3,'String',num2str(R(1,3)));
set(handles.rot_mat_2_1,'String',num2str(R(2,1)));
set(handles.rot_mat_2_2,'String',num2str(R(2,2)));
set(handles.rot_mat_2_3,'String',num2str(R(2,3)));
set(handles.rot_mat_3_1,'String',num2str(R(3,1)));
set(handles.rot_mat_3_2,'String',num2str(R(3,2)));
set(handles.rot_mat_3_3,'String',num2str(R(3,3)));

%Euler angles
[yaw, pitch, roll] = rotM2eAngles(R);
set(handles.euler_yaw,'String',num2str(yaw));
set(handles.euler_pitch,'String',num2str(pitch));
set(handles.euler_roll,'String',num2str(roll));

function [axis, angle] = quaternion2AxisAngle(q)
angle = 2*acosd(q(1));
half_sin = sind(angle * 0.5);
axis(1) = q(2) / half_sin;
axis(2) = q(3) / half_sin;
axis(3) = q(4) / half_sin;
if angle == 0
    axis = [1 0 0];
end

function [yaw, pitch, roll] = rotM2eAngles(R)
    %first we check the two special cases
    if round(R(3,1),6) == 1
      pitch = 270;
      roll = 0;
      yaw = R(2,2) -1;
    elseif round(R(3,1),6) == -1
      pitch = 90;
      roll = 0;
      yaw = 1 - R(2,2);
    elseif round(R(3,1),6) == 0
       pitch = 0;
       roll = atan2d(R(3,2)/cosd(pitch), R(3,3)/cosd(pitch));
       yaw = atan2d(R(2,1)/cosd(pitch), R(1,1)/cosd(pitch));
    else
       pitch = asind(R(3,1));
       roll = atan2d(R(3,2)/cosd(pitch), R(3,3)/cosd(pitch));
       yaw = atan2d(R(2,1)/cosd(pitch), R(1,1)/cosd(pitch));
    end

function [R] = quaternion2RotationMatrix(q)
 R = [q(1)*q(1) + q(2)*q(2) - q(3)*q(3) - q(4)*q(4), 2*q(2)*q(3) - 2*q(1)*q(4), 2*q(2)*q(4) + 2*q(1)*q(3);
     2*q(2)*q(3)+2*q(1)*q(4), q(1)*q(1)-q(2)*q(2)+q(3)*q(3)-q(4)*q(4), 2*q(3)*q(4)-2*q(1)*q(2);
     2*q(2)*q(4)-2*q(1)*q(3), 2*q(3)*q(4)+2*q(1)*q(2), q(1)*q(1)-q(2)*q(2)-q(3)*q(3)+q(4)*q(4)];

function [R] = rotateMatVec(vec)
% Transform vector into equivalent matrix
Ux = [0 -vec(3) vec(2); vec(3) 0 -vec(1); -vec(2) vec(1) 0];

vec_normalized = norm(vec);
if vec_normalized ~= 0
    R = eye(3) * cosd(vec_normalized);
    R = R + ((1 - cosd(vec_normalized)) / vec_normalized ^ 2) * (vec * vec');
    R = R + (sind(vec_normalized) / vec_normalized) * Ux;
else
    % We ensure that there is always a cube drawn on screen
    R = eye(3);
end

function [R] = Eaa2rotMat(a,u)
u = u/sqrt(u'*u);

[ux] = [0, -u(3), u(2);
        u(3), 0, -u(1);
        -u(2) u(1) 0];

R = eye(3)*cosd(a) + (1 - cosd(a))*(u *u') + ux*sind(a);

function [R] = eAngles2rotM(yaw, pitch, roll)
sin_pitch = sind(pitch);
sin_roll = sind(roll);
sin_yaw = sind(yaw);

cos_pitch = cosd(pitch);
cos_roll = cosd(roll);
cos_yaw = cosd(yaw);

R = [cos_pitch * cos_yaw, cos_yaw*sin_pitch*sin_roll-cos_roll*sin_yaw, cos_yaw*cos_roll*sin_pitch + sin_yaw*sin_roll;
    cos_pitch*sin_yaw, sin_yaw*sin_pitch*sin_roll+cos_roll*cos_yaw, sin_yaw*sin_pitch*cos_roll- cos_yaw*sin_roll;
    -sin_pitch, cos_pitch*sin_roll, cos_pitch*cos_roll];

function [a,u] = rotMat2Eaa(R)
a = acosd((trace(R)-1)*0.5);

if sind(a) == 0
    if a == 180
        ux = (R - eye(3)) / 2;
        u = [ux(3,2); ux(1,3);ux(2,1)];
    end
    if a == 0
        u = (rand(3,1));
    end
else
    ux = (R - R')/(2*sind(a));
    u = [ux(3,2); ux(1,3);ux(2,1)];
end

