function [theta1,phi1,numFreqs,Etheta,Ephi,freqs] = loadData(fileName,CoordinateSystem)
fid = fopen(fileName);

if CoordinateSystem == "Phi-Theta"
    numHeaderLines = 3;
else
    textscan(fid,'%s',1);
    numHeaderLines = 4;
end

data = num2cell(fscanf(fid,'%d',3));
theta1 = linspace(data{:});
data = num2cell(fscanf(fid,'%d',3));
phi1 = linspace(data{:});
C1 = textscan(fid,'%s %d',1);
numFreqs = C1{2};
fclose(fid);
Mfull = readmatrix(fileName,'FileType','text','NumHeaderLines',numHeaderLines);
freqs = Mfull(isnan(Mfull(:,1)),2);
MData = Mfull(~isnan(Mfull(:,1)),:);
Etheta = reshape(MData(:,1) + 1j*MData(:,2),length(phi1)*length(theta1),[]);
Ephi = reshape(MData(:,3) + 1j*MData(:,4),length(phi1)*length(theta1),[]);

Ntheta = length(theta1);
Nphi   = length(phi1);
Nf     =numFreqs;

Etheta = reshape(Etheta, Ntheta, Nphi, Nf);
Ephi   = reshape(Ephi,   Ntheta, Nphi, Nf);

Etheta = permute(Etheta, [3 1 2]);
Ephi   = permute(Ephi,   [3 1 2]);

end