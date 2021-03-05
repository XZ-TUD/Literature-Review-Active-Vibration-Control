P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';

num1=[0 3.3*10^4]; %开环传函的分子系数注意分子前面需要加个0
den1=[0 1]; %开环传函的分母系数
G_P=tf(num1,den1);

grid; %绘制网格命令
bode(G_P,P); %绘制波特图函数
gtext('P');
