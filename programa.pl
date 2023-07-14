% Cancion, Compositores,  Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

%%%%%%%  SOLUCIÓN  %%%%%%%

% Punto 1
esUnHit(Cancion):-
    cancion(Cancion,_,_),
    forall(rankingTop3(Mes,_,_), rankingTop3(Mes,_,Cancion)).
    
% Punto 2
noReconocidaPorCriticos(Cancion):-
    cancion(Cancion,_,Reproducciones),
    Reproducciones > 7000000.
    not(rankingTop3(_,_,Cancion)).

% Punto 3
sonColaboradores(Compositor1,Compositor2):-
    cantaEn(Compositor1,Cancion),
    cantaEn(Compositor2,Cancion),
    Compositor1 \= Compositor2.

cantaEn(Compositor,Cancion):-
    cancion(Cancion,Artistas,_),
    member(Compositor, Artistas).
    
% Punto 4
trabaja(tulio,conductor(5)).
trabaja(bodoque,periodista(2,licenciatura)).
trabaja(bodoque,reportero(5,300)).
trabaja(marioHugo,periodista(10,posgrado)).
trabaja(juanin,conductor(0)).

% Punto 5
sueldoTotal(Persona,SueldoTotal):-
    trabaja(Persona,_),
    findall(Sueldo, sueldoSegunTrabajo(Persona,Sueldo), Sueldos),
    sum_list(Sueldos, SueldoTotal).
    
sueldoSegunTrabajo(Persona,Sueldo):-
    trabaja(Persona,TipoTrabajo),
    sueldo(TipoTrabajo,Sueldo).

sueldo(conductor(AniosExperiencia),Sueldo):-
    Sueldo is AniosExperiencia * 10000.

sueldo(reportero(AniosExperiencia,CantidadNotas),Sueldo):-
    Sueldo is AniosExperiencia * 10000 + 100 * CantidadNotas.

sueldo(periodista(AniosExperiencia,Titulo),Sueldo):-
    aumentoSegunTitulo(Titulo,Aumento),
    Sueldo is AniosExperiencia * 5000 * (1 + Aumento/100).

aumentoSegunTitulo(posgrado,35).
aumentoSegunTitulo(licenciatura,20).
