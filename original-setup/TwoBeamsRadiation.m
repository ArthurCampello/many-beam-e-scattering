% takes in parameters specified in section 2 of report and angle pair
function R = TwoBeamsRadiation(phi, omega, eta, e, sampps, angx, angy)
% determines radiated electric field over time from parameters
erad=TwoBeamsField(phi, omega, eta, e, sampps, angx, angy);
% initializes intensity over time vector
I=zeros(1,length(erad(1,:)));
% loops over time
for i=1:length(I)
    % calculates the intensity from the electric field according to
    % equation 4 of the report
    I(i)=norm(erad(:,i))^2; 
end  
% calculates root mean squared of intensity over time and reurns the result
R=sqrt(mean(I(4:end)));