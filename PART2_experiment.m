%% --- 1. USER CONFIGURATION ---
% Choose your source: 'PART2' for hardware data, 'MODEL' for simulation data
SOURCE_TYPE = 'MODEL'; 
% Order must match your Multiport Switch in Simulink
wave_names = {'Step', 'Ramp', 'Stair', 'Sine', 'Chirp'}; 
PARENT_FOLDER = 'PART2_study';

%% --- 2. SELECT DATA SOURCE OBJECTS ---
switch SOURCE_TYPE
    case 'PART2'
        source_prefix = 'part2';
        if isprop(out, 'data') && isprop(out, 'mode')
            data_obj = out.data;      % Experimental sensors
            mode_obj = out.mode;      % Experimental mode selection
        else
            error('Experimental blocks (data/mode) not found in "out" object.');
        end
    case 'MODEL'
        source_prefix = 'model';
        if isprop(out, 'model_data') && isprop(out, 'model_mode')
            data_obj = out.model_data; % Simulation sensors
            mode_obj = out.model_mode; % Simulation mode selection
        else
            error('Simulation blocks (model_data/model_mode) not found in "out" object.');
        end
    otherwise
        error('Invalid SOURCE_TYPE. Set to ''PART2'' or ''MODEL''.');
end

% Get wave name based on the mode value
mode_val = mode_obj.Data(1);
current_wave = wave_names{mode_val};
if ~exist(PARENT_FOLDER, 'dir'), mkdir(PARENT_FOLDER); end

%% --- 3. GENERATE TIMESTAMP & AUTO-INCREMENT FOLDER ---
ts = datestr(now, 'yyyy-mm-dd_HH-MM'); 
search_pattern = fullfile(PARENT_FOLDER, [source_prefix '_' current_wave '_*']);
existing_items = dir(search_pattern);
dir_flags = [existing_items.isdir];
next_num = sum(dir_flags) + 1;

folder_name = sprintf('%s_%s_%d_%s', source_prefix, current_wave, next_num, ts);
FINAL_SUBFOLDER_PATH = fullfile(PARENT_FOLDER, folder_name);

if exist(FINAL_SUBFOLDER_PATH, 'dir')
    ts_sec = datestr(now, 'yyyy-mm-dd_HH-MM-ss');
    folder_name = sprintf('%s_%s_%d_%s', source_prefix, current_wave, next_num, ts_sec);
    FINAL_SUBFOLDER_PATH = fullfile(PARENT_FOLDER, folder_name);
end
mkdir(FINAL_SUBFOLDER_PATH);

%% --- 4. HARVEST DATA ---
Time  = data_obj.Time;
Input = data_obj.Data(:,1); 
Velo  = data_obj.Data(:,2); 

%% --- 5. GENERATE & SAVE PLOT ---
% Force the figure background to white ('Color', 'w')
fig = figure('Visible', 'off', 'Position', [100, 100, 900, 500], 'Color', 'w'); 

% Force the axes background to white and grid lines to a visible gray
ax = axes('Position', [0.1, 0.15, 0.65, 0.7], 'Color', 'w'); 

plot(Time, Velo, 'b', 'LineWidth', 1.5); 
grid on; 
ax.GridColor = [0.15 0.15 0.15]; % Ensures grid is visible on white background
ax.XColor = 'k'; % Force axis lines and labels to black
ax.YColor = 'k';

xlabel('Time (s)'); 
ylabel('Velocity (rad/s)'); 
legend('Velocity (\omega)', 'Location', 'northeast', 'TextColor', 'k'); 

% Create a string containing all the motor parameters
param_text = sprintf(['Motor Parameters:\n', ...
    'R: %.4f \\Omega\n', ...
    'L: %.4f H\n', ...
    'Eff: %.4f\n', ...
    'Ke: %.4f\n', ...
    'J: %.4f\n', ...
    'B: %.4f'], ...
    motor_R, motor_L, motor_Eff, motor_Ke, motor_J, motor_B);

% Place the parameter box outside
annotation('textbox', [0.78, 0.4, 0.18, 0.3], 'String', param_text, ...
    'FitBoxToText', 'on', 'BackgroundColor', 'white', 'FontSize', 9, ...
    'EdgeColor', 'black', 'Color', 'k'); % 'Color', 'k' forces text to black

title(ax, sprintf('%s - %s Velocity Response (Run %d)', source_prefix, current_wave, next_num), 'Color', 'k');

saveas(fig, fullfile(FINAL_SUBFOLDER_PATH, [current_wave '_Plot.png']));
close(fig);

%% --- 6. SAVE RAW FILES (.MAT & .XLSX) ---
RawData.Time = Time; 
RawData.Input = Input; 
RawData.Velo = Velo;
save(fullfile(FINAL_SUBFOLDER_PATH, [current_wave '_Raw.mat']), 'RawData');

T = table(Time, Input, Velo, 'VariableNames', {'Time_sec', 'Voltage_V', 'Speed_rad_s'});
writetable(T, fullfile(FINAL_SUBFOLDER_PATH, [current_wave '_Data.xlsx']));

fprintf('SUCCESS: %s data for %s (Run %d) saved to: %s\n', ...
    SOURCE_TYPE, current_wave, next_num, FINAL_SUBFOLDER_PATH);