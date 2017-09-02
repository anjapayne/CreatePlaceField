function [x_pos, y_pos, time_map, tVideo, map] = createPlaceField(mClust_spikeTimes, position)
% Script to create place field based on firing rate of a given neuron
% Written August 4, 2017
% Last modified by Anja Payne

% Load Data
position = load(position);
tSpikes = load(mClust_spikeTimes); 
tSpikes = tSpikes.tSpikes_Revised; 
tSpikes = floor(tSpikes/10000); %divide to get units of seconds

% Define Variables
bins = 35;
sLength = 70; %length of box: 70cm
binWidth = sLength/bins;
smooth_by = 5; %smoothing factor that is used when calculating the rate map
mapAxis = (-sLength/2+binWidth/2):binWidth:(sLength/2-binWidth/2);

% Smooth the position files
x_pos = position.pos(1,:);
y_pos = position.pos(2,:); 

for k = 8:length(x_pos)-7; 
    x_pos(k) = nanmean(x_pos(k-7:k+7));
    y_pos(k) = nanmean(y_pos(k-7:k+7)); 
end

% Center the position so it is the same for all maps
[x_pos,y_pos] = centerBox(x_pos, y_pos); 

% Determine how much time the animal spent in each bin (bin size is defined
% in the variables section above)
time_map = findTimeMap(x_pos, y_pos, tSpikes, bins, sLength, binWidth);

rate_map = calculateRateMap(tSpikes, x_pos(tSpikes), y_pos(tSpikes), x_pos, y_pos, t , smooth_by, mapAxis); %function is called 'ratemap' in Leutgeb code
 


% Old Analysis to be modified
window = 50; 
numSpikes = zeros(1, max(tSpikes)); 
for i = 1+window:max(tSpikes-window); 
    
    count = sum(tSpikes > i & tSpikes < i+window); 
    rate = count/window; 
    numSpikes(i+window/2) = rate;
end



% To be added: apply mean filter to position coordinates
% To be added (maybe): find the amount of time the animal spends in each
% space bin
% To be added: Leutgeb lab doesn't plot 'stray' spikes, only spike trains
% so maybe we should incorporate that also?



tVideo = position.pos/59.94; %divide by the sampling rate to get units in seconds

x_pos = round(downsample(x_pos, 60));
x_pos_new = round(x_pos/20);
y_pos = round(downsample(y_pos, 60)); 
y_pos_new = round(y_pos/20);
 

max(x_pos_new)-min(x_pos_new)
max(y_pos_new)-min(y_pos_new)

map = zeros(max(x_pos_new)-min(x_pos_new)+1, max(y_pos_new)-min(y_pos_new)+1); 
length(numSpikes)
length(x_pos_new)
length(y_pos_new)
for j = 1:length(numSpikes);
    j
    index_x = x_pos_new(j)-min(x_pos_new)+1
    index_y = y_pos_new(j)-min(y_pos_new)+1

    if isnan(x_pos_new(j)) == 1 || isnan(y_pos_new(j)) == 1;
        continue;
    end
    % If no spike rate has been assigned to the position then assign it
    if map(index_x, index_y) == 0; 
        map(index_x, index_y) = numSpikes(j);
 
    % Otherwise if a spike rate has already been assigned, then take the
    % average of the two and reassign it
    else
        map(index_x, index_y) = (map(index_x, index_y) + numSpikes(j))/2; 
    end
end

clf

figure(1);
hold on;
title('Rate Map', 'FontSize', 16); 
contourf(map);
colorbar;

figure(2)
hold on;
title('Spike Locations Overlaid on Animal Trajectory', 'FontSize', 16); 
plot(-x_pos, -y_pos', 'color', [0.57 0.57 0.57]);
scatter(-x_pos(tSpikes)', -y_pos(tSpikes)', '.r'); 


end
