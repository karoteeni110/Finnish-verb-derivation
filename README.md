# Finnish-verb-derivation
My final project for LDA-T3101 Computation morphology (2019)

# How to use


# My plan
To build a guesser that derives a new verb with a meaning label(output) from the input verb (input). That is, to illustrate the verb stem's verb derivation.

E.g. antaa => antautua<Refleksiiviverbi>

The input verb should be a _perussana_ (Fin. "basic word", i.e. a word that is composed of a single morpheme and have not gone through any derivational change), and the output verb contains a single or a triple derivational morpheme (Fin. johdin; See [§ 306 Yhdistymismahdollisuuksista ja -periaatteista](http://scripta.kotus.fi/visk/sisallys.php?p=306)).

Unfortunately the output is not guaranteed to be "correct", since the derivational form of the verb could be exist in principle but has not been used in real life (See [§ 158 Monitulkintaisuutta kannan ja johtimen erottamisessa](http://scripta.kotus.fi/visk/sisallys.php?p=158)), and also due to oversimplification.

# Structure of the scripts

## Filter the input
- Filter for Finnish word
    By ruling out impossible syllable combinations.

- Filter for non-verbs
    By ruling out those which do not end with a/ä.

## Conjugate to the stem form
- 
There are 8 types of stems: [§ 61 Taivutuksen ja johtamisen vertailua](http://scripta.kotus.fi/visk/sisallys.php?p=61), from which I give the rules:


## Add derivational suffixes
The derivational change happens at most three times (as _laih-du-t-el-la_ is attached with triple morphemes _tU-ttA-ele_.)

The verb is still in stem form after this rule.

## Label the derivation
The label tells on the meaning of the derivational change, which is named by the meaning groups it belongs to ([Verbijohdosten merkitysryhmiä](https://fl.finnlectura.fi/verkkosuomi/Morfologia/sivu2723.htm)). The number and order of labels depend on the derivation occurences.

# Summary
The rules perform the derivation changes below ([Verbinjohtimia, verbikantaisia](http://materiaalit.internetix.fi/fi/opintojaksot/8kieletkirjallisuus/aidinkieli/kielioppi/53sanojen_johtaminen)):

- AhtA 

    momentaaninen eli äkillinen, esim. hauk+ahta-, ist+ahta-, kieh+ahta-, tip+ahta-, väs+ähtä- 

- Aise 

    momentaaninen, esim. niel+aise-, pes+aise-, tek+aise-, pyyhk+äise 

- ele, ile 

    frekventatiivinen eli toistuva, esim. aj+ele-, heitt+ele-, kaipa+ile-, kerä+ile- 

- skele 

    frekventatiivinen, esim. ammu+skele-, etsi+skele-, pure+skele- 

- ttA 

    kausatiivinen, esim. ammu+tta-, eksy+ttä-, kaiva+tta-, tee+ttä- 

- UtU 

    refleksiivinen, translatiivinen, esim. ava+utu-, elä+yty-, hake+utu-, laske+utu-, uskalta+utu- 