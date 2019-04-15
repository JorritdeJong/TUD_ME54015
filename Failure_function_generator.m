function F_generator = Failure_function_generator()
%% generator failure functions
t_lifespan = 20;
t = linspace(1,t_lifespan,t_lifespan);
% Early failures
beta = 0.4; % Shape parameter
eta = 2; % Characteristic life
gamma = 0; % Failure free life
f_early = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);
% Aging failures
beta = 6; % Shape parameter
eta = 12; % Characteristic life
gamma = 8; % Failure free life
f_aging = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);

% Failure curve
ft_generator = 0.5.*f_early + 0.5.*f_aging;
% Cumulated curve
ft_generator_cum = cumtrapz(ft_generator);
% Error over time
err = 0.5.*(ft_generator)+0.01.*(ft_generator_cum);

% Plots
figure(3);
p1 = subplot(2,1,1);
%plot(p1,t,ft_generator)
errorbar(t,ft_generator,err);
title(p1,'Combined Weibull curve turbine generator')
xlabel('Life time [years]')
ylabel('Failure function')
ylim([0,0.4])
grid on

p2 = subplot(2,1,2);
%plot(p2,t,ft_generator_cum)
errorbar(t,ft_generator_cum,err);
title(p2,'Cumulated failure function')
xlabel('Life time [years]')
ylabel('Cumulated failure function')
ylim([0,1])
grid on

% Yearly failure rate and error
F_generator = [ft_generator ; err];
end