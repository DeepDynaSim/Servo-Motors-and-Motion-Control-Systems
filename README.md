# Servo Motors and Motion Control Systems

**DeepDynaSim collection | Electric drives and motion control | MATLAB / Simulink**

Hands-on educational examples for understanding motor dynamics, load characteristics and feedback control. Explore DC motor simulations, adaptive PID and induction-motor field-oriented control using the files already in this repository.

## Choose an example

| Topic | File |
| --- | --- |
| Motor and load operating curves | [motoroperatingcurve.m](motoroperatingcurve.m) |
| Stability analysis | [stabilityanalysis.m](stabilityanalysis.m) |
| Brushed DC motor dynamics | [brushed_dc_motor_simulation.m](brushed_dc_motor_simulation.m) |
| Adaptive PID speed control | [brushed_dc_motor_adaptive_pid_control.m](brushed_dc_motor_adaptive_pid_control.m) |
| Induction motor direct field-oriented control | [asm_dfoc.slx](asm_dfoc.slx) |
| Archived elevator-control materials | [elevatorcontrol.rar](elevatorcontrol.rar) |

## Getting started

Clone the repository and open its root directory in MATLAB. Review a script before running it so the motor parameters and load definitions match the exercise. Simulink models require Simulink and the additional toolboxes indicated by their blocks.

```matlab
addpath(pwd);
edit brushed_dc_motor_simulation.m
```

Use the detailed notes below as a learning guide. The examples illustrate modelling and controller behaviour; they are not a qualified motor drive or elevator controller. Existing discussions and shared course materials can be found in [Issues](https://github.com/DeepDynaSim/Servo-Motors-and-Motion-Control-Systems/issues).

## Detailed notes

1) Motor Operating Curve: Overview:
This MATLAB script is designed to analyze and visualize the characteristics of different types of electric motors under various load conditions. The code plots the speed-torque curves for synchronous, shunt, and series motors, and compares them against different types of loads including gravity, viscous friction, dry friction, and turbulence loads. This tool is invaluable for students, educators, and professionals in electrical and electronics engineering, particularly those specializing in electric motors.

Code Functionality:

Torque Range Definition:

The script starts by defining a range of torques (T = 0:0.1:10). This range can be adjusted based on specific requirements or motor specifications.
Motor Parameters:

Two example parameters are set: w0 (constant speed for a synchronous motor) and k (a constant used in motor/load characteristics). These parameters are adjustable to fit different motor models.
Load Functions:

Four types of load functions are defined:
load_gravity: Represents a constant load, typical in gravity-dominated scenarios.
load_viscous: Models a viscous load, proportional to the square root of torque.
load_dry: An example of a constant load, representing dry friction.
load_turbulence: Simulates a load for turbulence, proportional to the square of torque.
Motor Characteristics Functions:

Three motor types are modeled:
motor_sync: A synchronous motor with constant speed regardless of torque.
motor_shunt: A shunt motor whose speed decreases linearly with increasing torque.
motor_series: A series motor represented by a parabolic speed-torque relationship.
Plotting:

The script plots the speed-torque curves for each motor and load type. Different colors and styles are used for clarity.
The x-axis represents torque, and the y-axis represents speed.
The plot includes labels, a title, and a grid for better readability.
Operating Point Analysis:

While the script visualizes the motor and load characteristics, finding the exact operating point (where the motor and load curves intersect) would require additional analytical or numerical methods, which can be implemented as an extension of this script.
Applications:

Educational Tool: This script serves as an excellent educational resource for understanding motor characteristics and the effects of different loads.
Design and Analysis: It can be used in the design and analysis phase of motor-driven systems to predict performance under various load conditions.
Customization for Specific Motors: By adjusting the parameters and functions, the script can be tailored to specific types of motors and load scenarios.
Future Enhancements:

Interactive User Interface: Implementing a GUI for real-time parameter adjustments and visualization.
Extended Motor Models: Incorporating more complex motor models, including induction and brushless DC motors.
Operating Point Calculation: Adding functionality to automatically calculate and highlight operating points.

