%% Reference Position
X_ref = 4310031.16;
Y_ref = 628017.36;
Z_ref = 4644483.39;
[lat_ref, lon_ref, h_ref] = xyz2llh(X_ref, Y_ref, Z_ref);


%% GPS
UTC_gps = gps.Hour*3600 + gps.Minute*60 + gps.Second;

% calc latitude and longitude and height
lat_gps = gps.Latitudedeg + gps.Latitudemin/60;
lon_gps = gps.Longitudedeg + gps.Longitudemin/60;
h_gps = gps.Altitudemamsl;

% remove DGNSS data
lat_gps(gps.Status ~= 1) = nan;
lon_gps(gps.Status ~= 1) = nan;
h_gps(gps.Status ~= 1) = nan;

% calc enu
[x_gps, y_gps, z_gps] = llh2xyz(lat_gps, lon_gps, h_gps);
[e_gps, n_gps, u_gps] = xyz2enu(lat_ref, lon_ref, h_ref, x_gps, y_gps, z_gps);


%% DGPS
UTC_dgps = dgps.Hour*3600 + dgps.Minute*60 + dgps.Second;

% calc latitude and longitude and height
lat_dgps = dgps.Latitudedeg + dgps.Latitudemin/60;
lon_dgps = dgps.Longitudedeg + dgps.Longitudemin/60;
h_dgps = dgps.Altitudemamsl;

% remove non DGNSS data
lat_dgps(dgps.Status ~= 2) = nan;
lon_dgps(dgps.Status ~= 2) = nan;
h_dgps(dgps.Status ~= 2) = nan;

% calc enu
[x_dgps, y_dgps, z_dgps] = llh2xyz(lat_dgps, lon_dgps, h_dgps);
[e_dgps, n_dgps, u_dgps] = xyz2enu(lat_ref, lon_ref, h_ref, x_dgps, y_dgps, z_dgps);


%% Plot
figure('Name', 'GPS')
subplot(121)
hold on
plot(e_gps, n_gps)
plot(e_dgps, n_dgps)
hold off
title('Scatterplot ENU')
xlabel('East [m]')
ylabel('North [m]')

subplot(122)
hold on
plot(UTC_gps, u_gps)
plot(UTC_dgps, u_dgps)
hold off
title('Height ENU')
xlabel('Time [s]')
ylabel('Height [m]')
