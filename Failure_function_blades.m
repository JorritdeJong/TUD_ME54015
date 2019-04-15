function F_blades = Failure_function_blades()
%% Turbine blade failure functions
t_lifespan = 20;
t = linspace(1,t_lifespan,t_lifespan);
% Early failures
f_early = 0.25*(t./2).^(-0.5).*(exp(-(t./2).^(0.5)));
% Aging failures
f_aging = real(0.09*((t-10)./17).^(0.3).*exp(-((t-10)./17).^(1.3)));
f_aging(1:9) = 0; % Correction b
f_aging(10) = 0.025; % Correction c
% Fatigue failures
f_fatigue = 0.01375*(t./160).^(1.1).*exp(-(t./160).^(2.2));

% Failure curve
ft_blades = f_early + f_aging + f_fatigue;
% Cumulated curve
ft_blades_cum = cumtrapz(ft_blades);
% Error over time
err = 0.5.*(ft_blades)+0.01.*(ft_blades_cum);
% Plot
figure(1);

p1 = subplot(2,1,1);
%plot(p1,t,ft_blades)
errorbar(t,ft_blades,err);
title(p1,'Combined Weibull curve turbine blades')
xlabel('Life time [years]')
ylabel('Failure function')
ylim([0,0.4])
grid on
%set(gca, 'XScale', 'log')

p2 = subplot(2,1,2);
%plot(p2,t,ft_blades_cum)
errorbar(t,ft_blades_cum,err);
title(p2,'Cumulated failure function')
xlabel('Life time [years]')
ylabel('Cumulated failure function')
ylim([0,1])
grid on
%set(gca, 'XScale', 'log')

% Yearly failure rate and error
F_blades = [ft_blades ; err];
end