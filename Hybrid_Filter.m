function [lambda,y,e,y1,e1,y2,e2]= Hybrid_Filter(filter1,filter2,input)
%% Hybrid filter function to track the mixing parameter of 2 subfilters
%   Inputs: filter1 - filter function handle for the first subfilter e.g. @filter1
%           filter2 - filter function handle for the second subfilter
%                filter functions should take one dimensional input signal of length N and return the filter output of the same dimension
%                       (parameters must be set within the function itself)
%           input   - input signal (1xN) real or complex
%
%   Output: lambda  - the mixing parameter (1xN)
%           y       - hybrid filter output
%           e       - hybrid filter prediction error
%           y1      - subfilter 1 output
%           e1      - subfilter 1 prediction error
%           y2      - subfilter 2 output
%           e2      - subfilter 2 prediction error
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

mu          = 0.1;                      % Filter learning rate
y           = zeros(1,length(input));   % Initialization of filter output 
e           = zeros(1,length(input));   % Initialization of filter error
lambda      = 2*ones(1,length(input));  % Initialization of mixing parameter
lambda(1)   = 0.5;                      % Set the first value of the mixing parameter to mid point

[y1,e1] = filter1(input);  % Filter the data using filter 1
[y2,e2] = filter2(input);  % Filter the data using filter 2

% Update the hybrid filter based on the outputs of the subfilters
for k=1:length(input)
    
    y(k)        = lambda(k)*y1(k) + (1-lambda(k))*y2(k);        % Update the filter output
    e(k)        = input(k) - y(k);                              % Calculate the filter error
    lambda(k+1) = lambda(k) + mu*real(e(k)*conj(y1(k)-y2(k)));  % Update the mixing paramter
    
    % Ensure that the mixing parameter has not moved outside of the range 0-1
    if lambda(k+1)>1
        lambda(k+1) = 1;
    elseif lambda(k+1)<0
        lambda(k+1) = 0;
    end
end