2) Stability Analysis: Overview:
This MATLAB script is an advanced tool for analyzing the relationship between motor torque, load torque, and angular speed in electric motor systems. It includes the calculation of equilibrium points and a basic stability analysis around these points. This script is particularly useful for students and professionals in control systems, electric motor design, and mechanical engineering.

Code Functionality:

Defining Torque Coefficients:

The script begins by defining coefficients for parabolic equations representing motor torque (Tm) and load torque (Tl). These coefficients (am, bm, cm for the motor and al, bl, cl for the load) can be adjusted based on specific motor and load characteristics.
Angular Speed Range:

A range of angular speeds (omega) is defined, which can be modified as needed for different analysis scenarios.
Torque Equations:

The motor and load torques are defined as parabolic functions of angular speed. These functions are crucial for understanding how torque varies with speed in different systems.
Plotting Torques:

The script plots the motor and load torques against angular speed, providing a visual representation of their relationship.
Equilibrium Point Calculation:

The script calculates the equilibrium point, where motor torque equals load torque, using a numerical approach. This point is crucial for understanding the operating conditions of the motor.
Linearization and Stability Analysis:

The system is linearized around the equilibrium point, and a state-space representation is formed. This step is essential for control system analysis.
The script then performs a basic stability check by examining the eigenvalues of the system matrix A.
Output and Visualization:

The equilibrium point and the result of the stability check are displayed in the command window.
The equilibrium point is also plotted on the torque vs. angular speed graph for visual reference.
Applications:

Motor Design and Analysis: Useful for designing motors and understanding how they interact with various loads.
Educational Purposes: An excellent tool for teaching concepts related to motor torque, load torque, and stability in control systems.
Control System Design: Helpful in designing and analyzing control systems for motors, particularly in understanding the behavior around equilibrium points.
Future Enhancements:

Interactive User Interface: Implementing a GUI for easier manipulation of coefficients and parameters.
Extended Analysis Features: Including more comprehensive stability analysis methods and possibly considering non-linear effects.
Real-world Data Integration: Allowing users to input real motor and load data for analysis.

3) Brushed DC Motor Simulation: Overview:
This MATLAB script is designed to simulate the dynamic behavior of a brushed DC motor under varying load and input voltage conditions. It uses ordinary differential equations (ODEs) to model the motor's electrical and mechanical characteristics, providing insights into its current, speed, and position over time.

Code Functionality:

Defining Motor Parameters:

The script sets up key parameters of the brushed DC motor, including resistance (Rq), inductance (Lq), back EMF constant (kb), torque constant (kt), moment of inertia (J), and damping coefficient (B).
Load Torque and Input Voltage:

Load torque (Tl) and input voltage (Vq) are defined as functions of time. The script includes an example of a linearly increasing load torque and a cosine-varying input voltage.
Simulation Setup:

The time span for the simulation (tspan) is defined, along with initial conditions for current, speed, and position.
ODE Solution:

The script uses the ode45 solver to numerically solve the system of ODEs that describe the motor's behavior. The motor_equations function encapsulates these equations.
Motor Equations:

The motor_equations function calculates the derivatives of current (diqdt), angular speed (dwmdt), and angular position (dthmdt) based on the motor parameters, input voltage, and load torque.
Results Extraction and Plotting:

The script extracts the current (iq), speed (wm), and position (thm) from the ODE solver's output and plots these variables over time.
Applications:

Educational Tool: Ideal for teaching concepts related to brushed DC motor operation and control.
Motor Design and Testing: Useful for engineers in designing and testing brushed DC motors under various operating conditions.
Control System Development: Assists in developing and testing control strategies for brushed DC motors.
Future Enhancements:

Parameter Variation: Implementing a GUI or script modifications to easily vary motor parameters and observe the effects.
Advanced Control Algorithms: Integrating control algorithms like PID control to study their impact on motor performance.
Real-world Data Integration: Allowing for the input of real-world motor parameters and load profiles for more accurate simulations.

4) Brushed DC Motor Control with Adaptive PID: Overview:
This MATLAB script simulates a brushed DC motor's response to varying load conditions using an adaptive PID (Proportional-Integral-Derivative) control strategy. The script dynamically adjusts the PID parameters based on the error between the desired and actual motor speeds, optimizing the motor's performance over time.

Code Functionality:

