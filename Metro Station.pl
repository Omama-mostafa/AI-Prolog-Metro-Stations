%first line
connected(new_elmarg,elmarg).
connected(elmarg,ezbet_elnakhl).
connected(ezbet_elnakhl,ain_shams).
connected(ain_shams,elmatareyya).
connected(elmatareyya,helmeyet_elzaitoun).
connected(helmeyet_elzaitoun,hadayeq_elzaitoun).
connected(hadayeq_elzaitoun,saray_elqobba).
connected(saray_elqobba,hammamat_elqobba).
connected(hammamat_elqobba,kobri_elqobba).
connected(kobri_elqobba,manshiet_elsadr).
connected(manshiet_elsadr,eldemerdash).
connected(eldemerdash,ghamra).
connected(ghamra,alshohadaa).
connected(alshohadaa,urabi).
connected(urabi,nasser).
connected(nasser,sadat).
connected(sadat,saad_zaghloul).
connected(saad_zaghloul, alsayyeda_zeinab).
connected(alsayyeda_zeinab,elmalek_elsaleh).
connected(elmalek_elsaleh,margirgis).
connected(margirgis,elzahraa).
connected(elzahraa,dar_elsalam).
connected(dar_elsalam,hadayeq_elmaadi).
connected(hadayeq_elmaadi,maadi).
connected(maadi,thakanat_elmaadi).
connected(thakanat_elmaadi,tora_elbalad).
connected(tora_elbalad,kozzika).
connected(kozzika,tora_elasmant).
connected(tora_elasmant,elmaasara).
connected(elmaasara,hadayeq_helwan).
connected(hadayeq_helwan,wadi_hof).
connected(wadi_hof,helwan_university).
connected(helwan_university,ain_helwan).
connected(ain_helwan,helwan).
%second line
connected(shobra_elkheima,koliet_elzeraa).
connected(koliet_elzeraa,mezallat).
connected(mezallat,khalafawy).
connected(khalafawy,sainte_teresa).
connected(sainte_teresa,road_elfarag).
connected(road_elfarag,massara).
connected(massara,alshohadaa).
connected(alshohadaa,ataba).
connected(ataba,naguib).
connected(naguib,sadat).
connected(sadat,opera).
connected(opera,dokki).
connected(dokki,bohooth).
connected(bohooth,cairo_university).
connected(cairo_university,faisal).
connected(faisal,giza).
connected(giza,omm_elmisryeen).
connected(omm_elmisryeen,sakiat_mekki).
connected(sakiat_mekki,elmounib).


path(Y,Y,N,[]).
  
         
path(X,Y,N,L):-
    (
    (N == 'any') ->
    connecte(X,Z),
%    write("["),write(X),write(","),write(Z),write("]"),write(","),
%    path(Z,Y,N,L);
    path(Z,Y,N,R),
    L = [ [ X,Z ] | R];

    (N>0)->
    connecte(X,Z),
    NewN is N-1,
%    write("["),write(X),write(","),write(Z),write("]"),write(","),
%    path(Z,Y,NewN,L)
    path(Z,Y,NewN,R),
    L = [ [ X,Z ] | R]
    ).



connecte(X,Y):-
    connected(X,Y);
    connected(Y,X).


countList([] , 0).
 
countList([H|T] , R):-
    countList(T ,R1),
    R is R1+1.

memberbefore(X,[Y|T]):-
   X=Y;
   memberbefore(X,T).

findAllFacts(S,L):-
   findStations(S,[],L).

findStations(S,Acc,L):-
    connecte(S,Y),
   \+ memberbefore(Y,Acc),
    findStations(S,[Y|Acc],L).

findStations(_,L,L).


nstations(S,N):-
    findAllFacts(S,L),
    countList(L,N).

liststations(L,L,[L]):-!.
liststations(X,L,Y):-
connected(X,Z),liststations(Z,L,R),Y=[X|R].


cost(X,Y,N):-
    W is 0,
    liststations(X,Y,L),
    cost1(X,Y,R,W),
    (
    (R>16 ; R==16)->
     N is 7;
    (R>7,R<16)->
     N is 5;
    (findline(L))->
     N is 5;
    (R=<7 , not(findline(L)))->
     N is 3
    ).

cost1(S2 ,S2 ,NewN , NewN).

cost1(S1, S2 ,L,NewN ):-
    connected(S1,Z),
    R is NewN+1,
    cost1(Z , S2,L,R).
    



%-------------------------------------------------
findline([]):-!.
findline([H,T,M|X]):-((T==sadat)->(findsadat(H,M));(findramses(H,M)));findline([T,M|X]).

%--------------------------------------------
linechange(X,Y):-
(X==nasser,Y==opera)->!.
linechange(X,Y):-
(X==opera,Y==nasser)->!.
linechange(X,Y):-
(X==saad_zaghloul,Y==naguib)->!.
linechange(X,Y):-
(X==naguib,Y==saad_zaghloul)->!.
linechange(X,Y):-
(X==saad_zaghloul,Y==opera)->!.
linechange(X,Y):-
(X==opera,Y==saad_zaghloul)->!.
linechange(X,Y):-
(X==nasser,Y==naguib)->!.
linechange(X,Y):-
(X==naguib,Y==nasser)->!.
linechange(X,Y):-
(X==ghamra,Y==urabi)->!.
linechange(X,Y):-
(X==urabi,Y==massara)->!.
linechange(X,Y):-
(X==massara,Y==urabi)->!.
linechange(X,Y):-
(X==ghamra,Y==massara)->!.
linechange(X,Y):-
(X==massara,Y==ghamra)->!.
linechange(X,Y):-
(X==ghamra,Y==ataba)->!.
linechange(X,Y):-
(X==ataba,Y==ghamra)->!.
linechange(X,Y):-
(X==ataba,Y==urabi)->!.
linechange(X,Y):-
(X==urabi,Y==ataba)->!.

%----------------------------------------------
findsadat(X,Y):-
connected(X,sadat),connected(sadat,Y),linechange(X,Y).
findsadat(X,Y):-
connected(sadat,X),connected(Y,sadat),linechange(X,Y).


%----------------------------------------------
findramses(X,Y):-
connected(X,alshohadaa),connected(alshohadaa,Y),linechange(X,Y).
findramses(X,Y):-
connected(alshohadaa,X),connected(Y,alshohadaa),linechange(X,Y).
%-----------------------------------------------