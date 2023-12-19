function brushed_dc_motor_adaptive_pid_control()
    % Motor Parameters
    Rq = 2.86; % Resistance (Ohm)
    Lq = 10*10^-3; % Inductance (H)
    kb = 0.15; % Back EMF constant (Ns/rad) 
    kt = 0.15; % Torque constant (Nm/A)
    J = 5*10^-4; % Moment of inertia (kgm^2) 
    B = 2*10^-4; % Damping coefficient (Nms/rad)

    % Load torque as a function of time
    Tl = @(t) 11.08*10^-2 + (2*10^-4) * 200 * t + 0.44;

    % Desired speed (setpoint)
    desired_speed = 100; % Desired speed in rad/s

    % Fine-Tuned Initial PID Controller Parameters
    Kp = 0.8; % Higher Proportional gain
    Ki = 0.15; % Adjusted Integral gain
    Kd = 0.02; % Adjusted Derivative gain

    % Adaptive Tuning Thresholds and Limits
    threshold_high = 10; % High error threshold
    threshold_low = 1;  % Low error threshold
    Kp_max = 10; % Maximum allowable Kp
    Ki_max = 5; % Maximum allowable Ki
    Kp_min = 0.1; % Minimum allowable Kp
    Ki_min = 0.05; % Minimum allowable Ki
    adjustment_rate = 0.05; % Rate of adjustment

    % Simulation Parameters
    tspan = [0, 3]; % Time span for simulation

    % Initial Conditions (Extended to include PID parameters)
    initial_conditions = [0; 0; 0; 0; 0; 0; 0; Kp; Ki; Kd];

    % ODE Solver with Optimized Settings
    options = odeset('RelTol',1e-4,'AbsTol',1e-6); % Adjusted tolerances
    [t, Y] = ode45(@(t, y) motor_equations_adaptive(t, y, desired_speed, Rq, Lq, kb, kt, J, B, Tl, threshold_high, threshold_low, Kp_max, Ki_max, Kp_min, Ki_min, adjustment_rate), tspan, initial_conditions, options);

    % Extracting results
    iq = Y(:, 1);
    wm = Y(:, 2);
    thm = Y(:, 3);
    error_signal = desired_speed - wm;
    control_signal = Y(:, 8) .* error_signal + Y(:, 9) .* Y(:, 4) + Y(:, 10) .* (error_signal - Y(:, 5));

    % Plotting results
    figure;
    subplot(4,1,1);
    plot(t, iq);
    title('Motor Current (i_q)');

    subplot(4,1,2);
    plot(t, wm);
    hold on;
    plot(t, desired_speed * ones(size(t)), '--');
    hold off;
    title('Motor Speed (\omega_m) vs. Reference Speed');
    legend('Actual Speed', 'Reference Speed');

    subplot(4,1,3);
    plot(t, error_signal);
    title('Error Signal');

    subplot(4,1,4);
    plot(t, control_signal);
    title('Control Signal (Vq)');
end

function dydt = motor_equations_adaptive(t, y, desired_speed, Rq, Lq, kb, kt, J, B, Tl, threshold_high, threshold_low, Kp_max, Ki_max, Kp_min, Ki_min, adjustment_rate)
    % Extracting state variables and PID parameters from y
    iq = y(1);
    wm = y(2);
    integral_error = y(4);
    prev_error = y(6);
    prev_time = y(7);
    Kp = y(8);
    Ki = y(9);
    Kd = y(10);

    % Calculate new time step (dt)
    dt = t - prev_time;

    % PID Control Logic
    error = desired_speed - wm;
    integral_error = integral_error + error * dt;
    derivative_error = (error - prev_error) / (dt + eps); % Add eps to avoid division by zero
    % Efficient Adaptive Tuning
    if abs(error) > threshold_high
        Kp = min(Kp + adjustment_rate, Kp_max);
        Ki = min(Ki + adjustment_rate, Ki_max);
    elseif abs(error) < threshold_low
        Kp = max(Kp - adjustment_rate, Kp_min);
        Ki = max(Ki - adjustment_rate, Ki_min);
    end

    % Integral Windup Prevention
    if Ki * integral_error > 10
        integral_error = 10 / Ki; % Adjust as needed
    elseif Ki * integral_error < -10
        integral_error = -10 / Ki; % Adjust as needed
    end

    Vq = Kp * error + Ki * integral_error + Kd * derivative_error;

    % Motor equations
    diqdt = (Vq - Rq*iq - kb*wm) / Lq;
    dwmdt = (kt*iq - B*wm - Tl(t)) / J;
    dthmdt = wm;

    % Updating the state vector dydt
    dydt = [diqdt; dwmdt; dthmdt; integral_error; derivative_error; error; t; Kp; Ki; Kd];
end