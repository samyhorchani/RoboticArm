% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865
%%
figure(1)
axis([-0.25 0.25 -0.25 0.25])
XY = []; %vecteur qui va contenir les points placées
n = 100; %nombre de points à relever

for i = 1:n %pour chaque point
    xy = ginput(1); %nous placons le point sur la figure et le stockons dans xy
    XY = [XY; xy]; %nous rajoutons le point sélectionner à notre vecteur
    figure(1), hold on
    plot(XY(:,1), XY(:,2), 'ok')
end 