function varargout = lab10(varargin)
% LAB10 MATLAB code for lab10.fig
%      LAB10, by itself, creates a new LAB10 or raises the existing
%      singleton*.
%
%      H = LAB10 returns the handle to a new LAB10 or the handle to
%      the existing singleton*.
%
%      LAB10('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB10.M with the given input arguments.
%
%      LAB10('Property','Value',...) creates a new LAB10 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab10_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab10_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab10

% Last Modified by GUIDE v2.5 16-Sep-2026 18:34:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab10_OpeningFcn, ...
                   'gui_OutputFcn',  @lab10_OutputFcn, ...
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
end

% --- Executes just before lab10 is made visible.
function lab10_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab10 (see VARARGIN)

% Choose default command line output for lab10
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
updatePlot(handles);

% UIWAIT makes lab10 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = lab10_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit_func_Callback(hObject, eventdata, handles)
% hObject    handle to edit_func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_func as text
%        str2double(get(hObject,'String')) returns contents of edit_func as a double
end

% --- Executes during object creation, after setting all properties.
function edit_func_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double
end

% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double
end

% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function updatePlot(handles)
    % Считываем выражение функции
    exprStr = get(handles.edit_func, 'String');
    
    % Считываем границы интервала
    xmin = str2double(get(handles.edit_xmin, 'String'));
    xmax = str2double(get(handles.edit_xmax, 'String'));
    
    if isnan(xmin) || isnan(xmax) || xmin >= xmax
        errordlg('Некорректный интервал!', 'Ошибка ввода');
        return;
    end
    
    x = linspace(xmin, xmax, 1000);
    
    % Преобразуем строку в функцию-хендл и вычисляем значения
    try
        fh = str2func(['@(x) ' exprStr]);
        y = fh(x);
    catch
        errordlg('Некорректное аналитическое выражение!', 'Ошибка ввода');
        return;
    end
    
    % Считываем толщину линии
    lw_options = get(handles.popup_linewidth, 'String');
    lw_idx = get(handles.popup_linewidth, 'Value');
    lineWidth = str2double(lw_options{lw_idx});
    
    % Считываем цвет линии
    color_options = {'b','r','g','k','m'};   % синий,красный,зелёный,чёрный,пурпурный
    color_idx = get(handles.popup_color, 'Value');
    lineColor = color_options{color_idx};
    
    % Строим график
    plot(handles.axes_plot, x, y, 'Color', lineColor, 'LineWidth', lineWidth);
    
    % Управление сеткой
    if get(handles.checkbox_grid, 'Value')
        grid(handles.axes_plot, 'on');
    else
        grid(handles.axes_plot, 'off');
    end
    
    xlabel(handles.axes_plot, 'x');
    ylabel(handles.axes_plot, 'f(x)');
    title(handles.axes_plot, ['График функции: f(x) = ' exprStr]);
end

function pushbutton_plot_Callback(hObject, eventdata, handles)
    updatePlot(handles);
end

function checkbox_grid_Callback(hObject, eventdata, handles)
    updatePlot(handles);
end

function popup_linewidth_Callback(hObject, eventdata, handles)
    updatePlot(handles);
end

function popup_linewidth_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function popup_color_Callback(hObject, eventdata, handles)
    updatePlot(handles);
end

function popup_color_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end
