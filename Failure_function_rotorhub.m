function F_rotorhub = Failure_function_rotorhub()
%% rotorhub failure functions
t_lifespan = 20;
t = linspace(1,t_lifespan,t_lifespan);
% Early failures
beta = 0.2; % Shape parameter
eta = 2; % Characteristic life
gamma = 0; % Failure free life
f_early = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);
% Aging failures
beta = 9; % Shape parameter
eta = 12; % Characteristic life
gamma = 8; % Failure free life
f_aging = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);

% Failure curve
ft_rotorhub = 0.5.*f_early + 0.5.*f_aging;
% Cumulated curve
ft_rotorhub_cum = cumtrapz(ft_rotorhub);
% Error over time
err = 0.5.*(ft_rotorhub)+0.01.*(ft_rotorhub_cum);

% Plots
figure(4);
p1 = subplot(2,1,1);
%plot(p1,t,ft_rotorhub)
errorbar(t,ft_rotorhub,err);
title(p1,'Combined Weibull curve turbine rotorhub')
xlabel('Life time [years]')
ylabel('Failure function')
ylim([0,0.4])
grid on

p2 = subplot(2,1,2);
%plot(p2,t,ft_rotorhub_cum)
errorbar(t,ft_rotorhub_cum,err);
title(p2,'Cumulated failure function')
xlabel('Life time [years]')
ylabel('Cumulated failure function')
ylim([0,1])
grid on

% Yearly failure rate and error
F_rotorhub = [ft_rotorhub ; err];
end