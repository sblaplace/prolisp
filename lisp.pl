:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(charsio)).
:- use_module(library(si)).
:- use_module(library(lists)).
:- use_module(library(lambda)).

parse([], Ls, Ls) --> [].
parse([AST], [_|Ls0], Ls) --> ['('], parse(AST), [')'], parse(Ls0).
parse([ASTh|ASTt], Ls, Ls) --> [A], { atom_si(A), atom_chars(A, Cs), chars_are_nums(Cs), number_chars(ASTh, Cs) }, parse(ASTt).
parse([ASTh|ASTt], Ls, Ls) --> [ASTh], parse(ASTt).

tokenize(['('|As]) --> spaces(_), ['('], spaces(_), tokenize(As).
tokenize([')'|As]) --> spaces(_), [')'], spaces(_), tokenize(As).
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

chars_are_nums(Cs) :- maplist(\C^(char_type(C, numeric)), Cs).

eos([], []).

standard_env({(+): (+), (-): (-)}).
