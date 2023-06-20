clc
clear
%%Particle Swarm Test
tic;
N = 2;
num_realiz = 100;
range = [0 500];

n_it_max = 40;
n_particles = 10;
w = 0.9;
c1 = 0.5;
c2 = 1.5;
vmax = 0.25;
vmin = -0.25;
best_all = zeros(num_realiz,1);

for realizz = 1:num_realiz

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
    %aaaaaaaac = toc;
    %fprintf('best = %f, time = %f, iteration = %d\n',best_y,aaaaaaaac,it)
end
%timer = toc(tickloop);
%fprintf('Iteration %d took %f seconds\n',realizz,timer);
best_all(realizz) = best_y;
end

result = mean(best_all);
fprintf('Average result: %f\n',result);