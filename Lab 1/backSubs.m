function [x] = backSubs(A,b)
% [x] = backSubs(A,b)
% Performs a backsubstitution process over the matrix [A b]
%	to find x such that A*x = b with A upper triangular
% Inputs:
%	A: Upper triangular coefficients matrix
%	b: Independent term
% Outputs:
%	x: Solution of A*x = b
x = zeros(size(b));
[index,useless] = size(b);
i = 0;
while i < index
    x(index-i)=b(index-i)-A(index-i,index-i)*x(index-i)/A(index-i,index-i);
    i = i+1;
end
end

