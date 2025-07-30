%  0 = Vide
%  1 = Mur
%  2 = Début, fin
%  3 = Chemin
%  4 = Cul de sac


array[int, int] of var 0..9:  LABYRINTHE_ORIGINE = [|
     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	|  1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
	|  1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1
	|  1, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1
	|  1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1
	|  1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1
	|  1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1
	|  1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1
	|  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1
	|  1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1
	|  1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1
	|  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1
	|  1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1
	|  1, 1, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 1, 1, 1
	|  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

|];


%On crée un nouveau labyrinthe avec les même dimensions que celui d'origine 
array[1..round(sqrt(length(LABYRINTHE_ORIGINE))), 1..round(sqrt(length(LABYRINTHE_ORIGINE)))] of var 0..9: LABYRINTHE_PASSER;












%On fait en sorte que le nouveau labyrinthe soit similaire en tout point au labyrinthe d'origine
%Même mur, départ, arrivé, vide
constraint forall(
i in 1..round(sqrt(length(LABYRINTHE_ORIGINE))), 
j in 1..round(sqrt(length(LABYRINTHE_ORIGINE))) )
(
  LABYRINTHE_PASSER[i, j] == LABYRINTHE_ORIGINE[i, j] \/ LABYRINTHE_ORIGINE[i, j] = 0
);

%Si il y'a des trous dans le labyrinthe vise à les combler
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ 
not(
  LABYRINTHE_PASSER[i-1, j] = 1 /\
  LABYRINTHE_PASSER[i+1, j] = 1 /\
  LABYRINTHE_PASSER[i, j-1] = 1 /\
  LABYRINTHE_PASSER[i, j+1] = 1
)



);

%Si il y'a un cul de sac dans le labyrinthe en n on va l'enlever
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/
not(
  (LABYRINTHE_PASSER[i-1, j] = 1 \/ LABYRINTHE_PASSER[i-1, j] = 4) /\
  (LABYRINTHE_PASSER[i, j+1] = 1 \/ LABYRINTHE_PASSER[i, j+1] = 4) /\
  (LABYRINTHE_PASSER[i, j-1] = 1 \/ LABYRINTHE_PASSER[i, j-1] = 4)
)
);

%Si il y'a un cul de sac dans le labyrinthe en u on va l'enlever
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/
not(
  (LABYRINTHE_PASSER[i+1, j] = 1 \/ LABYRINTHE_PASSER[i+1, j] = 4) /\
  (LABYRINTHE_PASSER[i, j+1] = 1 \/ LABYRINTHE_PASSER[i, j+1] = 4) /\
  (LABYRINTHE_PASSER[i, j-1] = 1 \/ LABYRINTHE_PASSER[i, j-1] = 4)
)
);





%Si il y'a un cul de sac dans le labyrinthe en ( on va l'enlever
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/
not(
  (LABYRINTHE_PASSER[i, j-1] = 1 \/ LABYRINTHE_PASSER[i, j-1] = 4) /\
  (LABYRINTHE_PASSER[i+1, j] = 1 \/ LABYRINTHE_PASSER[i+1, j] = 4) /\
  (LABYRINTHE_PASSER[i-1, j] = 1 \/ LABYRINTHE_PASSER[i-1, j] = 4)
)
);


%Si il y'a un cul de sac dans le labyrinthe en ) on va l'enlever
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/
not(
  (LABYRINTHE_PASSER[i, j+1] = 1 \/ LABYRINTHE_PASSER[i, j+1] = 4) /\
  (LABYRINTHE_PASSER[i-1, j] = 1 \/ LABYRINTHE_PASSER[i-1, j] = 4) /\
  (LABYRINTHE_PASSER[i+1, j] = 1 \/ LABYRINTHE_PASSER[i+1, j] = 4)
)
);

%On cherche à transformer ces motifs selon cela :
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/

%000	000
%001	041
%111	111
not(
  (LABYRINTHE_ORIGINE[i-1, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i-1, j] = 0) /\
  (LABYRINTHE_ORIGINE[i-1, j+1] = 0) /\
  
  (LABYRINTHE_ORIGINE[i, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i, j+1] = 1 \/ LABYRINTHE_ORIGINE[i, j+1] = 4) /\
  
  (LABYRINTHE_ORIGINE[i+1, j-1] = 1 \/ LABYRINTHE_ORIGINE[i+1, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i+1, j] = 1 \/ LABYRINTHE_ORIGINE[i+1, j] = 4) /\
  (LABYRINTHE_ORIGINE[i+1, j+1] = 1 \/ LABYRINTHE_ORIGINE[i+1, j+1] = 4)
)
);


