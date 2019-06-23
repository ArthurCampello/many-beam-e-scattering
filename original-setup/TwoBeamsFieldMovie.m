%FOR USER TO SPECIFY:
% defines x and y rotation angle ranges
[radx, rady]=deal([-1.5,1.5]',[-1.5,1.5]');
% defines number of x and y rotation steps within respective ranges
[xres, yres]=deal(21,21);
% defines hard coded parapeters according to section 2 of the report
[phi, omega, eta, e, sampps]=deal(pi/2, [1, 2.1], 0, [1, 1], 200);

%FOR USER TO IGNORE:
% creates list of x and y angles
[xp, yp]=deal(linspace(radx(1),radx(2),xres),linspace(rady(1),rady(2),yres));
% references frequencies to determine two-frequency period
[num, den]=rat(max(omega)/min(omega));
N=2*den*sampps+1;
% creates meshgrid for quiver
[x,y] = meshgrid(yp,xp);
% initializes U and V for quiver
u = zeros(xres,yres, N); v = u;
% loops through x and y angles
for i=1:xres
    for j=1:yres
        % calculates field over time given angles and parameters
        ef=TwoBeamsField(phi, omega, eta, e, sampps, xp(i), yp(j));
        % assigns x and y field components to u and v
        u(i,j,:)=ef(1,:)/xres*(radx(2)-radx(1));
        v(i,j,:)=ef(2,:)/yres*(rady(2)-rady(1));
    end
end
% loops through N time slices
for i = 1:N
    % creates quiver plot
    title('Radiated Electric Field Observed from Angle Pairs')
    xlabel('Angle about y-axis')
    ylabel('Angle about x-axis')
    hold
    q=quiver(x,y,u(:,:,i),v(:,:,i));
    % quiver plot settings
    q.AutoScale="off";q.Color="red";grid on;axis([-2 +2 -2 +2]);pause(0.01);
    
    clf('reset') 
end