function [output] = ikeda(leng)
%% Creates a chaotic signal based on the Ikeda map from Aihara (Ed.): Applied chaos and applicable chaos
%   Inputs: leng    - the total number of samples of the signal to create
%
%   Output: output  - the chaotic signal
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
a   = 1;
b   = 0.9;
phi = 0.4;
c   = 6;

% Create signal
output = randn(1,leng).*.1 + sqrt(-1).* randn(1,leng).*.1;
for n = 1:leng-1
 output(n+1) = a + b*output(n)*exp(1j*(phi - c/(1+abs(output(n))^2)));
end