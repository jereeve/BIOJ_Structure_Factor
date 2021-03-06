function output = angfun(var,data)
A(1) = var(1);
A(2) = var(2);
A(3) = var(3);
the = data;

%SHG
% output = A(1) .* (((sin(the + A(2)).^3 + 3.* ((sin(A(3)).^2.*cos(A(3)))./cos(A(3)).^3).* cos(the + A(2)).^2.* sin(the + A(2))).^2));
%SHG (New)
% output = A(1) .* (((cos(the + A(2)).^3.*cos(A(3)).^3 + 3 .* 0.5 .* ((sin(A(3)).^2.*cos(A(3)))).* sin(the + A(2)).^2.* cos(the + A(2))).^2));

%SHG from expectation values
output = A(1) .* ((cos(the + A(2)).^3 + 3 .* A(3) .* sin(the + A(2)).^2.* cos(the + A(2))).^2);


% %SHG with depol
% R = 0;
% output = A(1) .* (((cos(the + A(2)).^3.*cos(A(3)).^3+ 0.5.*R.*cos(the + A(2)).^3.*sin(A(3)).^2.*cos(A(3)) + (3-(R./2)) .* 0.5 .* ((sin(A(3)).^2.*cos(A(3)))).* sin(the + A(2)).^2.* cos(the + A(2))).^2));

end