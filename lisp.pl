:- use_module(library(dcgs)).
:- use_module(library(pio)).

tokenize(Tokens) --> 

ws --> ([] | " " | "\n").