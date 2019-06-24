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
% samples per cycles
sampps=100;

%Define x and y rotation angle ranges
[radx, rady]=deal([-1.5,1.5]',[-1.5,1.5]');
%Define number of x and y rotation steps within respective ranges
[xres, yres]=deal(51,51);

%FOR USER TO IGNORE:
% populates x and y angle range
[x, y]=deal(linspace(radx(1),radx(2),xres),linspace(rady(1),rady(2),yres));
% initializes heatmap matrix of radiated intensity for angle pairs
radmat=zeros(xres,yres);
% loops through x and y angles
for i=1:xres
    for j=1:yres
        % calculates the radiated intensity given angles and parameters
        radmat(i,j)=ManyBeamRadiation(k, pol, e, omega, eta, sampps, [x(i), y(j)]);
    end    
end
% sets one (corner) heatmap value to zero for reference
radmat(1,1)=0;
% creates and diaplays heatmap of radiated intensity for angle pairs
h = heatmap(x,y,radmat', 'Colormap', parula(100), 'ColorbarVisible', 'on');
h.Title = 'Relative Intensity of Radiation over Shpere';
h.XLabel = 'Angle about Y';
h.YLabel = 'Angle about X';
grid off