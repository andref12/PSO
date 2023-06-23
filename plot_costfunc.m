x = 0:0.01:5;
y = 0:0.01:5;
z = zeros(501,501);
for count_x = 1:501
    for count_y = 1:501
        z(count_x,count_y) = costfunc(x(count_x),y(count_y));
    end
end
figure(1)
surf(x,y,z);
figure(2)
imagesc(x,y,z);
colorbar
grid on
xlabel('$x$ axis','Interpreter','Latex','Fontsize',14)
ylabel('$y$ axis','Interpreter','Latex','Fontsize',14)
