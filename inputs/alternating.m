function output = alternating(leng,alt,comp,sig1,sig2,sig3,sig4)
%% Creates a signal which alternates between two to four different signals
%   Inputs: leng    - the total number of samples of the signal to create
%           alt     - the number of samples in each block of the same signal nature
%           comp    - complex or real valued noise (1=complex circular noise, 2=complex doubly white circular noise, 3=complex doubly white noncircular noise, anything else real valued noise)
%           sig1    - signal function handle for the first signal e.g. @sig1
%           sig2    - signal function handle for the second signal
%           sig3    - (optional) signal function handle for the third signal
%           sig4    - (optional) signal function handle for the fourth signal
%                       signal functions should take the number of samples of the signal to create, whether to create complex or real signals and an optional input noise signal 
%
%   Output: output  - the alternating signal
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

num = leng/alt; % Number of blocks of different signals

% Create the noise signal
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

% Check the number of different signals to alternate between & create appropriate blocks of data
if nargin == 5
    for k=1:num/2
        output(alt*(2*k-2)+1:alt*(2*k-1)) = sig1(alt,comp,noise(alt*(2*k-2)+1:alt*(2*k-1)));
        output(alt*(2*k-1)+1:alt*(2*k)) = sig2(alt,comp,noise(alt*(2*k-1)+1:alt*(2*k)));
    end
elseif nargin == 6
    for k=1:num/3
        output(alt*(3*k-3)+1:alt*(3*k-2)) = sig1(alt,comp,noise(alt*(3*k-3)+1:alt*(3*k-2)));
        output(alt*(3*k-2)+1:alt*(3*k-1)) = sig2(alt,comp,noise(alt*(3*k-2)+1:alt*(3*k-1)));
        output(alt*(3*k-1)+1:alt*(3*k)) = sig3(alt,comp,noise(alt*(3*k-1)+1:alt*(3*k)));
    end
else
    for k=1:num/4
        output(alt*(4*k-4)+1:alt*(4*k-3)) = sig1(alt,comp,noise(alt*(4*k-4)+1:alt*(4*k-3)));
        output(alt*(4*k-3)+1:alt*(4*k-2)) = sig2(alt,comp,noise(alt*(4*k-3)+1:alt*(4*k-2)));
        output(alt*(4*k-2)+1:alt*(4*k-1)) = sig3(alt,comp,noise(alt*(4*k-2)+1:alt*(4*k-1)));
        output(alt*(4*k-1)+1:alt*(4*k)) = sig4(alt,comp,noise(alt*(4*k-1)+1:alt*(4*k)));
    end
end
