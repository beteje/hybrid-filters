function [y,e] = CNNGD_subFilter(input)
%% Complex normalized nonlinear gradient descent subfilter for use with Hybrid_Filter.m
%   Inputs: input   - input signal (1xN)
%
%   Output: y       - 1 step ahead prediction of input (1xN)
%           e       - filter prediction error (1xN)
% 
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Set filter parameters
order   = 10;       % Number of filter coefficients
mu      = 0.01;     % Learning rate of filter   

% Initialize filter variables
w       = zeros(order,1);
xr      = zeros(order,1);
xi      = zeros(order,1);
y       = zeros(1,length(input));
e       = zeros(1,length(input));

for k=1:length(input)

    % Create an input vector for the filter according to the filter length
    for i = 1:order
        if (k-i)>0
            xr(i) = real(input(k-i));
            xi(i) = imag(input(k-i));
        else
            xr(i) = 0;  % Zero pad at the start of the signal
            xi(i) = 0;
        end
    end
    x = xr + 1j*xi;
    
    % Update filter
    net     = transpose(x)*w;
    y(k)    = 1/(1+exp(-(net)));
    e(k)    = input(k) - y(k);
    der     = exp(-net)/(1+exp(-net))^2;
    n       = mu/(1 + der^2*(transpose(x)*x));
    w       = w + n*der*e(k)*x;
end