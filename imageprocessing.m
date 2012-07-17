function varargout = imageprocessing(varargin)
% IMAGEPROCESSING MATLAB code for imageprocessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSING.M with the given input arguments.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageprocessing

% Last Modified by GUIDE v2.5 06-Jan-2012 11:54:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @imageprocessing_OutputFcn, ...
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


% --- Executes just before imageprocessing is made visible.
function imageprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageprocessing (see VARARGIN)

% Choose default command line output for imageprocessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Initialisation
global deno thresh segmentcarrier;
segmentcarrier = 0;
deno = 500;
thresh = 30;
set(handles.pushbutton1, 'Enable','off'); % Can't auto-delimit until you threshold.
set(handles.autolimits, 'Enable','off'); % Can't start fitting until you define a few seed variables.
set(handles.pushbutton13, 'Enable','off'); % Can't remove a segment until you have a centrepoint.

% --- Outputs from this function are returned to the command line.
function varargout = imageprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to denoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global thresh cdata binary denoised;
axes(handles.circplot);
thresh = get(handles.threshold,'Value');
set(handles.thresh_valueout,'String',num2str(thresh));
binary = cdata > thresh;
denoised = bwareaopen(binary, 40);
imagesc(denoised);
guidata(hObject, handles);
set(handles.autolimits, 'Enable','on');

% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to denoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global theta rho Z dimx segmentcarrier dimy  A cdata deno radius fitdata2 v thetaplot thetavals Zplot angularfit angularfit2 angularfit3 rhoplot Zplot2 rhofit model rho theta logicrho logicrho2;

% Remove segements highlighted in segment remover
if segmentcarrier == 1
    coords = [theta rho Z];
    coords(coords(:,3)<0, :) = [];
    theta = coords(:,1);
    rho = coords(:,2);
    Z = coords(:,3);
end

% Prepare data
fitdata = [theta rho]';    % Function requires XY be one matrix, columnwise

