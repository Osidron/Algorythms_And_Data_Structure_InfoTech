PROGRAM FlowFile(INPUT, OUTPUT);
VAR
  B, I: INTEGER;
BEGIN
  READ(B);
  FOR I := 0 TO 255
  DO
    IF I <> B
    THEN
      WRITE(I, ' ')
END.