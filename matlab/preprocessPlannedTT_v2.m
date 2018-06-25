% load planned timetable, driver swithches, RSconnections and RS composition changes
mainFolder = 'D:\Dropbox\Postdoc\Articles WIP\INFORMS RAS 2018 Problem Solving Competition\Data\';

loadPlannedTT_v2
loadDriverSwitches
loadRSconnections
loadRSCompositionChanges

%% set minimum process times
% minimum dwell time at regular stations (e.g. Utrecht)
minDwellTime = 60;
% minimum dwell time at small stops (e.g. Delft South)
minDwellTimeShortStop = 30;
% time trashold before and after considered event
offsetTime = 10; % in minutes

%% preprocess TT
% adds: 1. PlannedTime in MM and SS and 2. WeekDay (1-5)
% CPUtime: 750s
[TT] = addTIMEtoMMandSS(TT);

% CPUtime: 100s?
TT = addTimeSupplements(TT,minDwellTime,minDwellTimeShortStop);

save('TTprocessed','TT')
%missingTTActivities = TT(missingPlannedTime);

% TODO: 
% 1. store missingTTActivities - NTV
% 2. store missing DSwitch trains
% 3. ?
%% remove NVT activities
% NVT (not relevant - freight, other train companies?) trains do not have scheduled times! remove them:
TT2_NVT = TT(strcmp({TT.TrainCharacteristic},'NVT'));
TT(strcmp({TT.TrainCharacteristic},'NVT')) = [];
%save('TT2_NVT', 'TT2_NVT')

%% 4. CONVERT TimeTable TO RealisedData FORMAT WITH EXTRA COLUMNS 
% TT2 to realTT format

realTT = convertPlannedToRealisedTT(TT);
%save('realTT','realTT')

%% remove some odd trains that have higher uncertainty in realization (e.g. local shunting movements in stations)
TT([TT.Trainnumber]>77000) = [];

%% make train dependencies

realTT = convertPlannedToRealisedTT(TT);
days = 1:5;
[TrainDependenciesReal,TrainDependenciesDaySReal,missingDS,missingRS,missingCC] = createTrainDependencies_v2(realTT,DriverSwitch,RSConnections,RSCompChange,offsetTime,days);
% save train dependencies in txt files
saveTrainDependencies_v2(TrainDependenciesDaySReal)

%save('TrainDependenciesReal_Day1','TrainDependenciesReal','TrainDependenciesDaySReal')

%% data description
% TrainDependenciesReal_Day1 combines all train activities (arrivals and departures) processes (running, dwelling). 
% Also, rolling stock connections, composition changes  and driver switches are included.
% Possible activity types are:
% V: departure
% A: arrival
% K_V: departure at a small stop (e.g. Delft South)
% K_A: arrival at a small stop (e.g. Delft South)
% DS_D: driver switch, next task is driving
% DS_P: driver switch, next task is as a passenger
% RS_V: Rolling stock connection (connected to departure of the second train)
% CC_V: Rolling stock composition change (connected to departure of the second train)



