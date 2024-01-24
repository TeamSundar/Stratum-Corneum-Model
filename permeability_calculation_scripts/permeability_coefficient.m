kB = 0.008314463;    % Boltzmann constant (in kilojoules per kelvin) 
T = 303.15;          % Temperature (in kelvin)

z = [-2.6:0.01:2.6];                
[P, Re, R] = IHSD('PMF.csv', 'DC.csv', z, kB, T);   
P = P .* 10^5                      
logP = log10(P) 

%%
% Saving
%writematrix([z, R], 'R.csv');
writematrix([P, logP], 'P.csv');