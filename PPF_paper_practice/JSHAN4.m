
C1=1;
C2=0.15;
D1=pi;
D2=D1;
K=8;
w = logspace(0,3,10000);


A0=[0 1;
    -D1^2 -2*C1*D1];
B0=[0;K];
C0=[1 0];
D0=[];
sys_struc=ss(A0, B0, C0, D0);
x0=[1;0];
t=[0:0.01:10];
u=0*t;
[y,T,x]=lsim(sys_struc,u,t,x0);



A1=[0 1;
    -D2^2 -2*C2*D2];
B1=[0;K];
C1=[1 0];
D1=[];
sys_PPF=ss(A1, B1, C1, D1);

sysAA  = append(sys_PPF, sys_struc);
Q      = [2 1; 1 2];
sysUU  = connect(sysAA, Q);

subplot(221),bode(sys_struc,w); grid on, hold on;
subplot(222),bode(sys_PPF,w); grid on, hold on
subplot(223),plot(T,x(:,1)); xlabel('Time (sec)'), ylabel('Displacement(mm)');grid on, hold on