Motor Parameters and Load Torque:

The script defines essential parameters of the brushed DC motor and a time-varying load torque function.
Desired Speed and PID Parameters:

A desired motor speed (desired_speed) is set as the control target.
Initial PID parameters (Kp, Ki, Kd) are defined, representing the proportional, integral, and derivative gains, respectively.
Adaptive Tuning Mechanism:

The script includes thresholds (threshold_high, threshold_low) and limits (Kp_max, Ki_max, Kp_min, Ki_min) for adaptive tuning of PID parameters.
An adjustment_rate determines how quickly the PID parameters are adjusted.
Simulation Setup and ODE Solver:

The time span for the simulation (tspan) and initial conditions are defined.
The ode45 solver is used with optimized settings to solve the system of ODEs.
Motor Equations with Adaptive PID Control:

The motor_equations_adaptive function calculates the derivatives of current, angular speed, and angular position.
It includes logic for PID control and adaptive tuning based on the error between the desired and actual speeds.
Results Extraction and Plotting:

The script plots the motor current, speed, error signal, and control signal over time.
The motor speed plot includes the reference speed for comparison.
Applications:

Control System Design: Useful for designing and testing adaptive PID control systems for brushed DC motors.
Educational Purposes: Ideal for teaching advanced control strategies in electrical and mechanical engineering courses.
Performance Optimization: Assists in optimizing motor performance under varying load conditions.
Future Enhancements:

User Interface for Parameter Adjustment: Implementing a GUI to allow users to easily adjust PID parameters and thresholds.
Real-time Control Implementation: Adapting the script for real-time control applications.
Advanced Adaptive Algorithms: Integrating more sophisticated adaptive control algorithms for improved performance under a wider range of operating conditions.

5) Induction Motor Vector Control Simulation: The uploaded Simulink model provides an in-depth and interactive way to understand and analyze the performance of an induction motor under the direct field-oriented vector control method. This control strategy is known for its efficiency and precision in controlling the speed and torque of induction motors.

Key Features of the Simulation:

Direct Field-Oriented Control (DFOC): The model implements DFOC, a sophisticated control technique that aligns the motor's stator current vector directly with its rotor flux vector, enabling precise control of the motor.

Dynamic Performance Analysis: Users can observe how the motor responds to various load conditions, speed commands, and other operational parameters.

Realistic Motor Parameters: The model is configured with realistic induction motor parameters, making the simulation results relevant for real-world applications.

User-Friendly Interface: The Simulink model is designed to be user-friendly, allowing both beginners and advanced users to explore and modify the control system.

6) Elevator Control System for RTOS: This application is a state-of-the-art simulation and control system model for elevators. It focuses on achieving precise control of elevator speed and position, ensuring smooth operation and accurate stopping at designated floors, even under varying load conditions.

Key Features of the Application:

Realistic Load Simulation: The model considers the dynamic weight of passengers and the counterweight, providing a realistic simulation environment.

Discrete Control System: Tailored for RTOS applications, the control system is designed discretely, making it suitable for implementation in embedded systems used in modern elevator control.

Speed and Position Control: The application includes algorithms for precise control of elevator speed and accurate positioning, essential for passenger comfort and safety.

RTOS Optimization: The control logic is optimized for real-time performance, ensuring responsive and reliable operation in RTOS environments.

User-Friendly Interface: The application includes a user-friendly interface for simulating different scenarios, adjusting parameters, and observing system behavior.


## Related work and collaboration

Explore related repositories: [Complete Kinematic Analysis](https://github.com/DeepDynaSim/Complete-Kinematic-Analysis) · [DeepLyapunovFunction](https://github.com/DeepDynaSim/DeepLyapunovFunction).

[DeepDynaSim](https://github.com/DeepDynaSim) is an engineering R&D and consulting company in İzmir, Türkiye, focused on physics-guided AI, simulation and control. For engineering collaboration: [support@deepdynasim.com](mailto:support@deepdynasim.com). For repository questions, use [Issues](https://github.com/DeepDynaSim/Servo-Motors-and-Motion-Control-Systems/issues).

Reuse follows the existing [LICENSE](LICENSE); academic authorship and third-party attribution remain with their respective creators.
