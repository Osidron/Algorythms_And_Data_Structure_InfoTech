PROGRAM Test(INPUT, OUTPUT);
USES
  Stack;
VAR
  I: INTEGER;
BEGIN {Test}
  {Проверка IsStackEmpty}
  IF NOT IsStackEmpty
  THEN
    WRITELN('Стек существует')
  ELSE
    WRITELN('Стек пуст');
  {Проверка Push ш Pop}
  FOR I := 1 TO 10
  DO
    BEGIN
      WRITE(I, ' ');
      Push(I)
    END;
  WRITELN;
  IF NOT IsStackEmpty
  THEN
    WRITELN('Стек существует')
  ELSE
    WRITELN('Стек пуст');
  FOR I := 1 TO 10
  DO
    WRITE(Pop, ' ');
  WRITELN;
  IF NOT IsStackEmpty
  THEN
    WRITELN('Стек существует')
  ELSE
    WRITELN('Стек пуст');
  {Проверка CheckHead}
  WRITE('0 - ');
  Push(0);
  WRITELN(CheckHead)
END.  {Test}
