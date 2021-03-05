P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';

num2=[3.3*10^4*5*10^-3 3.3*10^4]; %开环传函的分子系数注意分子前面需要加个0
den2=[5*10^-4 1]; %开环传函的分母系数
G_PD=tf(num2,den2);

grid; %绘制网格命令
bode(G_PD,P); %绘制波特图函数
gtext('PD');
