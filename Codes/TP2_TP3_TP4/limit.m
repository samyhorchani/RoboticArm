% Nom étudiant 1 : Samy HORCHANI - 28706765
% Nom étudiant 2 : Lara OUDJIT - 3801865

function new_pos = limit(pos,val_min,val_max)
% LIMIT(POS,VAL_MIN,VAL_MAX) limite les valeurs de position dans le 
% vecteur POS entre une valeur minimale VAL_MIN et maximale VAL_MAX 
% autorisée par la geometrie du robot.

new_pos = zeros(1,length(pos)); %vecteur de taille 1*le nombre de position donné en argument

for i = 1:length(pos) %pour chaque position
    if pos(i) <= val_min %si la pos. donné est <= à la pos. de butée minimum
        new_pos(i) = val_min; %on rend la position de butée minimum
    elseif pos(i)>= val_max %si la pos. donné est >= à la pos. de butée minimum
        new_pos(i) = val_max; %on rend la position de butée minimum
    else %sinon
        new_pos(i) = pos; %la position est atteignable : on rend la position demandée
    end
end


