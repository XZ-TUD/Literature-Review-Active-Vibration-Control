num=[0 2.025*10^7];
den=[1 48.63 1.042*10^7];

Df=-3.88; %% introduce a zero at 363Hz
G=tf(num,den);
G_D=G+Df;
C1=987/s;
G_D_C1=C1*G_D/(1-C1*G_D);
C2=1357/s;
G_D_C12=C2*G_D_C1/(1+C2*G_D_C1);

t = 0:0.2:20;
[y,t] = step(G_D_C12,t);
plot(t,y,'LineWidth',1.2); 

bode(G),grid on,hold on
bode(G_D),grid on,hold on
%%bode(G_D_C1),grid on,hold on
bode(G_D_C12),grid on,hold on