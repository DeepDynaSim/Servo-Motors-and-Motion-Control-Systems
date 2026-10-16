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

## Implemented examples

### Motor operating curves

`motoroperatingcurve.m` plots illustrative speed-versus-torque functions:

| Curve | Implemented function |
|---|---|
| Constant-speed example | `w0` |
| Shunt-like line | `w0 - k*T` |
| Reciprocal series-like curve | `1/T` |
| Two constant reference curves | `5` and `3` |
| Additional reference shapes | `k*sqrt(T)` and `k*T^2` |

These are prescribed teaching curves, not calibrated motor/load laws. In particular, `1/T` is reciprocal rather than parabolic; the named square-root reference is not a derivation of linear viscous friction. Torque is now strictly positive to avoid the reciprocal singularity, and constant functions return arrays matching the plotted torque grid.

### Equilibrium and stability

`stabilityanalysis.m` uses the mechanical balance and its scalar linearization:

```text
J * omega_dot = Tm(omega) - Tl(omega)
A = (dTm/domega - dTl/domega) / J
```

The script solves the specified quadratic torque balance, selects a real equilibrium inside the displayed speed range and evaluates both torque derivatives. With the supplied coefficients, the positive equilibrium is `omega = 1 + sqrt(6)`, approximately 3.44949, and `A` is positive: that uncontrolled equilibrium is locally unstable. A formula containing only the negative motor-torque derivative would give the wrong conclusion.

This is a scalar mechanical calculation, not a stability proof for the separate adaptive electrical-drive model or a complete elevator controller.

### Brushed DC motor scripts

`brushed_dc_motor_simulation` integrates the electrical/mechanical ODEs with `ode45`. `brushed_dc_motor_adaptive_pid_control` is a separate speed-control example with gain-adjustment logic. Review their voltage, torque, inertia, load and initial-state settings before running them. Plotted responses do not by themselves establish stability of every parameter setting.

### Simulink and archive materials

`asm_dfoc.slx` is the induction-motor direct field-oriented-control model. Simulink and its block-specific dependencies are required. `elevatorcontrol.rar` contains separate course materials; extract and inspect them before use. No production elevator-control qualification is implied.

## Related work and collaboration

Explore related repositories: [Complete Kinematic Analysis](https://github.com/DeepDynaSim/Complete-Kinematic-Analysis) · [DeepLyapunovFunction](https://github.com/DeepDynaSim/DeepLyapunovFunction).

[DeepDynaSim](https://github.com/DeepDynaSim) is an engineering R&D and consulting company in İzmir, Türkiye, focused on physics-guided AI, simulation and control. For engineering collaboration: [support@deepdynasim.com](mailto:support@deepdynasim.com). For repository questions, use [Issues](https://github.com/DeepDynaSim/Servo-Motors-and-Motion-Control-Systems/issues).

Reuse follows the existing [LICENSE](LICENSE); academic authorship and third-party attribution remain with their respective creators.
