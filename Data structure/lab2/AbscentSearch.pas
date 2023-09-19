PROGRAM AbscentSearch(INPUT, OUTPUT);
CONST
  MaxByte = 255;
TYPE
  NumType = BYTE;
  FileType = FILE OF NumType;
FUNCTION Median(LHS, RHS: NumType): NumType;
BEGIN {Median}
  Median := (LHS + RHS) DIV 2
END;  {Median}

FUNCTION IsDigitInFile(VAR F: FileType; I1: NumType): BOOLEAN;
VAR
  I2: NumType;
  Found: BOOLEAN;
BEGIN {IsDigitInFile}
  Found := FALSE;
  WHILE NOT EOF(F) AND NOT Found
  DO
    BEGIN
      READ(F, I2);
      IF I1 = I2
      THEN
        Found := TRUE
    END;
  IsDigitInFile := Found 
END;  {IsDigitInFile}

FUNCTION CountQuantityOfLess(VAR F: FileType; Comparable: NumType): NumType;
VAR
  B, I, Quantity: NumType;
BEGIN {CountQuantity}
  Quantity := 0;
  FOR I := 0 TO MaxByte - 1
  DO
    BEGIN
      READ(F, B);
      IF B < Comparable
      THEN
        Quantity := Quantity + 1
    END;
    CountQuantityOfLess := Quantity;
  RESET(F)
END;  {CountQuantity}

PROCEDURE CopyInputToFile(VAR F: FileType);
VAR
  I: NumType;
BEGIN {CopyInputToFile}
  WHILE NOT EOLN
  DO
    BEGIN
      READ(I);
      WRITE(F, I)
    END;
END;  {CopyInputToFile}

VAR
  LHS, RHS: NumType;
  F: FileType;
BEGIN {AbscentSearch}
  REWRITE(F);
  CopyInputToFile(F);
  RESET(F);
  LHS := 0;
  RHS := MaxByte;
  WHILE LHS <> Median(LHS, RHS)
  DO
    IF CountQuantityOfLess(F, Median(LHS, RHS)) < Median(LHS, RHS)
    THEN
      RHS := Median(LHS, RHS)
    ELSE
      LHS := Median(LHS, RHS);
  RESET(F);
  IF IsDigitInFile(F, LHS)
  THEN
    WRITELN(LHS + 1)
  ELSE
    WRITELN(LHS)
END.  {AbscentSearch}
