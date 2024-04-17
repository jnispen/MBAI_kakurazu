%% Kakurasu puzzle solver
%%
%% Kakurasu is played on a rectangular grid N x N
%% 1. The black squares on each row sum up to the number on the right.
%% 2. The black squares on each column sum up to the number on the bottom.
%% 3. If a black cell is first on its row/column its value is 1. If it is
%% second its value is 2, etc.

#const n=5.
color(white; black).

%% clues for the rows and columns
clues_row(1,1; 2,9; 3,10; 4,3; 5,8).
clues_col(1,13; 2,12; 3,3; 4,5; 5,7).

{pos(R,C,COL) : color(COL)} = 1 :- R=1..n, C=1..n.
%% achieved: every square of the grid is either black or white

row_tot(R,SUM) :- pos(R,_,COL), COL=black, SUM=#sum{C : pos(R,C,COL)}.
col_tot(C,SUM) :- pos(_,C,COL), COL=black, SUM=#sum{R : pos(R,C,COL)}.
%% achieved: calculate the sum of the rows/columns containing black squares

row_tot(R,0) :- pos(R,_,COL), COL=white, #count{C : pos(R,C,COL)} = n.
col_tot(C,0) :- pos(_,C,COL), COL=white, #count{R : pos(R,C,COL)} = n.
%% achieved: add the the sum of the rows/columns containing only white squares

:- row_tot(R,SUM1), clues_row(R,SUM2), SUM1 != SUM2.
:- col_tot(C,SUM1), clues_col(C,SUM2), SUM1 != SUM2.
%% achieved: if the sum of the rows/columns is not equal to the sum
%% provided in the clue, then this is not a valid solution

#show pos/3.
