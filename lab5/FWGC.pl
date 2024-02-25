  go:-  go(state(east,east,east,east),state(west,west,west,west)).

  go(S,G):-
  	path(S,G,[S],L3),
  	nl,write('A solution is:'),nl,
  	write_path(L3),
  	fail.
  go(_,_).

  path(S,G,L,L1):-
	move(S,S1),
	not( unsafe(S1) ),
	not( member(S1,L) ),
	path( S1,G,[S1|L],L1),!.
  path(G,G,T,T):-!.   /* The final state is reached  */
                    
  move(state(X,X,G,C),state(Y,Y,G,C)):-opposite(X,Y). /* FARMER + WOLF    */
  move(state(X,W,X,C),state(Y,W,Y,C)):-opposite(X,Y). /* FARMER + GOAT    */
  move(state(X,W,G,X),state(Y,W,G,Y)):-opposite(X,Y). /* FARMER + CABBAGE */
  move(state(X,W,G,C),state(Y,W,G,C)):-opposite(X,Y). /* ONLY FARMER	  */

  opposite(east,west).
  opposite(west,east).

  unsafe( state(F,X,X,_) ):- opposite(F,X).  /* The wolf eats the goat    */
  unsafe( state(F,_,X,X) ):- opposite(F,X).  /* The goat eats the cabbage */
  
  member(X,[X|_]).
  member(X,[_|L]):-member(X,L).

  write_move( state(X,W,G,C), state(Y,W,G,C) ) :-!,
	write('The farmer crosses the river from '),
        write(X),
        write(' to '),
        write(Y),nl. 
  write_move( state(X,X,G,C), state(Y,Y,G,C) ) :-!,
	write('The farmer takes the Wolf from '),
        write(X),
        write(' of the river to '),
        write(Y),nl.
  write_move( state(X,W,X,C), state(Y,W,Y,C) ) :-!,

	write('The farmer takes the Goat from' ),
        write(X),
        write(' of the river to '),
        write(Y),nl.
  write_move( state(X,W,G,X), state(Y,W,G,Y) ) :-!,
	write('The farmer takes the cabbage from '),
        write(X),
        write(' of the river to '),
        write(Y),nl.
		       
  write_path( [H1,H2|T] ) :- !,
	write_move(H1,H2),write_path([H2|T]).
  write_path( _ ).
