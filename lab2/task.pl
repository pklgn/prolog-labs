seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(4, point(3, 10), point(3, 1)).
seg(5, point(7, 10), point(13, 10)).
seg(6, point(8, 13), point(8, 0)).
seg(7, point(10, 12), point(10, 3)).
seg(8, point(11, 13), point(11, 3)).
seg(9, point(12, 12), point(12, 2)).

horiz(N) :- seg(N, point(X1, Y), point(X2, Y)), X1 \= X2.

vertical(N) :- seg(N, point(X, Y1), point(X, Y2)), Y1 \= Y2.

% Расстояние между двумя точками
distance(point(X1, Y1), point(X2, Y2), Dist) :-
  DX is X2 - X1,
  DY is Y2 - Y1,
  Dist is sqrt(DX * DX + DY * DY).

% Правило для определения горизонтальных отрезков
horizSeg(Number, point(X1, Y), point(X2, Y)) :- seg(Number, point(X1, Y), point(X2, Y)), X1 \= X2.

% Правило для определения вертикальных отрезков
verticalSeg(Number, point(X, Y1), point(X, Y2)) :- seg(Number, point(X, Y1), point(X, Y2)), Y1 \= Y2.

% Правило для определения пересекающихся отрезков
cross(N, M, point(X, Y), NL, ML) :-
  horizSeg(N, point(HX1, HY), point(HX2, HY)),
  verticalSeg(M, point(VX, VY1), point(VX, VY2)),
  HX1 =< VX, VX =< HX2, % Проверка, что вертикальный отрезок пересекает горизонтальный по X
  VY1 >= HY, HY >= VY2, % Проверка, что горизонтальный отрезок пересекает вертикальный по Y
  X = VX, % Точка пересечения по X
  Y = HY, % Точка пересечения по Y
  distance(point(HX1, HY), point(HX2, HY), NL), % Длина горизонтального отрезка
  distance(point(VX, VY1), point(VX, VY2), ML). % Длина вертикального отрезка