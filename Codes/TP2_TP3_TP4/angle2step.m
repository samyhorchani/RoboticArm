% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function p = angle2step(q,offset)
% ANGLE2STEP convertit la valeur angulaire Q (rad) en une valeur de pas
% moteur P.
% OFFSET permet de spécifier à quelle valeur de pas moteur correspond la
% valeur angulaire 0.
% 
% p = angle2step(q,offset);
thetaMax = 300*pi/180;

p = offset+(-q*1024/thetaMax);