global Xlims Ylims cdata Xa Ya radius;

[Xlims, Ylims] = ginput(2);
axes(handles.circplot);
hold on;
M = size(cdata,1); 
N = size(cdata,1); % Finds dimensionality of image
for k = Xlims(1); % Sets X value
    x = [k k]; % Sets X to be row vector from 1 to N.
    y = [1 N]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots X centre line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = Xlims(2); % Sets X value
    x = [k k]; % Sets X to be row vector from 1 to N.
    y = [1 N]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots X centre line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = Ylims(1); % Sets X value
    x = [1 M]; % Sets X to be row vector from 1 to N.
    y = [k k]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots Y centrepoint line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
for k = Ylims(2); % Sets X value
    x = [1 M]; % Sets X to be row vector from 1 to N.
    y = [k k]; % Sets y to Y value.
    plot(x,y,'Color','k','Linestyle','-'); % Plots Y centrepoint line
    plot(x,y,'Color','w','Linestyle',':'); % Plots contrast line
end
Xa = (Xlims(2) + Xlims(1))/2;
Ya = (Ylims(2) + Ylims(1))/2;
width = diff(Xlims);
height = diff(Ylims);
radius = (width + height)/4;
set(handles.text_Xcentre,'String',num2str(round(Xa))); 
set(handles.text_Ycentre,'String',num2str(round(Ya))); 
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
set(handles.pushbutton1, 'Enable','on');
set(handles.pushbutton13, 'Enable','on');
guidata(hObject, handles);