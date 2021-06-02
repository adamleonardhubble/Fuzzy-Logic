clc % Clear command window
format compact % Compact command window output

file = ('SampleData.xlsx'); % Read-in the sample data input into the FIS

%---------------------------------------------------------------------------------------------------------------------%
                                % Player ability to perform well in a multiplayer match
%---------------------------------------------------------------------------------------------------------------------%

SampleData = xlsread(file); % Read and store the contents of the sample data file

FIS = mamfis('Name', 'Player performance capability'); % Potential of a player to perform well in a multiplayer match, mamdani-styled FIS

%---------------------------------------------------------------------------------------------------------------------%
                                            % Player weapon accuracy (input)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addInput(FIS, [0 100], 'Name', 'Player weapon accuracy (control %)'); % Player weapon accuracy (global statistic)

FIS = addMF(FIS, 'Player weapon accuracy (control %)', 'trapmf', [-10 0 10 20], 'Name', 'Very Poor'); % Very poor accuracy
FIS = addMF(FIS, 'Player weapon accuracy (control %)', 'trimf',  [10 20 30], 'Name', 'Poor'); % Poor accuracy
FIS = addMF(FIS, 'Player weapon accuracy (control %)', 'trimf',  [20 40 50], 'Name', 'Average'); % Average accuracy
FIS = addMF(FIS, 'Player weapon accuracy (control %)', 'trimf',  [40 50 70], 'Name', 'Good'); % Good accuracy
FIS = addMF(FIS, 'Player weapon accuracy (control %)', 'trapmf', [60 70 100 110], 'Name', 'Very Good'); % Very good accuracy

%---------------------------------------------------------------------------------------------------------------------%
                                               % Elected map size (input)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addInput(FIS, [30 500], 'Name', 'Elected map size (metres²)'); % Size of map the player is subjected to

FIS = addMF(FIS, 'Elected map size (metres²)', 'trimf',  [-10 30 60], 'Name', 'Very Small'); % Very small in size
FIS = addMF(FIS, 'Elected map size (metres²)', 'trimf',  [40 80 120], 'Name', 'Small'); % Small in size
FIS = addMF(FIS, 'Elected map size (metres²)', 'trimf',  [100 150 200], 'Name', 'Medium'); % Medium in size
FIS = addMF(FIS, 'Elected map size (metres²)', 'trimf',  [170 250 350], 'Name', 'Large'); % Large in size
FIS = addMF(FIS, 'Elected map size (metres²)', 'trapmf', [250 440 500 510], 'Name', 'Very Large'); % Very large in size

%---------------------------------------------------------------------------------------------------------------------%
                                          % Weapon effective damage range (input)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addInput(FIS, [0 100], 'Name', 'Weapon damage falloff (metres)'); % Weapon damage falloff range (damage over distance)

FIS = addMF(FIS, 'Weapon damage falloff (metres)', 'trapmf', [-10 0 10 20], 'Name', 'Very Close'); % Very close effective damage range
FIS = addMF(FIS, 'Weapon damage falloff (metres)', 'trimf',  [10 20 30], 'Name', 'Close'); % Close effective damage range
FIS = addMF(FIS, 'Weapon damage falloff (metres)', 'trimf',  [20 40 60], 'Name', 'Medium'); % Medium effective damage range
FIS = addMF(FIS, 'Weapon damage falloff (metres)', 'trimf',  [50 65 80], 'Name', 'Far'); % Far effective damage range
FIS = addMF(FIS, 'Weapon damage falloff (metres)', 'trapmf', [70 80 100 110], 'Name', 'Very Far'); % Very far effective damage range

%---------------------------------------------------------------------------------------------------------------------%
                                                % Weapon fire rate (input)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addInput(FIS, [0 2000], 'Name', 'Weapon fire rate (RPM)'); % Weapon firing rate (rounds per minute)
FIS = addMF(FIS, 'Weapon fire rate (RPM)', 'trapmf', [-100 0 120 180], 'Name', 'Very Slow'); % Very slow fire rate
FIS = addMF(FIS, 'Weapon fire rate (RPM)', 'trapmf', [120 180 360 420], 'Name', 'Slow'); % Slow fire rate
FIS = addMF(FIS, 'Weapon fire rate (RPM)', 'trapmf', [360 420 660 720], 'Name', 'Medium'); % Medium fire rate
FIS = addMF(FIS, 'Weapon fire rate (RPM)', 'trapmf', [660 720 1200 1260], 'Name', 'Fast'); % Fast fire rate
FIS = addMF(FIS, 'Weapon fire rate (RPM)', 'trapmf', [1200 1260 2000 2100], 'Name', 'Very Fast'); % Very fast fire rate

%---------------------------------------------------------------------------------------------------------------------%
                                                 % Weapon mobility (input)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addInput(FIS, [0 100], 'Name', 'Weapon mobility (level %)'); % Rate of player mobility (agility competence)

