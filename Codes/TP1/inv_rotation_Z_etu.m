% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function [a] = inv_rotation_Z_etu(R)
% INV_ROTATION_Z retourne l'angle de rotation autour de l'axe Z à partir
% d'une matrice de rotation passée comme argument (et dont on suppose 
% qu'elle représente bien une rotation d'axe Z).
%   [a] = inv_rotation_Z(R)

%Vu que nous suposons que la matrice R represente toujours une matrice de
%rotation d'axe Z, nous savons que l'element de cette matrice en 1,1
%represente le cosinus de l'angle. Nous avons alors qu'à faire acos de
%cet élément pour retrouver l'angle.
a = acos(R(1,1));

end