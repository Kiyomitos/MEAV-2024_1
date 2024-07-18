% Paulo Mareze

clear;
clc ;
close all;
format long
 
T_0 = 293.15; % ref
T_01 = 273.15 ; % ref
T = 25 + 273.15; % measured temperature
Ppascal=101325; % measured pressure
Patm=Ppascal/101325; % em atm
p_s0 = Patm;
F = [10:10:10000]./Patm;
ler=length(F);
hrar=80;%[0 10 20 40 60 80 100]; % relative humidity [%]
a_ps_ar=zeros(1,ler);


    hr=hrar;
    psat = p_s0*10^(-6.8346*(T_01/T)^1.261 + 4.6151);
    h = p_s0*(hr)*(psat/p_s0);
    F_rO = 1/p_s0*(24 + 4.04*10^4*h*(0.02+h)/(0.391+h));
    F_rN = 1/p_s0*(T_0/T)^(1/2)*( 9 + 280*h*exp(-4.17*((T_0/T)^(1/3)-1)) );
    alpha_ps= 100*F.^2./p_s0.*( 1.84*10^(-11)*(T/T_0)^(1/2)...
    + (T/T_0)^(-5/2)*(0.01278*exp(-2239.1/T)./(F_rO + F.^2/F_rO)...
    + 0.1068*exp(-3352/T)./(F_rN + F.^2/F_rN) ) );
    a_ps_ar = alpha_ps*20/log(10);
 

psvg = figure (1);
loglog(F,a_ps_ar,'LineWidth',2);
xlabel({'f / p_s [Hz/atm]';'Frequency/pressure'},'FontSize',10,...
    'FontWeight','normal','FontName','Times New Roman');
ylabel('Absorption coefficient/pressure a / p_s [dB/100 m atm]',...
    'FontSize',10,'FontWeight','normal','FontName','Times New Roman');
title({['Sound absorption coefficient per atmosphere for air at ', num2str(T-273.15),'°C '];...
    'according to relative humidity per atmosphere'},...
    'FontSize',10,'FontWeight','bold','FontName','Times New Roman')
hleg = legend(['',num2str(hrar),'%']);
% v = get(hleg,'title');
% set(v,'string',{'h_r / p_s [%/atm]'},'FontName','Times New Roman','FontSize',10,...
%     'BackgroundColor', 'white','EdgeColor','white','HorizontalAlignment','center');
% set(hleg,'Location','SouthEast','EdgeColor','black')
%axis([1e1 1e6 1e-3 1e4]);
grid on;
set(gca,'gridlinestyle','-');
set(gca,'MinorGridLineStyle','-')




freq=F.*Patm;
m=(1/100).*a_ps_ar.*Patm./(10.*log10(exp(1))); % m=X*alpha - 1/100 é para corrigir os 100 metros - 1/m


psvg = figure (2);
loglog(F.*Patm,m,'LineWidth',2);
xlabel({'freq [Hz]';'Frequency'},'FontSize',10,...
    'FontWeight','normal','FontName','Times New Roman');
ylabel('Power attenuation coefficient - m [1/m]',...
    'FontSize',10,'FontWeight','normal','FontName','Times New Roman');
title({['Power attenuation coefficient for air at ', num2str(T-273.15),'°C '];...
    'according to relative humidity'},...
    'FontSize',10,'FontWeight','bold','FontName','Times New Roman')
hleg = legend(['',num2str(hrar),'%']);
v = get(hleg,'title');
% set(v,'string',{'h_r  [%]'},'FontName','Times New Roman','FontSize',10,...
%     'BackgroundColor', 'white','EdgeColor','white','HorizontalAlignment','center');
set(hleg,'Location','SouthEast','EdgeColor','black')
%axis([1e1 1e6 1e-6 1e2]);
grid on;
set(gca,'gridlinestyle','-');
set(gca,'MinorGridLineStyle','-')