FIS = addMF(FIS, 'Weapon mobility (level %)', 'trimf',  [-10 0 20], 'Name', 'Very Slow'); % Very slow mobility rate
FIS = addMF(FIS, 'Weapon mobility (level %)', 'trimf',  [0 20 40], 'Name', 'Slow'); % Slow mobility rate
FIS = addMF(FIS, 'Weapon mobility (level %)', 'trimf',  [20 40 60], 'Name', 'Medium'); % Medium mobility rate
FIS = addMF(FIS, 'Weapon mobility (level %)', 'trimf',  [40 60 80], 'Name', 'Fast'); % Fast mobility rate
FIS = addMF(FIS, 'Weapon mobility (level %)', 'trapmf', [60 80 100 110], 'Name', 'Very Fast'); % Very fast mobility rate

%---------------------------------------------------------------------------------------------------------------------%
                                                 % Player competence (output)
%---------------------------------------------------------------------------------------------------------------------%

FIS = addOutput(FIS, [0 100], 'Name', 'Player performance capability (potential %)'); % Player potential ability to perform well

FIS = addMF(FIS, 'Player performance capability (potential %)', 'trimf', [-25 0 25], 'Name', 'Very Low'); % Very low potential to perform well
FIS = addMF(FIS, 'Player performance capability (potential %)', 'trimf', [0 25 50], 'Name', 'Low'); % Low potential to perform well
FIS = addMF(FIS, 'Player performance capability (potential %)', 'trimf', [25 50 75], 'Name', 'Average'); % Average potential to perform well
FIS = addMF(FIS, 'Player performance capability (potential %)', 'trimf', [50 75 100], 'Name', 'High'); % High potential to perform well
FIS = addMF(FIS, 'Player performance capability (potential %)', 'trimf', [75 100 125], 'Name', 'Very High'); % Very high potential to perform well

%---------------------------------------------------------------------------------------------------------------------%
                                                     % Rules base and plots
%---------------------------------------------------------------------------------------------------------------------%

