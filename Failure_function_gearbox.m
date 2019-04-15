function F_gearbox = Failure_function_gearbox()
%% Gearbox failure functions
t_lifespan = 20;
t = linspace(1,t_lifespan,t_lifespan);
% Early failures
beta = 1; % Shape parameter
eta = 10; % Characteristic life
gamma = 0; % Failure free life
f_early = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);
% Aging failures
beta = 5; % Shape parameter
eta = 10; % Characteristic life
gamma = 5; % Failure free life
f_aging = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);

% Failure curve
ft_gearbox = 0.5.*f_early + 0.5.*f_aging;
% Cumulated curve
ft_gearbox_cum = cumtrapz(ft_gearbox);
% Error over time
err = 0.5.*(ft_gearbox)+0.01.*(ft_gearbox_cum);

% Plots
figure(2);
p1 = subplot(2,1,1);
%plot(p1,t,ft_gearbox)
errorbar(t,ft_gearbox,err);
title(p1,'Combined Weibull curve turbine gearbox')
xlabel('Life time [years]')
ylabel('Failure function')
ylim([0,0.4])
grid on

p2 = subplot(2,1,2);
%plot(p2,t,ft_gearbox_cum)
errorbar(t,ft_gearbox_cum,err);
title(p2,'Cumulated failure function')
xlabel('Life time [years]')
ylabel('Cumulated failure function')
ylim([0,1])
grid on

% Yearly failure rate and error
F_gearbox = [ft_gearbox ; err];
end