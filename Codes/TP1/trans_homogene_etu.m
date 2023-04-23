% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function [H] = trans_homogene_etu(R,T)
% TRANS_HOMOGENE retourne la matrice de transformation homogene 3D
% correspondant à une rotation R et à une translation T successives. 

H = eye(4); %création d'une matrice identité qui va contenir le resultat

%Construction de la matrice en assignant chaque élément de la matrice de
%transformation homogène avec un élément de la matrice de rotation R ou un
%élément de la matrice de translation T. 
% (Nous aurions également pu utiliser deux boucles imbriqués)
H(1,1) = R(1,1);
H(1,2) = R(1,2);
H(1,3) = R(1,3);
H(1,4) = T(1); 

H(2,1) = R(2,1);
H(2,2) = R(2,2);
H(2,3) = R(2,3);
H(2,4) = T(2);

H(3,1) = R(3,1);
H(3,2) = R(3,2);
H(3,3) = R(3,3);
H(3,4) = T(3);

end