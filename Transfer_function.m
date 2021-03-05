% If you know the exact parameters of transfer function, eg: G(s)=(s+2)/(3s^2+4s+5)

num1 = [1 2];
den1 = [3 4 5];
G1 = tf(num1,den1)
G12 = zpk(G1) % transfer G1 to the zeros&poles format

% Simple Model

s = tf('s');
sys = s/(s^2 + 2*s + 10)

% Zeros and Poles Model 

KGain = K; % The gain of system
Z = [1;2;3];
P = [4;5;6];
G2 = zpk(Z,P,KGain)
G21 = tf(G1) % transfer G2 to the normal format


% Feedback Model

G3 = tf(3,[1,4,4]);
G4 = tf(1,[1,3]);
G5 = feedback(G3,G4) % The third parameter is default -1, meaning negative feedback, when it is set to 1, it means positive feedback

% Multiply Model

a = [1 2 3];
b = [4 5 6];
num2 = conv(a,b);
den2 = [7 8 9];
G6 = tf(num2,den2)

% Series Model

G7 = series(G1,G2)

% Parallel Model

G8 = parallel(G1,G2)

% Discrete-Time SISO Transfer Function Model

num3 = [2,0];
den3 = [4,0,3,-1];
ts = 0.1;
sys = tf(num3,den3,ts)

% State-space Model

A = [-2 -1;1 -2];
B = [1 1;2 -1];
C = [1 0];
D = [0 1];
G9 = ss(A,B,C,D);
sys1 = tf(G9)



