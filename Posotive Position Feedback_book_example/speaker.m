%%%%%The parameters of the loudspeaker
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ks=Ks+c0^2*lo0*Ss^2/Vs;

A0=[-Rs/Ls, 0,      -Bl/Ls
    0,      0,      1
    Bl/Ms,  -Ks/Ms, -Rnn/Ms];

B0=[1/Ls 0; 0 0; 0 -Ss/Ms];

C0=[B1/Ms -Ks/Ms -Rnn/Ms];

D0=[0 -Ss/Ms];

sys_spk=ss(A0, B0, C0, D0);

