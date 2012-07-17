function output = angfuntwo(var,data)
A(1) = var(1);
A(2) = var(2);
A(3) = var(3);
A(9) = var(9);
A(10) = var(10);
the = data;

%SHG
% output = A(1) .* (((sin(the + A(2)).^3 + 3.* ((sin(A(3)).^2.*cos(A(3)))./cos(A(3)).^3).* cos(the + A(2)).^2.* sin(the + A(2))).^2));

% 1PF
% output = A(1) .* (3 .* (cos(the + A(2)).^2 - (1/3)) .* cos(A(3)).^2 - cos(the + A(2)).^2 + 1) + A(9);

% 2PF
output = A(1) .* ((cos(the + A(2))).^4.*A(3) + (3/16).*(sin(2.*(the + A(2)))).^2 + (3/8).*A(10).*(sin(the + A(2))).^4) + A(9);
end