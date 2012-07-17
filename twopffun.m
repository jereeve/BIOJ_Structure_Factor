

function output = twopffun(var,data)
A(1) = var(1);
A(2) = var(2);
A(3) = var(3);
A(4) = var(4);
A(5) = var(5);
A(6) = var(6);
A(7) = var(7);
A(8) = var(8);
A(9) = var(9);
A(10) = var(10);
the = data(1,:);
rh = data(2,:);
%SHG Parallel
% output = A(1) .* (((sin(the + A(2)).^3 + 3.* ((sin(A(3)).^2.*cos(A(3)))./cos(A(3)).^3).* cos(the + A(2)).^2.* sin(the + A(2))).^2) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))));

% 1PF
% output = A(1) .* (3 .* (cos(the + A(2)).^2 - (1/3)) .* cos(A(3)).^2 - cos(the + A(2)).^2 + 1) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))) + A(7) .* erfc((rh - (A(4)./(1 + A(5).*cos(the)))) ./ A(8)) + A(9);

% 2PF
% output = A(1) .* (cos(the + A(2)).^4.*cos(A(3)).^4 + (3/16).*sin(2.*(the + A(2))).^2.*sin(2.*A(3)).^2 + (3/8).*sin(the + A(2)).^4.*sin(A(3)).^4) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))) + A(7) .* erfc((rh - (A(4)./(1 + A(5).*cos(the)))) ./ A(8)) + A(9);

% 2PF to output expectation values (Old)
% output = A(1) .* (cos(the + A(2)).^4.*A(3) + (3/16).*sin(2.*(the + A(2))).^2 + (3/8).*sin(the + A(2)).^4.*A(10)) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))) + A(7) .* erfc((rh - (A(4)./(1 + A(5).*cos(the)))) ./ A(8)) + A(9);

% 2PF to output expectation values (Benninger/Reeve)
output = A(1) .* ((cos(the + A(2))).^4.*A(3) + (3/16).*(sin(2.*(the + A(2)))).^2 + (3/8).*A(10).*(sin(the + A(2))).^4) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))) + A(7) .* erfc((rh - (A(4)./(1 + A(5).*cos(the)))) ./ A(8)) + A(9);

end