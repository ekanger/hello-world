%f(x) = e^x + 2x, ønsker å finne null punktet til dette polynomet og vise
%hvordan løsningen sakte men sikkert nærmer seg for hver iterasjon.

% x(n+1)=x(n) - f(x(n))/f'(x(n))

f = @(x) exp(x) + 2*x;
df = @(x) exp(x) + 2;

n=5; 
sol = zeros(1,n);
sol(1)=1;
for i=1:n
    sol(i+1)=sol(i) - f(sol(i))/df(sol(i)); 
end
plot(sol)
