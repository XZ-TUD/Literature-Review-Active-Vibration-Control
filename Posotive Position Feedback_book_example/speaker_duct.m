%%%%%The parameters of the loudspeaker
Lx=4;
Ly=0.25;
Lz=0.25;
lo0=1.239;
c0=340;
ST=Lx*Ly; % the area of duct section
wc_s=28*2*pi; % the natural frequency of loudspeaker
Ss=207e-4; % the eff. area of cone (m^2)
Vs=ST*0.1; % the volume of  the loudspeaker box (estimate) (m^3)
Ls=0.75e-3; % inductance of loudspeaker (L)
Bl=9.9; % force factor of loudspeaker (Tm)
Rs=6.2; % resistance of loudspeaker (Om)
Ms=37e-3; % Eff. moving mass (Kg)
Ks=Ms*wc_s^2; % Stiffness of loudspeaker
Rnn=10; % Damping of loudspeaker (Estimate)
Nmod=12;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ks=Ks+c0^2*lo0*Ss^2/Vs;

A0=[-Rs/Ls, 0,      -Bl/Ls
    0,      0,      1
    Bl/Ms,  -Ks/Ms, -Rnn/Ms];

B0=[1/Ls 0; 0 0; 0 -Ss/Ms];

C0=[Bl/Ms -Ks/Ms -Rnn/Ms];

D0=[0 -Ss/Ms];

sys_spk=ss(A0, B0, C0, D0);

%%%%%%%%%%%%%%%%%%% For duct model
EE=lo0*c0^2/(Lz*Lx*Ly);

AD=[zeros(Nmod,Nmod) eye(Nmod); -wr.^2 -2*nnnr*wr];

BD(:,1)=[zeros(Nmod,1); EE*Ss*Paa.']; %% 1st column of BD
BD(:,2)=[zeros(Nmod,1); EE*Ss*Pcc.']; %% 2nd column of BD

CD=[Paa zeros(1, Nmod) %% pressure at primary
    Pmm zeros(1, Nmod) %% pressure at error sensor
    Pss zeros(1, Nmod) %% pressure at monitor microphone
    Pcc zeros(1, Nmod)]; %% pressure at control loudspeaker
DD=zeros(4,2); %% 4 row and 2 column zero matrix 

sys_duct=ss(AD,BD,CD,DD);

sysDT=sys_duct;
sysNS=sys_spk;
sysCS=sys_spk;
% Build the connection wih loudspeaker and duct models
systemnames = ' sysDT sysNS sysCS';
inputvar = '[ dist; control]';
outputvar = '[sysDT(2:3)]';
input_to_sysDT = '[sysNS; sysCS]';
input_to_sysNS = '[dist; sysDT(1)]';
input_to_sysCS = '[control; sysDT(4)]';
sysoutname = 'sysUU';
cleanupsysic = 'yes';
sysic

dist          = icsignal(1);
control       = icsignal(1);
out           = icsignal(4);
yp            = icsignal(2);
MM            = iconnect;
MM.Input      = [dist; control];
MM.Output     = [out(2:3)];
MM.Equation{1} = equate(out, sysDT*yp);
MM.Equation{2} = equate(yp,[sysNS*[dist; out(1)];
   sysCS*[control; out(4)]]);
sysUU=MM.system;

%%%%%%%%%%%%%%%%%%%%
sysAA  = append(sysNS, sysCS, sysDT);
Q      = [2 3; 4 6; 5 1; 6 2];
inputs = [1 3];
outputs= [4 5];
sysUU  = connect(sysAA, Q, inputs, outputs);
