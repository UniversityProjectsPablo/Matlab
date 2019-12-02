function varargout = Exercise1(varargin)
% EXERCISE1 MATLAB code for Exercise1.fig
%      EXERCISE1, by itself, creates a new EXERCISE1 or raises the existing
%      singleton*.
%
%      H = EXERCISE1 returns the handle to a new EXERCISE1 or the handle to
%      the existing singleton*.
%
%      EXERCISE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXERCISE1.M with the given input arguments.
%
%      EXERCISE1('Property','Value',...) creates a new EXERCISE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Exercise1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Exercise1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Exercise1

% Last Modified by GUIDE v2.5 26-Nov-2019 18:08:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exercise1_OpeningFcn, ...
                   'gui_OutputFcn',  @Exercise1_OutputFcn, ...
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


% --- Executes just before Exercise1 is made visible.
function Exercise1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exercise1 (see VARARGIN)

% Choose default command line output for Exercise1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exercise1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exercise1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qc_q0_Callback(hObject, eventdata, handles)
% hObject    handle to qc_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qc_q0 as text
%        str2double(get(hObject,'String')) returns contents of qc_q0 as a double


% --- Executes during object creation, after setting all properties.
function qc_q0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qc_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');

end



function qc_q1_Callback(hObject, eventdata, handles)
% hObject    handle to qc_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qc_q1 as text
%        str2double(get(hObject,'String')) returns contents of qc_q1 as a double


% --- Executes during object creation, after setting all properties.
function qc_q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qc_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qc_q2_Callback(hObject, eventdata, handles)
% hObject    handle to qc_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qc_q2 as text
%        str2double(get(hObject,'String')) returns contents of qc_q2 as a double


% --- Executes during object creation, after setting all properties.
function qc_q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qc_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qc_q3_Callback(hObject, eventdata, handles)
% hObject    handle to qc_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qc_q3 as text
%        str2double(get(hObject,'String')) returns contents of qc_q3 as a double

% --- Executes during object creation, after setting all properties.
function qc_q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qc_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function qb_q0_Callback(hObject, eventdata, handles)
% hObject    handle to qb_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qb_q0 as text
%        str2double(get(hObject,'String')) returns contents of qb_q0 as a double


% --- Executes during object creation, after setting all properties.
function qb_q0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qb_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qb_q1_Callback(hObject, eventdata, handles)
% hObject    handle to qb_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qb_q1 as text
%        str2double(get(hObject,'String')) returns contents of qb_q1 as a double


% --- Executes during object creation, after setting all properties.
function qb_q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qb_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function qb_q2_Callback(hObject, eventdata, handles)
% hObject    handle to qb_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qb_q2 as text
%        str2double(get(hObject,'String')) returns contents of qb_q2 as a double


% --- Executes during object creation, after setting all properties.
function qb_q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qb_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qb_q3_Callback(hObject, eventdata, handles)
% hObject    handle to qb_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qb_q3 as text
%        str2double(get(hObject,'String')) returns contents of qb_q3 as a double


% --- Executes during object creation, after setting all properties.
function qb_q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qb_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qa_q0_Callback(~, eventdata, handles)
% hObject    handle to qa_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qa_q0 as text
%        str2double(get(hObject,'String')) returns contents of qa_q0 as a double


% --- Executes during object creation, after setting all properties.
function qa_q0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qa_q0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qa_q1_Callback(hObject, ~, handles)
% hObject    handle to qa_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qa_q1 as text
%        str2double(get(hObject,'String')) returns contents of qa_q1 as a double


% --- Executes during object creation, after setting all properties.
function qa_q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qa_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qa_q2_Callback(~, ~, ~)
% hObject    handle to qa_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qa_q2 as text
%        str2double(get(hObject,'String')) returns contents of qa_q2 as a double


% --- Executes during object creation, after setting all properties.
function qa_q2_CreateFcn(hObject, ~, ~)
% hObject    handle to qa_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qa_q3_Callback(hObject, eventdata, handles)
% hObject    handle to qa_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qa_q3 as text
%        str2double(get(hObject,'String')) returns contents of qa_q3 as a double


% --- Executes during object creation, after setting all properties.
function qa_q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qa_q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Button.
function Button_Callback(~, ~, handles)
% hObject    handle to Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

qa(1) = get(handles.qa_q0,'String');
qa(1) = str2double(qa(1));
qa(2) = get(handles.qa_q1, 'String');
qa(2) = str2double(qa(2));
qa(3) = get(handles.qa_q2, 'String');
qa(3) = str2double(qa(3));
qa(4) = get(handles.qa_q3, 'String');
qa(4) = str2double(qa(4));

qb(1) = get(handles.qb_q0,'String');
qb(1) = str2double(qb(1));
qb(2) = get(handles.qb_q1, 'String');
qb(2) = str2double(qb(2));
qb(3) = get(handles.qb_q2, 'String');
qb(3) = str2double(qb(3));
qb(4) = get(handles.qb_q3, 'String');
qb(4) = str2double(qb(4));

qc = QuaternionMultiplication(qa,qb);

set(handles.qc_q0, 'String', num2string(qc(1)));
set(handles.qc_q1, 'String', num2string(qc(2)));
set(handles.qc_q2, 'String', num2string(qc(3)));
set(handles.qc_q3, 'String', num2string(qc(4)));


function qc = QuaternionMultiplication(qa,qb)
qc(1) = qa(1) * qc(1) - qa(2:4)' * qb(2:4);
qc(2:4) = qa(1) * qb(2:4) + qb(1)*qa(2:4) + cross(qa(2:4), qb(2:4));
