function area = numint(xmin,xmax,delta) % Runs trapezoidal integrations
area = 0;
for k = xmin:delta:xmax
    l = k + delta;
    area = area + delta * ((f(l) + f(k))/2);
end

end
