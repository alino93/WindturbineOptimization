R=35;
Rho=1.225;
Jr=2.96e6;
Jg=53.036;
Cls=1e5;
Kls=5.6e5;
Cr=625;
Cg=0.05;
ng=87.965;
beta_opt=2;
lambda_opt=7.1;
Cp_opt=0.4857;
a11=-Cr/Jr;
a12=0;
a13=-1/Jr;
a21=0;
a22=-Cg/Jg;
a23=1/ng/Jg;
a31=Kls-Cls*Cr/Jr;
a32=(Cls*Cg/Jg-Kls)/ng;
a33=-Cls*(Jr+ng^2*Jg)/(ng^2*Jg*Jr);
b11=1/Jr;
b12=0;
b21=0;
b22=-1/Jg;
b31=Cls/Jr;
b32=Cls/ng/Jg;
filename = 'Cp.xlsx';
Cp = xlsread(filename);
filename = 'v.xlsx';
vf = xlsread(filename);
TMax = 300;
%%
sim('Closedloop_PI.slx',[0,TMax]);
sim('Closedloop_PI_NN.slx',[0,TMax]);
sim('Closedloop_LL_NN.slx',[0,TMax]);
sim('Closedloop_LL.slx',[0,TMax]);
%% 
figure (1)
hold on
plot(Power_PI,'linewidth',1.5)
plot(Power_PI_NN,'linewidth',1.5)
plot(Power_LL,'linewidth',1.5)
plot(Power_LL_NN,'linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Power (kW)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('PI','PI-NN','LeadLag','LeadLag-NN');

figure(2)
hold on
plot(Tem_PI,'linewidth',1.5)
plot(Tem_PI_NN,'linewidth',1.5)
plot(Tem_LL,'linewidth',1.5)
plot(Tem_LL_NN,'linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Generator Torque (N.m)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('PI','PI-NN','LeadLag','LeadLag-NN');

figure(3)
hold on
plot(Err_PI,'linewidth',1.5)
plot(Err_PI_NN,'linewidth',1.5)
plot(Err_LL,'linewidth',1.5)
plot(Err_LL_NN,'linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Rotor Speed Error (rad/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('PI','PI-NN','LeadLag','LeadLag-NN');

figure(4)
hold on
plot(Energy_PI,'linewidth',1.5)
plot(Energy_PI_NN,'linewidth',1.5)
plot(Energy_LL,'linewidth',1.5)
plot(Energy_LL_NN,'linewidth',1.5)
set(gca,'fontsize',16);
ylabel('Output Energy (kj)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
title('');
legend('PI','PI-NN','LeadLag','LeadLag-NN');

figure(5)
hold on
plot(Omega_opt,'--','linewidth',0.5,'Color',[0,0.4470,0.7410])
plot(Omega_PI,'linewidth',1.5,'Color',[0 0 0])
plot(Omega_PI_NN,'linewidth',1.5,'Color',[0.4660    0.70    0.20])
plot(Omega_LL,'linewidth',1.5,'Color',[1,0,0])
plot(Omega_LL_NN,'linewidth',1.5,'Color',[0,0,1])
set(gca,'fontsize',16);
ylabel('Rotor Angular Speed (rad/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
title('');
legend('Optimal','PI','PI-NN','LeadLag','LeadLag-NN');

figure(6)
plot(Wind,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Wind Speed (m/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

%% 
% scrsz = get(groot,'ScreenSize');
% figure('Position',[scrsz(4)/5 scrsz(4)/8 scrsz(3)/1.39 scrsz(4)/1.36])
% set(groot,'DefaultFigurePosition',[scrsz(4)/5 scrsz(4)/8 scrsz(3)/1.39 scrsz(4)/1.36]);
% 
% co = [0,0,0
%       0.47,0.7,0.2
%       1,0,0
%       0,0,1
% ];
% set(groot,'defaultAxesColorOrder',co)
