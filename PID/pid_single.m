P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';

num6=[3.3*10^4*5*10^-3 (5*10^-4*60+1)*3.3*10^4 3.3*10^4*60]; %开环传函的分子系数注意分子前面需要加个0
den6=[5*10^-4 1 0]; %开环传函的分母系数
G_PID=tf(num6,den6);

grid; %绘制网格命令
bode(G_PID,P); %绘制波特图函数
gtext('G(PID)');