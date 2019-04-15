%% Failure generator
% Fixed input
%% Failure Data Index Generator [switch]
if true
    F_blades = Failure_function_blades();
    F_gearbox = Failure_function_gearbox();
    F_generator = Failure_function_generator();
    F_rotorhub = Failure_function_rotorhub();
    F_transformer = Failure_function_transformer();
    failure_rate = [F_blades(1,:) ; F_gearbox(1,:) ; F_generator(1,:) ; F_rotorhub(1,:) ; F_transformer(1,:)];
    save('failure_rate.mat','failure_rate')
    series_seed = 4415493;
    for j = 1:5 % Series 
        %series_seed = series_seed + 12050342; % Method A
        for i = 1:20 % Years (20)
            series_seed = series_seed + 12050342; % Method B
            sim('Failure_generator',n_T);
            Failure_data_index(i,j) = Failure_data; % Write failure data
            Failure_events_index(i,j) = Failure_events;
            [i j]
        end
    end
    save('Failure_data_index')
    save('Failure_events_index')
    clear Failure_data
    clear Failure_events
    clear Failure_data_index
    clear Failure_events_index
end