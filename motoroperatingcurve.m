% Define the range of torques
T = 0:0.1:10; % Adjust the range as needed

% Motor parameters (adjust these as needed)
w0 = 10; % Example constant speed for synchronous motor
k = 0.5; % Example constant for motor/load characteristics

% Define Load Functions
load_gravity = @(T) 5; % Example constant load
load_viscous = @(T) k * sqrt(T); % Example viscous load
load_dry = @(T) 3; % Example constant load for dry friction
load_turbulence = @(T) k * T.^2; % Example load for turbulence

% Define Motor Characteristics
motor_sync = @(T) w0; % Synchronous motor
motor_shunt = @(T) w0 - k * T; % Shunt motor
motor_series = @(T) 1./T; % Series motor (parabolic)

% Plotting
figure;
hold on;

% Plot for each motor type
plot(T, motor_sync(T), 'b', 'DisplayName', 'Synchronous Motor');
plot(T, motor_shunt(T), 'r', 'DisplayName', 'Shunt Motor');
plot(T, motor_series(T), 'g', 'DisplayName', 'Series Motor');

% Plot for each load type
plot(T, load_gravity(T), 'b--', 'DisplayName', 'Gravity Load');
plot(T, load_viscous(T), 'r--', 'DisplayName', 'Viscous Friction Load');
plot(T, load_dry(T), 'g--', 'DisplayName', 'Dry Friction Load');
plot(T, load_turbulence(T), 'k--', 'DisplayName', 'Turbulence Load');

% Add labels and legend
xlabel('Torque (T)');
ylabel('Speed (ω)');
title('Motor and Load Characteristics');
%legend('show');
grid on;


% Finding the operating point would involve finding the intersection

% of these curves, which can be done analytically or numerically.