# Finnish-verb-derivation

Finnish verb guesser (Alpha testing V0.0.1)

## My plan

The guesser produces derivative forms of the input verb.

E.g.

input:

```
hfst[1]: down antaa  
```

The output should be:

```
antautua
annella
anniskella
```

The input verb should be a "basic word" (Fin. _perussana_), i.e. a word that is composed of a single morpheme and have not gone through any derivational change. The output verb is designated to go through one derivational change (Fin. johdin; See [VISK § 306](http://scripta.kotus.fi/visk/sisallys.php?p=306), so they would contain only two morphemes.

Unfortunately, this version (010319) yields disappointing results. The derivational forms it yields could exist in principle, but has not been used in real life (See [VISK § 158](http://scripta.kotus.fi/visk/sisallys.php?p=158)), and there are bugs in the script :(. It seems an analyzer is more realistic.

## Structure

The lexc script has put several toy words, and added all the five suffixes to them. For example, the lower word for "antaa" are "antaa-AhtAA", "antaa-AistAA", "antaa-ellA", "antaa-illA", "antaa-skellA", "antaa-ttAA" and "antaa-UtUA". This is a simplification; as is mentioned above, not all of those forms exist in real life.

! "-ellA" / "-illA" state is problematic.

### Filter the input

1. Accept Finnish word

Ruling out impossible syllable combinations:

```

! Vokaalit ja konsonantit Suomen kielessä
define Vowel    a | o | u | ä | ö | y | e | i ;
define Con      b | c | d | f | g | h | j | k | l | m | n | p | q | r | s | t | v | w | x | z ;
define AA       ä | a ;

! Umpitavut;
define Umpitavu [ Con Vowel Con ] | [ Con Vowel Con Con ] | [ Con Vowel Vowel Con ] |
                 [ Vowel Con ] | [ Vowel Con Con ] | [ Vowel Vowel Con ] ;

! Avotavut; 
define Avotavu     [ Con Vowel ] | [ Vowel ] | [ Vowel Vowel ] | [ Con Vowel Vowel ] ;

! Viimeinen avotavu
define LoppuAvotavu     [ Con AA ] | [ AA ] | [ AA AA ] | [ Con AA AA ] ;

```

2. Filter out non-verbs

Ruling out those which do not end with a/ä:

```

! Loosely, we define verbs are words consisting of less than 6 syllables, 
! with the last one being dA/ A/ tA/ lA. (Should I keep it?)
define FinVerb      [ [Avotavu] | [Umpitavu] ]^<5 [ [ d AA ] | [ AA ] | [ t AA ] | [ l A ] ] ;

```

### Vowel Harmony

The Vowel Harmony in the suffix. 

Rules are composed before stemming, since words like "seisoa" turning into "seis" would effect on the vowel choice.

```
define VokaalisoituOne   A -> a, U -> u || $[ a | o | u ] _ ; ! We don't consider compounds
define VokaalisoituTwo   A -> ä, U -> y ;
```

### Stemming

These rules transform the inputs into a rough stem form. Only the  Here the exceptions like "juosta, mennä" are ignored:

```

! define stemI       AA -> 0 || Vowel _ %-       ! "antaa > anta-"; V stem
! define stemII      d AA -> 0 || _ %-           ! "luoda > luo-"; V stem
! define stemIII     l l AA -> l || _ %-          ! "tulla > tul-"; e-stem
! define stemIV      t AA -> 0 || Vowel _ %-      ! "ruveta > ruve"; supistumavartalo
! define stemV       s t AA -> s || _ %-          ! "nousta > nous-"; e-stem
! define stemVI      i t AA -> i || _ %-        ! "merkitä > merkit-"; e-stem
```

Since grade of the stem depends on the specific suffix, the gradation would be corporated in the conjugation rules.


### Conjugate to the stem form according to derivational suffixes

Derivational suffixes includes -Ahta-, -Aise-, -ele- or -ile-, -skele-, -UtU-. Each lexeme would be conjugated to a specific stem form to adapt the suffix ([Vesa 2006](http://materiaalit.internetix.fi/fi/opintojaksot/8kieletkirjallisuus/aidinkieli/kielioppi/53sanojen_johtaminen)).

Below demonstrates the rules of stemming and derivational changes.

### -UtU-

Follows strong graded vowel stems.

```

! -UtU-; kääntä-ytyä > kääntä-ytyä; sopia-utua > sope-utu-a
! A and e stay in the end of the stem, i turns into e 
define aeiUtU        Con [ a a ] -> a  , Con [ e e ] -> e , 
                    Con [ ä ä ] -> ä , Con i -> e ||  _ %- UU t UU AA ;

!!!!!!
! Exclude ttA-stem; *vahingoitta-utu-a vs. testamentta-utu-a
! define exUtU        stemI .o.
!                   [ 0 -> %-NOTPOSSIBLE%- || _ %- UU t UU AA ] ;
!!!!!!
```

### -AhtA- (Momental verb derivation)

Follows weak graded vowel stems ([VISK § 369](http://scripta.kotus.fi/visk/sisallys.php?p=369)).

Meaning: inchoative.

```

! Drop the last vowel
define vAhtA       Vowel -> 0 ||  _ %- A h t A A ; 
```

### -ile-

Usually follows Type IV verbs, epecially the stems with ending of _O_ (in two-syllable stems), _AA_-, _U_, and _e_- ([VISK § 360](http://scripta.kotus.fi/visk/sisallys.php?p=360)), i.e. strong-graded vowel stems.

Irragularity in one-syllable stems: 

> irv-ail-la, uin-ail-la, vits-ail-la, mak-oil-la

### -skele- 

Follows two-syllable stems, typically those with ending of _i_- or _e_-. ([VISK § 362](http://scripta.kotus.fi/visk/sisallys.php?p=362)).

Stem ending _a_- turns into _e_ (_laule-ske-la_).

Very unpredictive. 

> Verbeissä ann-iskel-la ja kann-iskel-la johdinaineksena on ‑iskele-.
> Rakenteeltaan kompleksisempi johdin -skentele- liittyy yksitavuiseen vartaloon. skentele-johdoksia on vain muutama, useimmat verbikantaisia: käyskennellä, teeskennellä, uiskennella (PS), myyskennellä (NS, skt)

### -Aise-

Follows strong graded vowel stems that are made of two syllables.

[VISK § 370](http://scripta.kotus.fi/visk/sisallys.php?p=370)

TBD

### -ttA-

Follows weak graded vowel stems.

[VISK § 320](http://scripta.kotus.fi/visk/sisallys.php?p=320)

TBD

#### Label the derivation

The label tells on the meaning of the derivational change, which is named by the meaning groups it belongs to ([Savolainen 2001](https://fl.finnlectura.fi/verkkosuomi/Morfologia/sivu2723.htm)). The number and order of labels depend on the derivation occurences.

TBD

#### Clean up the dashes

```
define CleafOffdash      %- -> 0 ;
```

### Summary

All rules composed:

```
regex AllFinVerbs .o. VokaalisoituOne .o. VokaalisoituTwo .o. Stemming .o. Gradation 
                  .o. aeiUtU .o. vAhtA .o. AeIle ! Add suffixes here
                  .o. CleafOffdash ;
```

The rules perform the derivation changes below ([1998 Savolainen](http://materiaalit.internetix.fi/fi/opintojaksot/8kieletkirjallisuus/aidinkieli/kielioppi/53sanojen_johtaminen)):

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

### References

Koivisto, Vesa. "Suomen sananjohdon morfofonologiaa." Virittäjä 110.4 (2006): 539-539.

VISK = Auli Hakulinen, Maria Vilkuna, Riitta Korhonen, Vesa Koivisto, Tarja Riitta Heinonen ja Irja Alho 2004: Iso suomen kielioppi. Helsinki: Suomalaisen Kirjallisuuden Seura. Verkkoversio, viitattu 1.11.2008. Available: http://scripta.kotus.fi/visk URN:ISBN:978-952-5446-35-7

Internetix / Erkki Savolainen 1998

Finn Lectura / Erkki Savolainen 2001