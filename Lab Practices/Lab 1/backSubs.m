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
sum = 0;

for i = 0:1:index-1
    for j = 0:1:i
        sum = sum + A(index-i,index-j)*x(index-j);
    end
   x(index-i) = (b(index-i) - sum) / A(index-i, index-i);
   sum = 0;
end
end

