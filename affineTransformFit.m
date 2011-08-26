function [A b] = affineTransformFit(x,y)
% fun times with least square fit preparation :)
% first we presume size(x,2) corresponds to the space dimension and
% size(x,1) corresponds to the number of fitting locations.
d = size(x,2);
n = size(x,1);
% prepare and fill the fitting matrix
Xmat = zeros(d*n,d*(d+1));
% add a vector of ones as an additional dimension for x
x = horzcat(x,ones(n,1));
% we reshape y to be a vector
y = y';
y = y(:);
% ... because matlab can...
for i=1:d
    Xmat(i:d:end,(i-1)*(d+1)+1:i*(d+1)) = x;
end

% in the spirit of least squares solve:
Bvec = (Xmat'*Xmat)\(Xmat'*y);
b = Bvec(d+1:d+1:end)';
Bvec(d+1:d+1:end) = [];
A = reshape(Bvec,d,d)';