% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function [TH0] = mod_geo_dir_etu(modele)
% MOD_GEO_DIR retourne la matrice de transformation homogène associée à
% l'organe terminal du modèle
%   THf = mod_geo_dir(modele)

% Vecteur contenant la longueur des segments
long_segment = modele.bodyLength;
    
% Vecteur contenant les configurations articulaires en rad
conf_artic = modele.getAngularPosition();

TH0 = eye(4); %creation d'une matrice identité

for i = 1:length(long_segment) %pour chaque position angulaire de chaque moteur
    TH0 = TH0 * trans_homogene_etu(rotation_Z_etu(conf_artic(i)), [long_segment(i)*cos(conf_artic(i));long_segment(i)*sin(conf_artic(i));0]);
    %Nous créeons la matrice homogène de transformation pour chaque angle
    %que nous multiplions avec TH0 qui contient la matrice identité au
    %debut, puis les matrices de transformations homogènes suivante.
end
