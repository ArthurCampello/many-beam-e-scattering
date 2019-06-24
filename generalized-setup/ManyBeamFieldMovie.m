%FOR USER TO SPECIFY:
% beam directions
[k1, k2, k3]=deal([0, 0, 1]',[0, 0, 1]',[0, 0, 1]');
k=[k1,k2,k3];
% beam polarizations
[p1, p2, p3]=deal([1, 0, 0]',[0, 1, 0]',[1, 1, 0]');
pol=[p1,p2,p3];
% beam intensities
e=[1, 1, 1];
% beam relative frequencies
omega=[1, 2.1, 1.2];
% beam phase shifts relative to first (keep first entry as zero)
eta=[0, 0, 0];
% samples per cycles
sampps=100;

%Define x and y rotation angle ranges
[radx, rady]=deal([-1.5,1.5]',[-1.5,1.5]');
%Define number of x and y rotation steps within respective ranges
[xres, yres]=deal(21,21);


%FOR USER TO IGNORE:
%Creates list of x and y angles
[xp, yp]=deal(linspace(radx(1),radx(2),xres),linspace(rady(1),rady(2),yres));
%References frequencies to determine two-frequency period
[nums, dems]=rat(omega/min(omega));
tspan=round(lcm(sym(dems)));
N=2*int32(tspan)*sampps+1;
%Creates meshgrid for quiver
[x,y] = meshgrid(yp,xp);
%Initializes U and V for quiver
u = zeros(xres,yres, N); v = u;
%Loops through x and y angles
for i=1:xres
    for j=1:yres
        %Calculates field over time given angles and parameters
        ef=ManyBeamField(k, pol, e, omega, eta, sampps, [xp(i), yp(j)]);
        %Assigns x and y field components to u and v
        u(i,j,:)=ef(1,:)/xres*(radx(2)-radx(1));
        v(i,j,:)=ef(2,:)/yres*(rady(2)-rady(1));
    end
end
%Loops through N time slices
for i = 1:N
    %Creates quiver plot
    q=quiver(x,y,u(:,:,i),v(:,:,i));
    %Quiver plot settings
    q.AutoScale="off";q.Color="red";grid on;axis([-2 +2 -2 +2]);pause(0.01);
end