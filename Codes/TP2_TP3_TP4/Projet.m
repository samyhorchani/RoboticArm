% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

clear all
clc

% Paramètres de la communications série
PORT = 29;       % A modifier avec le n° du port COM utilisé
BAUD = 1000000;

ID1 = 1; %ID du premier moteur
ID2 = 12; %ID du deuxieme moteur
ID3 = 2; %ID du troisieme moteur
ID = [ID1, ID2, ID3]; %Vecteur contenant les ID des moteurs

%position initiale coresspondant à notre 0 (pos verticale)
offset = 512;

speed = 100; %vitesse moteur
maquette = robot('real',PORT,BAUD);  % Connexion aux moteurs
maquette.setSpeed(ID, [speed, speed, speed]); % setting des moteurs à la vitesse speed

modele = robot('model', [0.068,0.068,0.078]); %taille mesurée à la regle sur notre robot
%% Projet
% =========================================================================


%butée min de chaque moteur
step_min_ID1 = 220; %butée min moteur 1
step_min_ID2 = 159; %butée min moteur 2
step_min_ID3 = 165; %butée min moteur 3


%butée max de chaque moteur
step_max_ID1 = 796; %butée max moteur 1
step_max_ID2 = 862; %butée min moteur 2
step_max_ID3 = 866; %butée min moteur 3

mat = [[step_min_ID1,step_min_ID2,step_min_ID3]; [step_max_ID1,step_max_ID2, step_max_ID3]];
%reinitialisation de la position à notre position "0" offset
maquette.setStepPosition(ID, [offset, offset, offset]);
pause(3) %afin de s'assurer que les moteurs ai le temps de se placer


%% 

% 2.2 : Déclaration d'un modèle de robot
% -------------------------------------------------------------------------
figure(1), title 'Premiere figure'
modele.plot(0, 'green', 0); % affichage du modele virtuelle du robot

% 2.3 : Modele géométrique direct
% -------------------------------------------------------------------------
figure(2), title 'MGD'
q1 = 0; 
q2 = pi/3;
q3 = 0;
q = [q1, q2, q3];

modele.setAngularPosition(q);
mod_geo_dir_q = mod_geo_dir(modele);
modele.plot(0, 'green', 0);

maquette.setStepPosition(ID1,limit(angle2step(q1,offset),step_min_ID1, step_max_ID1 ));
maquette.setStepPosition(ID2,limit(angle2step(q2,offset),step_min_ID2, step_max_ID2 ));
maquette.setStepPosition(ID3,limit(angle2step(q3,offset),step_min_ID3, step_max_ID3 ));
pause(2)

%% 

% 2.5 : Modele géométrique inverse
% -------------------------------------------------------------------------
figure(3), title 'MGI'
[q1_mdi, q2_mdi] = modele.mod_geo_inv(0.15,-0.05,0); 
%stockage de nos deux solutions en appliquant le modèle géo. inverse dans
%q1_mdi et q2_mdi

modele.setAngularPosition(q1_mdi);
modele.plot(1, 'red', 0);

maquette.setStepPosition(ID1,limit(angle2step(q1_mdi(1),offset),step_min_ID1, step_max_ID1 ));
maquette.setStepPosition(ID2,limit(angle2step(q1_mdi(2),offset),step_min_ID2, step_max_ID2 ));
maquette.setStepPosition(ID3,limit(angle2step(q1_mdi(3),offset),step_min_ID3, step_max_ID3 ));

pause(3)

modele.setAngularPosition(q2_mdi);
modele.plot(1, 'blue', 0);

maquette.setStepPosition(ID1,limit(angle2step(q2_mdi(1),offset),step_min_ID1, step_max_ID1 ));
maquette.setStepPosition(ID2,limit(angle2step(q2_mdi(2),offset),step_min_ID2, step_max_ID2 ));
maquette.setStepPosition(ID3,limit(angle2step(q2_mdi(3),offset),step_min_ID3, step_max_ID3 ));

%%
% 2.6 : Affichage de la pose du roboto en temps reel et animation du modele
% -------------------------------------------------------------------------
figure(4), title 'Affichage en temps reel'
%reinitialisation de la position à notre position "0" offset
maquette.setStepPosition(ID, [offset, offset, offset]);

pause(3) %le temps que le robot se place à notre position 0
%Nous plaçons chaque moteur à la position choisi en prenant en compte les
%limites des butées.
maquette.setStepPosition(ID1,limit(angle2step(q2_mdi(1),offset),step_min_ID1, step_max_ID1 )); 
maquette.setStepPosition(ID2,limit(angle2step(q2_mdi(2),offset),step_min_ID2, step_max_ID2 ));
maquette.setStepPosition(ID3,limit(angle2step(q2_mdi(3),offset),step_min_ID3, step_max_ID3 ));

  while (maquette.isMoving(ID1) || maquette.isMoving(ID2) ||maquette.isMoving(ID3)) %tant que les mot. du robots bougent
      modele.setAngularPosition([step2angle(maquette.getStepPosition(ID1),offset),step2angle(maquette.getStepPosition(ID2),offset),step2angle(maquette.getStepPosition(ID3),offset)])
      %nous récuperons la position des moteurs pendant le mouvement, nous
      %la convertissons en une valeur d'angle et nous plaçons le modele
      %virtuel à cette position
      modele.plot(0, 'green', 0); %nous affichons le robot virtuel avec les nouvelles positions.
      pause(0.1) %nous réalisons une courte pause afin de laisser à l'ordinateur le temps de realiser les opérations de la boucle
  end
%%
% PARTIE 3 : Génération de trajectoires
% -------------------------------------------------------------------------
pos_init = [-pi/4, 0, 0]; %Nous choisissons une position de départ
modele.setAngularPosition(pos_init); %nous plaçons le modele virtuelle à la position de départ

step  = angle2step(pos_init, offset); % convertissement de la position initiale (step) en une valeur en angle

maquette.setStepPosition(ID, step); %nous placons la maquette du robot à la position choisi
modele.plot(0, 'blue', 0); %affichage du modele virtuel
pos_cible = [pi/4, 2*pi/3, -pi/6];

pos_inter = modele.getAngularPosition();
[q1, q2] = modele.mod_geo_inv(pos_cible(1),pos_cible(2),pos_cible(3)); %determination du modele geométrique inverse

%Choix entre q1 et q2 => dq = qi - pos_inter avec la valeur absolue
q_min = min([abs(q1),abs(q2)]); 

dq = q_min-pos_inter;

N = 100;
for i = 1:N % N fois
    pos_c = modele.getAngularPosition(); %recuperons la position du modele virtuelle 
    modele.setAngularPosition(pos_c+(dq/N)); %Interpolation ?
    step2=angle2step( (pos_c+(dq/N)), offset);
    maquette.setStepPosition(ID, step2)
    modele.plot(0,'blue',1)
    pause(0.1)
end

%%
% BONUS : Tracé de la lettre L dans le fichier : bonus_letter_L.m
% -------------------------------------------------------------------------
%bonus_letter();

%%
% Bonus : Grosse Récompense

maquette.setStepPosition(ID3, [offset]); %fixation de q à 0 afin d être en 2R



