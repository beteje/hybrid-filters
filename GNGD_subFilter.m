function [y,e] = GNGD_subFilter(input)
%% Generalized normalized gradient descent subfilter for use with Hybrid_Filter.m
%   Based on Mandic: A generalized normalized gradient descent algorithm
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
order   = 100;      % Number of filter coefficients
mu      = 0.1;      % Learning rate of filter
rho     = 0.15;     % Regularisation parameter
ep      = 0.01;     % Initial value of regularisation term

% Initialize filter variables
w = zeros(order,1);
x = zeros(order,1);
y = zeros(1,length(input));
e = zeros(1,length(input));

for k=1:length(input)
    
    % Store current input vector & regularisation value
    x1  = x;
    ep1 = ep;
    % Create an input vector for the filter according to the filter length
    for i = 1:order
        if (k-i)>0
            x(i) = input(k-i);
        else
            x(i) = 0;   % Zero pad at the start of the signal
        end
    end
    
    % Update filter
    y(k)    = x'*w;
    e(k)    = input(k) - y(k);
    w       = w + (mu/(x'*x + ep))*e(k)*x;
    
    % Update regularisation term
    if k>1
        ep = ep - rho*mu*(e(k)*e(k-1)*x'*x1)/(x1'*x1 + ep1)^2;
    end
end