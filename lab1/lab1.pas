PROGRAM BinarySearch(INPUT, OUTPUT);
TYPE
  IntFile = FILE OF LONGINT;

CONST
  IntFileName = 'File.txt';
  Equality = 0;
  EmptyFile = 0;
  FileStart = 1;
 
FUNCTION Median(Lhs, Rhs: LONGINT): LONGINT;
BEGIN
  IF Lhs = Rhs
  THEN
    Median := Equality
  ELSE
    Median := (Lhs + Rhs) DIV 2
END;

PROCEDURE CopyInputStringToFile(VAR F: IntFile);
VAR
  I: LONGINT;
BEGIN
  WHILE NOT EOLN
  DO
    BEGIN
      READ(I);
      WRITE(F, I)
    END;
END;

VAR
  F: IntFile;
  CompI, I, Lhs, Rhs: LONGINT;
  PositionFound: BOOLEAN;
BEGIN
  ASSIGN(F, IntFileName);
  PositionFound := FALSE;
  REWRITE(F);
  CopyInputStringToFile(F);
  RESET(F);
   
  READ(CompI);
  IF FileSize(F) > 1
  THEN
    BEGIN
      Lhs := FileStart;
      Rhs := FileSize(F);
      WHILE NOT(PositionFound) AND (Rhs <> EmptyFile)
      DO
        BEGIN
          SEEK(F, Median(Lhs, Rhs));
          READ(F, I);
          IF Median(Lhs, Rhs) = Equality
          THEN
            IF CompI = I
            THEN
              BEGIN
                PositionFound := TRUE;
                WRITELN(Rhs)
              END
            ELSE
              BEGIN
                PositionFound := TRUE;
                WRITELN('-1')
              END
          ELSE 
            IF CompI < I
            THEN
              BEGIN
                Rhs := Median(Lhs, Rhs)
              END
            ELSE
              IF CompI > I
              THEN
                Lhs := Median(Lhs, Rhs)
              ELSE
                IF CompI = I
                THEN
                  BEGIN
                    PositionFound := TRUE;
                    WRITELN(Rhs)
                  END;
        END;
    END
  ELSE
    IF FileSize(F) = 1
    THEN
      BEGIN
        READ(F, I);
        IF CompI = I
        THEN
          WRITELN('1')
        ELSE
          WRITELN('-1')
      END
END.