%On cherche à transformer ces motifs selon cela :
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/

%000	000
%100	140
%111	111
not(
  (LABYRINTHE_ORIGINE[i-1, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i-1, j] = 0) /\
  (LABYRINTHE_ORIGINE[i-1, j+1] = 0) /\
  
  (LABYRINTHE_ORIGINE[i, j-1] = 1 \/ LABYRINTHE_ORIGINE[i, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i, j+1] = 0) /\
  
  (LABYRINTHE_ORIGINE[i+1, j-1] = 1 \/ LABYRINTHE_ORIGINE[i+1, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i+1, j] = 1 \/ LABYRINTHE_ORIGINE[i+1, j] = 4) /\
  (LABYRINTHE_ORIGINE[i+1, j+1] = 1 \/ LABYRINTHE_ORIGINE[i+1, j+1] = 4)
)
);






%On cherche à transformer ces motifs selon cela :
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/

%111	111
%100	140
%000	000
not(
  (LABYRINTHE_ORIGINE[i-1, j-1] = 1 \/ LABYRINTHE_ORIGINE[i-1, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i-1, j] = 1 \/ LABYRINTHE_ORIGINE[i-1, j] = 4) /\
  (LABYRINTHE_ORIGINE[i-1, j+1] = 1 \/ LABYRINTHE_ORIGINE[i-1, j+1] = 4) /\
  
  (LABYRINTHE_ORIGINE[i, j-1] = 1 \/ LABYRINTHE_ORIGINE[i, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i, j+1] = 0) /\
  
  (LABYRINTHE_ORIGINE[i+1, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i+1, j] = 0) /\
  (LABYRINTHE_ORIGINE[i+1, j+1] = 0)
)
);






%On cherche à transformer ces motifs selon cela :
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
)
(
LABYRINTHE_PASSER[i, j] = 4 \/ LABYRINTHE_ORIGINE[i, j] = 2 \/ LABYRINTHE_ORIGINE[i, j] = 1 \/

%111	111
%001	041
%000	000
not(
  (LABYRINTHE_ORIGINE[i-1, j-1] = 1 \/ LABYRINTHE_ORIGINE[i-1, j-1] = 4) /\
  (LABYRINTHE_ORIGINE[i-1, j] = 1 \/ LABYRINTHE_ORIGINE[i-1, j] = 4) /\
  (LABYRINTHE_ORIGINE[i-1, j+1] = 1 \/ LABYRINTHE_ORIGINE[i-1, j] = 4) /\
  
  (LABYRINTHE_ORIGINE[i, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i, j+1] = 1 \/ LABYRINTHE_ORIGINE[i-1, j] = 4) /\
  
  (LABYRINTHE_ORIGINE[i+1, j-1] = 0) /\
  (LABYRINTHE_ORIGINE[i+1, j] = 0) /\
  (LABYRINTHE_ORIGINE[i+1, j+1] = 0)
)
);







%On va calculer le nombre de 2 (chemin), plus il y'en a plus le chemin effectuer pour résoudre le labyrinthe est long
var int : penalite = sum(
i in 1..round(sqrt(length(LABYRINTHE_PASSER))), 
j in 1..round(sqrt(length(LABYRINTHE_PASSER))))
(LABYRINTHE_PASSER[i, j] == 3);






















%Un labyrinthe est effectuer si et seulement si :
%Il y'a plus de deux '3'
constraint penalite >= 3;

%Il faut que chaque 2 ai un seul 3 à côté de lui
constraint forall(
  i in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1),
  j in 2..round(sqrt(length(LABYRINTHE_ORIGINE))-1)
  ) (
    LABYRINTHE_PASSER[i, j] == 2 -> 
    (
      LABYRINTHE_PASSER[i-1, j] == 3 \/
      LABYRINTHE_PASSER[i+1, j] == 3 \/
      LABYRINTHE_PASSER[i, j-1] == 3 \/
      LABYRINTHE_PASSER[i, j+1] == 3
    )

);