% Rule list for determing the players potential to perform well
% [Input 1, Input 2, Input 3, Input 4, Input 5, Output, Weight, Operator]
% 5 inputs, 5 membership functions each, 5 outputs (5 * 5 * 5 * 5 * 5 (each input combination) = 3,125 possible rules [440 in total])
ruleList = [
            % Aggregate rules (generic)
            % Player weapon accuracy
            1 0 0 0 0 1 0.9 1; % If player weapon accuracy is very poor, then very low competence (bullets do not hit opponents)
            5 0 0 0 0 5 0.9 1; % If player weapon accuracy is very high, then very high competence (bullets hit opponents most of time)
            
            % Elected map size
            0 5 0 0 0 1 0.9 1; % If elected map size is very large, then very low competence (damage dealt is low, low accuracy at range, more covered fire)
            0 1 0 0 0 3 0.7 1; % If elected map size is very small, then average competence (more opponent encounters, low accuracy not really effected, damage not affected, mobility not affected)
            
            % Weapon effective damage range
            0 0 1 0 0 2 0.8 1; % If weapon damage falloff is very close range, then low competence (melee weapons)
            
            % Weapon fire rate
            0 0 0 1 0 2 0.6 1; % If weapon fire rate is very slow, then low competence (melee weapons, allows more time for opponents to evade fired bullets)
            
            % Weapon mobility
            0 0 0 0 1 4 0.7 1; % If weapon mobility is very low, then high competence (mounted turret weapons, sniper rifles, heavy machine guns)
            0 0 0 0 5 5 0.9 1; % If weapon mobility is very high, then very high competence (evade opponents shots more often and quickly, quick into cover, strategic play supported)
            
            % Unique rules (specific for purpose)
            
            %-------------------------------------------------------------%
                                 % Poor weapon accuracy
            %-------------------------------------------------------------%
            
            %-------------------------------------------------------------%
                                    % Small map size
            %-------------------------------------------------------------%
            
            % Poor weapon accuracy AND Small map size AND 
            % Close effective damage range AND Slow fire rate
            2 2 2 2 2 2 0.5 1; % Slow mobility rate
            2 2 2 2 3 3 0.5 1; % Medium mobility rate
            2 2 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Close effective damage range AND Medium fire rate
            2 2 2 3 2 3 0.5 1; % Slow mobility rate
            2 2 2 3 3 3 0.5 1; % Medium mobility rate
            2 2 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Close effective damage range AND Fast fire rate
            2 2 2 4 2 3 0.5 1; % Slow mobility rate
            2 2 2 4 3 3 0.5 1; % Medium mobility rate
            2 2 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Close effective damage range AND Very fast fire rate
            2 2 2 5 2 3 0.5 1; % Slow mobility rate
            2 2 2 5 3 3 0.5 1; % Medium mobility rate
            2 2 2 5 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Slow fire rate
            2 2 3 2 2 3 0.5 1; % Slow mobility rate
            2 2 3 2 3 3 0.5 1; % Medium mobility rate
            2 2 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Medium fire rate
            2 2 3 3 2 3 0.5 1; % Slow mobility rate
            2 2 3 3 3 3 0.5 1; % Medium mobility rate
            2 2 3 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Fast fire rate
            2 2 3 4 2 3 0.5 1; % Slow mobility rate
            2 2 3 4 3 3 0.5 1; % Medium mobility rate
            2 2 3 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Very fast fire rate
            2 2 3 5 2 3 0.5 1; % Slow mobility rate
            2 2 3 5 3 3 0.5 1; % Medium mobility rate
            2 2 3 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Far effective damage range AND Slow fire rate
            2 2 4 2 2 3 0.5 1; % Slow mobility rate
            2 2 4 2 3 3 0.5 1; % Medium mobility rate
            2 2 4 2 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Far effective damage range AND Medium fire rate
            2 2 4 3 2 3 0.5 1; % Slow mobility rate
            2 2 4 3 3 3 0.5 1; % Medium mobility rate
            2 2 4 3 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Far effective damage range AND Fast fire rate
            2 2 4 4 2 3 0.5 1; % Slow mobility rate
            2 2 4 4 3 4 0.5 1; % Medium mobility rate
            2 2 4 4 4 4 0.5 1; % Fast mobility rate
           
            % Poor weapon accuracy AND Small map size AND 
            % Far effective damage range AND Very fast fire rate
            2 2 4 5 2 3 0.5 1; % Slow mobility rate
            2 2 4 5 3 4 0.5 1; % Medium mobility rate
            2 2 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Slow fire rate
            2 2 5 2 2 3 0.5 1; % Slow mobility rate
            2 2 5 2 3 3 0.5 1; % Medium mobility rate
            2 2 5 2 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Medium fire rate
            2 2 5 3 2 3 0.5 1; % Slow mobility rate
            2 2 5 3 3 3 0.5 1; % Medium mobility rate
            2 2 5 3 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Fast fire rate
            2 2 5 4 2 3 0.5 1; % Slow mobility rate
            2 2 5 4 3 4 0.5 1; % Medium mobility rate
            2 2 5 4 4 4 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Very fast fire rate
            2 2 5 5 2 3 0.5 1; % Slow mobility rate
            2 2 5 5 3 4 0.5 1; % Medium mobility rate
            2 2 5 5 4 4 0.5 1; % Fast mobility rate
           
            %-------------------------------------------------------------%
                                   % Medium map size
            %-------------------------------------------------------------%
           
            % Poor weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Slow fire rate
            2 3 2 2 2 3 0.5 1; % Slow mobility rate
            2 3 2 2 3 3 0.5 1; % Medium mobility rate
            2 3 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Medium fire rate
            2 3 2 3 2 2 0.5 1; % Slow mobility rate
            2 3 2 3 3 2 0.5 1; % Medium mobility rate
            2 3 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Fast fire rate
            2 3 2 4 2 2 0.5 1; % Slow mobility rate
            2 3 2 4 3 2 0.5 1; % Medium mobility rate
            2 3 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Very fast fire rate
            2 3 2 5 2 2 0.5 1; % Slow mobility rate
            2 3 2 5 3 2 0.5 1; % Medium mobility rate
            2 3 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Slow fire rate
            2 3 3 2 2 2 0.5 1; % Slow mobility rate
            2 3 3 2 3 2 0.5 1; % Medium mobility rate
            2 3 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Medium fire rate
            2 3 3 3 2 2 0.5 1; % Slow mobility rate
            2 3 3 3 3 2 0.5 1; % Medium mobility rate
            2 3 3 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Fast fire rate
            2 3 3 4 2 2 0.5 1; % Slow mobility rate
            2 3 3 4 3 2 0.5 1; % Medium mobility rate
            2 3 3 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Very fast fire rate
            2 3 3 5 2 2 0.5 1; % Slow mobility rate
            2 3 3 5 3 2 0.5 1; % Medium mobility rate
            2 3 3 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Slow fire rate
            2 3 4 2 2 2 0.5 1; % Slow mobility rate
            2 3 4 2 3 2 0.5 1; % Medium mobility rate
            2 3 4 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Medium fire rate
            2 3 4 3 2 2 0.5 1; % Slow mobility rate
            2 3 4 3 3 3 0.5 1; % Medium mobility rate
            2 3 4 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Fast fire rate
            2 3 4 4 2 2 0.5 1; % Slow mobility rate
            2 3 4 4 3 3 0.5 1; % Medium mobility rate
            2 3 4 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Very fast fire rate
            2 3 4 5 2 2 0.5 1; % Slow mobility rate
            2 3 4 5 3 3 0.5 1; % Medium mobility rate
            2 3 4 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Slow fire rate
            2 3 5 2 2 2 0.5 1; % Slow mobility rate
            2 3 5 2 3 3 0.5 1; % Medium mobility rate
            2 3 5 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Medium fire rate
            2 3 5 3 2 2 0.5 1; % Slow mobility rate
            2 3 5 3 3 3 0.5 1; % Medium mobility rate
            2 3 5 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Fast fire rate
            2 3 5 4 2 2 0.5 1; % Slow mobility rate
            2 3 5 4 3 3 0.5 1; % Medium mobility rate
            2 3 5 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Very fast fire rate
            2 3 5 5 2 2 0.5 1; % Slow mobility rate
            2 3 5 5 3 3 0.5 1; % Medium mobility rate
            2 3 5 5 4 4 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                   % Large map size
            %-------------------------------------------------------------%
            
            % Poor weapon accuracy AND Large map size AND 
            % Close effective damage range AND Slow fire rate
            2 4 2 2 2 2 0.5 1; % Slow mobility rate
            2 4 2 2 3 2 0.5 1; % Medium mobility rate
            2 4 2 2 4 2 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Close effective damage range AND Medium fire rate
            2 4 2 3 2 2 0.5 1; % Slow mobility rate
            2 4 2 3 3 2 0.5 1; % Medium mobility rate
            2 4 2 3 4 2 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Close effective damage range AND Fast fire rate
            2 4 2 4 2 2 0.5 1; % Slow mobility rate
            2 4 2 4 3 2 0.5 1; % Medium mobility rate
            2 4 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Close effective damage range AND Very fast fire rate
            2 4 2 5 2 2 0.5 1; % Slow mobility rate
            2 4 2 5 3 2 0.5 1; % Medium mobility rate
            2 4 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Slow fire rate
            2 4 3 2 2 2 0.5 1; % Slow mobility rate
            2 4 3 2 3 2 0.5 1; % Medium mobility rate
            2 4 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Medium fire rate
            2 4 3 3 2 2 0.5 1; % Slow mobility rate
            2 4 3 3 3 2 0.5 1; % Medium mobility rate
            2 4 3 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Fast fire rate
            2 4 3 4 2 2 0.5 1; % Slow mobility rate
            2 4 3 4 3 3 0.5 1; % Medium mobility rate
            2 4 3 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Very fast fire rate
            2 4 3 5 2 2 0.5 1; % Slow mobility rate
            2 4 3 5 3 3 0.5 1; % Medium mobility rate
            2 4 3 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Far effective damage range AND Slow fire rate
            2 4 4 2 2 2 0.5 1; % Slow mobility rate
            2 4 4 2 3 2 0.5 1; % Medium mobility rate
            2 4 4 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Far effective damage range AND Medium fire rate
            2 4 4 3 2 2 0.5 1; % Slow mobility rate
            2 4 4 3 3 2 0.5 1; % Medium mobility rate
            2 4 4 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Far effective damage range AND Fast fire rate
            2 4 4 4 2 2 0.5 1; % Slow mobility rate
            2 4 4 4 3 3 0.5 1; % Medium mobility rate
            2 4 4 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Far effective damage range AND Very fast fire rate
            2 4 4 5 2 2 0.5 1; % Slow mobility rate
            2 4 4 5 3 3 0.5 1; % Medium mobility rate
            2 4 4 5 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Slow fire rate
            2 4 5 2 2 2 0.5 1; % Slow mobility rate
            2 4 5 2 3 3 0.5 1; % Medium mobility rate
            2 4 5 2 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Medium fire rate
            2 4 5 3 2 2 0.5 1; % Slow mobility rate
            2 4 5 3 3 3 0.5 1; % Medium mobility rate
            2 4 5 3 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Fast fire rate
            2 4 5 4 2 2 0.5 1; % Slow mobility rate
            2 4 5 4 3 3 0.5 1; % Medium mobility rate
            2 4 5 4 4 3 0.5 1; % Fast mobility rate
            
            % Poor weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Very fast fire rate
            2 4 5 5 2 2 0.5 1; % Slow mobility rate
            2 4 5 5 3 3 0.5 1; % Medium mobility rate
            2 4 5 5 4 4 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                 % Average weapon accuracy
            %-------------------------------------------------------------%
            
            %-------------------------------------------------------------%
                                    % Small map size
            %-------------------------------------------------------------%
            
            % Average weapon accuracy AND Small map size AND 
            % Close effective damage range AND Slow fire rate
            3 2 2 2 2 2 0.5 1; % Slow mobility rate
            3 2 2 2 3 3 0.5 1; % Medium mobility rate
            3 2 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Close effective damage range AND Medium fire rate
            3 2 2 3 2 2 0.5 1; % Slow mobility rate
            3 2 2 3 3 2 0.5 1; % Medium mobility rate
            3 2 2 3 4 3 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Small map size AND 
            % Close effective damage range AND Fast fire rate
            3 2 2 4 2 2 0.5 1; % Slow mobility rate
            3 2 2 4 3 2 0.5 1; % Medium mobility rate
            3 2 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Close effective damage range AND Very fast fire rate
            3 2 2 5 2 2 0.5 1; % Slow mobility rate
            3 2 2 5 3 2 0.5 1; % Medium mobility rate
            3 2 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Slow fire rate
            3 2 3 2 2 2 0.5 1; % Slow mobility rate
            3 2 3 2 3 2 0.5 1; % Medium mobility rate
            3 2 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Medium fire rate
            3 2 3 3 2 2 0.5 1; % Slow mobility rate
            3 2 3 3 3 2 0.5 1; % Medium mobility rate
            3 2 3 3 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Fast fire rate
            3 2 3 4 2 2 0.5 1; % Slow mobility rate
            3 2 3 4 3 2 0.5 1; % Medium mobility rate
            3 2 3 4 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Very fast fire rate
            3 2 3 5 2 2 0.5 1; % Slow mobility rate
            3 2 3 5 3 3 0.5 1; % Medium mobility rate
            3 2 3 5 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Far effective damage range AND Slow fire rate
            3 2 4 2 2 2 0.5 1; % Slow mobility rate
            3 2 4 2 3 3 0.5 1; % Medium mobility rate
            3 2 4 2 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Far effective damage range AND Medium fire rate
            3 2 4 3 2 3 0.5 1; % Slow mobility rate
            3 2 4 3 3 3 0.5 1; % Medium mobility rate
            3 2 4 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Far effective damage range AND Fast fire rate
            3 2 4 4 2 3 0.5 1; % Slow mobility rate
            3 2 4 4 3 3 0.5 1; % Medium mobility rate
            3 2 4 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Far effective damage range AND Very fast fire rate
            3 2 4 5 2 3 0.5 1; % Slow mobility rate
            3 2 4 5 3 3 0.5 1; % Medium mobility rate
            3 2 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Slow fire rate
            3 2 5 2 2 3 0.5 1; % Slow mobility rate
            3 2 5 2 3 3 0.5 1; % Medium mobility rate
            3 2 5 2 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Medium fire rate
            3 2 5 3 2 3 0.5 1; % Slow mobility rate
            3 2 5 3 3 3 0.5 1; % Medium mobility rate
            3 2 5 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Fast fire rate
            3 2 5 4 2 3 0.5 1; % Slow mobility rate
            3 2 5 4 3 4 0.5 1; % Medium mobility rate
            3 2 5 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Very fast fire rate
            3 2 5 5 2 3 0.5 1; % Slow mobility rate
            3 2 5 5 3 3 0.5 1; % Medium mobility rate
            3 2 5 5 4 4 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                   % Medium map size
            %-------------------------------------------------------------%
            
            % Average weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Slow fire rate
            3 3 2 2 2 2 0.5 1; % Slow mobility rate
            3 3 2 2 3 2 0.5 1; % Medium mobility rate
            3 3 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Medium fire rate
            3 3 2 3 2 2 0.5 1; % Slow mobility rate
            3 3 2 3 3 2 0.5 1; % Medium mobility rate
            3 3 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Fast fire rate
            3 3 2 4 2 2 0.5 1; % Slow mobility rate
            3 3 2 4 3 3 0.5 1; % Medium mobility rate
            3 3 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Very fast fire rate
            3 3 2 5 2 2 0.5 1; % Slow mobility rate
            3 3 2 5 3 3 0.5 1; % Medium mobility rate
            3 3 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Slow fire rate
            3 3 3 2 2 2 0.5 1; % Slow mobility rate
            3 3 3 2 3 3 0.5 1; % Medium mobility rate
            3 3 3 2 4 3 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Medium fire rate
            3 3 3 3 2 3 0.5 1; % Slow mobility rate
            3 3 3 3 3 3 0.5 1; % Medium mobility rate
            3 3 3 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Fast fire rate
            3 3 3 4 2 3 0.5 1; % Slow mobility rate
            3 3 3 4 3 3 0.5 1; % Medium mobility rate
            3 3 3 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Very fast fire rate
            3 3 3 5 2 3 0.5 1; % Slow mobility rate
            3 3 3 5 3 4 0.5 1; % Medium mobility rate
            3 3 3 5 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Slow fire rate
            3 3 4 2 2 3 0.5 1; % Slow mobility rate
            3 3 4 2 3 3 0.5 1; % Medium mobility rate
            3 3 4 2 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Medium fire rate
            3 3 4 3 2 3 0.5 1; % Slow mobility rate
            3 3 4 3 3 4 0.5 1; % Medium mobility rate
            3 3 4 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Fast fire rate
            3 3 4 4 2 3 0.5 1; % Slow mobility rate
            3 3 4 4 3 4 0.5 1; % Medium mobility rate
            3 3 4 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Very fast fire rate
            3 3 4 5 2 3 0.5 1; % Slow mobility rate
            3 3 4 5 3 4 0.5 1; % Medium mobility rate
            3 3 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Slow fire rate
            3 3 5 2 2 3 0.5 1; % Slow mobility rate
            3 3 5 2 3 4 0.5 1; % Medium mobility rate
            3 3 5 2 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Medium fire rate
            3 3 5 3 2 3 0.5 1; % Slow mobility rate
            3 3 5 3 3 4 0.5 1; % Medium mobility rate
            3 3 5 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Fast fire rate
            3 3 5 4 2 3 0.5 1; % Slow mobility rate
            3 3 5 4 3 4 0.5 1; % Medium mobility rate
            3 3 5 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Very fast fire rate
            3 3 5 5 2 3 0.5 1; % Slow mobility rate
            3 3 5 5 3 4 0.5 1; % Medium mobility rate
            3 3 5 5 4 4 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                   % Large map size
            %-------------------------------------------------------------%
            
            % Average weapon accuracy AND Large map size AND 
            % Close effective damage range AND Slow fire rate
            3 4 2 2 2 2 0.5 1; % Slow mobility rate
            3 4 2 2 3 2 0.5 1; % Medium mobility rate
            3 4 2 2 4 3 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Close effective damage range AND Medium fire rate
            3 4 2 3 2 2 0.5 1; % Slow mobility rate
            3 4 2 3 3 2 0.5 1; % Medium mobility rate
            3 4 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Close effective damage range AND Fast fire rate
            3 4 2 4 2 2 0.5 1; % Slow mobility rate
            3 4 2 4 3 2 0.5 1; % Medium mobility rate
            3 4 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Close effective damage range AND Very fast fire rate
            3 4 2 5 2 2 0.5 1; % Slow mobility rate
            3 4 2 5 3 3 0.5 1; % Medium mobility rate
            3 4 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Slow fire rate
            3 4 3 2 2 2 0.5 1; % Slow mobility rate
            3 4 3 2 3 2 0.5 1; % Medium mobility rate
            3 4 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Medium fire rate
            3 4 3 3 2 2 0.5 1; % Slow mobility rate
            3 4 3 3 3 3 0.5 1; % Medium mobility rate
            3 4 3 3 4 3 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Fast fire rate
            3 4 3 4 2 2 0.5 1; % Slow mobility rate
            3 4 3 4 3 3 0.5 1; % Medium mobility rate
            3 4 3 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Very fast fire rate
            3 4 3 5 2 3 0.5 1; % Slow mobility rate
            3 4 3 5 3 3 0.5 1; % Medium mobility rate
            3 4 3 5 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Far effective damage range AND Slow fire rate
            3 4 4 2 2 3 0.5 1; % Slow mobility rate
            3 4 4 2 3 4 0.5 1; % Medium mobility rate
            3 4 4 2 4 4 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Far effective damage range AND Medium fire rate
            3 4 4 3 2 3 0.5 1; % Slow mobility rate
            3 4 4 3 3 4 0.5 1; % Medium mobility rate
            3 4 4 3 4 4 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Far effective damage range AND Fast fire rate
            3 4 4 4 2 3 0.5 1; % Slow mobility rate
            3 4 4 4 3 4 0.5 1; % Medium mobility rate
            3 4 4 4 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Far effective damage range AND Very fast fire rate
            3 4 4 5 2 3 0.5 1; % Slow mobility rate
            3 4 4 5 3 4 0.5 1; % Medium mobility rate
            3 4 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Slow fire rate
            3 4 5 2 2 3 0.5 1; % Slow mobility rate
            3 4 5 2 3 3 0.5 1; % Medium mobility rate
            3 4 5 2 4 4 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Medium fire rate
            3 4 5 3 2 3 0.5 1; % Slow mobility rate
            3 4 5 3 3 4 0.5 1; % Medium mobility rate
            3 4 5 3 4 4 0.5 1; % Fast mobility rate
            
            % Average weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Fast fire rate
            3 4 5 4 2 3 0.5 1; % Slow mobility rate
            3 4 5 4 3 4 0.5 1; % Medium mobility rate
            3 4 5 4 4 4 0.5 1; % Fast mobility rate
           
            % Average weapon accuracy AND Large map size AND 
            % Very far effective damage range AND Very fast fire rate
            3 4 5 5 2 3 0.5 1; % Slow mobility rate
            3 4 5 5 3 4 0.5 1; % Medium mobility rate
            3 4 5 5 4 5 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                 % Good weapon accuracy
            %-------------------------------------------------------------%
            
            %-------------------------------------------------------------%
                                    % Small map size
            %-------------------------------------------------------------%
            
            % Good weapon accuracy AND Small map size AND 
            % Close effective damage range AND Slow fire rate
            4 2 2 2 2 2 0.5 1; % Slow mobility rate
            4 2 2 2 3 3 0.5 1; % Medium mobility rate
            4 2 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Close effective damage range AND Medium fire rate
            4 2 2 3 2 2 0.5 1; % Slow mobility rate
            4 2 2 3 3 3 0.5 1; % Medium mobility rate
            4 2 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Close effective damage range AND Fast fire rate
            4 2 2 4 2 2 0.5 1; % Slow mobility rate
            4 2 2 4 3 3 0.5 1; % Medium mobility rate
            4 2 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Close effective damage range AND Very fast fire rate
            4 2 2 5 2 2 0.5 1; % Slow mobility rate
            4 2 2 5 3 3 0.5 1; % Medium mobility rate
            4 2 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Slow fire rate
            4 2 3 2 2 3 0.5 1; % Slow mobility rate
            4 2 3 2 3 3 0.5 1; % Medium mobility rate
            4 2 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Medium fire rate
            4 2 3 3 2 3 0.5 1; % Slow mobility rate
            4 2 3 3 3 3 0.5 1; % Medium mobility rate
            4 2 3 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Fast fire rate
            4 2 3 4 2 3 0.5 1; % Slow mobility rate
            4 2 3 4 3 4 0.5 1; % Medium mobility rate
            4 2 3 4 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Medium effective damage range AND Very fast fire rate
            4 2 3 5 2 3 0.5 1; % Slow mobility rate
            4 2 3 5 3 4 0.5 1; % Medium mobility rate
            4 2 3 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Far effective damage range AND Slow fire rate
            4 2 4 2 2 3 0.5 1; % Slow mobility rate
            4 2 4 2 3 4 0.5 1; % Medium mobility rate
            4 2 4 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Far effective damage range AND Medium fire rate
            4 2 4 3 2 3 0.5 1; % Slow mobility rate
            4 2 4 3 3 4 0.5 1; % Medium mobility rate
            4 2 4 3 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Far effective damage range AND Fast fire rate
            4 2 4 4 2 4 0.5 1; % Slow mobility rate
            4 2 4 4 3 4 0.5 1; % Medium mobility rate
            4 2 4 4 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Far effective damage range AND Very fast fire rate
            4 2 4 5 2 4 0.5 1; % Slow mobility rate
            4 2 4 5 3 5 0.5 1; % Medium mobility rate
            4 2 4 5 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Slow fire rate
            4 2 5 2 2 4 0.5 1; % Slow mobility rate
            4 2 5 2 3 4 0.5 1; % Medium mobility rate
            4 2 5 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Medium fire rate
            4 2 5 3 2 4 0.5 1; % Slow mobility rate
            4 2 5 3 3 5 0.5 1; % Medium mobility rate
            4 2 5 3 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Fast fire rate
            4 2 5 4 2 4 0.5 1; % Slow mobility rate
            4 2 5 4 3 5 0.5 1; % Medium mobility rate
            4 2 5 4 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Small map size AND 
            % Very far effective damage range AND Very fast fire rate
            4 2 5 5 2 4 0.5 1; % Slow mobility rate
            4 2 5 5 3 5 0.5 1; % Medium mobility rate
            4 2 5 5 4 5 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                   % Medium map size
            %-------------------------------------------------------------%
            
            % Good weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Slow fire rate
            4 3 2 2 2 3 0.5 1; % Slow mobility rate
            4 3 2 2 3 3 0.5 1; % Medium mobility rate
            4 3 2 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Medium fire rate
            4 3 2 3 2 3 0.5 1; % Slow mobility rate
            4 3 2 3 3 3 0.5 1; % Medium mobility rate
            4 3 2 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Fast fire rate
            4 3 2 4 2 3 0.5 1; % Slow mobility rate
            4 3 2 4 3 4 0.5 1; % Medium mobility rate
            4 3 2 4 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Close effective damage range AND Very fast fire rate
            4 3 2 5 2 3 0.5 1; % Slow mobility rate
            4 3 2 5 3 4 0.5 1; % Medium mobility rate
            4 3 2 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Slow fire rate
            4 3 3 2 2 3 0.5 1; % Slow mobility rate
            4 3 3 2 3 4 0.5 1; % Medium mobility rate
            4 3 3 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Medium fire rate
            4 3 3 3 2 3 0.5 1; % Slow mobility rate
            4 3 3 3 3 4 0.5 1; % Medium mobility rate
            4 3 3 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Fast fire rate
            4 3 3 4 2 3 0.5 1; % Slow mobility rate
            4 3 3 4 3 4 0.5 1; % Medium mobility rate
            4 3 3 4 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Medium effective damage range AND Very fast fire rate
            4 3 3 5 2 3 0.5 1; % Slow mobility rate
            4 3 3 5 3 4 0.5 1; % Medium mobility rate
            4 3 3 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Slow fire rate
            4 3 4 2 2 3 0.5 1; % Slow mobility rate
            4 3 4 2 3 4 0.5 1; % Medium mobility rate
            4 3 4 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Medium fire rate
            4 3 4 3 2 3 0.5 1; % Slow mobility rate
            4 3 4 3 3 4 0.5 1; % Medium mobility rate
            4 3 4 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Fast fire rate
            4 3 4 4 2 3 0.5 1; % Slow mobility rate
            4 3 4 4 3 4 0.5 1; % Medium mobility rate
            4 3 4 4 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Far effective damage range AND Very fast fire rate
            4 3 4 5 2 3 0.5 1; % Slow mobility rate
            4 3 4 5 3 4 0.5 1; % Medium mobility rate
            4 3 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Slow fire rate
            4 3 5 2 2 3 0.5 1; % Slow mobility rate
            4 3 5 2 3 4 0.5 1; % Medium mobility rate
            4 3 5 2 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Medium fire rate
            4 3 5 3 2 4 0.5 1; % Slow mobility rate
            4 3 5 3 3 4 0.5 1; % Medium mobility rate
            4 3 5 3 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Fast fire rate
            4 3 5 4 2 4 0.5 1; % Slow mobility rate
            4 3 5 4 3 5 0.5 1; % Medium mobility rate
            4 3 5 4 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Medium map size AND 
            % Very far effective damage range AND Very fast fire rate
            4 3 5 5 2 4 0.5 1; % Slow mobility rate
            4 3 5 5 3 5 0.5 1; % Medium mobility rate
            4 3 5 5 4 5 0.5 1; % Fast mobility rate
            
            %-------------------------------------------------------------%
                                   % Large map size
            %-------------------------------------------------------------%
            
            % Good weapon accuracy AND Large map size AND 
            % Close effective damage range AND Slow fire rate
            4 4 2 2 2 2 0.5 1; % Slow mobility rate
            4 4 2 2 3 3 0.5 1; % Medium mobility rate
            4 4 2 2 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Close effective damage range AND Medium fire rate
            4 4 2 3 2 2 0.5 1; % Slow mobility rate
            4 4 2 3 3 3 0.5 1; % Medium mobility rate
            4 4 2 3 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Close effective damage range AND Fast fire rate
            4 4 2 4 2 2 0.5 1; % Slow mobility rate
            4 4 2 4 3 3 0.5 1; % Medium mobility rate
            4 4 2 4 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Close effective damage range AND Very fast fire rate
            4 4 2 5 2 2 0.5 1; % Slow mobility rate
            4 4 2 5 3 3 0.5 1; % Medium mobility rate
            4 4 2 5 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Slow fire rate
            4 4 3 2 2 2 0.5 1; % Slow mobility rate
            4 4 3 2 3 3 0.5 1; % Medium mobility rate
            4 4 3 2 4 3 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Medium fire rate
            4 4 3 3 2 2 0.5 1; % Slow mobility rate
            4 4 3 3 3 3 0.5 1; % Medium mobility rate
            4 4 3 3 4 3 0.5 1; % Fast mobility rate
           
            % Good weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Fast fire rate
            4 4 3 4 2 2 0.5 1; % Slow mobility rate
            4 4 3 4 3 3 0.5 1; % Medium mobility rate
            4 4 3 4 4 3 0.5 1; % Fast mobility rate
           
            % Good weapon accuracy AND Large map size AND 
            % Medium effective damage range AND Very fast fire rate
            4 4 3 5 2 3 0.5 1; % Slow mobility rate
            4 4 3 5 3 3 0.5 1; % Medium mobility rate
            4 4 3 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Far effective damage range AND Slow fire rate
            4 4 4 2 2 3 0.5 1; % Slow mobility rate
            4 4 4 2 3 3 0.5 1; % Medium mobility rate
            4 4 4 2 4 4 0.5 1; % Fast mobility rate
           
            % Good weapon accuracy AND Large map size AND 
            % Far effective damage range AND Medium fire rate
            4 4 4 3 2 3 0.5 1; % Slow mobility rate
            4 4 4 3 3 4 0.5 1; % Medium mobility rate
            4 4 4 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Far effective damage range AND Fast fire rate
            4 4 4 4 2 3 0.5 1; % Slow mobility rate
            4 4 4 4 3 4 0.5 1; % Medium mobility rate
            4 4 4 4 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Far effective damage range AND Fast fire rate
            4 4 4 5 2 3 0.5 1; % Slow mobility rate
            4 4 4 5 3 4 0.5 1; % Medium mobility rate
            4 4 4 5 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Very Far effective damage range AND Slow fire rate
            4 4 5 2 2 3 0.5 1; % Slow mobility rate
            4 4 5 2 3 4 0.5 1; % Medium mobility rate
            4 4 5 2 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Very Far effective damage range AND Medium fire rate
            4 4 5 3 2 3 0.5 1; % Slow mobility rate
            4 4 5 3 3 4 0.5 1; % Medium mobility rate
            4 4 5 3 4 4 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Very Far effective damage range AND Fast fire rate
            4 4 5 4 2 4 0.5 1; % Slow mobility rate
            4 4 5 4 3 4 0.5 1; % Medium mobility rate
            4 4 5 4 4 5 0.5 1; % Fast mobility rate
            
            % Good weapon accuracy AND Large map size AND 
            % Very Far effective damage range AND Very fast fire rate
            4 4 5 5 2 4 0.5 1; % Slow mobility rate
            4 4 5 5 3 5 0.5 1; % Medium mobility rate
            4 4 5 5 4 5 0.5 1; % Fast mobility rate
            ];

