% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function [R] = rotation_Z_etu(angle)
%  ROTATION_Z retourne la matrice de rotation 3D
% correspondant à une rotation d'angle 'angle' autour de z 
%  R = rotation_Z(angle)

R = eye(3);

R(1,1) = cos(angle);
R(1,2) = -sin(angle);
R(2,1) = sin(angle);
R(2,2) = cos(angle);

end
