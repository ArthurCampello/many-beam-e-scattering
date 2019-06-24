% takes in parameters specified in section 2 of user guide and angle pair
function R = ManyBeamRadiation(k, pol, e, omega, eta, sampps, angs)
% determines radiated electric field over time from parameters
erad=ManyBeamField(k, pol, e, omega, eta, sampps, angs);
% initializes intensity over time vector
I=zeros(1,length(erad(1,:)));
% loops over time
for i=1:length(I)
    % calculates the intensity from the electric field according to
    % equation 4 of the user guide
    I(i)=norm(erad(:,i))^2;
end  
% calculates root mean squared of intensity over time and reurns the result
R=sqrt(mean(I(4:end)));