clc; clear; close all;

A = randn(2, 3);
b = 0.5*randn(2, 1);
c = cross(A(1, :)', A(2, :)');
d = 1*randn();

M = [A; c'];
v = [b; d];

figure('Color', 'w')
DrawCone(A, b, c, d)

for i = 1:1000
x = randn(3, 1);
if norm(A*x + b) <= dot(c, x) + d
    plot3(x(1), x(2), x(3), 'o', 'Color', 'r', 'MarkerSize', 2);
else
    plot3(x(1), x(2), x(3), 'o', 'Color', 'b', 'MarkerSize', 2);
end

xi = M*x + v;
if ( xi(1)^2 + xi(2)^2 <= xi(3)^2 ) && (xi(3) > 0)
    plot3(x(1), x(2), x(3), 'o', 'Color', 'r', 'MarkerSize', 4);
else
    plot3(x(1), x(2), x(3), 'o', 'Color', 'b', 'MarkerSize', 4);
end
end
