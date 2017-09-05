<<<<<<< Updated upstream
function r = gaussianKernel(x,y)
% Script to calculate the Gaussian Kernel
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne September 5, 2017

% k(u) = ((2*pi)^(-length(u)/2)) * exp(u'*u)
=======
function r = gaussianKernel(x,y)
% Script to calculate the Gaussian Kernel
% Written in 2013 by members of Stefan Leutgeb's lab
% Last modified by Anja Payne September 5, 2017

% k(u) = ((2*pi)^(-length(u)/2)) * exp(u'*u)
>>>>>>> Stashed changes
r = 0.15915494309190 * exp(-0.5*(x.*x + y.*y));