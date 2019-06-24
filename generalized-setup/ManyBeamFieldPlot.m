%USER INPUTS:
% beam directions
[k1, k2, k3]=deal([0, 0, 1]',[1, 0, 1]',[0, 0, 1]');
k=[k1,k2,k3];
% beam polarizations
[p1, p2, p3]=deal([1, 0, 0]',[0, 1, 0]',[1, 1, 0]');
pol=[p1,p2,p3];
% beam intensities
e=[1, 1.5, 2];
% beam relative frequencies
omega=[1, 2.1, 1.2];
% beam phase shifts relative to first (keep first entry as zero)
eta=[0, 0, 0];
% samples per cycls
sampps=100;
% observation angle pair
angs=[0,0];

%FOR USER TO IGNORE: 
% determines length of one period given frequenceies
[nums, dems]=rat(omega/min(omega));
tspan=round(lcm(sym(dems)));
% determines radiated electric field over time
er=ManyBeamField(k, pol, e, omega, eta, sampps, angs);
% determines time-axis defined by resolution and span
x=0:1/sampps:tspan;
figure(1);
% plots radiated electrid field over time
plot(x(3:int32(tspan*sampps)),er(:,3:int32(tspan*sampps)));
title('Radiated Electric Field as Observed from \theta=1, \alpha=1')
xlabel('Time')
ylabel('Transformed Radiated Electric field')
legend('x-component','y-component','z-component')