function [ re ] = MNorm( X, Y, Cinv )
%Calculate || X -Y ||
tmp = X - Y;
re = sqrt( tmp * Cinv * tmp.');

end

