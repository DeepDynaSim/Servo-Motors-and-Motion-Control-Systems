% Define coefficients for motor and load torque parabolic equations
am = 0.8; bm = 1; cm = 2; % Coefficients for motor torque
al = 0.7; bl = 1.2; cl = 2.5; % Coefficients for load torque

% Define a range of angular speeds
omega = 0:0.1:10; % Adjust the range as needed

% Define the motor and load torques
Tm = @(omega) am * omega.^2 + bm * omega + cm; % Motor torque (Parabolic)
Tl = @(omega) al * omega.^2 + bl * omega + cl; % Load torque (Parabolic)

% Plotting
figure;
hold on;
plot(omega, Tm(omega), 'b', 'DisplayName', 'Motor Torque');
plot(omega, Tl(omega), 'r', 'DisplayName', 'Load Torque');

% Find the equilibrium point
omega_eq_idx = find(abs(Tm(omega) - Tl(omega)) < 0.1, 1, 'first'); % Threshold for finding equilibrium
omega_eq = omega(omega_eq_idx);
T_eq = Tm(omega_eq);

% Plot the equilibrium point
plot(omega_eq, T_eq, 'ko', 'MarkerSize', 10, 'DisplayName', 'Equilibrium Point');

% Add labels, title, and legend
xlabel('Angular Speed (ω)');
ylabel('Torque (T)');
title('Motor and Load Torque (Parabolic) vs Angular Speed');
legend('show');
grid on;

% Define system parameters
J =10; % Moment of inertia (Define this value)

% System linearization around the operating point
% Derivatives of Tm and Tl with respect to omega at the equilibrium point
dTm_domega = 2 * am * omega_eq + bm;
dTl_domega = 2 * al * omega_eq + bl;

% State-space representation (Linearized around the equilibrium point)
A = [-dTm_domega/J];
B = [1/J];
C = [1];
D = [0];

% Check stability
eigenvalues = eig(A);
isStable = all(real(eigenvalues) < 0);

% Display the equilibrium point in command window
fprintf('Equilibrium occurs at Angular Speed = %.2f, Torque = %.2f\n', omega_eq, T_eq);

% Display the result of stability check
if isStable
    disp('The equilibrium point is stable.');
else
    disp('The equilibrium point is not stable.');
end