PROGRAM TestQueue(INPUT, OUTPUT);
USES
  QueueUnit;
VAR
  J: INTEGER;
BEGIN
  IF NOT IsQueueEmpty
  THEN
    WRITELN('��।� �������')
  ELSE
    WRITELN('��।� ����');
  FOR J := 1 TO 10
  DO
    BEGIN
      WRITE(J, ' ');
      Push(J)
    END;
  WRITELN;
  IF NOT IsQueueEmpty
  THEN
    WRITELN('��।� �������')
  ELSE
    WRITELN('��।� ����');
  FOR J := 1 TO 10
  DO
    WRITE(Pop, ' ');
  WRITELN;
  IF NOT IsQueueEmpty
  THEN
    WRITELN('��।� �������')
  ELSE
    WRITELN('��।� ����')
END.
