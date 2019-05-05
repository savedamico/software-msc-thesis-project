function I = Area(x, y)%Metodo del punto medio

n = length(y);
m = length(x);
I=0;
if n == m && n~=0
    for i=1:n-1
        I = I + (0.5*(y(i) + y(i+1))*(x(i+1)-x(i)));
    end
    %I = I + (0.5*(y(n-1) + y(n))*(x(n)-x(n-1)));
end
