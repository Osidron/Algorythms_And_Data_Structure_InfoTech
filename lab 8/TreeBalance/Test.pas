PROGRAM Test(INPUT, OUTPUT);
USES
  RedBlackTree;
VAR
  I, J, K: INTEGER;
BEGIN
  WRITELN('������ ������⢮ ����⮢ ��� ��⠢��');
  READ(K);
  FOR I := 1 TO K
  DO
    BEGIN
      WRITELN('������ ', I, ' �᫮ �� -', MAXINT, ' �� ', MAXINT);
      READ(J);
      InsertKey(J)
    END;
  PrintSorted
END.
