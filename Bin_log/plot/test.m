 %% reference point
refLat = 39*pi/180;
refLong = -132*pi/180;
refH = 0;
 
%% Points of interest
lat = [39.5*pi/180; 39.5*pi/180;39.5*pi/180];
long = [-132*pi/180;-131.5*pi/180;-131.5*pi/180];
h = [0;0;1000];
 
disp('lat long height')
for i = 1:length(lat)
    disp([num2str(lat(i)*180/pi),' ', num2str(long(i)*180/pi), ' ',num2str(h(i))])
end
% lat = [39.5*pi/180];
% long = [-132*pi/180];
% h = [0];
 
%% convering llh to enu
[Xr,Yr,Zr] = llh2xyz(refLat,refLong,refH);
[X,Y,Z] = llh2xyz(lat,long,h);
disp('X Y Z')
 
for i = 1:length(X)
    disp([num2str(X(i)),' ', num2str(Y(i)), ' ',num2str(Z(i))])
end
 
[e,n,u] = xyz2enu(Xr, Yr, Zr, X, Y, Z);
disp('e n u')
for i = 1:length(e)
   disp([num2str(e(i)),' ', num2str(n(i)), ' ',num2str(u(i))])
end
 
%% Converting enu to llh
[X, Y, Z] = enu2xyz(refLat, refLong, refH, e, n, u);
disp('X Y Z')
for i = 1:length(X)
    disp([num2str(X(i)),' ', num2str(Y(i)), ' ',num2str(Z(i))])
end
 
[phi, lambda, h] = xyz2llh(X,Y,Z);
disp('\phi \lambda h')
for i = 1:length(X)
    disp([num2str(phi(i)*180/pi),' ', num2str(lambda(i)*180/pi), ' ',num2str(h(i))])
end