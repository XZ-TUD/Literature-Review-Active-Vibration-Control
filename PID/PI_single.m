P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';

num3=[3.3*10^4 1.8*10^6]; %开环传函的分子系数注意分子前面需要加个0
den3=[1 0]; %开环传函的分母系数
G_PI=tf(num3,den3);

grid; %绘制网格命令
bode(G_PI,P); %绘制波特图函数
gtext('PI');
