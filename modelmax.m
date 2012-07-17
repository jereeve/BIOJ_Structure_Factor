function clicking (gcbo, eventdata, handles)
global model v;
figure(2);
surfc(model,'edgecolor','none');
axis([0 512 0 512 0 300]); axis auto;

colormap jet;

hTitle  = title ('');
hXLabel = zlabel('Intensity (photons)');
% hYLabel = zlabel('');
set(gca, 'FontName'   , 'Helvetica' );
% set([hXLabel, hYLabel],'FontName', 'Helvetica');
% set([hXLabel, hYLabel], 'FontSize', 16);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'off'      , ...
  'XTick'       , 0:128:512, ...
  'YTick'       , 0:128:512, ...
  'ZTick'       , 0:50:300, ...
  'FontSize', 14, ...
  'LineWidth'   , 1         );

set(gcf, 'PaperPositionMode', 'auto');
set(gcf,'Color','white');
set(gcf, 'InvertHardCopy', 'off');
export_fig '-painters' 'figure3.png' '-r300'
% export_fig figure2.png -painters -r300 ;
end