tebak :-  hypothesize(Food),
          write('Ku rasa makanannya adalah ->'),
          write(Food), nl, undo.

hypothesize(soto_mie) :- soto_mie, !.
hypothesize(bakso) :- bakso, !.
hypothesize(nasi_goreng) :- nasi_goreng, !.
hypothesize(bika_ambon) :- bika_ambon, !.
hypothesize(sate) :- sate, !.
hypothesize(rawon) :- rawon, !.
hypothesize(gado_gado) :- gado_gado, !.
hypothesize(rujak) :- rujak, !.
hypothesize(pempek) :- pempek, !.
hypothesize(papeda) :- papeda, !.
hypothesize(pie_susu) :- pie_susu, !.


hypothesize(makanan_tidak_ada_didefinisi). 


/* Makanan identification rules */
soto_mie :- mie, nasi,
            verify(pakai_daging), 
            verify(pakai_sayur).

bakso :- berkuah,
         verify(pakai_daging),
         verify(bentuknya_bulat).

nasi_goreng :- nasi,
               verify(pakai_telor),
               verify(digoreng).

bika_ambon :- manis,
              verify(berpori_pori).

sate :- verify(pakai_kecap),
        verify(dibakar),
        verify(ditusuk),
        verify(pakai_daging).

rawon :- berkuah, 
         nasi,
         verify(pakai_daging).
          
gado_gado :-  verify(pakai_lontong),
              verify(pakai_sayur),
              verify(pakai_bumbu_kacang),
              verify(pakai_kerupuk).

rujak :-  verify(asam),
          verify(pedas),
          verify(segar),
          verify(pakai_buah).

pempek :- berkuah,
          verify(pakai_ikan),
          verify(pakai_sagu).
            
papeda :- verify(gurih),
          verify(kenyal),
          verify(pakai_sagu).

pie_susu :- manis,
            verify(pakai_telur),
            verify(pakai_susu).

/* classification rules */
jawa_timur :- verify(asin),
              verify(pedas),
              verify(pakai_petis).

jawa_tengah :-  verify(manis),
                verify(tidak_pedas),
                verify(pakai_bawang_putih),
                verify(sedikit_rempah_rempah).

sunda :-  verify(pakai_lalapan_n_sambal),
          verify(dimasak_pakai_daun_pisang),
          verify(pakai_bumbu_kuning), !.

sunda :-  verify(pakai_lalapan_n_sambal),
          verify(dimasak_pakai_daun_pisang),
          verify(pakai_bumbu_putih).

jakarta :-  verify(gurih),
            verify(tidak_pedas).

mie :-  berkuah, 
        verify(pakai_tepung), !.    
mie :-  verify(berbentuk_panjang).

nasi :- verify(tinggi_karbohitrat), !.
nasi :- verify(membuat_kenyang).

berkuah :- verify(terendam_kaldu), !.
berkuah :- verify(pakai_mangkok).

manis :- verify(pakai_gula), !.
manis :- verify(pakai_santan).



/* how to ask questions */
ask(Question) :-
        write('Apakah makanan tersebut mempunyai ciri-ciri seperti ini: '),
        write(Question), write('? '),
         read(Response), nl,
         ( (Response == iya ; Response == ya)
         -> assert(yes(Question)) ;
         assert(no(Question)), fail).
:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
