function DrawCone(A, b, c, d)

N = null(c');

if abs(det(A*N)) < 10^-5
    error("not full rank A*N")
end

ANinv = pinv(A*N);

Count_levels = 10;
Count_phi = 20;

phi = linspace(0, 2*pi, Count_phi);
circle.x = cos(phi);
circle.y = sin(phi);
% plot(circle.x, circle.y)

cone.X = zeros(Count_levels, Count_phi);
cone.Y = zeros(Count_levels, Count_phi);
cone.Z = zeros(Count_levels, Count_phi);

for i = 1:Count_levels
    alpha0 = -d / dot(c, c); %making sure the cone starts at the tip
    alpha1 = 1; %the cone is alpha1*norm(c)-long
    alpha = alpha1 * (i-1)              / Count_levels + ... 
            alpha0 * (Count_levels - i) / Count_levels;
    x0 = c*alpha;
    
    r = dot(c, x0) + d;
    m = A*x0 + b;
    for j = 1:Count_phi
        p = [circle.x(j); circle.y(j)];
        p0 = ANinv * (r*p - m);
        
        pp = x0 + N*p0;
        cone.X(i, j) = pp(1);
        cone.Y(i, j) = pp(2);
        cone.Z(i, j) = pp(3);
    end
end

surf(cone.X, cone.Y, cone.Z); hold on;
axis equal

plot3([0; c(1)], [0; c(2)], [0; c(3)], 'Color', 'r');
plot3([0; A(1, 1)], [0; A(1, 2)], [0; A(1, 3)], 'Color', 'b');
plot3([0; A(2, 1)], [0; A(2, 2)], [0; A(2, 3)], 'Color', 'b');

end
