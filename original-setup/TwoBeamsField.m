% takes in parameters specified in section 2 of report and angle pair
function E = TwoBeamsField(phi, omega, eta, e, sampps, angx, angy)

% writes omega values in relative terms of angular frequencies
o=2*pi*[1,max(omega)/min(omega)];
% finds two-beat-period timespan
[nums, dems]=rat(max(omega)/min(omega));
tspan=2*dems;
% initializes matrix for electron position over two periods
xt=zeros(3,2*dems*sampps+1); 

% loops over time
for i=3:length(xt(1,:))
    % determines acceleration according to equation 1 in report and
    acc=[e(1)*cos(o(1)*(i-2.5)/sampps+[0,0,1]*xt(:,i-1)),...
        e(2)*cos(o(2)*(i-2.5)/sampps+[sin(phi),0,cos(phi)]*xt(:,i-1)+eta),...
        0]'/sampps^2;
    % estimates future position using acceleration
    xt(:,i)=acc+2*xt(:,i-1)-xt(:,i-2);
end
% initializes matrix for electron acceleration over time
at=zeros(3,tspan*sampps+1);
% loops over time
for i=1:length(xt)-2
    % uses a finite difference approximation to estimate the acceleration
    % from xt
    at(:,i+1)=(xt(:,i+2)-2*xt(:,i+1)+xt(:,i))*sampps^2;
end
% determines r rotated about given angles as described in section 3 of the
% report
r=rotxy([0,0,1]',angx,angy, 0);
% initializes matrix for rotated electric field over time
E=zeros(3,length(at));
% loops over time
for i=1:length(at)
    % calculates the radiated electric field according to equation 2 from
    % the report
    erad = r'*at(:,i)*r-at(:,i);
    % rotates electric field into approproate coordinates for rotated
    % radiated field over time result, which is returned
    E(:,i)=rotxy(erad,-angx,-angy, 1);
end