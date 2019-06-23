%FOR USER TO SPECIFY:
% defines x and y rotation angle ranges
[radx, rady]=deal([-1.5,1.5]',[-1.5,1.5]');
% defines number of x and y rotation steps within respective ranges
[xres, yres]=deal(51,51);
% defines hard coded parapeters according to section 2 of the report
[phi, omega, eta, e, sampps]=deal(0.1, [1, 2.1], 0, [1, 1], 100);

%FOR USER TO IGNORE:
% populates x and y angle range
x=linspace(radx(1),radx(2),xres);
y=linspace(rady(1),rady(2),yres);
% initializes heatmap matrix of radiated intensity for angle pairs
radmat=zeros(xres,yres);
% loops through x and y angles
for i=1:xres
    for j=1:yres
        % calculates the radiated intensity given angles and parameters
        radmat(i,j)=TwoBeamsRadiation(phi, omega, eta, e, sampps, x(i), y(j));
    end    
end
% sets one (corner) heatmap value to zero for reference
radmat(1,1)=0;
% creates and diaplays heatmap of radiated intensity for angle pairs
h = heatmap(x,y,radmat', 'Colormap', parula(100), 'ColorbarVisible', 'on');
h.Title = 'Relative Intensity of Radiation over Shpere';
h.XLabel = 'Angle about y-axis';
h.YLabel = 'Angle about x-axis';
grid off