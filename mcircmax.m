function clicking (gcbo, eventdata, handles)
global model;
figure(4);
imagesc(model);
axis equal off;
colormap gray;
set(gcf, 'PaperPositionMode', 'auto');
set(gcf,'Color','white');
set(gcf, 'InvertHardCopy', 'off');
print(gcf, '-depsc2', 'figure5.eps', '-r300')
end