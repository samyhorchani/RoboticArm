% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

clear all
close all

%% 2.2/ Construction et affichage d’un 3R plan
% =========================================================================

% Question 2.2.1 : déclaration du modèle r3
% -------------------------------------------------------------------------
modele = robot('model', [0.5,0.3,0.2]);

% Question 2.2.2 : affichage du modèle
% -------------------------------------------------------------------------

modele.plot(0, 'green', 0);

% Question 2.2.3 : robot r3 en [pi/2,0,0] + vérification graphique
% -------------------------------------------------------------------------
modele.setAngularPosition([pi/2, 0, 0]);
figure(1), title 'position initiale'
modele.plot(0, 'green', 0);

%verification position d'angle
position = modele.getAngularPosition();

%% 2.3/ Fonctionnalités élémentaires
%----------------------------------------------------------------------

% Question 2.3.1 : matrice de rotation d’un angle alpha autour de l’axe Z
% -------------------------------------------------------------------------
a = pi/2; %angle
R = rotation_Z_etu(pi);

% Question 2.3.2 : retourne alpha à partir d’une matrice de rotation
% -------------------------------------------------------------------------
b = inv_rotation_Z_etu(rotation_Z_etu(a));

% Question 2.3.3 : matrice de transformation homogène
% -------------------------------------------------------------------------
H_test = trans_homogene(R, [1;1;1]);


%% 2.4/ Calcul du modèle géométrique direct et inverse
%----------------------------------------------------------------------

% Question 2.4.1 : fonction matlab qui retourne les matrices de transformation homogène
% -------------------------------------------------------------------------
%fait dans le fichier mod_geo_dir_etu

% Question 2.4.2 : Tester la fonction mod_geo_dir_etu() 
% -------------------------------------------------------------------------
T_H = mod_geo_dir_etu(modele) %notre fonction
T_H_verif = mod_geo_dir(modele) %fonction fournit afin de verifier que nous avons la même matrice


% Question 2.4.3 : Utilisation du modèle inverse
% -------------------------------------------------------------------------
figure(2), title 'test modele geometrique inverse'
[q1,q2] = modele.mod_geo_inv(0.5,0.5,pi/3) %stockage des 2 solutions du modele geo inv dans q1 et q2 
modele.setAngularPosition(q1);
modele.plot(1, 'red', 0);
modele.setAngularPosition(q2);
modele.plot(1, 'blue', 0);



% Question 2.4.4 : cible [1.0 1.0 3*pi/2]
% -------------------------------------------------------------------------
figure(3), title 'test mod inv avec cible 1 possibilite'
[q1,q2] = modele.mod_geo_inv(1.0,1.0,3*pi/2);
modele.setAngularPosition(q1);
modele.plot(1, 'red', 0);
modele.setAngularPosition(q2);
modele.plot(1, 'blue', 0);
%Les 2 representations sont supperposés
%% 3) Génération de trajectoires par interpolation
% =========================================================================

% Question 3.1.1 : interpolation articulaire
% -------------------------------------------------------------------------
figure(4), title 'test mod inv avec cible 1 possibilite'

N = 10;

teta_init = [pi/2;0;0];
[q1,q2] = modele.mod_geo_inv(0.5,0.5,pi/3);
modele.setAngularPosition(teta_init);


teta_fin = q2;
teta_inter = teta_init;
delta = (teta_fin-teta_init)/N;
for i = 1:N
    teta_inter = teta_inter + delta;
    modele.setAngularPosition(teta_inter);
    modele.plot(1, 'blue', 0);
end


%proposer un critère simple permettant de choisir entre 2 possibilités

% Question 3.1.2 : avantages/inconvénients
% -------------------------------------------------------------------------
%à rajouter
% Question 3.2.1 : interpolation opérationnelle
% -------------------------------------------------------------------------

figure()
modele.setAngularPosition(0,0,0)
cible = [0.3, 0.3, -pi/4];

T = modele.mod_geo_dir();

%configuration opérationnelle

OT = [T(1:2, 4), inv_rotation_Z([1:3; 1:3; 1:3])];

%droite dans l'espace opérationnelle

dot = cible-OT;
ncible = OT;
modele.plot(0, 'red', 1)
pause(0.1)

for i = 1:N
    ncible = ncible +dot/N;
    [q1,q2] = modele.mod_geo_inv(ncible(1), ncible(2), ncible(3));
    modele.plot(0,'red', 1)
    pause(0.1)
end


% Question 3.2.2 : avantages/inconvénients
% -------------------------------------------------------------------------
%Avantages et inconvénients à rajouter.

