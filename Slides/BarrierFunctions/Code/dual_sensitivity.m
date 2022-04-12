clc; clear; close all;

A = [-1, 0; 0, 1];
b = [0; 0];

c = [-1; 0];


%dual
Dual.H = -1/4 *(A*A');
Dual.f = A*c;

lambda = quadprog(-2*Dual.H,-Dual.f,[],[],[],[],[0;0],[]);
g_star = lambda' * Dual.H * lambda + Dual.f' * lambda;

disp('lambda, g_star')
disp(mat2str(round(lambda, 2)))
disp(num2str(round(g_star, 2)))

%primal
Primal.H = eye(2);
Primal.f = -2*c;

x = quadprog(2*Primal.H,Primal.f,A,b,[],[],[],[]);
p_star = (x - c)'*(x - c);

disp('x, p_star')
disp(mat2str(round(x, 2)))
disp(num2str(round(p_star, 2)))