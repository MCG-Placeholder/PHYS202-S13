clear all; close all; 
%% 
% Enter the measured data points by hand 
x=[-10 -9 -8 -7 -6 -5 -4 -3 0]; 
y = [2.65 2.10 1.90 1.40 1.00 0.80 0.60 0.30 0.00]; 
ey = [0.1 0.1 0.1 0.1 0.05 0.05 0.05 0.05 0.2]; 
% Plot the data with error bars 
figure(1) 
errorbar(x,y,ey,'b.') 
% Don?t forget the labels 
xlabel('x (mm)') 
ylabel('y (mm)') 
axis equal
hold on;

%% 
%hold on 
w=ey.^-2;
[slope,intercept,slerr,interr]=WeightedLSQFit(x,y,w);
disp(slope);disp(intercept);
%hold off

%% 
% Do something in the same figure window. 
plot(x,x.*slope+intercept)
%%
%function to fit
fun=@(a,b,c,x)-sqrt(a^2-(x-b).^2)+c;
%Find a starting point for the parameters a, b, and c.
guess = fun(15,0,15,x); %fun(a,b,c,x)
plot(x,guess,'r:')
%fit the data
fittedmodel=fit(x',y',fun,'StartPoint',[15 0 15])
%plot the result
plot(fittedmodel,'r-');
%fit the data using the uncertainties as weights
w=ey.^-2;
weightedfit=fit(x',y',fun,'StartPoint',[15 0 15],'Weights',w')
plot(weightedfit,'r-');