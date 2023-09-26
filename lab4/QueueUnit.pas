UNIT
  QueueUnit;
INTERFACE
TYPE
  TQueueValue = INTEGER;
FUNCTION Pop: TQueueValue;
PROCEDURE Push(Value: TQueueValue);
FUNCTION IsQueueEmpty: BOOLEAN;

IMPLEMENTATION
TYPE
  TPtr = ^TPointerValue;
  TPointerValue = RECORD
                    Value: TQueueValue;
                    Prev: TPtr
                  END;

VAR
  Tail, Head, Ptr: TPtr;
  
FUNCTION IsQueueEmpty: BOOLEAN;
BEGIN
  IF Head = NIL
  THEN
    IsQueueEmpty := TRUE
  ELSE
    IsQueueEmpty := FALSE
END;

FUNCTION Pop: TQueueValue;
BEGIN
  Pop := Head^.Value;
  Ptr := Head;
  Head := Head^.Prev;
  DISPOSE(Ptr)
END;

PROCEDURE Push(Value: TQueueValue);
BEGIN
  NEW(Ptr);
  Ptr^.Value := Value;
  Ptr^.Prev := NIL;
  IF IsQueueEmpty
  THEN
    BEGIN
      Head := Ptr;
      Tail := Ptr;
      Tail^.Prev := NIL;
      Head^.Prev := NIL
    END
  ELSE
    BEGIN
      Tail^.Prev := Ptr;
      Tail := Ptr 
    END
END;

BEGIN
  Tail := NIL;
  Head := NIL
END.
