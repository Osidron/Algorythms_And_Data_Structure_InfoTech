UNIT
  TreeUnit;
INTERFACE
PROCEDURE InsertCh(Ch: CHAR);
PROCEDURE InfixPrint;
PROCEDURE PrefixPrint;
PROCEDURE PostfixPrint;

IMPLEMENTATION
TYPE
  Tree = ^NodeType;
  NodeType = RECORD
               Key: CHAR;
               Left: Tree;
               Right: Tree
             END;

VAR
  Root: Tree;

PROCEDURE PrintInfixTree(Ptr: Tree);
BEGIN {PrintInfixTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintInfixTree(Ptr^.Left);
      WRITE(Ptr^.Key);
      PrintInfixTree(Ptr^.Right) 
    END
END;   {PrintInfixTree}

PROCEDURE InfixPrint;
BEGIN
  PrintInfixTree(Root)
END;

PROCEDURE PrintPostfixTree(Ptr: Tree);
BEGIN {PrintPostfixTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintPostfixTree(Ptr^.Left);
      PrintPostfixTree(Ptr^.Right);
      WRITE(Ptr^.Key); 
    END
END;   {PrintPostfixTree}

PROCEDURE PostfixPrint;
BEGIN
  PrintPostfixTree(Root)
END;

PROCEDURE PrintPrefixTree(Ptr: Tree);
BEGIN {PrintPrefixTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      WRITE(Ptr^.Key);
      PrintPrefixTree(Ptr^.Left);
      PrintPrefixTree(Ptr^.Right)  
    END
END;   {PrintPrefixTree}

PROCEDURE PrefixPrint;
BEGIN
  PrintPrefixTree(Root)
END;

PROCEDURE Insert(VAR Ptr: Tree; Data: CHAR);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Key := Data;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END
  ELSE
    BEGIN   
      IF Ptr^.Key > Data
      THEN
        Insert(Ptr^.Left, Data)
      ELSE
        Insert(Ptr^.Right, Data)
    END
END;   {Insert}

PROCEDURE InsertCh(Ch: CHAR);
BEGIN
  Insert(Root, Ch)
END;

BEGIN {Tree}
  Root := NIL
END.  {Tree}
