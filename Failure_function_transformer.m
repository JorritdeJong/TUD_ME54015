function F_transformer = Failure_function_transformer()
%% transformer failure functions
t_lifespan = 20;
t = linspace(1,t_lifespan,t_lifespan);
% Early failures
beta = 0.9; % Shape parameter
eta = 5; % Characteristic life
gamma = 0; % Failure free life
f_early = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);
% Aging failures
beta = 8; % Shape parameter
eta = 8; % Characteristic life
gamma = 6; % Failure free life
f_aging = beta/eta*((t-gamma)./eta).^(beta-1).*exp(-((t-gamma)./eta).^beta);

% Failure curve
ft_transformer = 0.5.*f_early + 0.5.*f_aging;
% Cumulated curve
ft_transformer_cum = cumtrapz(ft_transformer);
% Error over time
err = 0.5.*(ft_transformer)+0.01.*(ft_transformer_cum);

% Plots
figure(5);
p1 = subplot(2,1,1);
%plot(p1,t,ft_transformer)
errorbar(t,ft_transformer,err);
title(p1,'Combined Weibull curve turbine transformer')
xlabel('Life time [years]')
ylabel('Failure function')
ylim([0,0.4])
grid on

p2 = subplot(2,1,2);
%plot(p2,t,ft_transformer_cum)
errorbar(t,ft_transformer_cum,err);
title(p2,'Cumulated failure function')
xlabel('Life time [years]')
ylabel('Cumulated failure function')
ylim([0,1])
grid on

% Yearly failure rate and error
F_transformer = [ft_transformer ; err];
end