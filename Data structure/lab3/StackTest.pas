PROGRAM Test(INPUT, OUTPUT);
USES
  Stack;
VAR
  I: INTEGER;
BEGIN {Test}
  {�஢�ઠ IsStackEmpty}
  IF NOT IsStackEmpty
  THEN
    WRITELN('�⥪ �������')
  ELSE
    WRITELN('�⥪ ����');
  {�஢�ઠ Push � Pop}
  FOR I := 1 TO 10
  DO
    BEGIN
      WRITE(I, ' ');
      Push(I)
    END;
  WRITELN;
  IF NOT IsStackEmpty
  THEN
    WRITELN('�⥪ �������')
  ELSE
    WRITELN('�⥪ ����');
  FOR I := 1 TO 10
  DO
    WRITE(Pop, ' ');
  WRITELN;
  IF NOT IsStackEmpty
  THEN
    WRITELN('�⥪ �������')
  ELSE
    WRITELN('�⥪ ����');
  {�஢�ઠ CheckHead}
  WRITE('0 - ');
  Push(0);
  WRITELN(CheckHead)
END.  {Test}
