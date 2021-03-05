clc
clear
close all

%% system configuration
s=tf('s');
m0=50;m1=5;k1=40000;b1=0.01;
fB=1.0;a=0.5;wB=2*pi*fB;wpar=40;kI=(wB/a)^2*(m0+m1);
wp0=wB/a;wp1=93.8;wz=89.4;
dp0=1e-5;dp1=1e-5;dz=1e-5;
P=1/kI*s^2/(s^2/wp0^2+2*dp0*s/wp0+1)*1/(s/wpar+1)*(s^2/wz^2+2*dz*s/wz+1)/(s^2/wp1^2+2*dp1*s/wp1+1);

%% controls
KA=0.927; % actuator gain
wD=0.05*a*0.7*wB;
KH=kI*25.8/(KA*wp0^2*a*2.7);
H1=KH/(s/wD+1); %LPF
H2=KH*(s/(100*wD)+1)/(s/wD+1); % Lag component

%% open loops
L1=P*H1;
L2=P*H2;

%% closed loops
T1=kI*P/(1+H1*P)/s^2;
T2=kI*P/(1+H2*P)/s^2;

% closed loop second body
Ts1=(b1*s+k1)/(m1*s^2+b1*s+k1)*T1-T1;
Ts2=(b1*s+k1)/(m1*s^2+b1*s+k1)*T2-T2;

%% Response
figure(1)
w=logspace(-2,3,1000);
bode(T1,w), grid on, hold on %% Controlled system with LPF
bode(T2,w), grid on, hold on %% Controlled system with lag
bode(P/s^2,w), grid on, hold on
set(findall(gcf,'type','line'),'linewidth',2)

figure(2) % Nichols diagram for stability test
nichols(L1), grid on, hold on
nichols(L2), grid on, hold on
set(findall(gcf,'type','line'),'linewidth',2)

figure(3) % step response of the system
step(T1,T2,5)
set(findall(gcf,'type','line'), 'linewidth',2)

figure(4) % Effect of the controllers (LPF ad Lag) on second body
step(Ts1,Ts2,5)
set(findall(gcf,'type','line'),'linewidth',2)


