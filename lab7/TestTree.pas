PROGRAM TestTree(INPUT, OUTPUT);
USES
  TreeUnit;
VAR
  Ch: CHAR;
  F: TEXT;
BEGIN
  ASSIGN(F, 'test.txt');
  REWRITE(F);
  WHILE NOT EOF AND NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(F, Ch);
      InsertCh(Ch)
    END;
  WRITELN;
  WRITELN('Infix notation');
  InfixPrint;
  WRITELN;
  WRITELN('Postfix notation') ;
  PostfixPrint;
  WRITELN;
  WRITELN('Prefix notation');
  PrefixPrint
END.