FIS = addRule(FIS,ruleList); % Apply the rule list to the FIS configured

showrule(FIS) % Print the rules to the workspace

% Defuzzification method of data input to the FIS, for producing crisp output
%FIS.defuzzMethod = 'centroid'; % Centroid defuzzification method
%FIS.defuzzMethod = 'bisector'; % Bisector defuzzification method
FIS.defuzzMethod = 'mom'; % Mean of maximum defuzzification method
%FIS.defuzzMethod = 'som'; % Smallest of maximum defuzzification method
%FIS.defuzzMethod = 'lom'; % Largest of maximum defuzzification method

% Plot the membership functions of the FIS
subplot(6,1,1), plotmf(FIS,'input',1) % Plot the membership functions for input '1'
subplot(6,1,2), plotmf(FIS,'input',2) % Plot the membership functions for input '2'
subplot(6,1,3), plotmf(FIS,'input',3) % Plot the membership functions for input '3'
subplot(6,1,4), plotmf(FIS,'input',4) % Plot the membership functions for input '4'
subplot(6,1,5), plotmf(FIS,'input',5) % Plot the membership functions for input '5'
subplot(6,1,6), plotmf(FIS,'output',1) % Plot the membership functions for output '1'

for i=1:size(SampleData, 1) % For the size of the sample data fed into the FIS, do the following
    evalSampleData = evalfis(FIS, [SampleData(i, 1), SampleData(i, 2), SampleData(i, 3), SampleData(i, 4), SampleData(i, 5)]); % Evaluate the sample datas set for the FIS configured
    fprintf('%d) Input(1): %.2f, Input(2) %.2f, Input(3) %.2f, Input(4) %.2f, Input(5) %.2f => Output: %.2f \n\n', i, SampleData(i, 1), SampleData(i, 2), SampleData(i, 3), SampleData(i, 4), SampleData(i, 5), evalSampleData); % Output each line of data input to the FIS and the crisp output
    xlswrite('Output.xlsx', evalSampleData, 1, sprintf('A%d', i+1)); % Write the crisp output to a document, for each line of data input to the FIS
end % End of the iterative statement