function [ re ] = EuclidNorm( X, Y )
%Calculate || X -Y ||
    re = sqrt( sum( ( X - Y ).^2) );


end

