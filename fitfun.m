

function output = fitfun(var,data)
A(1) = var(1);
A(2) = var(2);
A(3) = var(3);
A(4) = var(4);
A(5) = var(5);
A(6) = var(6);
the = data(1,:);
rh = data(2,:);

%SHG Parallel (new function)
% output = A(1) .* (((cos(the + A(2)).^3.*cos(A(3)).^3 + 3 .* 0.5 .* ((sin(A(3)).^2.*cos(A(3)))).* sin(the + A(2)).^2.* cos(the + A(2))).^2) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))));

% SHG Parallel for finding expectation values
output = A(1) .* (((cos(the + A(2)).^3 + 3 .* A(3) .* sin(the + A(2)).^2.* cos(the + A(2))).^2) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))));


% % For depolarisation ratio
% R = 0.2;
% %SHG Parallel (new function)
% output = A(1) .* (((cos(the + A(2)).^3.*cos(A(3)).^3+ 0.5.*R.*cos(the + A(2)).^3.*sin(A(3)).^2.*cos(A(3)) + (3-(R./2)) .* 0.5 .* ((sin(A(3)).^2.*cos(A(3)))).* sin(the + A(2)).^2.* cos(the + A(2))).^2) .* exp(-(rh - (A(4)./(1 + A(5).*cos(the)))).^2/(2 .* A(6))));
end