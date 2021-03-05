P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';

num0=[0 1]; %开环传函的分子系数注意分子前面需要加个0
f1=[0.25 0.1 100]
den0=f1; %开环传函的分母系数
G_0=tf(num0,den0);

num6=[3.3*10^4*5*10^-3 (5*10^-4*60+1)*3.3*10^4 3.3*10^4*60]; %开环传函的分子系数注意分子前面需要加个0
den6=[5*10^-4 1 0]; %开环传函的分母系数
G_PID=tf(num6,den6);

num2=conv(num0,num6);
den2=conv(den0,den6);
G_2=tf(num2,den2);

grid; %绘制网格命令
bode(G_0,G_2,P); %绘制波特图函数
gtext('Gs');
gtext('Gs*GPID');
