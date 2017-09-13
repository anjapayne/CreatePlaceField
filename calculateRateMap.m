function map = calculateRateMap(ts,spkx,spky,posx,posy,post,h,mapAxis)
% Script to calculate the rate map
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne September 1, 2017

naninds = isnan(posx+posy+post);
posx(naninds)=[];posy(naninds)=[];post(naninds) = [];

invh = 1/h;
map = zeros(length(mapAxis),length(mapAxis));
yy = 0;
for y = 1:mapAxis %modified from y=mapAxis
    yy = yy + 1;
    xx = 0;
    for x = 1:mapAxis %modified from x=mapAxis
        xx = xx + 1;
        map(yy,xx) = rateEstimator(ts,spkx,spky,x,y,invh,posx,posy,post);
    end
end