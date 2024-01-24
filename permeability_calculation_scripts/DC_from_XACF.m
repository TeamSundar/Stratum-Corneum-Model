function dc = DC_from_XACF(xacf_file,i)
% This function calculates Diffusion Coefficient (DC) from Position Autocorrelation Function (XACF) 
% using the Generalized Langevin Method of Hummer (doi: 10.1088/1367-2630/7/1/034) 
% Two input arguments:
%   1) xacf_file: Filename of calculated Autocorrelation functions for different umbrella sampling windows.
%       Example: 'xacf_window_%d.xvg'
%       In this case, the names of the files should be 'xacf_window_1.xvg', 'xacf_window_2.xvg', 'xacf_window_3.xvg', ...
%       The first column in file should contain Time (in ps), and the second coulmn should have the correlation coefficients.
%   2) i: Total number of files   
% Output:
%   1) DC values of all umbrella sampling windows in a array.
% Example:
%   dc = DC_from_XACF('xacf_window_%d.xvg',20);


    hold on
    dc = zeros(i,1);
    ps = zeros(i,1);
    for n = 1:i
        filename = sprintf(xacf_file,n);
        delimiterIn =' ';
        headerlinesIn = 17;                                                         % Number of header lines to ignore in XACF files
        data = importdata(filename,delimiterIn,headerlinesIn);
         
        frames = 999900;                                                            % Number of rows in the XACF file to consider
        found_zero = (find (data.data(1:frames,2) <= 0));
        found_zero(1);
               
        var_c = 0.00005;                                                            % The curve is integrated untill its moving variance falls below var_c
        window = 5000;                                                              % Window for moving variance calculation
        MV = movvar(data.data(found_zero(1):frames,2),window);
        found=(find(MV <= var_c));
        cutoff = found(1) + found_zero(1);
        c_ps = cutoff / 100;                                                        
   
        plot(data.data(1:cutoff,1),data.data(1:cutoff,2),'Color',[rand,rand,rand])
                
        fun = @(x) interp1(data.data(:,1),data.data(:,2), x, 'linear');
        I=integral(fun,0,c_ps);
        varZsq = var(  (data.data(1:cutoff,2)) .^2 );
        dc(n) = (varZsq) ./ I;
        ps(n) = c_ps;
        
    end
    hold off
end