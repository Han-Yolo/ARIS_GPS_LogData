for i = 1:65
   prc.(i)(prc.(i) == 0) = nan;
end

sats = [];
for i = 2:2:65
    if any(prc.(i))
        sats = [sats i];
    end
end

figure('Name', 'Single')
for i = 1:length(sats)
   subplot(4, 3, i)
   plot([prc.(sats(i)) prc.(sats(i)+1)]); 
   title('Sat ' + string(sats(i)/2))
end

legendtxt = cell(length(sats), 1);
for i = 1:length(sats)
   legendtxt{i} = 'Sat ' + string(sats(i)/2);
end

figure('Name', 'All Unfiltered')
hold on
for i = 1:length(sats)
   plot(prc.(sats(i))); 
end
hold off
xlabel('Time [s]')
ylabel('Pesudorange Correction [m]')
legend(legendtxt, 'Location', 'southwest')

figure('Name', 'All Filtered')
hold on
for i = 1:length(sats)
   plot(prc.(sats(i)+1)); 
end
hold off
xlabel('Time [s]')
ylabel('Pesudorange Correction [m]')
legend(legendtxt, 'Location', 'southwest')