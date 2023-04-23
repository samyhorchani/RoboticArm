% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865
%%
%INITIALISATION
clear all
clc

% Paramètres de la communications série
PORT = 9;       % A modifier avec le n° du port COM utilisé
BAUD = 1000000;

ID1 = 1; %ID du premier moteur
ID2 = 2; %ID du deuxieme moteur
ID3 = 3; %ID du troisieme moteur
ID = [ID1, ID2, ID3]; %Vecteur contenant les ID des moteurs


offset = 512; %position initiale coresspondant à notre 0 (pos verticale)

speed = 100; %vitesse moteur
maquette = robot('real',PORT,BAUD);  % Connexion aux moteurs
maquette.setSpeed(ID, [speed, speed, speed]); % setting des moteurs à la vitesse speed

modele = robot('model', [0.07,0.07,0.09]); %taille mesurée à la regle sur notre robot

%butée min de chaque moteur
step_min_ID1 = 220; %butée min moteur 1
step_min_ID2 = 159; %butée min moteur 2
step_min_ID3 = 165; %butée min moteur 3


%butée max de chaque moteur
step_max_ID1 = 796; %butée max moteur 1
step_max_ID2 = 862; %butée min moteur 2
step_max_ID3 = 866; %butée min moteur 3

%initialisation d'une matrice contenant les butées min et max de chaque
%moteur
mat = [[step_min_ID1,step_min_ID2,step_min_ID3]; [step_max_ID1,step_max_ID2, step_max_ID3]];
%reinitialisation de la position à notre position "0" offset
maquette.setStepPosition(ID, [offset, offset, offset]);
pause(3) %afin de s'assurer que les moteurs ai le temps de se placer

%%
%Permet de tracer des points directement sur le graphe et de les relever
modele.plot(0, 'blue', 1);
positions(); %Nous tracons les points
%%
% -------------------------------------------------------------------------
% BONUS : Tracé de lettre

for i = 1:length(XY) %pour chaque point
    [q1, q2] = modele.mod_geo_inv(XY(i,1), XY(i,2), 0); %stockage des solutions du mod. geo. inv.
    if(norm(q1-modele.getAngularPosition())<norm(q2-modele.getAngularPosition())) %détermination de la solution ayant la plus petite norme.
        q=q1;
    else
        q=q2;
    end
    modele.setAngularPosition(q); %positionnement du robot virtuel à la position q choisie
    
    modele.plot(0, 'blue', 1); 
    for j = 1:3 %pour chaque moteur, on le positionne en tenant en compte les limites (butées)
        maquette.setStepPosition(ID(j), limit( angle2step(q(j), offset), mat(1, j),mat(2, j) ) );
    end
   % maquette.setStepPosition(ID(j), limit( angle2step(q(j), offset), mat(1, j),mat(2, j) ) );
    pause(); %afin que chaque point ce trace lorsque l'on appuie sur "entrée" dans la console 
    %car nous observons qu'il est plus simple de controler les tracer du
    %robot ainsi.
end