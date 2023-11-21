UNIT
  RedBlackTree;
INTERFACE
TYPE
  KeyType = INTEGER;
PROCEDURE InsertKey(Key: KeyType);
PROCEDURE PrintSorted;

IMPLEMENTATION
TYPE
  ColorType = (Black, Red);
  Tree = ^NodeType;
  NodeType = RECORD
               Left, Right: Tree;
               Key: KeyType;
               Color: ColorType
             END;
VAR
  Root: Tree;

PROCEDURE PrintNodeWithChildren(Ptr: Tree);
BEGIN
  IF Ptr^.Left <> NIL
  THEN
    WRITE(Ptr^.Left^.Key, ' <- ')
  ELSE
    WRITE('NIL <- ');
  WRITE(Ptr^.Key, ' -> ');
  IF Ptr^.Right <> NIL
  THEN
    WRITE(Ptr^.Right^.Key)
  ELSE
    WRITE('NIL');
END;

PROCEDURE PrintTree(Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(Ptr^.Left);
      WRITE('Key = ', Ptr^.Key);
      IF Ptr^.Color = Black
      THEN
        WRITE('; Color = Black | ')
      ELSE
        WRITE('; Color = Red   | ');
      PrintNodeWithChildren(Ptr);
      WRITELN;
      PrintTree(Ptr^.Right) 
    END
END;  {PrintTree}

PROCEDURE PrintSorted;
BEGIN
  PrintTree(Root)
END;

PROCEDURE RightSideTurn(VAR Ptr: Tree); {Правосторонний поворот}
VAR
  Temp: Tree;
BEGIN {RightSideTurn}
  IF Ptr <> NIL
  THEN
    IF Ptr^.Left <> NIL
    THEN
      IF Ptr^.Left^.Right <> NIL
      THEN
        BEGIN
          Temp := Ptr^.Left^.Right;
          Ptr^.Left^.Right := Ptr;
          Ptr := Ptr^.Left;
          Ptr^.Right^.Left := Temp 
        END
      ELSE
        BEGIN
          Temp := Ptr^.Left^.Right;
          Ptr^.Left^.Right := Ptr;
          Ptr := Ptr^.Left;
          Ptr^.Right^.Left := Temp 
        END
END;  {RightSideTurn}

PROCEDURE LeftSideTurn(VAR Ptr: Tree); {Левосторонний поворот}
VAR
  Temp: Tree;
BEGIN {LeftSideTurn}
  IF Ptr <> NIL
  THEN
    IF Ptr^.Right <> NIL
    THEN
      IF Ptr^.Right^.Left <> NIL
      THEN
        BEGIN
          Temp := Ptr^.Right^.Left;
          Ptr^.Right^.Left := Ptr;
          Ptr := Ptr^.Right;
          Ptr^.Left^.Right := Temp
        END
      ELSE  
        BEGIN
          Temp := Ptr^.Right^.Left;
          Ptr^.Right^.Left := Ptr;
          Ptr := Ptr^.Right;
          Ptr^.Left^.Right := Temp
        END
END;  {LeftSideTurn}

PROCEDURE Invert(VAR Color: ColorType); {Инверсия переменной цвета}
BEGIN
  IF Color = Black
  THEN
    Color := Red
  ELSE
    Color := Black
END;

PROCEDURE InvertNodeColors(VAR Ptr: Tree); {Инверсия цветов узла и его детей}
BEGIN {InvertNodeColors}
  Invert(Ptr^.Color);
  Invert(Ptr^.Left^.Color);
  Invert(Ptr^.Right^.Color)
END;  {InvertNodeColors}

FUNCTION IsThereAnyRedGrandSon(VAR Ptr: Tree): BOOLEAN;
BEGIN // ((Ptr^.Left^.Left <> NIL) OR (Ptr^.Left^.Right <> NIL) OR (Ptr^.Right^.Left <> NIL) OR (Ptr^.Right^.Right <> NIL))
  IF Ptr <> NIL
  THEN
    BEGIN
      IF Ptr^.Left <> NIL
      THEN
        BEGIN
          IF Ptr^.Left^.Left <> NIL
          THEN
            IF Ptr^.Left^.Left^.Color = Red
            THEN
              BEGIN
                IsThereAnyRedGrandSon := TRUE;
                EXIT
              END;
          IF Ptr^.Left^.Right <> NIL
          THEN
            IF Ptr^.Left^.Right^.Color = Red
            THEN
              BEGIN
                IsThereAnyRedGrandSon := TRUE;
                EXIT
              END 
        END;
      IF Ptr^.Right <> NIL
      THEN
        BEGIN
          IF Ptr^.Right^.Left <> NIL
          THEN
            IF Ptr^.Right^.Left^.Color = Red
            THEN
              BEGIN
                IsThereAnyRedGrandSon := TRUE;
                EXIT
              END;
          IF Ptr^.Right^.Right <> NIL
          THEN
            IF Ptr^.Right^.Right^.Color = Red
            THEN
              BEGIN
                IsThereAnyRedGrandSon := TRUE;
                EXIT
              END
        END
    END;
  IsThereAnyRedGrandSon := FALSE
END;

PROCEDURE BalanceTree(VAR Ptr: Tree); {Рекурсивная процедура балансировки К-Ч дерева}
BEGIN {BalanceTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      BalanceTree(Ptr^.Left);
      BalanceTree(Ptr^.Right);
      // Ситуация 1 | Red <- Red <- Black -> Black   (правый без перекараса)
      IF Ptr^.Left <> NIL
      THEN 
        IF Ptr^.Left^.Left <> NIL
        THEN
          IF (Ptr^.Left^.Color = Red) AND (Ptr^.Left^.Left^.Color = Red)
          THEN
            IF Ptr^.Right = NIL
            THEN
              BEGIN
                RightSideTurn(Ptr);
                Ptr^.Color := Black;
                Ptr^.Left^.Color := Red
              END
            ELSE
              IF Ptr^.Right^.Color = Black
              THEN
                BEGIN
                  RightSideTurn(Ptr);
                  Ptr^.Color := Black;
                  Ptr^.Left^.Color := Red
                END;
      // Ситуация 2 | Black <- Black -> Red -> Red   (левый с перекрасом в черный)
      IF Ptr^.Right <> NIL
      THEN
        IF Ptr^.Right^.Right <> NIL
        THEN
          IF (Ptr^.Right^.Color = Red) AND (Ptr^.Right^.Right^.Color = Red)
          THEN
            IF Ptr^.Left = NIL
            THEN  
              BEGIN
                LeftSideTurn(Ptr);
                Ptr^.Color := Black;
                Ptr^.Left^.Color := Red
              END
            ELSE
              IF Ptr^.Left^.Color = Black
              THEN
                BEGIN
                LeftSideTurn(Ptr);
                Ptr^.Color := Black;
                Ptr^.Left^.Color := Red 
                END;  
      // Ситуация 3 | (Red -> Red) <- Black -> Black (правый без перекраса и левый с перекрасом)
      IF Ptr^.Left <> NIL
      THEN
        IF Ptr^.Left^.Right <> NIL 
        THEN
          IF (Ptr^.Left^.Color = Red) AND (Ptr^.Left^.Right^.Color = Red)
          THEN
            IF Ptr^.Right = NIL
            THEN
              BEGIN
                LeftSideTurn(Ptr^.Left);
                RightSideTurn(Ptr);
                Ptr^.Color := Black;
                Ptr^.Right^.Color := Red
              END
            ELSE
              IF Ptr^.Right^.Color = Black
              THEN  
                BEGIN
                LeftSideTurn(Ptr^.Left);
                RightSideTurn(Ptr);
                Ptr^.Color := Black;
                Ptr^.Right^.Color := Red
                END;
      // Ситуация 4 | Black <- Black -> (Red <- Red) (левый с перекрасом и правый без перекраса после всех)
      IF Ptr^.Right <> NIL
      THEN
        IF Ptr^.Right^.Left <> NIL
        THEN
          IF (Ptr^.Right^.Color = Red) AND (Ptr^.Right^.Left^.Color = Red)
          THEN
            IF Ptr^.Left = NIL
            THEN
              BEGIN
                RightSideTurn(Ptr^.Right);
                Ptr^.Right^.Color := Black;
                LeftSideTurn(Ptr);
                Ptr^.Left^.Color := Red
              END
            ELSE
              IF Ptr^.Left^.Color = Black
              THEN
                BEGIN
                  RightSideTurn(Ptr^.Right);
                  Ptr^.Right^.Color := Black;
                  LeftSideTurn(Ptr);
                  Ptr^.Left^.Color := Red                     
                END;
      // Ситуация 5 | Red <- Black -> Red и хотя бы 1 сын любого сына - красный (инверсия)
      IF (Ptr^.Left <> NIL) AND (Ptr^.Right <> NIL) AND IsThereAnyRedGrandSon(Ptr)
      THEN
        IF (Ptr^.Left^.Color = Red) AND (Ptr^.Right^.Color = Red)
        THEN
          InvertNodeColors(Ptr)
    END 
END;  {BalanceTree} 

PROCEDURE Insert(VAR Ptr: Tree; Key: KeyType);  {Рекурсивная вставка нового элемента}
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Key := Key;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL;
      Ptr^.Color := RED;
      BalanceTree(Root);
      Root^.Color := Black;
      PrintSorted;
      WRITELN;
    END
  ELSE
    BEGIN   
      IF Ptr^.Key > Key
      THEN
        Insert(Ptr^.Left, Key)
      ELSE
        IF Ptr^.Key <> Key
        THEN
          Insert(Ptr^.Right, Key)
    END
END;   {Insert}

PROCEDURE InsertKey(Key: KeyType);            {Начало для рекурсивной вставки нового элемента}
BEGIN
  Insert(Root, Key)
END;                                                                                                                                    

BEGIN
  Root := NIL
END.