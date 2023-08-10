clc;
clear all;
close all;

% input parameters
% Vrms = input('Enter the rms value of supply voltage: ');
% f = input('Enter the frequency of supply voltage: ');
% T = input('Enter the total number of cycles on the scope: ');
% t1 = input('Enter the time at which interruption occurs: ');
% t2 = input('Enter the duration of interruption: ');
% t3 = input('Enter the time at which flicker occurs: ');
% t4 = input('Enter the duration of flicker: ');
% t5 = input('Enter the time at which unbalance occurs: ');
% t6 = input('Enter the duration of unbalance: ');

Vrms = 230;
f = 50;
T = 25;
t1 = 5;
t2 = 3;
flicker_per = 5;
t3 = 10;
t4 = 3;
unbalance_per = 10;
t5 = 15;
t6 = 3;
thetaR = 0;
thetaY = (2*pi)/3;
thetaB = (2*pi)/3;

% generate time vector
t = linspace(0,T/f,T*100);

% generate voltage interruption
Vint_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
Vint_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
Vint_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);

Vint_R(t1*100:t1*100+t2*100) = 0;
Vint_Y(t1*100:t1*100+t2*100) = 0;
Vint_B(t1*100:t1*100+t2*100) = 0;

% generate voltage flicker
Vflicker_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
Vflicker_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
Vflicker_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);
Vflicker_R(t3*100:t3*100+t4*100) = Vflicker_R(t3*100:t3*100+t4*100)/flicker_per;
Vflicker_Y(t3*100:t3*100+t4*100) = Vflicker_Y(t3*100:t3*100+t4*100)/flicker_per;
Vflicker_B(t3*100:t3*100+t4*100) = Vflicker_B(t3*100:t3*100+t4*100)/flicker_per;

% generate voltage unbalance
Vunbalance = Vrms*sqrt(2)*sin(2*pi*f*t);
Vunbalance(t5*100:t5*100+t6*100) = Vrms*0.9;
Vunbalance(t5*100+t6*100/2:t5*100+t6*100/2+t6*100) = Vrms*1.1;

% plot the waveforms
figure;
subplot(3,1,1);
plot(t,Vint_R);
hold on;
plot(t,Vint_Y);
plot(t,Vint_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Interruption');
grid on;

subplot(3,1,2);
plot(t,Vflicker_R);
hold on;
plot(t,Vflicker_Y);
plot(t,Vflicker_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Flicker');
grid on;

subplot(3,1,3);
plot(t,Vunbalance,'b');
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Unbalance');
grid on;