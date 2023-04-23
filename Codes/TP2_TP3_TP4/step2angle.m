% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function q = step2angle(step,offset)
% STEP2ANGLE convertit la valeur de pas moteur STEP en une valeur angulaire
% Q exprimée en rad.
% OFFSET permet de spécifier à quelle valeur de pas moteur correspond la
% valeur angulaire 0.
% 
% q = step2angle(step,offset);

q = -(offset-step)*300*(pi/180)*(1/1024);