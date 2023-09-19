UNIT
  Stack;
INTERFACE
TYPE
  DataType = INTEGER;

FUNCTION IsStackEmpty: BOOLEAN;
PROCEDURE Push(D: DataType);
FUNCTION Pop: DataType;
FUNCTION CheckHead: DataType;
  
IMPLEMENTATION
TYPE
  StackPtr = ^StackType;
  StackType = RECORD
                Next: StackPtr;
                Data: DataType
              END;

VAR
  HeadPtr, Ptr: StackPtr;
  
FUNCTION IsStackEmpty: BOOLEAN;
BEGIN {IsStackEmpty}
  IsStackEmpty := FALSE;
  IF HeadPtr = NIL
  THEN
    IsStackEmpty := TRUE
END;  {IsStackEmpty}

PROCEDURE Push(D: DataType);
BEGIN {Push}
  NEW(Ptr);
  Ptr^.Next := HeadPtr;
  Ptr^.Data := D;
  HeadPtr := Ptr
END;  {Push}

FUNCTION CheckHead: DataType;
BEGIN {CheckTop}
  IF NOT IsStackEmpty
  THEN
    CheckHead := HeadPtr^.Data
END;   {CheckTop}

FUNCTION Pop: DataType;
BEGIN {Pop}
  IF NOT IsStackEmpty
  THEN
    BEGIN 
      Pop := HeadPtr^.Data;
      HeadPtr := HeadPtr^.Next
    END   
END;  {Pop}

PROCEDURE InitStack;
BEGIN {InitStack}
  HeadPtr := NIL
END;   {InitStack}

BEGIN {Stack}
  InitStack
END.  {Stack}
