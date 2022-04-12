clc; clear; close all;

A = [-1, 0; 0, 1];
b = [0; 0];

x_lim = 1;
Count = 20;

ResPrimal.X = NaN(Count, Count);
ResPrimal.Y = NaN(Count, Count);
ResPrimal.Z = NaN(Count, Count);

for i = 1:Count
for j = 1:Count
    x = [-x_lim + ((i-1)/Count) *2*x_lim;
         -x_lim + ((j-1)/Count) *2*x_lim];
    if (A*x <= b)
        ResPrimal.X(i, j) = x(1);
        ResPrimal.Y(i, j) = x(2);
        ResPrimal.Z(i, j) = 0;
    end
end
end

figure('Color', 'w')

subplot(1, 2, 1)
surf(ResPrimal.X, ResPrimal.Y, ResPrimal.Z, 'EdgeAlpha', 0.2);
ax = gca;
ax.FontSize = 16;
ax.XLim = [-1; 1];
ax.YLim = [-1; 1];
title('domain')


ResDual.X = NaN(Count, Count);
ResDual.Y = NaN(Count, Count);
ResDual.Lambda1 = zeros(Count, Count);
ResDual.Lambda2 = zeros(Count, Count);

for i = 1:Count
for j = 1:Count
    c = [-x_lim + ((i-1)/Count) *2*x_lim;
         -x_lim + ((j-1)/Count) *2*x_lim];

    Dual.H = -1/4 *(A*A');
    Dual.f = A*c;

    lambda = quadprog(-2*Dual.H,-Dual.f,[],[],[],[],[0;0],[]);
    %g_star = lambda' * Dual.H * lambda + Dual.f' * lambda;    

    ResDual.X(i, j) = c(1);
    ResDual.Y(i, j) = c(2);
    ResDual.Lambda1(i, j) = lambda(1);
    ResDual.Lambda2(i, j) = lambda(2);

end
end

subplot(1, 2, 2)
quiver(ResDual.X,ResDual.Y,ResDual.Lambda1,ResDual.Lambda2);
ax = gca;
ax.FontSize = 16;
ax.XLim = [-1; 1];
ax.YLim = [-1; 1];
title('sensitivity')