%Empêche certain placement de 3
constraint sum(

%%Empeche le solveur de faire des 3 isolés. Il doit y en avoir deux
%On compte le nombre de 3 qui n'a qu'un seul 3 attaché à lui
% 333 donnera deux car il y'a que deux 3 qui n'ont qu'un seul voisin 3
% 3333 donnera deux également car il n'y a que deux 3 qui n'ont qu'un seul voisin 3
% 33 donnera deux car les deux trois n'ont qu'un seul voisin

i in 2..round(sqrt(length(LABYRINTHE_PASSER))) -1, 
j in 2..round(sqrt(length(LABYRINTHE_PASSER)))-1)
(
  LABYRINTHE_PASSER[i, j] == 3 /\
  (
    (
      LABYRINTHE_PASSER[i+1, j] == 3 /\ 
      LABYRINTHE_PASSER[i-1, j] != 3 /\ 
      LABYRINTHE_PASSER[i, j+1] != 3 /\
      LABYRINTHE_PASSER[i, j-1] != 3
    )
    \/
    (
      LABYRINTHE_PASSER[i+1, j] != 3 /\ 
      LABYRINTHE_PASSER[i-1, j] == 3 /\ 
      LABYRINTHE_PASSER[i, j+1] != 3 /\
      LABYRINTHE_PASSER[i, j-1] != 3
    )
    \/
    (
      LABYRINTHE_PASSER[i+1, j] != 3 /\ 
      LABYRINTHE_PASSER[i-1, j] != 3 /\ 
      LABYRINTHE_PASSER[i, j+1] == 3 /\
      LABYRINTHE_PASSER[i, j-1] != 3
    )
    \/
    (
      LABYRINTHE_PASSER[i+1, j] != 3 /\ 
      LABYRINTHE_PASSER[i-1, j] != 3 /\ 
      LABYRINTHE_PASSER[i, j+1] != 3 /\
      LABYRINTHE_PASSER[i, j-1] == 3
    )
    \/
    (
      LABYRINTHE_PASSER[i+1, j] != 3 /\ 
      LABYRINTHE_PASSER[i-1, j] != 3 /\ 
      LABYRINTHE_PASSER[i, j+1] != 3 /\
      LABYRINTHE_PASSER[i, j-1] != 3
    )
  )
) = 2;

%Empêche le solveur de generer des carres
%Vérifie également que chaque 3 soit attaché à un autre trois
constraint forall(
i in 2..round(sqrt(length(LABYRINTHE_PASSER))) - 1, 
j in 2..round(sqrt(length(LABYRINTHE_PASSER))) - 1)
(
  not (
    LABYRINTHE_PASSER[i, j] == 3 /\
    (
      (
        LABYRINTHE_PASSER[i+1, j] == 3 /\ 
        LABYRINTHE_PASSER[i, j+1] == 3 /\ 
        LABYRINTHE_PASSER[i+1, j+1] == 3
       )
    )
) 
);




% Contrainte pour s'assurer qu'un 3 est relié à au moins un autre 3
constraint forall(i in 2..round(sqrt(length(LABYRINTHE_PASSER))) - 1, 
                  j in 2..round(sqrt(length(LABYRINTHE_PASSER))) - 1)
(
  LABYRINTHE_PASSER[i, j] == 3 -> 
  (
    LABYRINTHE_PASSER[i+1, j] == 3 \/ 
    LABYRINTHE_PASSER[i-1, j] == 3 \/ 
    LABYRINTHE_PASSER[i, j+1] == 3 \/
    LABYRINTHE_PASSER[i, j-1] == 3
  )
);




















%On résout en minimisant la pénalité
solve minimize penalite;

%On affiche le labyrinthe d'origine
output["Labyrinthe d'origine : \n"];
output
[
  if j == round(sqrt(length(LABYRINTHE_ORIGINE)))+1
  then
   "\n"
  else 
    show(
    LABYRINTHE_ORIGINE[i, j]
    )
  endif

| i in 1..round(sqrt(length(LABYRINTHE_ORIGINE))), j in 1..round(sqrt(length(LABYRINTHE_ORIGINE)))+1
];


%On affiche le labyrinthe de test
output["Labyrinthe après test : \n"];
output
[
  if j == round(sqrt(length(LABYRINTHE_PASSER)))+1
  then
   "\n"
  else 
    show(
    LABYRINTHE_PASSER[i, j]
    )
  endif

| i in 1..round(sqrt(length(LABYRINTHE_PASSER))), j in 1..round(sqrt(length(LABYRINTHE_PASSER)))+1
];

output["Chemin longueur de : "];
output[show(penalite)];