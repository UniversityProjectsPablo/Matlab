function [ s,m ] = DummyFunction( a, b )
%This is a dummy function created for you.
% It takes two arguments a and b and return their sum or the sum of their
% elements and the minimum of both or their elements. Note that a and b
% must be scalars or arrays.

dum = [a(:);b(:)];

s = sum(dum);
m = min(dum);


end

