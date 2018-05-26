%% Reference Position
X_ref = 4309200.12361766;
Y_ref = 627121.227002268;
Z_ref = 4645596.10952142;
[lat_ref, lon_ref, h_ref] = xyz2llh(X_ref, Y_ref, Z_ref);


%% GPS
UTC_gps = gps.Hour*3600 + gps.Minute*60 + gps.Second;

% calc latitude and longitude and height
lat_gps = gps.Latitude_deg + gps.Latitude_min/60;
lon_gps = gps.Longitude_deg + gps.Longitude_min/60;
h_gps = gps.Altitude_mamsl;

% remove DGNSS data
lat_gps(gps.Status ~= 1) = nan;
lon_gps(gps.Status ~= 1) = nan;
h_gps(gps.Status ~= 1) = nan;

% calc enu
[x_gps, y_gps, z_gps] = llh2xyz(lat_gps, lon_gps, h_gps);
[e_gps, n_gps, u_gps] = xyz2enu(lat_ref, lon_ref, h_ref, x_gps, y_gps, z_gps);

% calc horizontal euclidian error
en_gps = sqrt(e_gps.^2 + n_gps.^2);

%% DGPS
UTC_dgps = dgps.Hour*3600 + dgps.Minute*60 + dgps.Second;

% calc latitude and longitude and height
lat_dgps = dgps.Latitude_deg + dgps.Latitude_min/60;
lon_dgps = dgps.Longitude_deg + dgps.Longitude_min/60;
h_dgps = dgps.Altitude_mamsl;

% remove non DGNSS data
lat_dgps(dgps.Status ~= 2) = nan;
lon_dgps(dgps.Status ~= 2) = nan;
h_dgps(dgps.Status ~= 2) = nan;

% calc enu
[x_dgps, y_dgps, z_dgps] = llh2xyz(lat_dgps, lon_dgps, h_dgps);
[e_dgps, n_dgps, u_dgps] = xyz2enu(lat_ref, lon_ref, h_ref, x_dgps, y_dgps, z_dgps);

% calc horizontal euclidian error
en_dgps = sqrt(e_gps.^2 + n_gps.^2);

%% Plot
start = max([UTC_gps(1) UTC_dgps(1)]);
finish = min([UTC_gps(end) UTC_dgps(end)]);

index_gps = find(UTC_gps==start):find(UTC_gps==finish);
index_dgps = find(UTC_dgps==start):find(UTC_dgps==finish);

timeVec_gps = index_gps - find(UTC_gps==start) + 1;
timeVec_dgps = index_dgps - find(UTC_dgps==start) + 1;

figure('Name', 'Scatterplot/Altitude')
hold on
plot(e_gps(index_gps), n_gps(index_gps))
plot(e_dgps(index_dgps), n_dgps(index_dgps))
hold off
title('Horizontal Error Scatterplot')
xlabel('East [m]')
ylabel('North [m]')
legend('GPS', 'DGPS')


figure('Name', 'East/North')

subplot(121)
hold on
plot(timeVec_gps, en_gps(index_gps))
plot(timeVec_dgps, en_dgps(index_dgps))
hold off
title('Horizontal Error')
xlabel('Time [s]')
ylabel('Error [m]')
legend('GPS', 'DGPS')

subplot(122)
hold on
plot(timeVec_gps, u_gps(index_gps))
plot(timeVec_dgps, u_dgps(index_dgps))
hold off
title('Vertical Error')
xlabel('Time [s]')
ylabel('Error [m]')
legend('GPS', 'DGPS')