% Do fit
if get(handles.radio_para,'value') == 1 % Sends data to correct user-specified fitting function
    [A,error] = lsqcurvefit(@fitfun,[deno,pi/2,pi/10,radius,0,20],fitdata,Z');
elseif get(handles.radio_perp,'value') == 1
    [A,error] = lsqcurvefit(@fitfunperp,[deno,pi/2,pi/7,radius,0,8],fitdata,Z');
elseif get(handles.radiobutton3,'value') == 1 % Sends data to correct user-specified fitting function
    [A,error] = lsqcurvefit(@onepffun,[50000,pi/2,pi/5,radius,0,8,20,10,10],fitdata,Z');
elseif get(handles.radiobutton4,'value') == 1 % Sends data to correct user-specified fitting function
    [A,error] = lsqcurvefit(@twopffun,[deno,pi/2,pi/6,radius,0,8,20,10,10,pi/6],fitdata,Z');
else
    disp('Image must be either Parallel or Perpendicular, 1PF or 2PF');
end

num2clip([A error]);                % Copies output to clipboard

% Plot results
% First surface
if segmentcarrier == 1
    if get(handles.radio_para,'value') == 1 % Gets plot for appropriate user-specified function
        z2 = fitfun(A,fitdata2);
    elseif get(handles.radio_perp,'value') == 1
        z2 = fitfunperp(A,fitdata2);
    elseif get(handles.radiobutton3,'value') == 1
        z2 = onepffun(A,fitdata2);
    elseif get(handles.radiobutton4,'value') == 1
        z2 = twopffun(A,fitdata2);
    else
        disp('Image must be either Parallel or Perpendicular');
    end
else
    if get(handles.radio_para,'value') == 1 % Gets plot for appropriate user-specified function
        z2 = fitfun(A,fitdata);
    elseif get(handles.radio_perp,'value') == 1
        z2 = fitfunperp(A,fitdata);
    elseif get(handles.radiobutton3,'value') == 1
        z2 = onepffun(A,fitdata);
    elseif get(handles.radiobutton4,'value') == 1
        z2 = twopffun(A,fitdata);
    else
        disp('Image must be either Parallel or Perpendicular');
    end
end

model = reshape(z2,dimx,dimy)';     % Reshapes model output from function
axes(handles.modelplot);            % Define axes
surfc(model,'edgecolor','none');    % Plots surface        
axis(v);                            % Keeps same axes as surface plot of image
colormap jet;                       % Aesthetics

axes(handles.ocircplot);            % Define axes
imagesc(cdata);                     % Plot image from data
axes(handles.mcircplot);            % Define axes
imagesc(model);                     % Plot image from model
% imwrite(uint8(cdata), 'cdata.tif', 'tif');
% imwrite(uint8(model), 'model.tif', 'tif');

% Then angular plot to show goodness of fit
boundedrho = rho > (A(4) - (A(6)/8));                       % Selects ROI upper bound                                     
uboundedrho = rho < (A(4) + (A(6)/8));                      % Selects ROI lower bound
randop = logical(rand(1,numel(rho))<0.1)';
logicrho = logical(boundedrho .* uboundedrho .* randop);
thetaplot = theta(logicrho);
Zplot = Z(logicrho); % Logical selection of those values  
thetavals = -pi:0.005:pi;
if get(handles.radio_para,'value') == 1                     % Plotting of appropriate model
    angularfit = angfun(A,thetavals);
elseif get(handles.radio_perp,'value') == 1
    angularfit = angfunperp(A,thetavals);
elseif get(handles.radiobutton3,'value') == 1
    angularfit = angfunone(A,thetavals);
elseif get(handles.radiobutton4,'value') == 1
    angularfit = angfuntwo(A,thetavals);
else
    disp('Image must be either Parallel or Perpendicular');
end
    B = A;
    B(3) = (A(3) / 100) * 110;
if get(handles.radio_para,'value') == 1 % Plotting of appropriate model
    angularfit2 = angfun(B,thetavals);
elseif get(handles.radio_perp,'value') == 1
    angularfit2 = angfunperp(B,thetavals);
elseif get(handles.radiobutton3,'value') == 1
    angularfit2 = angfunone(B,thetavals);
elseif get(handles.radiobutton4,'value') == 1
    angularfit2 = angfuntwo(B,thetavals);
else
    disp('Image must be either Parallel or Perpendicular');
end
    C = A;
    C(3) = (A(3) / 100) * 90;
if get(handles.radio_para,'value') == 1 % Plotting of appropriate model
    angularfit3 = angfun(C,thetavals);
elseif get(handles.radio_perp,'value') == 1
    angularfit3 = angfunperp(C,thetavals);
elseif get(handles.radiobutton3,'value') == 1
    angularfit3 = angfunone(C,thetavals);
elseif get(handles.radiobutton4,'value') == 1
    angularfit3 = angfuntwo(C,thetavals);
else
    disp('Image must be either Parallel or Perpendicular');
end
axes(handles.angplot);                                      % Display images
hold on;
scatter(thetaplot,Zplot,3);
scatter(thetavals,angularfit,3);
scatter(thetavals,angularfit2,3);
scatter(thetavals,angularfit3,3);
axis([-pi pi 0 500], 'auto y');
maxang = max(angularfit);
% num2clip([thetaplot Zplot]);
% pause(10);

% Then radial plot to show goodness of fit - same layout as above
boundedrho2 = rho > (A(4) - A(6) .* 1.5); 
uboundedrho2 = rho < (A(4) + A(6) .* 1.5);
randop = logical(rand(1,numel(rho))<0.006)';
logicrho2 = logical(boundedrho2 .* uboundedrho2 .* randop);
rhoplot = rho(logicrho2);
thetaplot2 = theta(logicrho2);
Zplot2 = Z(logicrho2);
if get(handles.radio_para,'value') == 1 || get(handles.radio_perp,'value') == 1 % Plotting of appropriate model
    rhofit = rhofun(A,rhoplot,maxang);
else
    rhofit = rhofunone(A,rhoplot,maxang);
end
axes(handles.radplot);
hold on;
scatter(rhoplot,Zplot2,3);
scatter(rhoplot,rhofit,3,'red');
axis([(A(4) - A(6) .* 1.5) (A(4) + A(6) .* 1.5) 0 500], 'auto y');

% Code to allow popouts
set(handles.surfplot, 'buttondownfcn', @surfmax)    % Callbacks for clicking on graphs to popout figure
set(handles.modelplot, 'buttondownfcn', @modelmax)
set(handles.ocircplot, 'buttondownfcn', @ocircmax)
set(handles.mcircplot, 'buttondownfcn', @mcircmax)
set(handles.radplot, 'buttondownfcn', @radmax)
% set(handles.angplot, 'buttondownfcn', @angmax)
% End

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function denoising_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
lbox2;  % Calls listbox function to open file - must be in same directory

% --- Executes on button press in autolimits.
function denoising_Callback(hObject, eventdata, handles)
global deno;                                            % Globals variables
axes(handles.circplot);                                 % Sets focus on circplot
deno = round(get(handles.denoising,'Value'));           % Gets value from slider
set(handles.text_denoisingout,'String',num2str(deno));  % Displays value next to slider

% --- Executes on button press in pushbutton1.
function autolimits_Callback(hObject, eventdata, handles)
global theta rho Z dimx dimy cdata Xa Ya coords3 fitdata2;
drawlines;
% Create architecture
[P, Q] = ndgrid(1:dimx, 1:dimy);    % Creates 512x512x2 matrix where val=subscript
form = reshape([P Q],dimx*dimy,2);  % Turns architecture into an x,y,z triple

Xb = Xa*ones(dimx^2,1);             % Vector of Xa to subtract to centre cartesian coordinates
Yb = Ya*ones(dimy^2,1);             % Same for Ya

% Reshape architecture - @fitfun requires an x,y,z triple
b = reshape(cdata',numel(cdata),1); % row-wise reshaping of cdata to a column vector
bform = form - [Xb Yb];             % Zeroes cartesian coordinates at centre of circle
data = [bform b];                   % Creates x,y,z triple

% Convert to polar
[theta rho Z] = cart2pol(data(:,2), data(:,1), data(:,3));
coords3 = [theta rho Z];
fitdata2 = [theta rho]';

% --- Executes on button press in manuallimits.
function manuallimits_Callback(hObject, eventdata, handles)
global theta rho Z dimx dimy cdata Xa Ya coords3 fitdata2;
drawlines2;
% Create architecture
[P, Q] = ndgrid(1:dimx, 1:dimy);    % Creates 512x512x2 matrix where val=subscript
form = reshape([P Q],dimx*dimy,2);  % Turns architecture into an x,y,z triple

Xb = Xa*ones(dimx^2,1);             % Vector of Xa to subtract to centre cartesian coordinates
Yb = Ya*ones(dimy^2,1);             % Same for Ya

% Reshape architecture - @fitfun requires an x,y,z triple
b = reshape(cdata',numel(cdata),1); % row-wise reshaping of cdata to a column vector
bform = form - [Xb Yb];             % Zeroes cartesian coordinates at centre of circle
data = [bform b];                   % Creates x,y,z triple

% Convert to polar
[theta rho Z] = cart2pol(data(:,2), data(:,1), data(:,3));
coords3 = [theta rho Z];
fitdata2 = [theta rho]';

% --- Executes on button press in radio_para.
function radio_para_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radio_para
set(handles.radio_para, 'value',1);
set(handles.radio_perp, 'value',0);
set(handles.radiobutton3, 'value',0);
set(handles.radiobutton4, 'value',0);
gcbf

% --- Executes on button press in radio_perp.
function radio_perp_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radio_perp
set(handles.radio_para, 'value',0);
set(handles.radio_perp, 'value',1);
set(handles.radiobutton3, 'value',0);
set(handles.radiobutton4, 'value',0);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radio_para, 'value',0);
set(handles.radio_perp, 'value',0);
set(handles.radiobutton3, 'value',1);
set(handles.radiobutton4, 'value',0);

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radio_para, 'value',0);
set(handles.radio_perp, 'value',0);
set(handles.radiobutton3, 'value',0);
set(handles.radiobutton4, 'value',1);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Removes segment
global theta rho Z coords2 coords3 dimx dimy segmentcarrier Xa Ya;
pcoords = Z;
coords2 = Z;
[Xang, Yang] = ginput(2);

% Find angles and correct for coordinate system
bound1 = atan2(-(Yang(1) - Ya), (Xang(1) - Xa)) + pi/2;
bound2 = atan2(-(Yang(2) - Ya), (Xang(2) - Xa)) + pi/2;
if bound1 > pi
    bound1 = bound1 - 2*pi;
end
if bound2 > pi
    bound2 = bound2 - 2*pi;
end

% Remove relevant datapoints
if bound2 > bound1
    coords2(coords3(:,1)>bound2, :) = nan;
    coords2(coords3(:,1)<bound1, :) = nan;
    pcoords(coords3(:,1)>bound2, :) = -1;
    pcoords(coords3(:,1)<bound1, :) = -1;
else
    coords2((coords3(:,1)<bound1) & (coords3(:,1)>bound2), :) = nan;
    pcoords((coords3(:,1)<bound1) & (coords3(:,1)>bound2), :) = -1;
end

% Plot Image of new dataset
coords2 = coords2';
model2 = reshape(coords2,dimx,dimy)'; 
figure(12);
imagesc(model2);
axis equal;

% Return outputs to original
Z = pcoords;

% And some housekeeping to that the software knows you've removed a
% segment.
segmentcarrier = 1;

