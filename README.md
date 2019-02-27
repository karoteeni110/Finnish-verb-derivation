# Finnish-verb-derivation
My final project for LDA-T3101 Computation morphology (2019)

# My plan
To build a guesser that derives a new verb with a meaning label(output) from the input verb (input). That is, to illustrate the verb stem's verb derivation.

E.g. antaa => antautua<Reflek>

The input verb should be a _perussana_ (Fin. "basic word", i.e. a word that is composed of a single morpheme and have not gone through any derivational change), and the output verb contains a single or a triple derivational morpheme (Fin. johdin; See [§ 306 Yhdistymismahdollisuuksista ja -periaatteista](http://scripta.kotus.fi/visk/sisallys.php?p=306)).

Unfortunately, the output is not guaranteed to be correct, since the derivational form of the verb could be exist in principle but has not been used in real life (See [§ 158 Monitulkintaisuutta kannan ja johtimen erottamisessa](http://scripta.kotus.fi/visk/sisallys.php?p=158)), and there might be bugs in the script.

# Structure of the scripts

## Filter the input
- Accept Finnish word
    By ruling out impossible syllable combinations.

- Filter out non-verbs
    By ruling out those which do not end with a/ä.

## Conjugate to the stem form according to derivational suffixes and attach suffixes
Derivational suffixes includes -Ahta-, -Aise-, -ele- or -ile-, -skele-, -UtU-. Each lexeme would be conjugated to a specific stem form to adapt the suffix ([Vesa 2006](http://materiaalit.internetix.fi/fi/opintojaksot/8kieletkirjallisuus/aidinkieli/kielioppi/53sanojen_johtaminen)).

Below demonstrate the rules of stemming and derivational changes.

### -Ahta- (Momental)

Three-syllable (*_matkustahtaa_, *_kiristäistä_) and two-syllable derivated verb stems cannot be derivated to momental verbs ([§ 368 Momentaanijohtimista](http://scripta.kotus.fi/visk/sisallys.php?p=368)).

- UtU; A vartalot
```
    define AEtoUtU            a a -> a u t u || _ .#.
    define 
```

## Label the derivation
The label tells on the meaning of the derivational change, which is named by the meaning groups it belongs to ([Verbijohdosten merkitysryhmiä](https://fl.finnlectura.fi/verkkosuomi/Morfologia/sivu2723.htm)). The number and order of labels depend on the derivation occurences.

# Summary
The rules perform the derivation changes below ([Verbinjohtimia, verbikantaisia](http://materiaalit.internetix.fi/fi/opintojaksot/8kieletkirjallisuus/aidinkieli/kielioppi/53sanojen_johtaminen)):

- AhtA 

    momentaaninen eli äkillinen
    
    esim. hauk+ahta-, ist+ahta-, kieh+ahta-, tip+ahta-, väs+ähtä- 

- Aise 

    momentaaninen
    
    esim. niel+aise-, pes+aise-, tek+aise-, pyyhk+äise 

- ele, ile 

    frekventatiivinen eli toistuva
    
    esim. aj+ele-, heitt+ele-, kaipa+ile-, kerä+ile- 

- skele 

    frekventatiivinen
    
    esim. ammu+skele-, etsi+skele-, pure+skele- 

- ttA 

    kausatiivinen
    
    esim. ammu+tta-, eksy+ttä-, kaiva+tta-, tee+ttä- 

- UtU 

    refleksiivinen, translatiivinen
    
    esim. ava+utu-, elä+yty-, hake+utu-, laske+utu-, uskalta+utu- 

## References
Koivisto, Vesa. "Suomen sananjohdon morfofonologiaa." Virittäjä 110.4 (2006): 539-539.
