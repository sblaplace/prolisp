:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).

tokenize(["("|As]) --> ['('], tokenize(As).
tokenize([")"|As]) --> [')'], tokenize(As).
tokenize([A|As]) -->
    spaces(_),
    chars([X|Xs]),
    {atom_chars(A, [X|Xs])},
    spaces(_),
    tokenize(As).
tokenize([]) --> [].

chars([X|Xs]) --> char(X), !, chars(Xs).
chars([]) --> [].

spaces([X|Xs]) --> space(X), !, spaces(Xs).
spaces([]) --> [].

space(X) --> [X], {char_type(X, whitespace)}.
char(X) --> [X], {\+ char_type(X, whitespace), X \= ')', X \= '(' }.
