function output = rhofun(var,datas,maxang)

A(4) = var(4);
A(5) = var(5);
A(6) = var(6);

rh = datas;
the = 0;
% SHG
output = maxang .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6)));

% 1 or 2 Photon Fluorescence
% output = A(1) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))) + A(7) .* erfc((rh - (A(4)./(1 + A(5).*cos(the)))) ./ A(8)) + A(9);
end