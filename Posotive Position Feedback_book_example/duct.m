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