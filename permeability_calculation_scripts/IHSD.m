function [P, Re, R] = IHSD(pmf_file, dc_file, z, kB, T)
    % 'IHSD' calculates Permeability Coefficient 'P' using Inhomogeneous Solubility Diffusion Model by integrating Resistivities 'R' over the reaction coordinate 'z'. 
    % 5 input arguments in the following order
    %   1)  pmf_file:   CSV file with two columns, Reaction coordinate (in nm) in column 1, PMF (Potential of Mean Force) values (in kJ/mol) in column 2 
    %   2)  dc_file:    CSV file with two columns, Reaction coordinate (in nm) in column 1, DC (Diffusion Coefficient) values (in (nm^2)/ps) in column 2
    %   3)  z:          reaction coordinate
    %   4)  kB:         Boltzmann constant (in kilojoules per kelvin) 
    %   5)  T:          Temperature (in Kelvin)
    %
    % 3 output arguments in the following order
    %   1)  P:          Permeability Coefficient (in nm/ps)
    %   2)  Re:         Effective Resistivity (in ps/nm)
    %   3)  R:          Resistivities (in ps/(nm^2))
    %
    % Example
    % [P, R] = IHSD('PMF.csv', 'DC.csv', [-3.8:0.01:3.8], 0.008314463, 303.15);
    pmf = readmatrix(pmf_file);                 % Reading PMF
    dc = readmatrix(dc_file);                   % Reading DC
    PMF = interp1(pmf(:,1), pmf(:,2), z, 'linear');
    DC = interp1(dc(:,1), dc(:,2), z, 'linear');
    R = exp(PMF./(kB.*T)) ./ DC;                % Calculating Resistivities
    fun = @(x) interp1(z, R, x, 'linear');
    Re = (integral(fun, z(1), z(end) ) );
    P = 1 ./ Re         % Calculating Permeability Coefficinet
    
end