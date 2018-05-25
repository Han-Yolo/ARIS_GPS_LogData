prc = dlmread('PRC_log_kriens_balkon_21_05_18_ohne_satcorr.txt', '\t', 1, 0);

prc(prc == 0) = nan;

hold on
plot(prc(:, 17))
plot(prc(:, 21))
plot(prc(:, 22))
plot(prc(:, 26))
plot(prc(:, 27))
plot(prc(:, 28))
plot(prc(:, 30))
plot(prc(:, 32))
hold off

%title('Pseudorange Corrections gemessen am 21.05.2018 in Kriens')
xlabel("Time [s]")
ylabel("Pseudorange Correction [m]")
legend('Sat 16', 'Sat 20', 'Sat 21', 'Sat 25', 'Sat 26', 'Sat 27', 'Sat 29', 'Sat 31', 'Location', 'SouthWest')
