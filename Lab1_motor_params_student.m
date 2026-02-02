%{  
This script for prepare data and parameters for parameter estimator.
1. Load your collected data to MATLAB workspace.
2. Run this script.
3. Follow parameter estimator instruction.
%}

% R and L from experiment
motor_R = 9.393179725;
motor_L = 0.136562826;
% Optimization's parameters
motor_Eff = 0.750882138129295;
motor_Ke = 0.0595281219387613;
motor_J = 3.67584411965396E-06;
motor_B = 3.13337426732843E-06;

fprintf('Motor parameters loaded. You can now run Simulink.\n');