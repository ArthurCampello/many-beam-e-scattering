%FOR USER TO SPECIFY:
% defines hard coded parapeters according to section 2 of the report
[phi, omega, eta, e, sampps]=deal(pi/2, [1, 2.1], 0, [1, 1], 2000);
% defines pre-selected x and y rotation angles
angs=[1, 1];

%FOR USER TO IGNORE:
% finds two-beat-period timespan
[num, dem]=rat(max(omega)/min(omega));
tspan=2*dem; 
% determines radiated electric field over time
er=TwoBeamsField(phi, omega, eta, e, sampps, angs(1), angs(2));
% determines time-axis defined by resolution and span
x=0:1/sampps:tspan;
figure(1);
% plots radiated electrid field over time
plot(x(4:dem*sampps),er(:,4:dem*sampps))
title('Radiated Electric Field as Observed from \theta=1, \alpha=1')
xlabel('Time')
ylabel('Transformed Radiated Electric field')
legend('x-component','y-component','z-component')