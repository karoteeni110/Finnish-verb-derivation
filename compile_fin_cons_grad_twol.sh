#!/bin/bash

# This script creates a finite-state transducer for Finnish nouns with consonant gradation
# based on two-level morphology rules

# First create an FST of the lexicon
hfst-lexc -o fin_cons_grad_lexicon.hfst fin_cons_grad_lexicon.lexc

# Then create FSTs of the twol rules
hfst-twolc -o fin_cons_grad_rules_twol.hfst -i fin_cons_grad_rules_twol.twol --resolve

# Combine the FSTs into one; the command is called "compose-intersect", because the lexicon 
# FST is composed with an FST that is produced by intersecting the individual twol-rule 
# FSTs into one twol FST 
hfst-compose-intersect -o fin_cons_grad_twol.hfst -1 fin_cons_grad_lexicon.hfst -2 fin_cons_grad_rules_twol.hfst

# Create an analyzer FST instead of a generator FST
hfst-invert -o fin_cons_grad_analyzer_twol.hfst -i fin_cons_grad_twol.hfst
