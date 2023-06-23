clc
clear
%%Particle Swarm Test
tic;
N = 2;
num_realiz = 1;
range = [0 500];

x = 0:0.01:5;
y = 0:0.01:5;
z = zeros(501,501);
for count_x = 1:501
    for count_y = 1:501
        z(count_x,count_y) = costfunc(x(count_x),y(count_y));
    end
end

n_it_max = 40;
n_it_min = 5;
brk = 0.001;
n_particles = 10;
w = 0.9;
c1 = 0.5;
c2 = 1.5;
vmax = 0.25;
vmin = -0.25;
best_all = zeros(num_realiz,1);

for realizz = 1:num_realiz

last_vec = zeros(n_it_min,1);
V = zeros(n_particles,N);
Best_pos = zeros(1,N);
pos_particle = randi(range,n_particles,N)/100;
best_y = -18;
best_y_local = zeros(1,n_particles)-18;

for par2 = 1:n_particles
    y_ret = costfunc(pos_particle(par2,1),pos_particle(par2,2));
    best_y_local(par2) = y_ret;
    if(y_ret > best_y)
        best_y = y_ret;
        best_y_pos = pos_particle(par2,:);
    end
end
best_y_local_pos = pos_particle(:,:);
tickloop = tic;
pos_particle = pos_particle + V;
for it = 1:n_it_max
    x_plot_pos(:,it) = pos_particle(:,1);
    y_plot_pos(:,it) = pos_particle(:,2);
    for par = 1:n_particles
        for dim = 1:N
            r1 = rand();
            r2 = rand();
            V(par,dim) = w*V(par,dim) + c1*r1*(-pos_particle(par,dim) + best_y_local_pos(par,dim)) + c2*r2*(-pos_particle(par,dim) + best_y_pos(dim));
            if (V(par,dim)>  vmax)
                V(par,dim) = vmax;
            end
            if (V(par,dim)<vmin)
                V(par,dim) = vmin;
            end
        end
    end
    pos_particle = pos_particle + V;
            
    for par3 = 1:n_particles
        for dim3 = 1:N
            if (pos_particle(par3,dim3)>(range(2)/100))
                pos_particle(par3,dim3)=(range(2)/100);
            end
            if (pos_particle(par3,dim3)<range(1))
                pos_particle(par3,dim3) = range(1);
            end
        end
            
        y_ret = costfunc(pos_particle(par3,1),pos_particle(par3,2));
        
        if(y_ret > best_y)
            best_y = y_ret;
            %fprintf('%f\n',best_y)
            best_y_pos = pos_particle(par3,:);
        end
        if(y_ret > best_y_local(par3))
            best_y_local(par3) = y_ret;
            %fprintf('%d\n',par)
            best_y_local_pos(par3,:) = pos_particle(par3,:);
        end
    end
    for count_last = 1:(n_it_min-1)
        last_vec(count_last) = last_vec(count_last+1);
    end
    last_vec(n_it_min) = best_y;
    if(it>n_it_min)
        if((abs(last_vec(1)-last_vec(n_it_min)))< brk)
            fprintf('Final iteration %d\n',it)
            break;
        end
    end
    %aaaaaaaac = toc;
    %fprintf('best = %f, time = %f, iteration = %d\n',best_y,aaaaaaaac,it)
end
%timer = toc(tickloop);
%fprintf('Iteration %d took %f seconds\n',realizz,timer);
best_all(realizz) = best_y;
end
figure(1);
for plot_res = 1:it
    z_plot = z;
    for i = 1:n_particles
        x_i_plot = round(100*x_plot_pos(i,plot_res));
        x_1 = x_i_plot - 5;
        if(x_1<1)
            x_1 = 1;
        end
        x_2 = x_i_plot + 5;
        if(x_2>501)
            x_2 = 501;
        end
        y_i_plot = round(100*y_plot_pos(i,plot_res));
        y_1 = y_i_plot - 5;
        if(y_1<1)
            y_1 = 1;
        end
        y_2 = y_i_plot + 5;
        if(y_2>501)
            y_2 = 501;
        end
        z_plot(x_1:x_2,y_1:y_2) = 10;
    end
    imagesc(x,y,z_plot);
    pause(0.1);
end

result = mean(best_all);
fprintf('Average result: %f\n',result);