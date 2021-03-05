sysDT=sys_duct;
sysNS=sys_spk;
sysCS=sys_spk;

% Interconnection Model Using Function sysic
% Build the connection wih loudspeaker and duct models
systemnames = 'sysDT sysNS sysCS';
inputvar = '[dist; control]';
outputvar = '[sysDT(2:3)]';
input_to_sysDT = '[sysNS; sysCS]';
input_to_sysNS = '[dist; sysDT(1)]';
input_to_sysCS = '[control; sysDT(4)]';
sysoutname = 'sysUU';
cleanupsysic = 'yes';
sysic

% Interconnection Model Using Functions iconnect and icsignal
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
