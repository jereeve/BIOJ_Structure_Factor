%% Initialisation

%After importing (245)
if max(a) > 32768
    a = a - 32768;
end
a = double(a);

% Global some variables
global data Z fitdata;

%Plot data
figure(1);
surfc(a,'edgecolor','none');
axis([-0 512 -0 512 0 500]);
colormap hsv;

% Set some initial variables
X = 246;
Y = 239;
Xa = X*ones(512^2,1);
Ya = Y*ones(512^2,1);

% Matrix dimensions
[Xmax Ymax] = size(a);


% Import architecture
form = importdata('t.mat');

%% Reshape matrix
b = reshape(a',numel(a),1); %row-wise reshaping of a to a column vector
bform = form - [Xa Ya];
data = [bform b];

%% Transform to polar coordinates
global theta rho Z;
[theta rho Z] = cart2pol(data(:,2), data(:,1), data(:,3));



%% Fit surface
fitdata = [theta rho]';
% G = lsqcurvefit(@model2d,[100,0,50,pi/6,1,170,1],fitdata,Z);
% fitfun = @(A,theta,rho) A(1) .* (((sin(theta + A(2)).^3 + 3.* ((sin(A(3)).^2.*cos(A(3)))./cos(A(3)).^3).* cos(theta + A(2)).^2.* sin(theta + A(2))).^2) .* (A(4) .* exp(-(rho - A(5)).^2/(2 .* A(6)))));
[A,error] = lsqcurvefit(@fitfun,[400,0,pi/6,144,1,10],fitdata,Z');
%Amp, phase, tilt, mean, angle, sd

%% Plot Surface
z2 = fitfun(A,fitdata);
m = reshape(z2,512,512);
model= m';
figure(2);
surfc(model,'edgecolor','none');
axis([-0 512 -0 512 0 500]);
colormap hsv;

%% Produce theta plot
boundedrho = rho > 140;
uboundedrho = rho < 144;
logicrho = logical(boundedrho .* uboundedrho);
thetaplot = theta(logicrho);
Zplot = Z(logicrho);
angularfit = angfun(A,thetaplot);
figure(3);
scatter(thetaplot,Zplot,3);
hold on
scatter(thetaplot,angularfit,3,'red');

%% Produce radial plot
boundedrho2 = rho > 130;
uboundedrho2 = rho < 155;
logicrho2 = logical(boundedrho2 .* uboundedrho2);
rhoplot = rho(logicrho2);
Zplot2 = Z(logicrho2);
rhofit = rhofun(A,rhoplot);
figure(5);
scatter(rhoplot,Zplot2,3);
hold on;
scatter(rhoplot,rhofit,3,'red');

%% Transform to polar coordinates
% x = zeros(1,numel(a));
% y = zeros(1,numel(a));
% dim = size(a);
% for i = 1:numel(a)
%     [x(i) y(i)] = ind2sub(dim, i);
%     
%     %Progress bar
%     stopBar = progressbar(i/numel(a),0);
%     
%     if (stopBar) 
%       break; 
%     end
% 
% end
% x = x - X;
% y = y - Y;



