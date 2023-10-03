UNIT
  PriorityQueueUnit;
INTERFACE
TYPE
  TQueueValue = INTEGER;
FUNCTION Pop: TQueueValue;
PROCEDURE Push(Value: TQueueValue);
FUNCTION IsQueueEmpty: BOOLEAN;
PROCEDURE SwapPriority(Value, Priority: INTEGER);

IMPLEMENTATION
CONST
  LowPriority = 1;
TYPE
  TPtr = ^TPointerValue;
  TPointerValue = RECORD
                    Value: TQueueValue;
                    Priority: INTEGER;
                    Prev: TPtr
                  END;

VAR
  Tail, Head: TPtr;
  
FUNCTION IsQueueEmpty: BOOLEAN;
BEGIN
  IF Head = NIL
  THEN
    IsQueueEmpty := TRUE
  ELSE
    IsQueueEmpty := FALSE
END;

FUNCTION Pop: TQueueValue;
VAR
  Ptr: TPtr;
BEGIN
  Pop := Head^.Value;
  Ptr := Head;
  Head := Head^.Prev;
  DISPOSE(Ptr)
END;

PROCEDURE Push(Value: TQueueValue);
VAR
  Ptr: TPtr;
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
      Tail^.Priority := LowPriority;
      Head^.Prev := NIL;
      Head^.Priority := LowPriority
    END
  ELSE
    BEGIN
      Ptr^.Priority := Tail^.Priority + 1;
      Tail^.Prev := Ptr;
      Tail := Ptr;
      Tail^.Prev := NIL; 
    END
END;

PROCEDURE SwapPriority(Value, Priority: INTEGER);
VAR
  FoundQueueValue, PriorityDone, NoMatches: BOOLEAN;
  Ptr1, Ptr2: TPtr;
BEGIN
  FoundQueueValue := FALSE;
  PriorityDone := FALSE;
  NoMatches := FALSE;
  IF Head <> NIL
  THEN
    BEGIN
      Ptr1 := Head;
      IF Ptr1^.Value <> Value
      THEN
        WHILE (NOT FoundQueueValue) AND (NOT NoMatches) 
        DO
          IF Ptr1^.Prev <> NIL
          THEN {���� ᮢ������� �� ���祭��}
            IF Value = Ptr1^.Prev^.Value
            THEN {���祭�� �������}
              BEGIN 
                FoundQueueValue := TRUE;
                Ptr2 := Ptr1^.Prev; {���⠥� ����� �� ��।� � ������� �裡 �ᥤ�� ��� � ��㣮�}
                IF Ptr1^.Prev = Tail
                THEN
                  Tail := Ptr1;
                Ptr1^.Prev := Ptr1^.Prev^.Prev;
                Ptr2^.Priority := Priority
              END
            ELSE {�������� �� ��।�}
              Ptr1 := Ptr1^.Prev
          ELSE {�� ����� �� ��諨 ᮢ������� �� ���祭��}
            NoMatches := TRUE
      ELSE
        BEGIN
          FoundQueueValue := TRUE;
          Ptr2 := Ptr1;
          Ptr2^.Priority := Priority;
          Head := Ptr1^.Prev
        END
    END
  ELSE
    NoMatches := True;
  IF NOT NoMatches
  THEN {�� ��諨 ᮢ�������}
    BEGIN
      Ptr1 := Head;
      IF Head^.Priority <= Ptr2^.Priority
      THEN {������ ࠢ�� �� �ਮ��� ��� �ਮ��⭥� �����}
        BEGIN 
          WHILE (NOT PriorityDone) AND (Ptr1^.Prev <> NIL)
          DO
            BEGIN
              IF Ptr1^.Prev^.Priority <= Priority
              THEN {�������� �� ��।�}
                Ptr1 := Ptr1^.Prev
              ELSE
                BEGIN {������� ���� ��� �ᯮ������� �����}
                  PriorityDone := TRUE;
                  Ptr2^.Prev := Ptr1^.Prev; {��⠢�� ����� � ���������� �� ���� �痢� � �ᥤﬨ}
                  Ptr1^.Prev := Ptr2
                END
            END;
          IF Ptr1^.Prev = NIL {Ptr2 �������� �ਮ����}
          THEN
            BEGIN
              Tail := Ptr2;
              Ptr1^.Prev := Ptr2;
              Tail^.Prev := NIL
            END
        END
      ELSE {������� �ਮ�⭥� ������}
        BEGIN
          Head := Ptr2;
          Ptr2^.Prev := Ptr1
        END
    END   
END;

BEGIN
  Tail := NIL;
  Head := NIL
END.
