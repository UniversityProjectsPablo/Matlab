function varargout = Exercise3(varargin)
% EXERCISE3 MATLAB code for Exercise3.fig
%      EXERCISE3, by itself, creates a new EXERCISE3 or raises the existing
%      singleton*.
%
%      H = EXERCISE3 returns the handle to a new EXERCISE3 or the handle to
%      the existing singleton*.
%
%      EXERCISE3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXERCISE3.M with the given input arguments.
%
%      EXERCISE3('Property','Value',...) creates a new EXERCISE3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Exercise3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Exercise3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Exercise3

% Last Modified by GUIDE v2.5 02-Dec-2019 17:28:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exercise3_OpeningFcn, ...
                   'gui_OutputFcn',  @Exercise3_OutputFcn, ...
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


% --- Executes just before Exercise3 is made visible.
function Exercise3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exercise3 (see VARARGIN)

% Choose default command line output for Exercise3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exercise3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exercise3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.slider2, 'Max', 2 * pi);
set(handles.slider2, 'Min', 0);
set(handles.slider2, 'SliderStep', [1,1]);
sliderValue = get(handles.slider2, 'Value');
set(handles.u_2_et,'String', sliderValue);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function v_1_et_Callback(hObject, eventdata, handles)
% hObject    handle to v_1_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_1_et as text
%        str2double(get(hObject,'String')) returns contents of v_1_et as a double


% --- Executes during object creation, after setting all properties.
function v_1_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_1_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_2_et_Callback(hObject, eventdata, handles)
% hObject    handle to v_2_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_2_et as text
%        str2double(get(hObject,'String')) returns contents of v_2_et as a double


% --- Executes during object creation, after setting all properties.
function v_2_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_2_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_3_et_Callback(hObject, eventdata, handles)
% hObject    handle to v_3_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_3_et as text
%        str2double(get(hObject,'String')) returns contents of v_3_et as a double


% --- Executes during object creation, after setting all properties.
function v_3_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_3_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_1_et_Callback(hObject, eventdata, handles)
% hObject    handle to u_1_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_1_et as text
%        str2double(get(hObject,'String')) returns contents of u_1_et as a double


% --- Executes during object creation, after setting all properties.
function u_1_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_1_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_2_et_Callback(hObject, eventdata, handles)
% hObject    handle to u_2_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_2_et as text
%        str2double(get(hObject,'String')) returns contents of u_2_et as a double


% --- Executes during object creation, after setting all properties.
function u_2_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_2_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u_3_et_Callback(hObject, eventdata, handles)
% hObject    handle to u_3_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_3_et as text
%        str2double(get(hObject,'String')) returns contents of u_3_et as a double


% --- Executes during object creation, after setting all properties.
function u_3_et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_3_et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
