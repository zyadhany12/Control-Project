clear;
close all;
clc;

%% define TF
num = [1.151, 0.1774];
den = [1, 0.739, 0.921, 0];

G = tf(num, den);

%% time and reference signal
t = 0:0.01:50;
r = ones(size(t));   % step input (reference)

%% Closed loop without controller
T0 = feedback(G, 1);

[y0, t] = step(T0, t);

figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, y0, 'b', 'LineWidth', 2);
title('Without Controller');
legend('Reference', 'Output');
grid on;

%% P Controller
Kp = 15;
C_P = Kp;

T_P = feedback(C_P * G, 1);

[yP, t] = step(T_P, t);

figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, yP, 'b', 'LineWidth', 2);
title('P Controller');
legend('Reference', 'Output');
grid on;

%% PI Controller
Kp = 15;
Ki = 1;

C_PI = tf([Kp, Ki], [1 0]);

T_PI = feedback(C_PI * G, 1);

[yPI, t] = step(T_PI, t);

figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, yPI, 'b', 'LineWidth', 2);
title('PI Controller');
legend('Reference', 'Output');
grid on;

%% PD Controller
Kp = 15;
Kd = 8;

C_PD = tf([Kd, Kp], 1);

T_PD = feedback(C_PD * G, 1);

[yPD, t] = step(T_PD, t);

figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, yPD, 'b', 'LineWidth', 2);
title('PD Controller');
legend('Reference', 'Output');
grid on;

%% PID Controller
Kp = 15;
Ki = 1;
Kd = 8;

C_PID = tf([Kd, Kp, Ki], [1, 0]);

T_PID = feedback(C_PID * G, 1);

[yPID, t] = step(T_PID, t);

figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, yPID, 'b', 'LineWidth', 2);
title('PID Controller');
legend('Reference', 'Output');
grid on;

%% Comparison (outputs only + reference)
figure;
plot(t, r, '--r', 'LineWidth', 2); hold on;
plot(t, y0, 'y', t, yP, 'b', t, yPI, 'g', t, yPD, 'c', t, yPID, 'm', 'LineWidth', 1.5);
legend('Reference','No Controller','P','PI','PD','PID');
title('Comparison of All Controllers');
grid on;

%% display
disp('No Controller');
stepinfo(T0)

disp('P Controller');
stepinfo(T_P)

disp('PI Controller');
stepinfo(T_PI)

disp('PD Controller');
stepinfo(T_PD)

disp('PID Controller');
stepinfo(T_PID)