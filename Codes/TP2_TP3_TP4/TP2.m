% L3 Elec/Méca – LU3MEE01

% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

% TP2

clear all
clc

% Paramètres de la communications série
PORT = 29;       % A modifier avec le n° du port COM utilisé
BAUD = 1000000;
%% 2.1 Prise en main du contrôle des moteurs
% =========================================================================
ID1 = 1; %ID premier moteur aka le moteur terminal
ID2 = 12; %ID deuxieme moteur
ID3 = 2; %ID troisieme moteur
ID = [ID1, ID2, ID3]; %Vecteur contenant les ID des moteurs 
POSITION = 512;
speed = 200;  

maquette = robot('real',PORT,BAUD);  % Connexion aux moteurs


% 2.1.6 : utilisation de la fonction setStepPosition
% -------------------------------------------------------------------------

    %pause(0.5)
    maquette.setStepPosition(ID, [POSITION,POSITION,POSITION]);
    %pause(0.5)

% 2.1.7 : utilisation de la fonction setSpeed
% -------------------------------------------------------------------------
    maquette.setSpeed([ID1,ID2,ID3], [speed, speed, speed]);

%% 2.2 Caractérisation des actionneurs
% =========================================================================

% 2.2.12 : tracé des positions en fonction du temps
% -------------------------------------------------------------------------
figure(1), title 'Position en fonction du temps'
speed = 100; %valeur de speed à changer à chaque fois
    maquette.setSpeed(ID2, speed)
    x = [];
    y = [];

    maquette.setStepPosition(ID2, 0); % nous plaçons le moteur 2 à la position 0
    pause(4) %afin de s'assurer que le robot ai le temps de se positionner
    maquette.setStepPosition(ID2, 1023); % nous essayons de mettre le robot à la position 1023
    
    tic;
    timerVal = tic;
    while (maquette.isMoving(ID2)) == 1 % tant que le moteur 2 bouge
        
        x = [x, toc]; %nous relevons le temps
        y = [y, maquette.getStepPosition(ID2)]; % nous relevons la position du moteur 2

    end
    plot(x,y);
    hold on


%plus on augmente la vitesse, plus la pente est verticale (ici nos graphs
%sont espacés de 4 sec à cause du pause(4)

% 2.2.14 : tracé des vitesses en fonction du temps
% -------------------------------------------------------------------------
figure(2), title 'Vitesse en fonction du temps'

    maquette.setSpeed(ID2, speed)
    x2 = [];
    y2 = [];

    maquette.setStepPosition(ID2, 250);
    pause(5)
    maquette.setStepPosition(ID2, 800);

    timerVal = tic; %initialisation de la 
    while (maquette.isMoving(ID2)) == 1 %tant que la maquette est enn mouvement
        x2 = [x2, toc]; %nous relevons le temps
        y2 = [y2, val2speed(maquette.getSpeed(ID2))];%nous relevons la vitesse en tour/min

    end
    plot(x2,y2);



% 2.2.15 : tracé des positions estimées par différence finie
% -------------------------------------------------------------------------
figure(3), title 'difference finie'
y3 = diff(y);
plot(y3)
%En utilisant une difference finie, nous trouvons la même allure de courbe
%que dans la question 12.


% 2.2.16 : répétabilité des vitesses et positions
% -------------------------------------------------------------------------
maquette.setSpeed(ID, [100;100;100]);

maquette.setStepPosition(ID, [POSITION,POSITION,POSITION]);
pause(2)
figure(16), title 'Répétabilité des positions en fonction du temps'
speed = [100;200;300;400;500;600]; %valeur de speed à changer à chaque fois

for i = 1:6 
    maquette.setSpeed(ID1, speed(i))
    
    x = []; %pour reinitialiser les valeurs pour chaque vitesse
    y = [];
    tic; %nous remettons le temps à 0
    timerVal = tic;
    maquette.setStepPosition(ID1, 250); % nous plaçons le moteur 1 à la position 250
    pause(4) %afin de s'assurer que le robot ai le temps de se positionner
    maquette.setStepPosition(ID1, 800); % nous essayons de mettre le robot à la position 800
     while (maquette.isMoving(ID1)) == 1 % tant que le moteur 1 bouge
        
        x = [x, toc]; %nous relevons le temps
        y = [y, maquette.getStepPosition(ID1)]; % nous relevons la position du moteur 2
        
     end
     plot(x,y); %nous affichons sur le graphiques les resultats
     hold on %on s'assure de conserver les resultats obtenues afin d'obtenir la courbe sur le même graphs
end
    
% 2.2.19 : tracé des positions en fonction du temps pour le 1er moteur
% -------------------------------------------------------------------------

maquette.setStepPosition(ID, [POSITION,POSITION,POSITION]);
pause(3)
vitesse = [1000, 2000, 2040, 2060] * 2*pi/60; % On multiplie par 2*pi/60 pour avoir une vitesse de rotation
vitesse                         

figure(4), title 'Question 19 : Position en fonction du temps'

for i = 1:length(vitesse)
    x = [];
    y = [];
    tic;
    timerVal = tic;
    maquette.setSpeed(ID1, vitesse(i));
    
    maquette.setStepPosition(ID1, 250); % nous plaçons le moteur 1 à la position initiale
    while (maquette.isMoving(ID1)) == 1
    pause(0.1)
    end
    %afin de s'assurer que le robot ai le temps de se positionner
    maquette.setStepPosition(ID1, 850); % nous essayons de mettre le robot à la position finale
    
    while (maquette.isMoving(ID1)) == 1 % tant que le moteur 1 bouge
        
        x = [x, toc]; %nous relevons le temps
        y = [y, maquette.getStepPosition(ID1)]; % nous relevons la position du moteur 1
    end
    plot(x,y);
    hold on
end

%truc fait avant modif
%     maquette.setSpeed(ID2, speed)
%     x = []; 
%     y = []; 
% 
%     maquette.setStepPosition(ID2, limit(0, 159, 862));
%     pause(5)
%     maquette.setStepPosition(ID2, limit(1023, 159, 862));
%     
%     tic;
%     timerVal = tic;
%     while (maquette.isMoving(ID2)) == 1
%         
%         x = [x, toc];
%         y = [y, maquette.getStepPosition(ID2)];
% 
%     end
%     plot(x,y);

%% 2.3 Maquette du robot 3R plan
% =========================================================================
