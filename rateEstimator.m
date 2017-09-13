function r = rateEstimator(ts,spkx,spky,x,y,invh,posx,posy,post)
% Script to find the rate for one position in space
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne September 4, 2017

conv_sum = sum(gaussianKernel(((spkx-x)*invh),((spky-y)*invh)));
edge_corrector =  trapz(post,gaussianKernel(((posx-x)*invh),((posy-y)*invh)));
%edge_corrector(edge_corrector<0.15) = NaN;
r = (conv_sum / (edge_corrector + 0.1)) + 0.1; % regularised firing rate for "wellbehavedness"
% i.e. no division by zero or log of zero

% Gaussian kernel for the rate calculation