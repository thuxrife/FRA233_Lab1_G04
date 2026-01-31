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
motor_Eff = 0.964637068303546;
motor_Ke = 0.0558027813847964;
motor_J = 3.27549608652329e-05;
motor_B = 2.15556464347356e-05;

fprintf('Motor parameters loaded. You can now run Simulink.\n');