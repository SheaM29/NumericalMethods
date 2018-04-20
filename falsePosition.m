function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%Shea Mielke 2/18/2018 Mech 105
%falsePosition estimates the root of the function by setting brackets and
%connecting them with a straght line. Then where the line interects the
%x-axis is the guess of the root. The x value of the guess replaces
%whichever bracket has the same sign as x. This is repeated until the
%maximum error or iterations has been reached.
%
%Inputs
% func - the function being evaluated
% xl - the lower guess
% xu - the upper guess
% es - the desired relative error (default to 0.0001%)
% maxiter - the number of iterations desired (default to 200)
%
%Outputs
% root - the estimated root location
% fx - the function evaluated at the root location
% ea - the approximate relative error (%)
% iter - how many iterations were performed

%Test number of inputs
if(nargin < 3)
    error('Input function, lower guess, upper guess, desired relative error, desired # of iterations')
end
if(nargin < 4)
    es = 0.0001;
end
if(nargin < 5)
    maxiter = 200;
end

%Set inital values
rerror = intmax;
iter = 0;
xr = 0;

%Check if user bracketed the root
if((func(xl)*func(xu))>0)
    error('Please bracket the root')
end

%Calculate the root estimate
while((rerror > es)&&(iter < maxiter))
%Record previous root estimate
xr0 = xr;

%Estimate root
xr = vpa(xu - (func(xu)*(xl-xu))/(func(xl)-func(xu)));

%Change brackets
if((func(xr)*func(xu))>0)
    xu=xr;
elseif((func(xr)*func(xu))<0)
    xl = xr;
end

%Calculate Error
if(iter > 0)
    rerror = abs((xr-xr0)/xr)*100;
end

%Increase Iterations
iter = iter+1;
end

%Set output values
root = xr;
fx = func(root);
ea = rerror;
end

