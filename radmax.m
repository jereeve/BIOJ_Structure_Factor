function clicking (gcbo, eventdata, handles)
global A rhoplot Zplot2 rhofit;
figure(6);
hold on;
scatter(rhoplot,Zplot2,3);
scatter(rhoplot,rhofit,3,'red');
axis([(A(4) - A(6) .* 1.5) (A(4) + A(6) .* 1.5) 0 500], 'auto y');
end