% База данных родственных отношений
parent(bill, joe).
parent(sue, joe).
parent(bill, ann).
parent(sue, ann).
parent(joe, tammy).
parent(paul, jim).
parent(mary, jim).
parent(ann, bob).
parent(jim, bob).

male(bill).
male(paul).
male(joe).
male(jim).
male(bob).

female(sue).
female(mary).
female(ann).
female(tammy).

% b) Запрос для нахождения бабушки для bob
% ?- parent(Y, bob), parent(X, Y), female(X)

% c) Запрос для нахождения внука
% parent(X, Y), parent(Y, Z), male(Z).

% d) Правило для определения сестры
sister(X, Y) :- female(X), parent(Z, X), parent(Z, Y), X \= Y.

% Запрос для нахождения сестры для Jim
% sister(Sister, jim).

% e) Правило для определения тёти (aunt)
aunt(X, Y) :- sister(X, Z), parent(Z, Y).

% Правило для определения брата (brother)
brother(X, Y) :- male(X), parent(Z, X), parent(Z, Y), X \= Y.

% f) Правило для определения кузина (cousin)
cousin(X, Y) :- parent(Z, X), parent(W, Y), (sister(Z, W); brother(Z, W)).