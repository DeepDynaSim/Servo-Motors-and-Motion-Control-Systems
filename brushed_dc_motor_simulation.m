%syms Vq(t) iq(t) wm(t) thm(t) Tl(t)
%syms Rq Lq kb kt J B 
%Eq1=Vq==Rq*iq+Lq*diff(iq,t)+kb*wm;
%Eq2=kt*iq==J*diff(wm,t)+B*wm+Tl;
%Eq3=diff(thm,t)==wm;
 
function brushed_dc_motor_simulation()
    % Motor Parameters
    Rq = 2.86; % Resistance (Ohm)
    Lq = 10*10^-3; % Inductance (H)
    kb = 0.15; % Back EMF constant (Ns/rad) 
    kt = 0.15; % Torque constant (Nm/A)
    J = 5*10^-4; % Moment of inertia (kgm^2) 
    B = 2*10^-4; % Damping coefficient (Nms/rad)

    % Load torque as a function of time
    %Tl = @(t) 0.01 * sin(2 * pi * 0.5 * t); % Example: Sinusoidal variation
    Tl=@(t) 11.08*10^-2+(2*10^-4)*200*t+0.44;
    % Input voltage as a function of time
    Vq = @(t) 24 + 2 * cos(2 * pi * 0.1 * t); % Example: Cosine variation
    
    % Simulation Parameters
    tspan = [0, 10]; % Time span for simulation

    % Initial Conditions
    initial_conditions = [0; 0; 0]; % [initial current, initial speed, initial position]

    % Solve ODE
    [t, Y] = ode45(@(t, y) motor_equations(t, y, Vq, Rq, Lq, kb, kt, J, B, Tl), tspan, initial_conditions);

    % Extracting results
    iq = Y(:, 1);
    wm = Y(:, 2);
    thm = Y(:, 3);

    % Plotting results
    figure;
    subplot(3,1,1);
    plot(t, iq);
    title('Motor Current (i_q)');

    subplot(3,1,2);
    plot(t, wm);
    title('Motor Speed (\omega_m)');

    subplot(3,1,3);
    plot(t, thm);
    title('Motor Position (\theta_m)');
end

function dydt = motor_equations(t, y, Vq, Rq, Lq, kb, kt, J, B, Tl)
    iq = y(1);
    wm = y(2);
    thm = y(3);
    
    diqdt = (Vq(t) - Rq*iq - kb*wm) / Lq;
    dwmdt = (kt*iq - B*wm - Tl(t)) / J;
    dthmdt = wm;

    dydt = [diqdt; dwmdt; dthmdt];
end