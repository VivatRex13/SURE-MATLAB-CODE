function [Etheta,Ephi,theta,phi] = extractFields(prefix,form)
Etheta = zeros(21,91);
Ephi = zeros(21,91);

for i = 1:21
    [theta,phi,numFreqs,Etheta_temp,Ephi_temp,freqs] = loadData(prefix+"_"+i+".ffd",form);
    Etheta(i,:) = Etheta_temp;
    Ephi(i,:) = Ephi_temp;
end
end