function [posx,posy] = centerBox(posx,posy)
% Script to find the center of the behavioral box
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne August 28, 2017

% Find border values for box for session 1
maxX = max(posx);
minX = min(posx);
maxY = max(posy);
minY = min(posy);

% Set the corners of the reference box
NE = [maxX, maxY];
NW = [minX, maxY];
SW = [minX, minY];
SE = [maxX, minY];

% The centre will be at the point of interception by the corner diagonals
a = (NE(2)-SW(2))/(NE(1)-SW(1)); % Slope for the NE-SW diagonal
b = (SE(2)-NW(2))/(SE(1)-NW(1)); % Slope for the SE-NW diagonal
c = SW(2);
d = NW(2);
x = (d-c+a*SW(1)-b*NW(1))/(a-b); % X-coord of centre
y = a*(x-SW(1))+c; % Y-coord of centre
center = [x,y];

% Center both boxes according to the coordinates to the first box
posx = posx - center(1);
posy = posy - center(2);