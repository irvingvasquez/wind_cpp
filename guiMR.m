function varargout = guiMR(varargin)
% GUIMR MATLAB code for guiMR.fig
%      GUIMR, by itself, creates a new GUIMR or raises the existing
%      singleton*.
%
%      H = GUIMR returns the handle to a new GUIMR or the handle to
%      the existing singleton*.
%
%      GUIMR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMR.M with the given input arguments.
%
%      GUIMR('Property','Value',...) creates a new GUIMR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiMR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiMR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiMR

% Last Modified by GUIDE v2.5 19-Apr-2016 16:21:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiMR_OpeningFcn, ...
                   'gui_OutputFcn',  @guiMR_OutputFcn, ...
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


% --- Executes just before guiMR is made visible.
function guiMR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiMR (see VARARGIN)

% Choose default command line output for guiMR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiMR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiMR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in getPolygonButton.
function getPolygonButton_Callback(hObject, eventdata, handles)
% hObject    handle to getPolygonButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Poligono
n_vertices = 4;
polygon_radius = 200; %meters
rad_var = 5;
ang_var = 1;
% get polygon
M = getPolygon(n_vertices,polygon_radius,rad_var,ang_var);
handles.m = M;
% Graficar polygono
%figure('Position',[10 100 500 500],'Renderer','zbuffer');
axes(handles.axes1);
cla(handles.axes1);
line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
title('Polygon');
ylabel('x(meters)');
xlabel('y(meters)');
guidata(hObject, handles)


function txt_u_Callback(hObject, eventdata, handles)
% hObject    handle to txt_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_u as text
%        str2double(get(hObject,'String')) returns contents of txt_u as a double


% --- Executes during object creation, after setting all properties.
function txt_u_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_w_Callback(hObject, eventdata, handles)
% hObject    handle to txt_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_w as text
%        str2double(get(hObject,'String')) returns contents of txt_w as a double


% --- Executes during object creation, after setting all properties.
function txt_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_gamma_w_Callback(hObject, eventdata, handles)
% hObject    handle to txt_gamma_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_gamma_w as text
%        str2double(get(hObject,'String')) returns contents of txt_gamma_w as a double


% --- Executes during object creation, after setting all properties.
function txt_gamma_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_gamma_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_r_Callback(hObject, eventdata, handles)
% hObject    handle to txt_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_r as text
%        str2double(get(hObject,'String')) returns contents of txt_r as a double


% --- Executes during object creation, after setting all properties.
function txt_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_b0_Callback(hObject, eventdata, handles)
% hObject    handle to txt_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_b0 as text
%        str2double(get(hObject,'String')) returns contents of txt_b0 as a double


% --- Executes during object creation, after setting all properties.
function txt_b0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_b1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_b1 as text
%        str2double(get(hObject,'String')) returns contents of txt_b1 as a double


% --- Executes during object creation, after setting all properties.
function txt_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_b2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_b2 as text
%        str2double(get(hObject,'String')) returns contents of txt_b2 as a double


% --- Executes during object creation, after setting all properties.
function txt_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in energyButton.
function energyButton_Callback(hObject, eventdata, handles)
% hObject    handle to energyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% UAV and coverage
dx = 20; % distance between lines
curve_radius = 15; %meters
%u = 15; %m/s

%Wind
w = str2double(get(handles.txt_w,'string')); %m/s
gamma_w = str2double(get(handles.txt_gamma_w,'string')) * (pi/180);
v = str2double(get(handles.txt_v,'string'));

%Power estimation
b0 = str2double(get(handles.txt_b0,'string'));
b1 = str2double(get(handles.txt_b1,'string'));
b2 = str2double(get(handles.txt_b2,'string'));
%b2 = 0.0111;
%maxb2 = 0.0111;

% Generar poligono
M = handles.m;

% Obtener una grafica de la función energia
disp('Iniciar rotación');

steps = 100;
maxrotation = pi;
diam = zeros(steps+1,1);
energy = zeros(steps+1,1);
length = zeros(steps+1,5);
gamma = zeros(steps+1,1);
x = 0:maxrotation/steps:maxrotation;
xdeg = (180/pi) .* x;

pts_s = [M(:,1) M(:,2)];
pts_e = [M(:,3) M(:,4)];

axes(handles.axes4)
%figure('Position',[500 290 500 500],'Renderer','zbuffer');
title('Energy')
ylabel('Energy')
xlabel('\beta (radians)')
hold on;

%b2steeps = 10;

i=1;
for beta = 0:maxrotation/steps:maxrotation
        % Rotate M
        pts_s2 = rotatePolygon(pts_s, beta);
        pts_e2 = rotatePolygon(pts_e, beta);
        M2 = [pts_s2' pts_e2'];
        diam(i) = diameter(M2);
        gamma_w_prima = gamma_w + beta;
        [energy(i), D, gamma(i)] = f_energyMR(M2, dx, curve_radius, v, w, gamma_w_prima, b0, b1, b2);
        length(i,:) = [D sum(D)];
        i = i+1;
end
plot(xdeg,energy)

axes(handles.axes2);
plot(xdeg,diam)
title('Diameter')
ylabel('Diameter')
xlabel('\beta (degrees)')

axes(handles.axes5);
plot(xdeg,gamma);
title('Gamma')
ylabel('Diameter')
xlabel('\beta (degrees)')

%figure('Position',[500 190 500 500],'Renderer','zbuffer');
axes(handles.axes3);
hold on;
plot(xdeg,length(:,1))
%plot(xdeg,length(:,1) + length(:,2),'r--')
plot(xdeg,length(:,2))
%plot(xdeg,length(:,3) + length(:,4),'b--')
plot(xdeg,length(:,3))
plot(xdeg,length(:,4))
hold off;
title('Path length')
ylabel('meters')
xlabel('\beta (degrees)')



function txt_v_Callback(hObject, eventdata, handles)
% hObject    handle to txt_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_v as text
%        str2double(get(hObject,'String')) returns contents of txt_v as a double


% --- Executes during object creation, after setting all properties.
function txt_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
