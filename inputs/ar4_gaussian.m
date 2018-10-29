function [output] = ar4_gaussian(leng,comp,noise)
%% Creates an AR4 signal based on a Gaussian model
%   Inputs: leng    - the total number of samples of the signal to create
%           comp    - complex or real valued noise (1=complex circular noise, 2=complex doubly white circular noise, 3=complex doubly white noncircular noise, anything else real valued noise)
%           noise   - (optional) the input noise signal
%
%   Output: output  - the AR4 signal
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

% Set signal parameters
a = [1.79, -1.85, 1.27, -0.41];
% Initialize signal
output = zeros(1,leng);

% If no noise signal is provided create one
if nargin == 2
    amplitude1 = randn(1,leng);
    amplitude2 = randn(1,leng);
    ang = unifrnd(0,pi*2,[1,leng]);
    
    if comp == 1        % Complex valued circular noise
        realinput = amplitude1 .* cos(ang);
        imaginput = amplitude1 .* sin(ang);
        noise = realinput + 1j*imaginput;
    elseif comp == 2    % Complex valued doubly white circular noise
        noise = amplitude1 + 1j*amplitude2;
    elseif comp == 3    % Complex valued doubly white noncircular noise
        noise = 2*amplitude1 + 1j*amplitude2;
    else                % Real valued noise
        noise = amplitude1;
    end
end

% Create signal
output(1) = noise(1);
output(2) = a(1)*output(1) + noise(2);
output(3) = a(1)*output(2) + a(2)*output(1) + noise(3);
output(4) = a(1)*output(3) + a(2)*output(2) + a(3)*output(1) + noise(4);

for k=5:leng
    output(k) = a(1)*output(k-1) + a(2)*output(k-2) + a(3)*output(k-3) + a(4)*output(k-4) + noise(k);
end