% takes in parameters specified in section 2 of user guide and angle pair
function E = ManyBeamField(k, pol, e, omega, eta, sampps, angs)

% checks for basic input size correctness
if size(k)~=size(pol)
   error('Error: k and pol must be the same size')       
end  
if size(e)~=size(omega)
   error('Error: e, omega, and eta must be of the same size (1 by # of columns of k)')       
end 
for i = 1:length(k(1,:))
   if round(k(:,i)'*pol(:,i),3) ~= 0
       error('Error: ray and polarization vectors are not perpenducular')       
   end    
end   

% writes omega values in relative terms of angular frequencies
o=2*pi*omega/min(omega);
% finds many-beat-period timespan
[nums, dems]=rat(omega/min(omega));
tspan=round(lcm(sym(dems)));
% initializes matrix for electron position over two periods
xt=zeros(3,2*int32(tspan)*sampps+1); 

% loops over time
for i=3:length(xt(1,:))
    % initializes instantaneous acceleration vector
    acc=zeros(3,1);
    % determines acceleration according to equation 1 in guide and updates
    % vector
    for j=1:length(e)
        acc=acc+e(j)*cos(o(j)*(i-2.5)/sampps+k(:,j)'*xt(:,i-1)+eta(j))*pol(:,j);
    end    
    % estimates future position using accelerations
    xt(:,i)=acc/sampps^2+2*xt(:,i-1)-xt(:,i-2);
end
% initializes matrix for electron acceleration over time
at=zeros(size(xt));
% loops over time
for i=1:length(xt)-2
    % uses a finite difference approximation to estimate the acceleration
    % from xt
    at(:,i+1)=(xt(:,i+2)-2*xt(:,i+1)+xt(:,i))*sampps^2;
end
% determines r rotated about given angles as described in section 3 of
% user guide
r=rotxy([0,0,1]',angs(1),angs(2),0);
% initializes matrix for rotated electric field over time
E=zeros(3,length(at));
% loops over time
for i=1:length(at)
    % rotates electric field into approproate coordinates for rotated
    % radiated field over time result, which is returned
    E(:,i)=rotxy(r'*at(:,i)*r-at(:,i),-angs(1),-angs(2),1);
end