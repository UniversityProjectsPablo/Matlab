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
[index,~] = size(b);

x(index) = b(index)/A(index,index);

    for i = index-1:-1:1
    x(i) = (b(i)-dot(A(i,:),x))/A(i,i);  
    disp(x);
    end
end

