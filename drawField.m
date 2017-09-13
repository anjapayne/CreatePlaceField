function drawField(map,faxis,cmap,maxrate_actual,maxrate_draw,cellid,cell_file,text)
% Function to plot the rate map
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne September 5, 2017

% From Stefan's lab:
% This function will calculate an RGB image from the rate
% map. We do not just call image(map) and caxis([0 maxrate]),
% as it would plot unvisted parts with the same colour code
% as 0 Hz firing rate. Instead we give unvisited bins
% their own colour (e.g. gray or white).

maxrate_actual = ceil(maxrate_actual);
maxrate_draw = ceil(maxrate_draw);
if maxrate_draw < 1
    maxrate_draw = 1;
end
n = size(map,1);
plotmap = ones(n,n,3);
for jj = 1:n
    for ii = 1:n
        if isnan(map(jj,ii))
            plotmap(jj,ii,1) = 1; % give the unvisited bins a gray colour
            plotmap(jj,ii,2) = 1;
            plotmap(jj,ii,3) = 1;
        else
            if (map(jj,ii) > maxrate_draw)
                plotmap(jj,ii,1) = 1; % give the unvisited bins a gray colour
                plotmap(jj,ii,2) = 0;
                plotmap(jj,ii,3) = 0;
            else
                rgb = pixelColor(map(jj,ii),maxrate_draw,cmap);
                plotmap(jj,ii,1) = rgb(1);
                plotmap(jj,ii,2) = rgb(2);
                plotmap(jj,ii,3) = rgb(3);
            end
        end
    end
end
image(faxis,faxis,plotmap);
set(gca,'YDir','Normal');
axis image;
axis off
if strcmp(text,'on')
    if maxrate_actual~=maxrate_draw
        title(strcat(cellid,'¤(0 - ',num2str(maxrate_actual), ' (',num2str(maxrate_draw),') Hz)','¤',cell_file),'FontSize',20,'Interpreter','none');
    else
        title(strcat(cellid,'¤(0 - ',num2str(maxrate_actual), ' Hz)','¤',cell_file),'FontSize',20,'Interpreter','none');
    end
end
end
