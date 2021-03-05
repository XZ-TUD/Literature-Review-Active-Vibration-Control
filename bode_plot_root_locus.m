
num =[5*0.1,1];
f1=[1,0];f2=[0.5,1];
f3=[1/2500,0.6/50,1];
den=conv(f1,conv(f2,f3));
G = tf(num,den);

figure(1)
bode(num,den);
grid on; % 绘制网格命令 
hold on % hold on是当前轴及图像保持而不被刷新,准备接受此后将绘制的图形,多图共存 

figure(2)
rlocus(G);
grid on;
hold on

% change x axis to Hz
figure(3)
P=bodeoptions;
P.Grid='on';
P.XLim={[10^-1,10^5]};
P.XLimMode={'manual'};
P.FreqUnits='Hz';
bode(G,P)