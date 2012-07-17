global denoised;
global cdata;
global ddata;
global Xa;
global Ya;
global radius;

hold on;
[C,D] = find(denoised > 0, 1);
[E,F] = find(denoised > 0, 1, 'last');
height = F-D;
Xa = D + ((height)/2); % Finds X centrepoint
Tdenoised=denoised'; % Transposes image so that we can use find.
[G,H] = find(Tdenoised > 0, 1);
[I,J] = find(Tdenoised > 0, 1, 'last');
width = J-H;
radius = (width + height)/4;
Ya = H + ((width)/2); % Finds Y centrepoint
set(handles.text_Xcentre,'String',num2str(Xa)); 
set(handles.text_Ycentre,'String',num2str(Ya)); 
%Draw lines on image
axes(handles.circplot);
M = size(denoised,1); 
N = size(denoised,1); % Finds dimensionality of image
for k = Xa; % Sets X value
    x = [k k]; % Sets X to be row vector from 1 to N.
    y = [1 N]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots X centre line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = Ya; % Sets X value
    x = [1 M]; % Sets X to be row vector from 1 to N.
    y = [k k]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots Y centrepoint line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = F; % Sets X value
    x = [k k]; % Sets X to be row vector from 1 to N.
    y = [1 N]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots X centre line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = D; % Sets X value
    x = [k k]; % Sets X to be row vector from 1 to N.
    y = [1 N]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots X centre line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = J; % Sets X value
    x = [1 M]; % Sets X to be row vector from 1 to N.
    y = [k k]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots Y centrepoint line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = H; % Sets X value
    x = [1 M]; % Sets X to be row vector from 1 to N.
    y = [k k]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots Y centrepoint line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
set(handles.pushbutton1, 'Enable','on');
set(handles.pushbutton13, 'Enable','on');
guidata(hObject, handles);