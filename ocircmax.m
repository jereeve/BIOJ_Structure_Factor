function clicking (gcbo, eventdata, handles)
global cdata;
figure(3);
imagesc(cdata);
axis equal off;
colormap gray;
set(gcf, 'PaperPositionMode', 'auto');
set(gcf,'Color','white');
set(gcf, 'InvertHardCopy', 'off');
print(gcf, '-depsc2', 'figure4.eps', '-r300')
end