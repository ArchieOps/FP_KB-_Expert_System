tebak_makanan :-  hypothesize(Food),
          write('Ku rasa makanannya adalah: '),
          write(Food), nl, undo.

% --- soto ---
hypothesize(soto_bogor) :- soto_bogor, !.
hypothesize(soto_jakarta) :- soto_jakarta, !.
hypothesize(soto_lamongan) :- soto_lamongan, !.
% ----------

% ---sate---
hypothesize(sate_madura) :- sate_madura, !.
hypothesize(sate_padang) :- sate_padang, !.
hypothesize(sate_lilit) :- sate_lilit, !.
% ----------

% ---nasi---
hypothesize(nasi_liwet) :- nasi_liwet, !.
hypothesize(nasi_kebuli) :- nasi_kebuli, !.
% ----------

% ---ikan---
hypothesize(ikan_kuah_kuning_papua) :- ikan_kuah_kuning_papua, !.
hypothesize(ikan_bakar_parape_makasar) :- ikan_bakar_parape_makasar, !.
hypothesize(pepes_ikan_bakar_sunda) :- pepes_ikan_bakar_sunda, !.
% ----------

hypothesize(makanan_tidak_ada_didefinisi).

% ------ soto ------
soto_bogor :-  jawa_barat, rebus,
               verify(pakai_kikil), 
               verify(pakai_risol).

soto_jakarta :- jakarta, rebus,
                verify(pakai_emping).
              
soto_lamongan :- jawa_timur, rebus,
                 verify(pakai_taburan_koya),
                 verify(daging_diiris_menyamping), 
                 verify(pakai_kerupuk_udang).  
% ------ end soto ------



% ------ sate ------
sate_madura :-  jawa_timur, sambal_kacang, bakar,
                verify(pakai_kecap),
                verify(daging_ayam).

sate_padang :-  sumatera_barat, bakar,
                verify(daging_sapi),
                verify(bumbu_saus_kuning).

sate_lilit :-  bali, bakar,
               verify(daging_babi),
               verify(daging_dicincang),
               verify(tusuk_batang_sereh).
% ------ end sate ------



% ------ nasi ------
nasi_liwet :-   jawa_barat, 
                verify(menggunakna_sambal_goreng_labu_siam),
                verify(menggunakan_ayam_opor),
                verify(menggunakan_areh).

nasi_kebuli :-  jakarta,
                verify(menggunakan_daging_kambing),
                verify(ditaburi_kurma).
% ------ end nasi ------



% ------ ikan ------
ikan_bakar_parape_makasar :-  bakar, 
                              verify(pakai_ikan_kue),
                              verify(kecap), 
                              verify(jeruk_nipis), 
                              verify(asam_jawa).

pepes_ikan_bakar_sunda :- jawa_barat, bakar,
                          verify(ikan_seluang),
                          verify(daun_kemangi).

ikan_kuah_kuning_papua :- papua, 
    					  rebus, 
    					  bumbu_kuning,
                          verify(pakai_ikan_tongkol).
                          
% ------ end ikan ------


% ------ daerah -------
jawa_timur :- verify(pakai_petis), !.
jawa_timur :- bumbu_merah, !.
jawa_timur :- bumbu_putih.

jawa_barat :- verify(merupakan_pepes), !.
jawa_barat :- verify(pakai_lalapan), !.
jawa_barat :- bumbu_kuning, !.
jawa_barat :- bumbu_putih.

bali :- verify(pakai_sambal_matah), !.  

jakarta :-  verify(pakai_minyak_samin), !. 
jakarta :-  verify(pakai_susu), !.
jakarta :-  bumbu_kuning, !.
jakarta :-  bumbu_putih.

sumatera_barat :- verify(pakai_santan), verify(pedas), !.
sumatera_barat :- bumbu_kuning, !.
sumatera_barat :- bumbu_merah.

papua :- verify(tepung_sagu).
         
% ------ end daerah ------

/*
 ------ bumbu dasar ------
Contoh makanan menggunakan bumbu dasar ini

bumbu merah: sambal goreng, balado, urap, rendang, pepes, nasi goreng, sambal bajak, dan gulai.
bumbu putih: gudeg, sayur bobor, soto, lodeh, rawon, opor, oseng-oseng, tempe bacem, dan aneka tumis.
bumbu kuning:  kari, acar kuning, nasi kuning, kari ayam, pesmol ikan, pepes, dan ayam goreng.
sambal kacang: pecel, sate, gado-gado, lotek, serta rujak.
*/

bumbu_putih :- verify(pakai_bumbu_putih).
bumbu_merah :- verify(pakai_cabai_merah), bumbu_putih.
bumbu_kuning :- verify(pakai_kunyit), bumbu_putih.
sambal_kacang :- verify(pakai_bumbu_kacang).

% ------ end bumbu dasar ------




% ------ teknik masak ------

rebus :- verify(direbus).
bakar :- verify(dibakar).
goreng :- verify(digoreng).

% ----end teknik masak ----



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


/* Referensi 
soto lamongan : https://travel.kompas.com/read/2017/06/08/152100527/ini.perbedaan.soto.lamongan.dengan.soto.lainnya?page=all
soto betawi   : https://www.kompas.com/food/read/2020/06/18/220700675/apa-bedanya-soto-betawi-dengan-soto-daerah-lain?page=all
Sate :
Madura vs padang : https://id.quora.com/Apa-perbedaan-Sate-Padang-dan-Sate-Madura
Sate Madura, Sate Ponorogo, Sate Lilit, Apa Bedanya? : https://pergikuliner.com/blog/sate-madura-sate-ponorogo-sate-lilit-apa-bedanya
Ciri khas makanan daerah : https://republika.co.id/berita/gaya-hidup/kuliner/15/11/25/nyclnl328-yuk-kenali-kekhasan-masakan-tiap-daerah
Nasi : 
Nasi Liwet : https://travel.kompas.com/read/2017/06/10/152400227/ini.ternyata.perbedaan.nasi.liwet.sunda.dan.jawa.?page=all
Nasi Kebuli : https://id.wikipedia.org/wiki/Nasi_kebuli
*/