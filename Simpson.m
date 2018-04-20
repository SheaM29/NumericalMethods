function [I] = Simpson(x,y)
%Where the function numerically evaluates the integral of the vector of function
%values ‘y’ with respect to ‘x’
%Inputs:
%x - matrix containing x values of a function
%y - matrix containing y values of a function
%Outputs
%I - Value of the estimated integral

%Check that the number of inputs is 2
if nargin > 2
    error('Only input 2 matrices');
elseif nargin < 2
    error('Only input 2 matrices');
end

%Check if the input matrices are the same length
if(length(x) ~= length(y))
    error('Length of vector x must be the same as vector y')
end

%Check if the x matrix is equally spaced
xwidth = x(2)-x(1);
for i=2:length(x)-1
    if((x(i+1)-x(i)) ~= xwidth)
        error('Vector x must be equally spaced')
    end
end

%Set points for calculating area
x0 = 1;
y0 = y(1);

%If the length of x is even, use all but the last value for the Simpson's
%rule
if(mod(length(x),2) == 0)
    disp('The length of x is even so the trapezoidal rule has to be used on the last interval')
    x2 = length(x)-1;
    y2 = y(x2);
    x1 = (length(x))/2;
    y1 = y(x1);
else
    x2 = length(x);
    y2 = y(length(x));
    x1 = (length(x)+1)/2;
    y1 = y(x1);
end

%Estimate area under points by using the Simpson's 1/3 rule
I = ((x2-x0)*(y0 + 4*y1 + y2))/6;

%If the array length is even, calculate the last value using the trapezoid
%rule

if(mod(length(x),2) == 0)
    I = I + (y2+y(length(x)))/2*xwidth;
end

end

