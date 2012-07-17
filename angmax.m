function clicking (gcbo, eventdata, handles)
global A thetaplot Zplot angularfit angularfit2 angularfit3 thetavals;
figure(5);
hold on;
A(2);
handle3 = scatter(thetaplot,Zplot,3);
% scatter(thetavals,angularfit,3);
% scatter(thetavals,angularfit2,3);
% scatter(thetavals,angularfit3,3);
axis(gca, [-pi pi 0 300]); axis autoy;
syms the;

handle5 = ezplot(A(1) .* (((cos(the + A(2)).^3 + 3 .* A(3) .* sin(the + A(2)).^2.* cos(the + A(2))).^2)), [-pi, pi]);
set(handle5,'LineWidth',2,'Color','k','linestyle','-');
set(handle3,'SizeData',15,'LineWidth',.5,'MarkerEdgeColor','k','MarkerFaceColor',[.6 .6 .6]);
%Title and Axes
hTitle  = title ('');
hXLabel = ylabel('Intensity (photons)');
hYLabel = xlabel('Angle around profile (degrees)');

set(gca, 'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel],'FontName', 'Helvetica');
set([hXLabel, hYLabel], 'FontSize', 16);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'off'      , ...
  'XTick'       , -pi:pi/4:pi, ...
  'YTick'       , 0:50:300, ...
  'FontSize', 14, ...
  'LineWidth'   , 1         );
axis(gca, [-pi pi 0 300]);
set(gcf, 'PaperPositionMode', 'auto');
set(gcf,'Color','white');
set(gcf, 'InvertHardCopy', 'off');
export_fig figure1.png -painters -r300 ;

% print(gcf, '-depsc2', 'figure1.eps', '-r300')
end