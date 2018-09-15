syms x1 x2 x3 x4 y1 y2 y3 y4 z1 z2 z3 z4

eq1 = x2-x1 == x4-x3;
eq2 = x3-x1 == x4-x2;
eq3 = y2-y1 == y4-y3;
eq4 = y3-y1 == y4-y2;
eq5 = z2-z1 == z4-z3;
eq6 = z3-z1 == z4-z2;

solutions = solve([eq1, eq2, eq3, eq4, eq5, eq6], [x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4]);