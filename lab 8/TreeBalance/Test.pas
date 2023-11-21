PROGRAM Test(INPUT, OUTPUT);
USES
  RedBlackTree;
VAR
  I, J, K: INTEGER;
BEGIN
  WRITELN('Введите количество элементов для вставки');
  READ(K);
  FOR I := 1 TO K
  DO
    BEGIN
      WRITELN('Введите ', I, ' число от -', MAXINT, ' до ', MAXINT);
      READ(J);
      InsertKey(J)
    END;
  PrintSorted
END.
