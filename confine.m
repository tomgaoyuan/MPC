function [ re ] = confine( X )
%confine over topology
%   X <1x2> coordinates
%   re : bool-class return value
%           1 : true;
%           0 : false
    if X(1) > 0 && X(2) >0 && X(1) > X(2)   %x >0 y>0 x>y
        re = true;
    else
        re = false;
    end
end

