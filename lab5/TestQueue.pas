PROGRAM TestQueue(INPUT, OUTPUT);
USES
  PriorityQueueUnit;
VAR
  J: INTEGER;
PROCEDURE QueueTest;
BEGIN
  IF NOT IsQueueEmpty
  THEN
    WRITELN('Очередь существует')
  ELSE
    WRITELN('Очередь пуста');
  FOR J := 1 TO 10
  DO
    BEGIN
      WRITE(J, ' ');
      Push(J)
    END;
  WRITELN;
  IF NOT IsQueueEmpty
  THEN
    WRITELN('Очередь существует')
  ELSE
    WRITELN('Очередь пуста');
  FOR J := 1 TO 10
  DO
    WRITE(Pop, ' ');
  WRITELN;
  IF NOT IsQueueEmpty
  THEN
    WRITELN('Очередь существует')
  ELSE
    WRITELN('Очередь пуста');
  WRITELN
END;

PROCEDURE PriorityTest1;
BEGIN
  WRITELN('Queue 1');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(4, 0)');
  SwapPriority(4, 0);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;

PROCEDURE PriorityTest2;
BEGIN
  WRITELN('Queue 2');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(5, 0)');
  SwapPriority(5, 0);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;

PROCEDURE PriorityTest3;
BEGIN
  WRITELN('Queue 3');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(1, 6)');
  SwapPriority(1, 6);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;
PROCEDURE PriorityTest4;
BEGIN
  WRITELN('Queue 4');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(2, 6)');
  SwapPriority(2, 6);
  WRITELN('SwapPriority(2, 2)');
  SwapPriority(2, 2);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;

PROCEDURE PriorityTest5;
BEGIN
  WRITELN('Queue 5');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(4, 6)');
  SwapPriority(4, 6);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;

PROCEDURE PriorityTest6;
BEGIN
  WRITELN('Queue 6');
  WRITELN('Input');
  WRITELN('  1 2 3 4 5');
  FOR J := 1 TO 5
  DO
    Push(J);
  WRITELN('SwapPriority(3, 1)');
  SwapPriority(3, 1);
  WRITELN('Output');
  WRITE('  ');
  FOR J := 1 TO 5
  DO
    WRITE(Pop, ' ');
  WRITELN;
  WRITELN
END;

BEGIN
  QueueTest;     {Тест самой очереди}
  PriorityTest1; {Тест на перемещение элемента из середины в голову}
  PriorityTest2; {Тест на перемещение элемента из хвоста в голову}
  PriorityTest3; {Тест на перемещение элемента из головы в хвост}
  PriorityTest4; {Тест на возврат элемента на прежнее место}
  PriorityTest5; {Тест на перемещение элемента из середины в хвост}
  PriorityTest6  {Тест на перемещение элемента из середины в середину}    
END.
