function [output] = sparsesig(leng,comp,noise)
%% Creates a sparse signal based on the sparse environment from Martin et al.: Exploiting sparsity in adaptive filters
%   Inputs: leng    - the total number of samples of the signal to create
%           comp    - complex or real valued noise (1=complex circular noise, 2=complex doubly white circular noise, 3=complex doubly white noncircular noise, anything else real valued noise)
%           noise   - (optional) the input noise signal
%
%   Output: output  - the sparse signal
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
b = [0.1,0,1,-0.5,0,0,0,0.1,0,0];

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
output = filter(b,1,noise);