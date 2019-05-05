len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);
%% delta
for i=1 : len1
    
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    
    if (times_r(i) > stop)
        
        stop_D = i;
        
        break;
    end
end

[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
[y_minD,x_minD] = min(Delta_n(start_D:stop_D));
x_timesmaxD = times_r(x_maxD + start_D);
x_timesminD = times_r(x_minD + start_D);

Deriv_D = (y_maxD - y_minD) / ((x_timesmaxD - x_timesminD)/10000);
%% lfhf

len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

[y_maxL,x_maxL] = max(LFHF_n(start_L:stop_L));
[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
x_timesmaxL = tacogramma_shift(x_maxL + start_L);
x_timesminL = tacogramma_shift(x_minL + start_L);

Deriv_L = (y_maxL - y_minL) / ((x_timesmaxL - x_timesminL)/10000);
rapporto_der = Deriv_D / Deriv_L;
%% punto intersezione
x_int = 0;
[x_int,y_int] = intersections(times_r(start_D:stop_D),Delta_n(start_D:stop_D),tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),1);
if (x_int)
    k3=0;
    for i=start_D : stop_D
    
        if (times_r(i)>=x_int)
            start_int_D = i;
            break;
        end
    end

    for i=start_L : stop_L
    
        if (tacogramma_shift(i)>= x_int)
            start_int_L = i;
            break;
        end
    end

    Deriv_int_D = (y_maxD - y_int) / ((x_timesmaxD - x_int)/10000); %moltiplicato per diecimila per una migliore visualizzazione

    
    Deriv_int_L = (y_int - y_minL) / ((x_int - x_timesminL)/10000); %moltiplicato per diecimila per una migliore visualizzazione
    rapporto_der_int = Deriv_int_D / Deriv_int_L;

end
Diff_fase = x_timesmaxD - x_timesminL;
%% plot
figure(2);

if (x_int)
    subplot(3,1,2);
    plot([x_int x_timesminL], [y_int y_minL],'linewidth',2,'color','y');
    hold on; grid on;
    plot([x_int x_timesmaxD], [y_int y_maxD],'linewidth',2,'color','k');
    subplot(3,1,3);
    plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L));
    hold on; plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D));
    grid on; hold on;
    plot([x_int x_timesminL], [y_int y_minL],'linewidth',2,'color','k');
    hold on; grid on;
    plot([x_int x_timesmaxD], [y_int y_maxD],'linewidth',2,'color','k');
end
figure(3);
subplot(2,1,1);
plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L));
hold on; plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D));
grid on; hold on;
plot([x_timesmaxL x_timesminL], [y_maxL y_minL],'linewidth',2,'color','k');
hold on; grid on;
plot([x_timesminD x_timesmaxD], [y_minD y_maxD],'linewidth',2,'color','k');
if (x_int)
    subplot(2,1,2);
    plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L));
    hold on; plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D));
    grid on; hold on;
    plot([x_int x_timesminL], [y_int y_minL],'linewidth',2,'color','k');
    hold on; grid on;
    plot([x_int x_timesmaxD], [y_int y_maxD],'linewidth',2,'color','k');
end
    %% save
if (x_int)
    save Delta_analysis_0_3 Deriv_int_L Deriv_int_D rapporto_der_int Deriv_L Deriv_D rapporto_der Diff_fase;
else
    save Delta_analysis_0_3 Deriv_L Deriv_D rapporto_der Diff_fase;
end