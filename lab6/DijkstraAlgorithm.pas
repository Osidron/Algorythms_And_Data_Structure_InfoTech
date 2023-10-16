PROGRAM DijkstraAlgorythm(INPUT, OUTPUT);
USES
  Stack;
CONST
  Digit = ['a' .. 'z', 'A' .. 'Z'];
  Sign = ['+', '-', '*', '/', '^'];
  Brackets = ['(', ')'];
  LeftAssociative = ['+', '-', '*', '/'];
  RightAssociative = ['^'];
FUNCTION PrioritySign(Ch1, Ch2: CHAR): SHORTINT; {-1 - Ch1 < Ch2, 0 - Ch1 = Ch2, 1 - Ch1 > Ch2}
CONST
  FirstPriority = ['^'];
  SecondPriority = ['*', '/'];
  ThirdPriority = ['+', '-'];
BEGIN
  IF ((Ch1 IN ThirdPriority) AND ((Ch2 IN SecondPriority) OR (Ch2 IN FirstPriority))) OR ((Ch1 IN SecondPriority) AND (Ch2 IN FirstPriority))
  THEN
    PrioritySign := -1;
  IF ((Ch2 IN ThirdPriority) AND ((Ch1 IN SecondPriority) OR (Ch1 IN FirstPriority))) OR ((Ch2 IN SecondPriority) AND (Ch1 IN FirstPriority))
  THEN
    PrioritySign := 1; 
  IF ((Ch1 = Ch2) AND (Ch1 IN Sign)) OR ((Ch1 IN FirstPriority) AND (Ch2 IN FirstPriority)) OR ((Ch1 IN SecondPriority) AND (Ch2 IN SecondPriority)) OR ((Ch1 IN ThirdPriority) AND (Ch2 IN ThirdPriority))
  THEN
    PrioritySign := 0                                                                                                                               
END;

VAR
  Ch: CHAR;
  IsActionMade: BOOLEAN;  
BEGIN                                                                                                                                                        
//UnaryMinusCheck(F);                                                                                                                                                 
  WHILE NOT EOF AND NOT EOLN                                                                                                                                 
  DO                                                                                                                                                         
    BEGIN                                                                                                                                                    
      IsActionMade := FALSE;                                                                                                                                 
      READ(Ch);                                                                                                                                              
      IF Ch IN Digit                                                                                                                                         
      THEN                                                                                                                                                   
        WRITE(Ch);                                                                                                                                           
      IF NOT IsStackEmpty AND (PrioritySign(Ch, CheckHead) = 1) AND (CheckHead IN Sign) AND (Ch IN Sign) AND (IsActionMade = FALSE)                          
      THEN                                                                                                                                                   
        BEGIN                                                                                                                                                
          Push(Ch);                                                                                                                                          
          IsActionMade := TRUE                                                                                                                               
        END;                                                                                                                                                 
      IF (IsStackEmpty OR (NOT IsStackEmpty AND (CheckHead = '('))) AND (Ch IN Sign) AND (IsActionMade = FALSE)                                              
      THEN                                                                                                                                                   
        BEGIN                                                                                                                                                
          Push(Ch);                                                                                                                                          
          IsActionMade := TRUE                                                                                                                               
        END;                                                                                                                                                 
      IF (Ch IN LeftAssociative) AND (CheckHead IN Sign) AND (PrioritySign(Ch, CheckHead) <= 0) AND (NOT IsStackEmpty) AND (IsActionMade = FALSE)            
      THEN                                                                                                                                                   
        BEGIN                                                                                                                                                
          IsActionMade := TRUE;                                                                                                                              
          WHILE (CheckHead <> '(') AND (PrioritySign(Ch, CheckHead) <= 0) AND NOT IsStackEmpty                                                               
          DO                                                                                                                                                 
            WRITE(Pop);                                                                                                                                      
          Push(Ch)                                                                                                                                           
        END;                                                                                                                                                 
      IF (Ch IN RightAssociative) AND (CheckHead IN Sign) AND (PrioritySign(Ch, CheckHead) <= 0) AND (NOT IsStackEmpty) AND (IsActionMade = FALSE)           
      THEN                                                                                                                                                   
        BEGIN                                                                                                                                                
          IsActionMade := TRUE;                                                                                                                              
          WHILE (CheckHead <> '(') AND (PrioritySign(Ch, CheckHead) > 0) AND NOT IsStackEmpty                                                                
          DO                                                                                                                                                 
            WRITE(Pop);                                                                                                                                      
          Push(Ch)                                                                                                                                           
        END;                                                                                                                                                 
      IF Ch = '('                                                                                                                                            
      THEN                                                                                                                                                   
        Push(Ch);                                                                                                                                            
      IF Ch = ')'                                                                                                                                            
      THEN                                                                                                                                                   
        BEGIN                                                                                                                                                
          WHILE CheckHead <> '('                                                                                                                             
          DO                                                                                                                                                 
            WRITE(Pop);                                                                                                                                      
          Pop                                                                                                                                                
        END                                                                                                                                                  
    END;                                                                                                                                                     
  WHILE NOT IsStackEmpty                                                                                                                                     
  DO
    WRITE(Pop);
  WRITELN
END.