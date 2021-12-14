;********************************************************************
;
; Author        : Pal Eagleson
;
; Date          : 12 September  2021�.
;
; File          : KVART100.asm
;
; Hardware      : ��89C51RD2
;
; Description   :��������� # � ����� ������ � ������� �������� ��� �������� ��������(������)
;                 
;               :��������� �������� � 3 ��� ����� �������� �����
;********************************************************************
$MOD52                          ; use 8052 predefined symbols


;____________________________________________________________________
;������������� ���������:
;R0 
;R1 
;R2 
;R3 
;R4 
;R5 
;R6 
;R7 
;B
;____________________________________________________________________
;������������� ��������:
;T0 
;�1 
;	
;
;
;
;____________________________________________________________________
; MAIN PROGRAM
CSEG	#0afffh			;��������� ���������� ������ ��������
ORG  0000h
	  jmp	start		;

ORG  0003h	

ORG  000bh			

ORG  0013h	

ORG  001bh	
	
ORG  0023h
				
ORG  0040h			




start:       mov     r7,#0feh        ;1 ���� ������ DISP
init:        mov     P0,#01h	     ;2   ������� ������� ������ � ������
	     lcall   disp_wcomm      ;3   ����� ������������ ������ ������� � �������
             mov     p0,#02h         ;4  
	     lcall   disp_wcomm      ;5
             mov     p0,#0ch         ;6
             lcall   disp_wcomm      ;7
             mov     p0,#038h        ;8 ������� 8 ��� 2 ������ ����� 5x7
             lcall   disp_wcomm      ;9
             djnz    r7,init	     ;10
             mov     r7,#0bfh         ;1 ������� indirect RAM ������ ������� ��. 
             mov     r0,#040h         ;2 ��������� � ������  20h
resetram:    mov     @r0,#020h        ;3 ��������� ������������� �������� r0
             inc     r0               ;4
             djnz    r7,resetram      ;5
             mov     r7,#028h         ;1 ������� indirect RAM ������ ������� ��. 
             mov     r0,#0d8h         ;2 ��������� � ������  20h
resetram1a:  mov     @r0,#020h        ;3 ��������� ������������� �������� r0
             inc     r0               ;4
             djnz    r7,resetram1a    ;5
             mov     r7,#00ah         ;1 ������� indirect RAM ������ � ������ 0b0h
             mov     r0,#0b0h         ;2 ��������� � ������  030h
resetram1:   mov     @r0,#030h        ;3 ��������� ������������� �������� r0
             inc     r0               ;4
             djnz    r7,resetram1     ;5
             mov     r7,#008h         ;1 ������� indirect RAM ������ � ������ 0c0h
             mov     r0,#0c0h         ;2 ��������� � NO   04eh
resetram2:   mov     @r0,#04eh        ;3 ��������� ������������� �������� r0
             inc     r0               ;4
             djnz    r7,resetram2     ;5
             mov     p0,#000h           ;1��������� �������� ��� � 00  
             mov     p1,#0a0h           ;2
             mov     p1,#0b0h           ;3
             mov     009h,#000h             ;������ ������ ����������� � 0
             setb    p1.7                     ;��������� ���������������� � ������� �����
             jnb     p2.0,eagle                             ;1 ���� � ����� ���� ������ ������ ������� !!! ���� ��!!!
             ljmp    abcde
eagle:       jnb     p2.1,eagle1                            ;2
             ljmp    abcde
eagle1:      mov     p0,#001h       
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h                                ;  ����� ������ ���� ������ ������� !!!.
             mov     dptr,#tprobe            
eagle11:     mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,eagle11
             lcall   sek
             lcall   sek






abcde:        mov    p0,#050h                            ;
              lcall   disp_wcomm                         ;���������������� ��������������� ��� ������ ��������� 8
              mov     p0,#0fbh                           ;��� �������    #002h
              lcall   disp_wdata                         ;
              mov     p0,#051h                           ;
              lcall   disp_wcomm
              mov     p0,#0f5h
              lcall   disp_wdata
              mov     p0,#052h
              lcall   disp_wcomm
              mov     p0,#0f5h
              lcall   disp_wdata
              mov     p0,#053h
              lcall   disp_wcomm
              mov     p0,#0fbh
              lcall   disp_wdata
              mov     p0,#054h
              lcall   disp_wcomm
              mov     p0,#0f5h
              lcall   disp_wdata
              mov     p0,#055h
              lcall   disp_wcomm
              mov     p0,#0f5h
              lcall   disp_wdata
              mov     p0,#056h
              lcall   disp_wcomm
              mov     p0,#0fbh
              lcall   disp_wdata
               mov    p0,#057h
              lcall   disp_wcomm
              mov     p0,#0ffh                           ;
              lcall   disp_wdata                         ;
              mov     r0,#0b1h                      ;��������������� ��������� �� ��� ���� =10���
              mov     @r0,#031h                             ;
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              inc     r0                                    ;
              mov     @r0,#032h                 ;��������������� ��������� �� 2�� ��� ���� =20���
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              inc     r0                                    ;
              mov     @r0,#031h                 ;��������������� ��������� �� ������ =10���
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              mov     r0,#0c1h                  ;��������������� ��������� �������� ����  "Y"  
              mov     @r0,#059h                             ; 
             mov     r0,#080h        ;1 ������ � ������ ������������� ����. � ���. � ������ #080h 
             mov     dptr,#tpredust  
predust:     mov     a,#00h
             movc    a,@a+dptr
             mov     @r0,a
             inc     dptr
             inc     r0
             mov     a,#00h
             movc    a,@a+dptr
             cjne    a,#0ffh,predust ;8
             mov     r0,#080h        ;�����. �� ��������� ������ �������� ������� ������� � ���� 
             mov     030h,@r0                        ;��� ���������
             inc     r0
             mov     031h,@r0
             inc     r0
             mov     032h,@r0
             inc     r0
             mov     033h,@r0
             inc     r0
             mov     034h,@r0
             inc     r0
             inc     r0
             inc     r0
             mov     035h,@r0
             inc     r0
             mov     036h,@r0
             mov     r0,#090h
             mov     037h,@r0
             inc     r0
             mov     038h,@r0 
             mov     r0,#099h
             mov     039h,@r0
             inc     r0
             mov     03ah,@r0
             mov     r0,#0a2h
             mov     03bh,@r0
             inc     r0
             mov     03ch,@r0
             mov     r0,#0abh
             mov     03dh,@r0
             inc     r0
             mov     03eh,@r0
             mov     r1,#022h                ; ������������� ����� - ��. �
             mov     @r1,#041h 



func1:       mov     p0,#001h       ;������� ����� ��. 1
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     p0,#000h                                 ;��������� ���� � 000
             mov     p1,#090h
             mov     p1,#0b0h
             mov     r7,#80h                    ;  ����� ������ �����.
             mov     dptr,#tnomer1            
func11:      mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,func11
             dec     r7
             mov     dptr,#tab
func12:      mov     p0,r7                      
             lcall   disp_wcomm             
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,func12
             dec     r7
             mov     p0,r7
             lcall   disp_wcomm
             mov     p0,#031h                    ;����� ����� 1 � ����� ������ 1
             lcall   disp_wdata
kf00:        jnb     p2.2,kf00            ;1 �������� ������� ������
             jnb     p2.4,kf00            ;2
kf001:       jnb     p2.4,funca2          ;1 �������� ������� ������
             jnb     p2.2,nomer           ;2
             ajmp    kf001                ;3
funca2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    func2
nomer:                                ;���� ������ ��������
             mov     p0,#01h              ;1  ������� DISP
             lcall   disp_wcomm           ;2
             mov     p0,#00ch             ;3 �������� DISP
             lcall   disp_wcomm
             mov     r0,#040h                  ;  ��������� ��������� ������ ������ ������ �� DISP
             mov     r1,#040h                  ;  ��������� ��������� ������ � ������ ������
             mov     dptr,#tcifr               ;  ����� 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    func1
func2:      mov     p0,#01h        ;������� ����� ��. 2
            lcall   disp_wcomm
            mov     p0,#00ch                                                    
            lcall   disp_wcomm
            mov     r7,#80h               ;����� ������ �����
            mov     p0,r7
            lcall   disp_wcomm
            mov     dptr,#tnomer1            
func22:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func22
            dec     r7
            mov     dptr,#tab             ;����� ������ �� 
func23:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func23
            dec     r7
            mov     p0,r7                 ;����� ����� 2 � ����� ������ 1
            lcall   disp_wcomm             
            mov     p0,#032h
            lcall   disp_wdata           
                                  
kf2:        jnb     p2.2,kf2
            jnb     p2.4,kf2
kf21:       jnb     p2.2,nomer1
            jnb     p2.4,funca3
            ajmp    kf21 
funca3:     mov     p0,#00ch
            lcall   disp_wcomm
            ljmp    funca2b
nomer1:                                ;���� ������ ��������
             mov     p0,#001h                  ;1  ������� DISP
             lcall   disp_wcomm                ;2
             mov     p0,#008h                  ;3 �������� DISP
             lcall   disp_wcomm
             mov     r0,#058h                  ;  ��������� ��������� ������ ������ ������ �� DISP
             mov     r1,#058h                  ;  ��������� ��������� ������ � ������ ������
             mov     dptr,#tcifr               ;  ����� 
             lcall   vyv3
             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    func2


funca2b:       mov     p0,#001h     ;������� ����� ��. 3
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h              ;����� ������ �����.
             mov     dptr,#tnomer1            
funcb11:      mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,funcb11
             dec     r7
             mov     dptr,#tab
funcb12:      mov     p0,r7                      
             lcall   disp_wcomm             
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,funcb12
             dec     r7
             mov     p0,r7
             lcall   disp_wcomm
             mov     p0,#033h             ;����� ����� 3 � ����� ������ 1
             lcall   disp_wdata
kfb00:        jnb     p2.2,kfb00              ;1 �������� ������� ������
             jnb     p2.4,kfb00               ;2
kfb001:       jnb     p2.4,funcab2            ;1 �������� ������� ������
             jnb     p2.2,nomerb              ;2
             ajmp    kfb001                   ;3
funcab2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    funca2g
nomerb:                                ;���� ������ ��������
             mov     p0,#01h                  ;1  ������� DISP
             lcall   disp_wcomm               ;2
             mov     p0,#00ch                 ;3 �������� DISP
             lcall   disp_wcomm
             mov     r0,#0d0h                 ;  ��������� ��������� ������ ������ ������ �� DISP
             mov     r1,#0d0h                 ;  ��������� ��������� ������ � ������ ������
             mov     dptr,#tcifr              ;  ����� 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    funca2b


funca2g:       mov     p0,#001h    ;������� ����� ��. 4
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h                 ;����� ������ �����.
             mov     dptr,#tnomer1            
funcg11:      mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,funcg11
             dec     r7
             mov     dptr,#tab
funcg12:      mov     p0,r7                      
             lcall   disp_wcomm             
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             cjne    a,#0ffh,funcg12
             dec     r7
             mov     p0,r7
             lcall   disp_wcomm
             mov     p0,#034h               ;����� ����� 4 � ����� ������ 1
             lcall   disp_wdata
kfg00:        jnb     p2.2,kfg00               ;1 �������� ������� ������
             jnb     p2.4,kfg00                ;2
kfg001:       jnb     p2.4,funcag2             ;1 �������� ������� ������
             jnb     p2.2,nomerg               ;2
             ajmp    kfg001                    ;3
funcag2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    func3
nomerg:                                 ;���� ������ ��������
             mov     p0,#01h                   ;1  ������� DISP
             lcall   disp_wcomm                ;2
             mov     p0,#00ch                  ;3 �������� DISP
             lcall   disp_wcomm
             mov     r0,#0e8h                  ;  ��������� ��������� ������ ������ ������ �� DISP
             mov     r1,#0e8h                  ;  ��������� ��������� ������ � ������ ������
             mov     dptr,#tcifr               ;  ����� 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    funca2g

;funca2d:       mov     p0,#001h       ;������� ����� ��. �
;             lcall   disp_wcomm
;             mov     p0,#00ch                                                  
;             lcall   disp_wcomm
;             mov     r7,#80h                ;����� ������ �����.
;             mov     dptr,#tnomer1            
;funcd11:      mov     p0,r7
;             lcall   disp_wcomm
;             mov     a,#00h
;             movc    a,@a+dptr
;             mov     p0,a
;             lcall   disp_wdata
;             inc     dptr
;             inc     r7
;             cjne    a,#0ffh,funcd11
;             dec     r7
;             mov     dptr,#tab
;funcd12:      mov     p0,r7                      
;             lcall   disp_wcomm             
;             mov     a,#00h
;             movc    a,@a+dptr
;             mov     p0,a
;             lcall   disp_wdata
;             inc     dptr
;             inc     r7
;             cjne    a,#0ffh,funcd12
;             dec     r7
;             mov     p0,r7
;             lcall   disp_wcomm
;             mov     p0,#0e0h               ;����� �����  � � ����� ������ 1
;             lcall   disp_wdata
;kfd00:        jnb     p2.2,kfd00                  ;1 �������� ������� ������
;             jnb     p2.4,kfd00                   ;2
;kfd001:       jnb     p2.4,funcad2                ;1 �������� ������� ������
;             jnb     p2.2,nomerd                  ;2
;             ajmp    kfd001                       ;3
;funcad2:      mov     p0,#00ch                                                    
;             lcall   disp_wcomm
;             mov     p0,#001h
;             lcall   disp_wcomm
;             ljmp    func3
;nomerd:                                 ;���� ������ ��������
;             mov     p0,#01h                      ;1  ������� DISP
;             lcall   disp_wcomm                   ;2
;             mov     p0,#00ch                     ;3 �������� DISP
;             lcall   disp_wcomm
;             mov     r0,#0d8h                     ;  ��������� ��������� ������ ������ ������ �� DISP
;             mov     r1,#0d8h                     ;  ��������� ��������� ������ � ������ ������
;             mov     dptr,#tcifr                  ;  ����� 
;             lcall   vyv3
;
;             mov     p0,#00ch
;             lcall   disp_wcomm
;             ljmp    funca2d







func3:      mov     p0,#01h          ;���� � ��� 
            lcall   disp_wcomm
            mov     p0,#00ch          
            lcall   disp_wcomm
            mov     r7,#80h                  ;����� ������ ���� � ��� 
            mov     dptr,#tdlit            
func30:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func30
            mov     r7,#0c0h                 ;����� ������ ���������� 
            mov     dptr,#tsoed            
func31:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func31

kfa3:       jnb     p2.2,kfa3
            jnb     p2.4,kfa3
kfa31:      jnb     p2.2,dat
            jnb     p2.4,func32
            ajmp    kfa31
func32:     mov     p0,#001h                                                    
            lcall   disp_wcomm
            mov     p0,#00ch
            lcall   disp_wcomm
            ljmp    func4
dat:         mov     r0,#080h                        ;��������� � ������ ��������� �������� ������� ������� � ���� 
             mov     @r0,030h                        ;��� ��������� ,����������� �� ��������� ������
             inc     r0
             mov     @r0,031h
             inc     r0
             mov     @r0,032h
             inc     r0
             mov     @r0,033h
             inc     r0
             mov     @r0,034h
             inc     r0
             inc     r0
             inc     r0
             mov     @r0,035h
             inc     r0
             mov     @r0,036h
             mov     r0,#090h
             mov     @r0,037h
             inc     r0
             mov     @r0,038h 
             mov     r0,#099h
             mov     @r0,039h
             inc     r0
             mov     @r0,03ah
             mov     r0,#0a2h
             mov     @r0,03bh
             inc     r0
             mov     @r0,03ch
             mov     r0,#0abh
             mov     @r0,03dh
             inc     r0
             mov     @r0,03eh 
             mov     p0,#001h                    ;��������� ������� � ������ ����� ������ ������ ���� �������� 1
             lcall   disp_wcomm
             mov     p0,#00eh                    ;�������� disp � ������
             lcall   disp_wcomm
             mov     r0,#080h
             mov     r1,#080h
             lcall   data11
             mov     r0,#080h                        ;��������� �� ��������� ������ ��������� �������� ������� ������� � 
             mov     030h,@r0                        ;��� ���������
             inc     r0
             mov     031h,@r0
             inc     r0
             mov     032h,@r0
             inc     r0
             mov     033h,@r0
             inc     r0
             mov     034h,@r0
             inc     r0
             inc     r0
             inc     r0
             mov     035h,@r0
             inc     r0
             mov     036h,@r0
             mov     p0,#001h                    ;��������� ������� � ������ ����� ������ ������ ���� �������� 2
             lcall   disp_wcomm
             mov     p0,#00eh                    ;�������� disp � ������
             lcall   disp_wcomm
             mov     r0,#089h
             mov     r1,#089h
             lcall   data11 
             mov     r0,#090h                         ;��������� �� ��������� ������ ��������� �������� ��� ���������
             mov     037h,@r0
             inc     r0
             mov     038h,@r0
             mov     p0,#001h                    ;��������� ������� � ������ ����� ������ ������ ���� �������� 3
             lcall   disp_wcomm
             mov     p0,#00eh                    ;�������� disp � ������
             lcall   disp_wcomm
             mov     r0,#092h
             mov     r1,#092h
             lcall   data11
             mov     r0,#099h                         ;��������� �� ��������� ������ ��������� �������� ��� ���������
             mov     039h,@r0
             inc     r0
             mov     03ah,@r0
             mov     p0,#001h                    ;��������� ������� � ������ ����� ������ ������ ���� �������� 4
             lcall   disp_wcomm
             mov     p0,#00eh                    ;�������� disp � ������
             lcall   disp_wcomm
             mov     r0,#09bh
             mov     r1,#09bh
             lcall   data11
             mov     r0,#0a2h                         ;��������� �� ��������� ������ ��������� �������� ��� ���������
             mov     03bh,@r0
             inc     r0
             mov     03ch,@r0
             mov     p0,#001h                    ;��������� ������� � ������ ����� ������ ������ ���� �������� 5
             lcall   disp_wcomm
             mov     p0,#00eh                    ;�������� disp � ������
             lcall   disp_wcomm
             mov     r0,#0a4h
             mov     r1,#0a4h
             lcall   data11
             mov     r0,#0abh                          ;��������� �� ��������� ������ ��������� �������� ��� ���������
             mov     03dh,@r0
             inc     r0
             mov     03eh,@r0
             mov     p0,#00ch                    ;�������� disp � ���� ������
             lcall   disp_wcomm
             ljmp    func3
   
            
            
            
            
             
func4:      mov     p0,#01h          ;������� �� 4 =) �� 1
            lcall   disp_wcomm
            mov     r7,#80h                   ;  ����� ������  �� 4 =) �� 1 
            mov     dptr,#tab            
func400:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func400
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#031h
            lcall   disp_wdata
            inc     r7
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#03dh
            lcall   disp_wdata
            inc     r7
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#03eh
            lcall   disp_wdata
            inc     r7
            mov     dptr,#tab
func401:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func401
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#034h
            lcall   disp_wdata
            inc     r7
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#020h
            lcall   disp_wdata
            inc     r7
            mov     p0,r7
            lcall   disp_wcomm
            mov     p0,#03fh
            lcall   disp_wdata
             mov     r0,#0c0h
             mov     r1,#0c0h            
             mov     p0,#0c0h                 ; ����� � ������ ������ ������           
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
kfa44:  ;    
             jnb     p2.2,kfa44
             jnb     p2.4,kfa44
kfa45:  ;     
             jnb     p2.2,func42
             jnb     p2.4,func45
             ajmp    kfa45             
func42:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#059h
             lcall   disp_wdata
             mov     @r1,#059h
kfa46:       jnb     p2.2,kfa46
             jnb     p2.4,kfa46
kfa47:   
             jnb     p2.2,func43
             jnb     p2.4,func45
             ajmp    kfa47         
func43:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#04eh
             lcall   disp_wdata
             mov     @r1,#04eh
kfa48:  
             jnb     p2.2,kfa48
             jnb     p2.4,kfa48
kfa49:    
             jnb     p2.2,func42
             jnb     p2.4,func45
             ajmp    kfa49         
func45: 
             mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm


            mov     p0,#001h            ;�� ����� ��
            lcall   disp_wcomm
            mov     p0,#00ch            ;���� ������
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ �� 
            mov     dptr,#tozid            
func50:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func50
            dec     r7                       ;  ����� ������ ����� �� 
            mov     dptr,#totvet            
func51:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func51
            mov     r0,#0b1h                 ; ����� ������ ������� �����
            mov     r1,#0b2h                 ; ����� ������ ������� ����� 
            cjne    @r0,#030h,func502               ; �������� � ������� ���� ���� ���� �� ������� N  � ���� ����� 
            cjne    @r1,#030h,func502
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa50:     ;  mov     r6,#080h        ;  ���� �������� ������� ������
;waitkfa50:   djnz    r6,waitkfa50	    
             jnb     p2.2,kfa50
             jnb     p2.4,kfa50
kfa51:      ; mov     r6,#080h        ; ���� �������� ������� ������
;waitkfa510:  djnz    r6,waitkfa510	    
             jnb     p2.2,func502
             jnb     p2.4,func59
             ajmp    kfa51
func502:     lcall   func52
func59:  ;    mov     p0,#001h            ;�������� disp � ������
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm




          
;func6
            mov     p0,#01h               ;�� 2 �� ��� ��
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ �� 
            mov     dptr,#tozid            
func60:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func60
            dec     r7                       ;  ����� ������ 2�� ��� 
            mov     dptr,#t2otv            
func61:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func61
            mov     r0,#0b3h                 ; ����� ������ ������� �����
            mov     r1,#0b4h                 ; ����� ������ ������� ����� 
            cjne    @r0,#030h,func602               ; �������� � ������� ���� ���� ���� �� ������� N  � ���� ����� 
            cjne    @r1,#030h,func602
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa60:      ; mov     r6,#080h        ;  ���� �������� ������� ������
;waitkfa60:   djnz    r6,waitkfa60	    
             jnb     p2.2,kfa60
             jnb     p2.4,kfa60
kfa61:   ;    mov     r6,#080h        ; ���� �������� ������� ������
;waitkfa610:  djnz    r6,waitkfa610	    
             jnb     p2.2,func602
             jnb     p2.4,func69
             ajmp    kfa61
func602:     lcall   func52
func69:  ;    mov     p0,#001h            ;�������� disp �  ������
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm
            

;func7
            mov     p0,#01h             ;����� ���
            lcall   disp_wcomm
            mov     r7,#080h 
            mov     dptr,#tpriem        ; ����� ����� ������    
func70:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func70
            mov     r0,#0b5h                 ; ����� ������ ������� �����
            mov     r1,#0b6h                 ; ����� ������ ������� ����� 
            cjne    @r0,#030h,func702               ; �������� � ������� ���� ���� ���� �� ������� N  � ���� ����� 
            cjne    @r1,#030h,func702
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa70:       mov     r6,#080h        ;  ���� �������� ������� ������
waitkfa70:   djnz    r6,waitkfa70	    
             jnb     p2.2,kfa70
             jnb     p2.4,kfa70
kfa71:       mov     r6,#080h        ; ���� �������� ������� ������
waitkfa710:  djnz    r6,waitkfa710	    
             jnb     p2.2,func702
             jnb     p2.4,func79
             ajmp    kfa71
func702:     lcall   func52
func79:  ;    mov     p0,#001h            ;�������� disp �  ������
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm
 





;func9 
            mov     p0,#01h             ;�����  ����
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ �������� ���� 
            mov     dptr,#tkontrsoe            
func90:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func90
             mov     r0,#0c1h
             mov     r1,#0c1h            
             mov     p0,#0c0h        ; ����� � ������ ������ ������           
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             mov     a,@r0                                       ;������� �� ��� � ������ ��������
             cjne    a,#059h,kfa90                            ;� ���� �� ����� ���� ��� ��������������
             ljmp    kfa96                                    ;

kfa90:       mov     r6,#080h        ;  ���� �������� ������� ������
waitkfa990:  djnz    r6,waitkfa990	    
             jnb     p2.2,kfa90
             jnb     p2.4,kfa90
kfa91:       mov     r6,#080h        ; ���� �������� ������� ������
waitkfa951:  djnz    r6,waitkfa951	    
             jnb     p2.2,func92
             jnb     p2.4,func95
             ajmp    kfa91             
func92:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#059h
             lcall   disp_wdata
             mov     @r1,#059h
kfa96:       mov     r6,#080h        ;  ���� �������� ������� ������
waitkfa960:  djnz    r6,waitkfa960	    
             jnb     p2.2,kfa96
             jnb     p2.4,kfa96
kfa97:       mov     r6,#080h        ; ���� �������� ������� ������
waitkfa971:  djnz    r6,waitkfa971	    
             jnb     p2.2,func93
             jnb     p2.4,func95
             ajmp    kfa97         
func93:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#04eh
             lcall   disp_wdata
             mov     @r1,#04eh
kfa98:       mov     r6,#080h        ;  ���� �������� ������� ������
waitkfa980:  djnz    r6,waitkfa980	    
             jnb     p2.2,kfa98
             jnb     p2.4,kfa98
kfa99:       mov     r6,#080h        ; ���� �������� ������� ������
waitkfa991:  djnz    r6,waitkfa991	    
             jnb     p2.2,func92
             jnb     p2.4,func95
             ajmp    kfa99         
func95:  ;    mov     p0,#001h            ;����� DISP � �������
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm

;func111 
            mov     p0,#01h             ;������� ����� ��.
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ����� ��.
            mov     dptr,#totboy            
func11a:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func11a
             mov     r0,#022h
             mov     r1,#022h            
             mov     p0,#0c0h        ; ����� � ������ ������ ������           
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             mov     a,@r0                                       ;������� �� ��� � ������ ��������
             cjne    a,#041h,kfa119                            ;� ���� �� ����� ���� ��� ��������������
             ljmp    kfa196                                    ;

kfa119:      jnb     p2.2,kfa119
             jnb     p2.4,kfa119
kfa191:      jnb     p2.2,func192
             jnb     p2.4,func195
             ajmp    kfa191             
func192:     mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#041h
             lcall   disp_wdata
             mov     @r1,#041h
kfa196:      jnb     p2.2,kfa196
             jnb     p2.4,kfa196
kfa197:      jnb     p2.2,func193
             jnb     p2.4,func195
             ajmp    kfa197         
func193:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#0a0h
             lcall   disp_wdata
             mov     @r1,#0a0h
kfa198:      jnb     p2.2,kfa198
             jnb     p2.4,kfa198
kfa199:      jnb     p2.2,func192
             jnb     p2.4,func195
             ajmp    kfa199         
func195:      mov     p0,#00ch            ;�������� disp � ���� ������
             lcall   disp_wcomm



;func10
            mov     p0,#01h          ;������� �����
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ����� 
            mov     dptr,#tstart            
func100:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func100
            
kf10:       mov     r6,#080h
kf110:      djnz    r6,kf110
            jnb     p2.2,kf10
            jnb     p2.4,kf10
kf101:      mov     r6,#080h
kf111:      
            jnb     p2.2,func1111
            jnb     p2.4,funcr11
            djnz    r6,kf111
            ajmp    kf101
func1111:    mov     r0,#080h                        ;��������� � ������ ��������� ��������                                                      ;������� ������� � ���� 
             mov     @r0,030h                        ;��� ��������� ,����������� �� ���������                                                      ;������
             inc     r0
             mov     @r0,031h
             inc     r0
             mov     @r0,032h
             inc     r0
             mov     @r0,033h
             inc     r0
             mov     @r0,034h
             inc     r0
             inc     r0
             inc     r0
             mov     @r0,035h
             inc     r0
             mov     @r0,036h
             mov     r0,#090h
             mov     @r0,037h
             inc     r0
             mov     @r0,038h 
             mov     r0,#099h
             mov     @r0,039h
             inc     r0
             mov     @r0,03ah
             mov     r0,#0a2h
             mov     @r0,03bh
             inc     r0
             mov     @r0,03ch
             mov     r0,#0abh
             mov     @r0,03dh
             inc     r0
             mov     @r0,03eh 



            ljmp    otschet  


funcr11:    mov     p0,#01h          ;������� �����
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ����� 
            mov     dptr,#proba           
func800:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func800
            
kf900:      mov     r6,#080h
kf9110:      djnz    r6,kf9110
            jnb     p2.2,kf900
            jnb     p2.4,kf900
kf9101:      mov     r6,#080h
kf9111:      
            jnb     p2.2,func9111
            jnb     p2.4,func911
            djnz    r6,kf9111
            ajmp    kf9101
func9111:   ljmp    prob  
func911:    ljmp    func1




; ������ ��������� ���������
otschet:    mov     010h,#058h              ;������ �� ��������� ������ ���������� ������ ���                                                                            ;�������� ����� ������ �� 2
            mov     011h,#000h                   ;������ �� ������. ������ ������ �������� ���                                                                                ;���������(�� �=0)�� �=1 ���
            mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                     ;�������
            mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                      ;�������
            mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                    ;���������
            mov     r0,#0c1h
            mov     021h,@r0
            mov     r0,#040h                  ;�������� ���� �� ����� ������ � ������ ������ ��.1
            cjne    @r0,#020h,nach            ;���� ��� �� ����� ������ ��� �������!
netuti:     mov     r7,#080h                  ;� ��������� ���� �� ����� ��.2   
            mov     dptr,#netnom            
netnomer:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,netnomer 
            lcall   sek
            ljmp    func1                     ;� ���� �� ����� ������ 
nach:       mov     r0,#058h                  ;�������� ���� �� ����� ������ � ������ ������ ��.2
            cjne    @r0,#020h,nachalo         ;���� ��� �� ����� ������ ��� �������!
            ljmp    netuti                     


nachalo:    mov     01fh,#000h                   ;��������� ������ �������� � 0 (������ ��������)          
            mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                        ;�������
            mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                        ;�������
            mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                        ;���������
            mov     r0,#080h               ;������ � ������� ������ ������� ����� ������� �������
            mov     r1,#087h               ;������ � ������� ������ ������� ����� ���������� ���
            mov     013h,@r0                 ;������ � � ��������� ������ ���� ������� �������
            mov     019h,@r0
            inc     r0
            mov     014h,@r0
            mov     01ah,@r0
            inc     r0
            mov     015h,@r0
            mov     01bh,@r0
            inc     r0
            inc     r0
            mov     016h,@r0 
            mov     01ch,@r0 
            mov     017h,@r1                 ;������ �� ��������� ������ ���������� ��� ��������
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1                 
            mov     r0,#0c1h
            mov     021h,@r0
            inc     011h                 ;���������� �� 1 ������ ������ �� ��� �������� �                                          ;����������� �� ����� ���������� ��
            mov     a,017h                   ;�������� �� 0 ���������� ��� ��� ������ ��������      
            cjne    a,#030h,progra                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,progra                 ;������� ����� ���������� ���
            ljmp    prov2                             ;���� ���������� ��� ��� ������ ��������                                                       ;����� ���� ������� � ���� 2
            
; ������ ������� ������ ������ � ��������� �������� ������� �������
progra:     mov     p0,#01h               
            lcall   disp_wcomm
            mov     r0,#0c1h
            mov     021h,@r0
            setb    p1.7                     ;��������� ���������������� � ������� �����
            mov     a,017h                   ;�������� �� 0 ���������� ��� ��������      
            cjne    a,#030h,progra1                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,progra1                 ;������� ����� ���������� ���
            ljmp    kom                             ;���� ���������� ��� ��� �������� ����� ����                                                                                                        ;������� � KOM
progra1:    lcall   sek                      ;�������� �� 3 ��� ����� �������� �����
            lcall   sek                      ;
            lcall   sek                      ;
            mov     a,009h
            orl     a,#010h
            mov     p0,a          ; ��� ����� �� � 
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            mov     r0,#0b1h                 ; ����� ������ ������� ����� �������� ������ ��
            mov     r1,#0b2h                 ; ����� ������ ������� ����� �������� ������ ��
            cjne    @r0,#030h,connect1               ;1 �������� � ������� ���� ���� ���� �� ��                                                                                   ;��������� ��� �� 
            cjne    @r1,#030h,connect2               ;2
progra11:   ljmp    nabnom
connect1:   mov     a,@r0                    ;������ ������� ����� ��
            anl     a,#00fh                  ;��������� �������� ��������� � 0
            mov     r5,a                     ;������ ������� ��  � ��� �� ��������� ��� R5
            mov     r3,#00ah                 ;��������� ��������� 10����
connect11:  ;jnb     p2.7,progra11              ; �������� ������� ��� ��(0) ���� ��� (1) ��                                                                                 ;�������� ���� ���� �� �����
            ;lcall   sek             
            mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connozid:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozid
            mov     r7,#0c0h           ;  ����� ������ ����� �� �� ������ ������
            mov     dptr,#totvet            
connozida:  mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozida
            jnb     p2.7,progra11              ; �������� ������� ��� ��(0) ���� ��� (1) ��                                                                                 ;�������� ���� ���� �� �����
            lcall   sek 
            jnb     p2.4,pryg1                  ;�������������� ����� �� �������� �� ����� "OK"
            djnz    r3,connect11
            djnz    r5,connect11
connect2:   cjne    @r1,#030h,connect21
            jnb     p2.7,progra11                          
            mov     p0,#000h                 ;1���� ����� �� �
            mov     p1,#0a0h                 ;2
            mov     p1,#0b0h                 ;3
func302:    mov     p0,#01h               ;����� ������ ��� ��� ��
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ��� 
            mov     dptr,#tnet            
func300:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func300
            mov     r7,#0c0h                       ;  ����� ������ ����� ��
            mov     dptr,#totvet            
func301:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,func301
            mov     p0,#080h          ; ���� ����� �� � � ��� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; ���� ����� �� � � ���� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg1                  ;�������������� ����� �� �������� �� ����� "OK" 
            
            djnz    r4,net1
            inc     011h
            ljmp    kommab
net1:       ljmp    progra
pryg1:      ljmp    func1
connect21:  mov     a,@r1                    ;������ ������� ����� ��
            anl     a,#00fh                  ;��������� �������� ��������� � 0
            mov     r5,a                     ;������ ������� �� �� ��������� ��� R5
connect211:  mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connozid1:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozid1
            mov     r7,#0c0h           ;  ����� ������ ����� �� �� ������ ������
            mov     dptr,#totvet            
connozida1:  mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozida1
            jnb     p2.7,nabnom                     ; �������� ������� ��� ��(0) ���� ��� (1) ��                                                                                 ;��������
            lcall   sek             
            jnb     p2.4,pryg1                  ;�������������� ����� �� �������� �� ����� "OK" 
            djnz    r5,connect211
            ljmp    func302


nabnom:     setb    p1.7                     ;��������� ���������������� � ������� �����
            mov     r0,010h           ;����� ������----��������� ������ ������ ������ �� � ��                                                                      ;��������� ������
            mov     r1,#0c2h             ;1������������� ����� @0c2 (T/P) � P
            mov     @r1,#01fh            ;2
            mov     r4,#080h                              ;����� ������ ���������� ����� �� �����
            mov     p0,#001h          
            lcall   disp_wcomm
nabnom0:    mov     a,@r0              ;������ ������ ����� ������ ������
            cjne    a,#057h,nabnom1
            lcall   sek
            lcall   sek
            lcall   sek
            ljmp    nabnom21
nabnom1:    cjne    a,#054h,nabnom2            
            mov     @r1,#00fh
            ljmp    nabnom21 
nabnom2:    cjne    a,#050h,nabnom6
            mov     @r1,#01fh
            ljmp    nabnom21
nabnom6:    cjne    a,#002h,nabnom7               ;�������� �� �������� ( 8 ��������� )
            ljmp    mezgor   
nabnom7:    cjne    a,#023h,nabnom3                ;�������� ��(#) ���� �� �� ������ ��� ���� 0bh
            mov     a,#00bh                        ;� ����������������
            ljmp    nabnom42
nabnom3:    cjne    a,#02ah,nabnom35                ;�������� ��(*) ���� �� �� ������ ��� ���� 00h
            mov     a,#000h                        ;� ����������������
            ljmp    nabnom42  
nabnom35:   cjne    a,#020h,nabnom4
            ljmp    nabnom5
nabnom21:   inc     r0
            ljmp    nabnom0
nabnom4: 
            lcall   ind            ;����� ���������� ����� �� �����
            anl     a,@r1         
nabnom42:   setb    p1.7                ;��������� ����� ����� � ���������������� 
            mov     p0,a                ;1 ������ ����� � ����������������             
            setb    p1.3                ;2 
            clr     p1.3                ;3 
;            mov     p1,#030h                ;1 ������ ����� � ����������������
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
nabnom41:   jnb     p2.5,nabnom41           ;�������� ���������� ����������������
            inc     r0
            ljmp    nabnom0
nabnom5:     mov     p0,#01h        ;����� ������       
            lcall   disp_wcomm
            mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                     ;�������
            mov     r0,#0b5h                 ; ����� ������ ������� ����� �������� ������ ���
            mov     r1,#0b6h                 ; ����� ������ ������� ����� �������� ������ ���
            cjne    @r0,#030h,connecto1               ;1 �������� � ������� ���� ���� ���� �� ��   ��������� ��� ��          
            cjne    @r1,#030h,connecto2               ;2
con111:     ljmp    connecto3
connecto1:   mov     a,@r0                    ;������ ������� ����� ��
            anl     a,#00fh                  ;��������� �������� ��������� � 0
            mov     r5,a                     ;������ ������� ��  � ��� �� ��������� ��� R5
            mov     r3,#00ah                 ;��������� ��������� 10����
connecto11: mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connozd1:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozd1
            mov     r7,#0c0h
            mov     dptr,#tpriem         ;  ����� ������ ����� ������ �� ������ ������    
connozda1:  mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozda1
            jnb     p2.6,con111                     ; �������� ������� ������ ���(0) ���� ��� (1)                                                                                ;�� ��������
            lcall   sek             
            djnz    r3,connecto11
            djnz    r5,connecto11
connecto2:   cjne    @r1,#030h,connecto21
            jnb     p2.6,con111                          
            mov     p0,#000h                 ;1���� ����� �� � � �� �
            mov     p1,#0a0h                 ;2
            mov     p1,#0b0h                 ;3
funco302:    mov     p0,#01h               ;����� ������ ��� ������ ���
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ��� 
            mov     dptr,#tnet            
funco300:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,funco300
            mov     r7,#0c0h                       ;  ����� ������ ����� ���
            mov     dptr,#tpriem            
funco301:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,funco301
            mov     p0,#080h          ; ���� ����� �� � � �� � � ��� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; ���� ����� �� � � �� � � ���� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg2                    ;������ ����� �� �������� �� ��� "OK"
            djnz    027h,net2
            inc     011h
            ljmp    kommab
net2:       ljmp    progra
pryg2:      ljmp    func1
connecto21:  mov     a,@r1                    ;������ ������� ����� ��
            anl     a,#00fh                  ;��������� �������� ��������� � 0
            mov     r5,a                     ;������ ������� �� �� ��������� ��� R5
connecto211: mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connozd2:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozd2
            mov     r7,#0c0h
            mov     dptr,#tpriem         ;  ����� ������ ����� ������ �� ������ ������    
connozda2:  mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connozda2

            jnb     p2.6,connecto3                     ; �������� ������� ������ ���(0) ���� ���                                                         ;(1) �� ��������
            lcall   sek             
            djnz    r5,connecto211
            ljmp    funco302

connecto3:  mov     p0,#001h            ;����� DISP � ������� 
            lcall   disp_wcomm
            mov     p0,#00ch            ;�������� disp � ���� ������
            lcall   disp_wcomm 
            mov     p0,#080h              ;����� ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,013h
            lcall   disp_wdata
            mov     p0,#081h              ;����� ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,014h
            lcall   disp_wdata
            mov     p0,#082h              ;����� ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,015h
            lcall   disp_wdata
            mov     p0,#083h              ;����� ������� �� �����
            lcall   disp_wcomm
            mov     p0,#02ch
            lcall   disp_wdata
            mov     p0,#084h              ;����� ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,016h
            lcall   disp_wdata
            mov     p0,#085h              ;����� ����� � �� �����
            lcall   disp_wcomm
            mov     p0,#063h               
            lcall   disp_wdata
            mov     p0,#0c0h              ;����� ������ ������ ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,017h
            lcall   disp_wdata
            mov     p0,#0c1h              ;����� ������ ������ ��������� ������ �� �����
            lcall   disp_wcomm
            mov     p0,018h
            lcall   disp_wdata 
            mov     p0,#0c2h             
            lcall   disp_wcomm
            mov     p0,#020h
            lcall   disp_wdata 
             mov    r7,#0c3h
             mov     dptr,#traz        ; ����� ���                
ots1:        mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             mov     a,#00h
             movc    a,@a+dptr
             cjne    a,#0ffh,ots1
             mov     p0,#0c8h          ;����� �� ����� "����� c" ��� ��������� �������� � ��� ���  ���������   
             lcall   disp_wcomm
             mov     p0,019h
             lcall   disp_wdata 
             mov     p0,#0c9h             
             lcall   disp_wcomm
             mov     p0,01ah
             lcall   disp_wdata 
             mov     p0,#0cah             
             lcall   disp_wcomm
             mov     p0,01bh
             lcall   disp_wdata
             mov     p0,#0cbh             
             lcall   disp_wcomm
             mov     p0,#063h
             lcall   disp_wdata


             mov     a,#030h                         ;�������� �� 0 ������� ����� ���
             cjne    a,018h,ots2  
             cjne    a,017h,ots2                         ;�������� �� 0 ������� ����� ��� 
             ljmp    kom



ots2:      mov     029h,#00h         ; ������� ����� �������� ��� �������� 29 ��. � 2A ��.
             mov     02ah,#00h
             mov     a,016h              ; ������� ���. ����. ������� � �������� ��� ��������
             mov     029h,a              ; ��������� ������� ������� � �� � ��. ������ ��������
             anl     029h,#00fh               
             dec     029h              ;���������� �� 1 ���������� ���� ��� ����. ������ ��������     
             mov     02bh,015h              ;��������� � ������������� ������� �������� ������� � ���    
             anl     02bh,#00fh            ; ������� � HEX
             mov     r5,02bh             ; ��������� � ������������� ������� �������� ������� � ���
             mov     a,#00h                         ;��������� � ����. �������� ��� �������� �� 00 ���. ���
             cjne     a,02bh,ots2b               ; ��������� �� 0 ��� ��� , ���� =0 �� ���� � ��� ���
             ljmp      ots2a1

ots2b:       mov      r6,#00ah                      ;��������� � ���� ������� ��������� �10 ��� ������������ ���
ots2bb:      inc      029h                       ; ���������� � �������� ���������� ���
             djnz     r6,ots2bb             
             djnz     r5,ots2b                    ;

ots2a1:      mov      02bh,014h              ;��������� � ������������� ������� �������� ������� � ��� ���    
             anl      02bh,#00fh            ; ������� � HEX
             mov      r5,02bh             ; ��������� � ������������� ������� �������� ������� � ��� ���
             mov      a,#00h                         ;��������� � ����. �������� ��� �������� �� 00 ���. ��� ���
             cjne     a,02bh,ots2a              ; ��������� �� 0 ��� ��� ��� , ���� =0 �� ���� � ��� ���
             ljmp     ots2c1
ots2a:       mov      r6,#064h                      ;��������� � ���� ������� ��������� �100 ��� ������������ ��� ���
             mov      a,#0ffh                         ;��������� � ����. �������� ��� �������� �� ������������ 029
ots2aa:      inc      029h                       ; ���������� � �������� ���������� ��� ���
             cjne     a,029h,ots2ab                ; �������� �� ������������ ��. ������� �������� ������� ���.    
             lcall    ots2d                             ; ���� ���� FF �� ��������� �� 1 ��. �������
ots2ab:      djnz     r6,ots2aa             
             djnz     r5,ots2a                    ;

ots2c1:      mov      02bh,013h              ;��������� � ������������� ������� �������� ������� � ��� ���    
             anl      02bh,#00fh            ; ������� � HEX
             mov      r5,02bh             ; ��������� � ������������� ������� �������� ������� � ��� ���
             mov      a,#00h                         ;��������� � ����. �������� ��� �������� �� 00 ���. ��� ���
             cjne     a,02bh,ots2c            ; ��������� �� 0 ��� ��� ��� , ���� =0 �� ���� � �����
             ljmp     counter

ots2c:       mov      r6,#064h                      ;��������� � ���� ������� R6 ��������� �100 ��� ������������ ��� ���
ots2ce:      mov      r4,#00ah                    ;��������� � ���� ������� R4 ��������� �10 ��� �������
             mov      a,#0ffh                         ;��������� � ����. �������� ��� �������� �� ������������ 029  
ots2cc:      inc      029h                       
             cjne     a,029h,ots2cb                ; �������� �� ������������ ��. ������� �������� ������� ���.    
             lcall    ots2d                             ; ���� ���� FF �� ��������� �� 1 ��. �������
ots2cb:      djnz     r4,ots2cc
             djnz     r6,ots2ce             
             djnz     r5,ots2c                    ;   
             ljmp     counter
ots2d:       inc      02ah
             ret








counter:      mov     tmod,#0d1h      ;��������� ������� ��������� �0 � ����. 1 ��� , �1 � ����. 10 �� 
              mov     a,029h                  ; ���������� ������������ ����� ��� ��������� � �������
              cpl     a                        
              mov     029h,a
              mov     tl1,a                        ;������ �����. ������� ����� �� 
              mov     a,02ah
              cpl     a
              mov     02ah,a                 ;
              mov     th1,a                        ;������ �����. ������� ����� ��
              mov     th0,#00h                   ;��������� �������� 1 ���
              mov     tl0,#0ffh
              clr     tr0                               ;����� ���������
              clr     tf0 
              clr     tr1                              ;����� ���������
              clr     tf1
              mov     r1,#0c1h          ;������ � ���. ������ ������ ������ � ����������� ���� ��� ��� �������� �����
              mov     r3,#003h            ;���������� ����� �������� ����� =3

;������ �����, ��������� �����

             mov     a,009h                  ; ��� ����� �� � � ����� �� � 
             orl     a,#030h
             mov     p0,a                   
             mov     p1,#0a0h               ;1 ������ � ������� ��� 
             mov     p1,#0b0h               ;2          
 
             setb    tr1                                ;����� ����� 10��

count1:      mov     p0,#001h                ;�������� ����������
             setb    p1.3
             clr     p1.3   
;             mov     p1,#000h               ;1 ������ ��������� ����� 1 � ���������������� � ��������� ������ ���
;             mov     p1,#008h                ;2 ��������� �����
             clr     p1.7                   ;��������� ������ ���� � ����������������  
               mov     r7,#017h                   ;��������� �������� 1 ��� � ������
count1a:       setb    tr0                                ;����� ����� 1��

countsek:      jbc     tf1,count10                 ;�������� ����� ����� 10��, ����� ���������� � ������� �� ��� �������� 
               jnb     tf0,countsek           ;�������� ����� ����� 1���, ���� ���� �� ����� ����     
               clr     tr0                               ;����� ���������
               clr     tf0 
               djnz    r7,count1a
               cjne    @r1,#059h,countsek1                  ; �������� ���� �� ��������� �����?           
               jb      p3.4,countsek1                               ;������ ������������ ������� ������� �����
               djnz    r3,countsek1
               ljmp    hy                                   ;��������� ������� ������

countsek1:     lcall   dubizm                ; ����� � ������� ������ �� ����� ��������
               mov     th0,#00h                   ;��������� �������� 1 ���
               mov     tl0,#0ffh             
               jnb     p2.4,stoper                          ; �������� ������� ������ ��� ����� �� ��������, ������� "OK"
	    
               ljmp    count1


count10:       clr     tr1                               ;����� ���������
               clr     tf1 
               mov     p0,#000h          ; ���� ����� �� � � ���� ���
               mov     p1,#0a0h             ;1 ������ � ������� ��� 
               mov     p1,#0b0h             ;2
               clr     tr0                               ;����� ���������
               clr     tf0 
               ljmp    raz3

stoper:        clr     tr1                               ;����� ���������
               clr     tf1 
               mov     p0,#000h          ; ���� ����� �� � � ���� ���
               mov     p1,#0a0h             ;1 ������ � ������� ��� 
               mov     p1,#0b0h             ;2
               clr     tr0                               ;����� ���������
               clr     tf0 
               setb    p1.7
               ljmp    func1                         ; ��������� ����� ��������




raz3:        mov     a,#030h                         ;�������� �� 0 ������� ����� ���
             cjne    a,018h,raz2a  
             cjne    a,017h,raz1                     ;�������� �� 0 ������� ����� ��� 

              
kom:         mov     a,01fh
             cjne    a,#000h,sr1 
             mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;���������
             ljmp    prov2
sr1:         cjne    a,#001h,sr2 
             mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;���������
             ljmp    prov3
sr2:         cjne    a,#002h,sr3
             mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;���������
             ljmp    prov4
sr3:         cjne    a,#003h,sr4
             mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;���������
             ljmp    prov5
sr4:         cjne    a,#004h,sr5
             mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;���������
             ljmp    kommab              
sr5:        mov     r4,#00ah                           ;������ 10 ��� ������� ��������� �������                                                                                                           ;�������
             mov     027h,#00ah                         ;������ 10 ��� ������� ��������� ������                                                                                                             ;�������
             mov     028h,#00ah                         ;������ 10 ��� ������� ��������� ��������                                                                                                          ;��������� 
            ljmp    kommab

pryg10:      setb    p1.7
             ljmp    func1
raz2a:     ljmp    raz2         
raz1:        mov     018h,#039h                        ;������ 9 � ������� ����� ��� � ���������                                                                                         ;������� �����
             dec     017h 
             mov     019h,013h
             mov     01ah,014h
             mov     01bh,015h

            mov     r0,#022h               ;����� ���������
            mov     a,@r0
            cjne    a,#041h,kommut7a              ;�������� --����� ��. � ����� �? ���� ��� �� ���� �� ����� ��. �.
            mov     p0,#020h
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4            
             ljmp    progra
kommut7a:    mov     p0,#010h                           ; ����� ��. � ����� �
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4                
            

;             mov     p0,#000h                 ;1���� ����� �� �
;             mov     p1,#0a0h                 ;2
;             mov     p1,#0b0h                 ;3
;             lcall   sek
;             setb    p1.7
             ljmp    progra
raz2:        dec     018h
             mov     019h,013h
             mov     01ah,014h
             mov     01bh,015h
            mov     r0,#022h               ;����� ���������
            mov     a,@r0
            cjne    a,#041h,kommut7b              ;�������� --����� ��. � ����� �? ���� ��� �� ���� �� ����� ��. �.
            mov     p0,#020h
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4            
             ljmp    progra
kommut7b:    mov     p0,#010h                           ; ����� ��. � ����� �
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4                
                         
;             mov     p0,#000h                 ;1���� ����� �� �
;             mov     p1,#0a0h                 ;2
;             mov     p1,#0b0h                 ;3
;             lcall   sek
;             setb    p1.7
             ljmp    progra
             
prov2:      inc     01fh
            mov     r0,#089h               ;������ � ������� ������ ������� ����� ������� �������
            mov     r1,#090h               ;������ � ������� ������ ������� ����� ���������� ���
            mov     013h,@r0                 ;������ � � ��������� ������ ���� ������� �������
            mov     019h,@r0
            inc     r0
            mov     014h,@r0
            mov     01ah,@r0
            inc     r0
            mov     015h,@r0
            mov     01bh,@r0
            inc     r0
            inc     r0
            mov     016h,@r0 
            mov     01ch,@r0 
            mov     017h,@r1                 ;������ �� ��������� ������ ���������� ��� ��������
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;�������� �� 0 ���������� ���
            cjne    a,#030h,prov21                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,prov21                 ;������� ����� ���������� ���
            ljmp    prov3                    ;���� ���������� ��� ��� ������ �������� ����� ����                                              ;������� � ���� 3
prov21:     setb    p1.7
            ljmp    progra
prov3:      inc     01fh
            mov     r0,#092h               ;������ � ������� ������ ������� ����� ������� �������
            mov     r1,#099h               ;������ � ������� ������ ������� ����� ���������� ���
            mov     013h,@r0                 ;������ � � ��������� ������ ���� ������� �������
            mov     019h,@r0
            inc     r0
            mov     014h,@r0
            mov     01ah,@r0
            inc     r0
            mov     015h,@r0
            mov     01bh,@r0
            inc     r0
            inc     r0
            mov     016h,@r0 
            mov     01ch,@r0 
            mov     017h,@r1                 ;������ �� ��������� ������ ���������� ��� ��������
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;�������� �� 0 ���������� ���
            cjne    a,#030h,prov31                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,prov31                 ;������� ����� ���������� ���
            ljmp    prov4                    ;���� ���������� ��� ��� ������ �������� ����� ����                                              ;������� � ���� 4
prov31:     ljmp    progra
prov4:      inc     01fh
            mov     r0,#09bh               ;������ � ������� ������ ������� ����� ������� �������
            mov     r1,#0a2h               ;������ � ������� ������ ������� ����� ���������� ���
            mov     013h,@r0                 ;������ � � ��������� ������ ���� ������� �������
            mov     019h,@r0
            inc     r0
            mov     014h,@r0
            mov     01ah,@r0
            inc     r0
            mov     015h,@r0
            mov     01bh,@r0
            inc     r0
            inc     r0
            mov     016h,@r0 
            mov     01ch,@r0 
            mov     017h,@r1                 ;������ �� ��������� ������ ���������� ��� ��������
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;�������� �� 0 ���������� ���
            cjne    a,#030h,prov41                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,prov41                 ;������� ����� ���������� ���
            ljmp    prov5                    ;���� ���������� ��� ��� ������ �������� ����� ����                                              ;������� � ���� 5
prov41:     setb    p1.7
            ljmp    progra
prov5:      inc     01fh
            mov     r0,#0a4h               ;������ � ������� ������ ������� ����� ������� �������
            mov     r1,#0abh               ;������ � ������� ������ ������� ����� ���������� ���
            mov     013h,@r0                   ;������ � � ��������� ������ ���� ������� �������
            mov     019h,@r0
            inc     r0
            mov     014h,@r0
            mov     01ah,@r0
            inc     r0
            mov     015h,@r0
            mov     01bh,@r0
            inc     r0
            inc     r0
            mov     016h,@r0 
            mov     01ch,@r0 
            mov     017h,@r1                 ;������ �� ��������� ������ ���������� ��� ��������
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;�������� �� 0 ���������� ���
            cjne    a,#030h,prov51                 ;������� ����� ���������� ���
            mov     a,018h
            cjne    a,#030h,prov51                 ;������� ����� ���������� ���
            ljmp    kommab                   ;���� ���������� ��� ��� �������� ����� ���� �������                                              ;� �������� ������ ���. ��
prov51:    setb    p1.7
           ljmp    progra

kommab:    mov     a,011h
           cjne    a,#001h,kommab1
           ljmp    ab2
kommab1:   cjne    a,#002h,kommab2
           ljmp    ab3 
kommab2:   cjne    a,#003h,kommutp
           ljmp    kommutp
kommab3:   cjne    a,#004h,kommutp          ;���� ������� ��� �������� �� ������� � ��������                                                                             ;�������� ����������� �����
           ljmp    kommut
kommutp:   ljmp    kommut

ab2:       mov     010h,#0d0h              ;������ �� ��������� ������ ���������� ������ ���                                            ;�������� ����� ������ �� 3
           mov     r0,#0d0h                  ;�������� ���� �� ����� ������ � ������ ������ ��.3
           cjne    @r0,#020h,ab2a            ;���� ��� �� ��� ����� ���� ��� �� � 1 �.� ����                                              ;�������� ����� �� 1
           mov     p0,#050h                                 ;��������� ���� � 101  "2 �� 1"
           mov     p1,#090h
           mov     p1,#0b0h                                
           mov     010h,#040h              ;������ �� ��������� ������ ���������� ������ ���                                            ;�������� ����� ������ �� 1
           mov     r0,#040h   
           ljmp    nachalo                    ;� ���� �� ����� �� 1
ab2a:      mov     p0,#010h                                 ;��������� ���� � 001  "2 �� 3"
           mov     p1,#090h
           mov     p1,#0b0h
           ljmp    nachalo                   ;� ���� �� ����� �� 3
ab3:       mov     010h,#0d0h              ;������ �� ��������� ������ ���������� ������ ���                                            ;�������� ����� ������ �� 3
           mov     r0,#0d0h                  ;�������� ���� �� ����� ������ � ������ ������ ��.3
           cjne    @r0,#020h,ab3a            ;���� ��� �� ���� �� �������� �� 4                      
           inc     011h                      ; 
           inc     011h 
           ljmp    kommab                    ;� ���� �� ���������� ���������
ab3a:      mov     p0,#060h                                 ;��������� ���� � 110  "3 �� 1"
           mov     p1,#090h
           mov     p1,#0b0h
           mov     010h,#040h              ;������ �� ��������� ������ ���������� ������ ���                                                                            ;�������� ����� ������ �� 1
           mov     r0,#040h              

           setb    p1.7
           ljmp    nachalo 


          ljmp    nachalo
ab4:       mov     010h,#040h              ;������ �� ��������� ������ ���������� ������ ���                                                                            ;�������� ����� ������ �� �
           mov     r0,#040h                  ;�������� ���� �� ����� ������ � ������ ������ ��.�
           cjne    @r0,#020h,ab4a            ;���� ��� �� ��� ����� ���� ��� �� � 1 �.� ����                                                                              ;�������� ����� ��.�
           inc     011h                      ; 
           ljmp    kommab                    ;� ���� �� ���������� ���������
ab4a:      ljmp    nachalo

ab5:       mov     010h,#0e8h              ;������ �� ��������� ������ ���������� ������ ���                                                                                                   ;�������� ����� ������ �� 4
           mov     r0,#0e8h                  ;�������� ���� �� ����� ������ � ������ ������ ��.4
           cjne    @r0,#020h,ab5a            ;
           inc     011h                      ; 
           ljmp    kommab                    ;� ���� �� ���������� ���������
ab5a:       mov     p0,#000h             ;����� ���� �������� �������� 
            clr     p1.5
            setb    p1.5                      ;������ � ���. ���. �� ������

;            mov     p1,#0a0h             ;1 ������ � ������� ��� 
;            mov     p1,#0b0h             ;2
;            mov     p0,#000h                                 ;��������� ���� � 000  "4 �� 1"
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            mov     p0,#01h               
            lcall   disp_wcomm
            mov     p0,#010h                ; ��� ����� �� � 
            clr     p1.4
            setb    p1.4                      ;������ � ���. ���. �� ������
;            mov     p1,#0a0h                ;1 ������ � ������� ��� 
;            mov     p1,#0b0h                ;2
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
sosozid:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,sosozid
            mov     r7,#0c0h           ;  ����� ������ ����� �� �� ������ ������
            mov     dptr,#totvet            
sosozida:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,sosozida
            jnb     p2.7,sosnab              ; �������� ������� ��� ��(0) ���� ��� (1) ��                                                                                 ;�������� ���� ���� �� �����
            jnb     p2.4,stop1                          ; �������� ������� ������ ��� ����� �� ��������, ������� "OK"
            lcall   sek                          ;�������� ������ �� � ������� 3 ���
            jnb     p2.4,stop1                          ; �������� ������� ������ ��� ����� �� ��������, ������� "OK"
            lcall   sek                          ;
            lcall   sek                          ;
            jnb     p2.7,sosnab              ; �������� ������� ��� ��(0) ���� ��� (1) �� �� ����� ���� ���� �� �����  
            jnb     p2.4,stop1                          ; �������� ������� ������ ��� ����� �� ��������, ������� "OK" 
            ljmp     ab5a
stop1:      ljmp    func1
sosnab:     mov     r0,010h           ;����� ������----��������� ������ ������ ������ �� � �� 
                                       ;��������� ������
            mov     r1,#0c2h                   ;1������������� ����� @0c2 (T/P) � P
            mov     @r1,#01fh                  ;2
            mov     r4,#080h                              ;����� ������ ���������� ����� �� �����
            mov     p0,#001h          
            lcall   disp_wcomm
sosnom0:    mov     a,@r0              ;������ ������ ����� ������ ������
            cjne    a,#057h,sosnom1
            lcall   sek
            lcall   sek 
            ljmp    sosnom21
sosnom1:    cjne    a,#054h,sosnom2            
            mov     @r1,#00fh
            ljmp    sosnom21 
sosnom2:    cjne    a,#050h,sosnom6
            mov     @r1,#01fh
            ljmp    sosnom21
sosnom6:    cjne    a,#038h,sosnom3                  ;�������� �� �������� ( 8 )
            cjne    r4,#080h,sos                     ;������ ������ ����� ������?���� �� ��                                                      ;�������� ���������� ������ ��
            ljmp    sosgor   
sos:        cjne    r4,#081h,sosnom3                 ;������ ������ ����� ������?���� �� ��  
            ljmp    sosgor                           ;�������� ���������� ������ ��
sosnom3:    cjne    a,#020h,sosnom4
            ljmp    sosnom5
sosnom21:   inc     r0
            ljmp    sosnom0
sosnom4: 
            lcall   ind                 ;����� ���������� ����� �� �����
            anl     a,@r1          
            setb    p1.7 
            mov     p0,a
            setb    p1.3
            clr     p1.3 
;            mov     p1,#030h                   ;1 ������ ����� � ����������������
;            mov     p1,#038h                   ;2 
;            mov     p1,#030h                   ;3
sosnom41:   jnb     p2.5,sosnom41              ;�������� ���������� ����������������
            inc     r0
            ljmp    sosnom0
sosnom5:     mov     r4,#010h           ;���. ��������� ��� ���������� ������ � ������� 32 ���
sosnom51:    mov     p0,#0cbh                        ;����� ������������  ^             
             lcall   disp_wcomm
             mov     p0,#0d9h                        ;����� ������������  ^             
             lcall   disp_wdata
             jnb     p2.4,sosnom7
             setb    p1.7 
             mov     p0,#001h                  ;
             setb    p1.3
             clr     p1.3 
;             mov     p1,#030h                  ;1 ������ ��������� ����� 1 � ����������������
;             mov     p1,#038h                  ;2 
;             mov     p1,#030h                  ;3
             lcall   sek
             mov     p0,#0cbh                        ;����� ������������  ^             
             lcall   disp_wcomm
             mov     p0,#0dah                        ;����� ������������  ^             
             lcall   disp_wdata
             lcall   sek
             jnb     p2.4,sosnom7
             djnz    r4,sosnom51
             mov     p0,#000h             ;����� ���� �������� �������� 
             mov     p1,#0a0h             ;1 ������ � ������� ��� 
             mov     p1,#0b0h             ;2
sosnom7:     mov     p0,#01h               
             lcall   disp_wcomm
             ljmp    func1

sosgor:     lcall   ind
            anl     a,@r1         
            setb    p1.7
            mov     p0,a
            setb    p1.3
            clr     p1.3 
;            mov     p1,#030h                ;1 ������ ����� � ����������������
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
sosmez:     jnb     p2.5,sosmez 
            lcall   sek                           ;�������� ������ ��������� � ��� 4 ���
            lcall   sek                           ;
            lcall   sek                           ;
            lcall   sek                           ;
            ljmp    sosnom21
















kommut:     mov     r0,#0c0h               ;������������ ��.�))��.�
            mov     a,@r0
            cjne    a,#059h,kommut1              ;�������� --���� �� �����������
            mov     009h,#040h                          ;������ ������ ����������� � ����������
;            mov     a,#04eh                      ;���� ���� �� �������� ���� ������������ � N
;            mov     @r0,a    
            mov     p0,#000h                   ;������ � ���� ��� �������� ������ �����������
            clr     p1.5
            setb    p1.5 
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            lcall   sek
            mov     010h,#0d8h                  ;���������� ����� �������� ������ ������ ��.�
            mov     011h,#003h                    ;���������� ����� �������� ��� �������� kommab

            ljmp    ab5
kommut1:
;           mov     p0,#000h                   ;������ � ���� ��� ����� ���� ��������
;            clr     p1.5 
;            setb    p1.5
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            mov     009h,#000h
            mov     r0,#022h               ;����� ���������
            mov     a,@r0
            cjne    a,#041h,kommut7              ;�������� --����� ��. � ����� �? ���� ��� �� ���� �� ����� ��. �.
            mov     p0,#020h
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4            
            ljmp    kommut8
kommut7:    mov     p0,#010h                           ; ����� ��. � ����� �
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4                
            
kommut8:  mov     p0,#01h               
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ ��������� �� ������ ������ 
            mov     dptr,#tvse            
vse:      mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,vse
            mov     r7,#0c0h           ;  ����� ������ ��������� �� ������ ������
            mov     dptr,#tvse1           
vse1:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,vse1
vsek:      jnb     p2.4,vsek            ; �������� ������� ������� ��
vsek1:    jnb     p2.4,vsek2
             ljmp    vsek1

vsek2:    ljmp    funcr11
    
hy:
;            mov     p0,#080h          ;���� ���.�� � � ��� ���-��� ��� �����. ��������� �����!!!!
;            mov     p1,#0a0h             ;1 ������ � ������� ��� 
;            mov     p1,#0b0h             ;2
;            jnb     p2.4,hy1
;            lcall   sek
;            mov     p0,#000h          ; ���� ����� �� � � ���� ���
;            mov     p1,#0a0h             ;1 ������ � ������� ��� 
;            mov     p1,#0b0h             ;2
;            mov     p0,#080h          ; ���� ����� �� � � ��� ���
;            mov     p1,#0a0h             ;1 ������ � ������� ��� 
;            mov     p1,#0b0h             ;2
;            jnb     p2.4,hy1
;            lcall   sek
;            mov     p0,#000h          ; ���� ����� �� � � ���� ���
;            mov     p1,#0a0h             ;1 ������ � ������� ��� 
;            mov     p1,#0b0h             ;2
             lcall   sek
             jnb     p2.4,hy1
              mov     r0,#080h               ;������ � ������� ������ ������� ����� ������� �������       
              mov     019h,@r0                 ;������ � � ��������� ������ ���� ������� �������
              inc     r0              
              mov     01ah,@r0
              inc     r0
              mov     01bh,@r0
;             ljmp     ab5 
             ljmp     progra
hy1:         ljmp     func1                ; (ab5)

prob:        mov     r0,#080h         ;��������� � ������ �������� ������� �������  
             mov     a,#030h          ;10.0 cek � ��� 01 �����
             mov     @r0,a                           ;� ��������� ���� ��������� 00 ���
             inc     r0
             mov     a,#031h
             mov     @r0,a
             inc     r0
             mov     a,#030h         
             mov     @r0,a
             inc     r0
             inc     r0
             mov     @r0,a
             mov     r0,#087h
             mov     @r0,a
             inc     r0
             mov     a,#031h
             mov     @r0,a
             mov     a,#030h 
             mov     r0,#090h
             mov     @r0,a
             inc     r0
             mov     @r0,a 
             mov     r0,#099h
             mov     @r0,a
             inc     r0
             mov     @r0,a
             mov     r0,#0a2h
             mov     @r0,a
             inc     r0
             mov     @r0,a
             mov     r0,#0abh
             mov     @r0,a
             inc     r0
             mov     @r0,a

           
            ljmp     otschet









;SUBROUTINES            
ind:                                     ;�����.���.���������� ����������������� ���� �� �����
             mov     p0,r4            
             lcall   disp_wcomm
             mov     p0,a
             lcall   disp_wdata
             inc     r4
             cjne    r4,#08ch,ind1
             mov     r4,#0c0h
             mov     p0,r4
             lcall   disp_wcomm
ind1:        ret            
             









vyv3:        mov     r5,#080h         ;  ��������� ��������� addr disp ������� R5           
vyv1:        mov     p0,r5            ;        R5- ���� �� �������
             lcall   disp_wcomm       ;        R0- ��������� ������ ������ ������ �� DISP        
             mov     p0,@r0           ;        R1- ����� ������ ������
             lcall   disp_wdata       ;        �3- ����� �������
             inc     r5               ;
             inc     r0               ;
             cjne    r5,#08ch,vyv1    ;
             mov     r5,#0c0h
vyv2:        mov     p0,r5
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             inc     r5   
             inc     r0
             cjne    r5,#0cch,vyv2
             mov     r5,#080h
             mov     p0,#00eh           ;��������� ������� � ������ ����� ������ ������ ������
             lcall   disp_wcomm
             mov     p0,#002h          ;�������� disp � ������
             lcall   disp_wcomm
             mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
             mov     r3,#000h        ;��������� ������ �������







kfa0:        jnb     p2.0,kfa0
             jnb     p2.1,kfa0
             jnb     p2.2,kfa0
             jnb     p2.4,kfa0
kfa01:       jnb     p2.0,nazad
             jnb     p2.1,vpered
             jnb     p2.2,vvod
             jnb     p2.4,funcab
             ljmp    kfa01
funcab:      ret
vvod:       mov     a,#00h             ;����� ���� ������ ������  
            movc    a,@a+dptr
            cjne    a,#0ffh,vvod1
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    vvod
vvod1:      mov     @r1,a
            mov     p0,r5
            lcall   disp_wcomm
            mov     p0,a 
            lcall   disp_wdata
            mov     p0,#010h          ;������ ����� ����� ������ �����
            lcall   disp_wcomm
            inc     dptr
            inc     r3
            lcall   sek0
            ljmp    kfa0
nazad:      cjne    r5,#0c0h,nazad1
nazad0:     mov     p0,#08bh
            lcall   disp_wcomm
            mov     r5,#08bh
nazad01:    lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0            
nazad1:     jc      nazad2
            cjne    r5,#0cdh,nazad2
nazad11:    lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0                     
nazad2:     cjne    r5,#080h,nazad21
            ljmp    nazad22
nazad21:    mov     p0,#010h
            lcall   disp_wcomm
            dec     r5
            dec     r1
nazad22:    
            lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0
vpered:     cjne    r5,#08bh,vpered1
vpered0:    mov     p0,#0c0h
            lcall   disp_wcomm
            mov     r5,#0c0h
vpered01:   inc     r1 
            lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0            
vpered1:    jc      vpered2
            cjne    r5,#0cbh,vpered2
vpered11:   
            lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0                     
vpered2:    mov     p0,#014h
            lcall   disp_wcomm
            inc     r5
            inc     r1 
vpered21:  
            lcall   sek0
            mov     dptr,#tcifr        ;��������� ��������� ������ ������ ����
            ljmp    kfa0            

data11:      mov     r5,#080h         ;  ��������� ��������� addr disp ������� R5           
data1:       mov     p0,r5            
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             inc     r5
             inc     r0
             cjne    r5,#089h,data1
             mov     dptr,#traz
data2:       mov     p0,r5
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r5
             mov     a,#00h
             movc    a,@a+dptr
             cjne    a,#0ffh,data2
             mov     p0,#00eh            ;��������� ������� � ������ ����� ������ ������ 
             lcall   disp_wcomm
             mov     p0,#002h            ;�������� disp � ������
             lcall   disp_wcomm
             mov     dptr,#tcifr1        ;��������� ��������� ������ ������ ����
             mov     r5,#080h            ;��������� ������ �������
            
kfa310:  ;    mov     r6,#080h           ;  ���� �������� ������� ������
waitkfa310:  	    
             jnb     p2.0,kfa310
             jnb     p2.1,kfa310
             jnb     p2.2,kfa310
             jnb     p2.4,kfa310
             djnz    r6,waitkfa310
kfa311:   ;   mov     r6,#030h        ; ���� �������� ������� ������
waitkfa311:  	    
             jnb     p2.0,nazad3
             jnb     p2.1,vpered3
             jnb     p2.2,vvod3
             jnb     p2.4,funcab3
             djnz    r6,waitkfa311
             ljmp    kfa311
funcab3:     ret
vvod3:       cjne    r5,#083h,vvod330
             ljmp    vvod32
vvod330:     cjne    r5,#085h,vvod340
             ljmp    vvod32
vvod340:     cjne    r5,#086h,vvod310
             ljmp    vvod32
vvod310:     mov     a,#00h             ;����� ���� ������ ������  
             movc    a,@a+dptr
             cjne    a,#0ffh,vvod31
             mov     dptr,#tcifr1 
;vvod30:     jnb     p2.2,vvod30
             ljmp    vvod310
vvod31:      mov     @r1,a
             mov     p0,r5
             lcall   disp_wcomm
             mov     p0,a 
             lcall   disp_wdata
             mov     p0,#010h          ;������ ����� ����� ������ �����
             lcall   disp_wcomm
             inc     dptr          
vvod32:      jnb     p2.2,vvod32
             ljmp    kfa310
nazad3:      cjne    r5,#080h,nazad321
nazad301:    jnb     p2.0,nazad301
             mov     dptr,#tcifr1
             ljmp    kfa310            
nazad321:    mov     p0,#010h
             lcall   disp_wcomm
             dec     r5
             dec     r1  
nazad311:    jnb     p2.0,nazad311
             mov     dptr,#tcifr1
             ljmp    kfa310                     
vpered3:     cjne    r5,#088h,vpered311 
vpered301:   jnb     p2.1,vpered301
             mov     dptr,#tcifr1
             ljmp    kfa310            
vpered311:   mov     p0,#014h
             lcall   disp_wcomm             
             inc     r5    
             inc     r1
vpered331:   jnb     p2.1,vpered331
             mov     dptr,#tcifr1
             ljmp    kfa310

;������������ "����� �� ���"
func52:      mov     p0,#00eh        ; ���������  ������ � ������� 
             lcall   disp_wcomm
             mov     r7,#0c0h
             mov     p0,r7
             lcall   disp_wcomm             
             mov     p0,@r0
             lcall   disp_wdata
             inc     r7
             mov     p0,r7
             lcall   disp_wcomm            
             mov     p0,@r1
             lcall   disp_wdata
             inc     r7
             mov     dptr,#tsek        ; ����� ���    
func500:     mov     p0,r7
             lcall   disp_wcomm
             mov     a,#00h
             movc    a,@a+dptr
             mov     p0,a
             lcall   disp_wdata
             inc     dptr
             inc     r7
             mov     a,#00h
             movc    a,@a+dptr
             cjne    a,#0ffh,func500
             mov     p0,#00eh
             lcall   disp_wcomm
             mov     p0,#0c0h
             lcall   disp_wcomm

             mov     r5,#0c0h        ; ����� ������ �� DISP ����
             mov     dptr,#tcifr1 
kfa52:       mov     r6,#080h        ;  ���� �������� ������� ������
waitkfa52:   djnz    r6,waitkfa52	    
             jnb     p2.0,kfa52
             jnb     p2.1,kfa52
             jnb     p2.2,kfa52
             jnb     p2.4,kfa52
kfa53:       mov     r6,#080h        ; ���� �������� ������� ������
waitkfa530:  djnz    r6,waitkfa530	    
             jnb     p2.0,f5naz
             jnb     p2.1,f5vper
             jnb     p2.2,f5cifr
             jnb     p2.4,f5vv
             ljmp    kfa53   
f5vper:      cjne    r5,#0c1h,f5vper11 
f5vper1:     jnb     p2.1,f5vper1
             mov     dptr,#tcifr1
             ljmp    kfa52            
f5vper11:    mov     p0,#014h
             lcall   disp_wcomm             
             inc     r5
f5vper31:    jnb     p2.1,f5vper31
             mov     dptr,#tcifr1
             ljmp    kfa52
f5naz:       cjne    r5,#0c0h,f5naz321
f5naz301:    jnb     p2.0,f5naz301
             mov     dptr,#tcifr1
             ljmp    kfa52            
f5naz321:    mov     p0,#010h
             lcall   disp_wcomm
             dec     r5             
f5naz311:    jnb     p2.0,f5naz311
             mov     dptr,#tcifr1
             ljmp    kfa52    
f5cifr:      mov     a,#00h             ;����� ���� ������ ������  
             movc    a,@a+dptr
             cjne    a,#0ffh,f5vvod31
             mov     dptr,#tcifr1 
             ljmp    f5cifr
f5vvod31:    cjne    r5,#0c1h,f5vvod5
             mov     @r1,a
f5vvod51:    mov     p0,r5
             lcall   disp_wcomm
             mov     p0,a 
             lcall   disp_wdata
             mov     p0,#010h          ;������ ����� ����� ������ �����
             lcall   disp_wcomm
             inc     dptr
f5vvod32:    jnb     p2.2,f5vvod32
             ljmp    kfa52
f5vvod5:     mov     @r0,a
             ljmp    f5vvod51
f5vv:        ret


;������������ ������������ 1 ���
sek:         mov     tmod,#001h
;             clr     rs0
;             clr     rs1
             mov     r2,#014h                   ; ��� ����� ���� 20 ?????????????          
sekloop:     mov     th0,#03ch
             mov     tl0,#0b0h
             setb    tr0
seklowai:    jnb     tf0,seklowai            
             clr     tr0
             clr     tf0 
             dec     r2
             cjne    r2,#000h,sekloop
             ret
;������������ ������������ 0,1 ��� ��� �������
sek0:        mov     tmod,#001h
;             clr     rs0
;             clr     rs1
             mov     r2,#006h                   
sek00loop:   mov     th0,#03ch
             mov     tl0,#0b0h
             setb    tr0
sek0lowai:   jnb     tf0,sek0lowai            
             clr     tr0
             clr     tf0 
             dec     r2
             cjne    r2,#000h,sek00loop
             ret
; ������������ ������������ 1 ��� ��� �������
sek1:         mov     tmod,#001h
;             clr     rs0
;             clr     rs1
             mov     r2,#014h                   ; ��� ����� ���� 20 ?????????????          
sek1loop:    mov     th0,#000h
             mov     tl0,#0ffh
             setb    tr0
sek1owai:    jnb     tf0,sek1owai            
             clr     tr0
             clr     tf0 
             dec     r2
             cjne    r2,#000h,sek1loop
sek1b:       ret


;��������� �������� 2-�� ������ ������� 
mezgor:     lcall   ind
            mov     a,#038h
            anl     a,@r1         
            setb    p1.7
            mov     p0,a
            setb    p1.3
            clr     p1.3 
;            mov     p1,#030h                ;1 ������ ����� � ����������������
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
nabmez:     jnb     p2.5,nabmez              ;�������� ���������� ����������������


             mov     025h,r0            ;��������� ���� ���������
             mov     026h,r1 

             mov     r0,#0b3h                 ; ����� ������ ������� ����� ��. 2-�� ������ ��
             mov     r1,#0b4h                 ; ����� ������ ������� ����� ��. 2-�� ������ ��
             cjne    @r0,#030h,connectm1               ;1 �������� � ������� ���� ���� ���� �� �� 
             cjne    @r1,#030h,connectm2               ;2 ��������� ��� ��
             mov     r0,025h
             mov     r1,026h
             mov     p0,014h
             lcall   disp_wcomm
             ljmp    nabnom21
connectm1:   mov     a,@r0                    ;������ ������� ����� ��
             anl     a,#00fh                  ;��������� �������� ��������� � 0
             mov     r5,a                     ;������ ������� ��  � ��� �� ��������� ��� R5
             mov     r3,#00ah                 ;��������� ��������� 10����
connectm11:  mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connoz2:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connoz2
            mov     r7,#0c0h
            mov     dptr,#t2otv         ;  ����� ������ 2-�� ��� �� ������ ������    
connoza2:  mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connoza2
             jnb     p2.7,mezg7                     ; �������� ������� ��� ��(0) ���� ��� (1) �� 
             lcall   sek                            ;��������
             jnb     p2.4,pryg3                    ;������ ����� �� �������� �� ��� "OK"
             djnz    r3,connectm11
             djnz    r5,connectm11
connectm2:   cjne    @r1,#030h,connectm21
             jnb     p2.7,mezg7                          
             mov     p0,#000h                 ;1���� ����� �� �
             mov     p1,#0a0h                 ;2
             mov     p1,#0b0h                 ;3
funcm302:    mov     p0,#01h               ;����� ������ ��� 2-�� ��� ��
            lcall   disp_wcomm
            mov     r7,#080h                 ;  ����� ������ ��� 
            mov     dptr,#tnet            
funcm300:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,funcm300
            mov     r7,#0c0h                       ;  ����� ������ 2-�� ������ 
            mov     dptr,#t2otv            
funcm301:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,funcm301
            mov     p0,#080h          ; ���� ����� �� � � ��� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; ���� ����� �� � � ���� ���
            mov     p1,#0a0h             ;1 ������ � ������� ��� 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg3                    ;������ ����� �� �������� �� ��� "OK"
            djnz    028h,net3
            inc     011h
            ljmp    kommab
net3:       ljmp    progra
mezg7:      ljmp    mezgor1
pryg3:      ljmp    func1

connectm21: mov     a,@r1                    ;������ ������� ����� ��
            anl     a,#00fh                  ;��������� �������� ��������� � 0
            mov     r5,a                     ;������ ������� �� �� ��������� ��� R5
connectm211:mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  ����� ������ �������� �� ������ ������ 
            mov     dptr,#ozid            
connoz3:    mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connoz3
            mov     r7,#0c0h
            mov     dptr,#t2otv         ;  ����� ������ 2-�� ��� �� ������ ������    
connoza3:   mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            mov     a,#00h
            movc    a,@a+dptr
            cjne    a,#0ffh,connoza3
            jnb     p2.7,mezgor1              ; �������� ������� ��� ��(0) ���� ��� (1) �� 
            lcall   sek                       ;��������
            jnb     p2.4,pryg3                    ;������ ����� �� �������� �� ��� "OK"
            djnz    r5,connectm211
            ljmp    funcm302
mezgor1:    mov     r0,025h                    ;������� ���������            
            mov     r1,026h 
            mov     p0,#001h          
            lcall   disp_wcomm
            lcall   ind 
            ljmp    nabnom21
 

dubizm:                               ;��������� ������� �������� �� DISP � ������ ������ ����
             mov     a,#030h                ;�������� �� 0 ��.���� �������� ������� ������ 
             cjne    a,01bh,dub1            ;������� ���������� �� �����
             mov     01bh,#039h
             cjne    a,01ah,dub2
             mov     01ah,#039h
             cjne    a,019h,dub3
             ajmp     dubok
dub1:        dec     01bh
             jmp     dubok
dub2:        dec     01ah
             jmp     dubok
dub3:        dec     019h
             jmp     dubok
dubok:       mov     p0,#0c8h          ;����� �� ����� "XXX c" ��� ��������� �������� � ���    
             lcall   disp_wcq        ; ��� ���������
             mov     p0,019h
             lcall   disp_wdq 
             mov     p0,#0c9h             
             lcall   disp_wcq
             mov     p0,01ah
             lcall   disp_wdq 
             mov     p0,#0cah             
             lcall   disp_wcq
             mov     p0,01bh
             lcall   disp_wdq
             ret

disp_wait:     mov     p1,#0b4h              ;���. RS=0 RW=1 E=0  (������ ���� 7 ����������                                                                               ;�������)  �������� ���. DISP
               mov     p1,#0b6h              ;���. RS=0 RW=1 E=1  (���� D7=1 �� busy) 
               jb      p0.7,disp_wait
               mov     p1,#0b0h              ;���. RS=0 RW=0 E=0
               mov     r6,#080h              ;1 �������� 
wait:          djnz    r6,wait	             ;2
               ret   	      
disp_wcomm:    mov     p1,#0b0h              ;���  RS=0 RW=0    ������ �������(������) � DISP
               mov     p1,#0b2h              ;���  E=1
               mov     p1,#0b0h              ;���  E=0
               lcall   disp_wait
               ret
disp_wdata:    mov     p1,#0b1h              ;���  RS=1 RW=0  ������ ������ � DISP
               mov     p1,#0b3h              ;���  E=1
               mov     p1,#0b0h              ;���  RS=0 RW=0 E=0
               lcall   disp_wait
               ret              

;������� �����
disp_wcq:      mov     p1,#0b0h              ;���  RS=0 RW=0    ������ �������(������) � DISP
               mov     p1,#0b2h              ;���  E=1
               mov     p1,#0b0h              ;���  E=0
               lcall   disp_wq
               ret
disp_wdq:      mov     p1,#0b1h              ;���  RS=1 RW=0  ������ ������ � DISP
               mov     p1,#0b3h              ;���  E=1
               mov     p1,#0b0h              ;���  RS=0 RW=0 E=0
;               lcall   disp_wq
               ret              
disp_wq:       mov     p1,#0b4h              ;���. RS=0 RW=1 E=0  (������ ���� 7 ���������� �������)                 
                mov      p1,#0b6h              ;���. RS=0 RW=1 E=1  (���� D7=1 �� busy)
                jb         p0.7,disp_wq
                ret   


tnomer1:    db      048h                 ;����� �����+ (������)        
            db      06fh
            db      0bch
            db      065h       
            db      070h
            db      020h
            db      0ffh                 ;������ ����� ������
tab:        db      061h                 ;����� ��.        
            db      0b2h
            db      02eh
            db      0ffh       
tozid:      db      06fh                 ;����� ��.+(������)
            db      0b6h
            db      02eh
            db      020h
            db      0ffh
tsek:       db      063h                 ;����� ���        
            db      065h
            db      0bah
            db      0ffh       
tdlit:      db      0e0h                 ;����� ����. � ���.                
            db      0bbh
            db      0b8h
            db      0bfh
            db      02eh       
            db      020h
            db      0b8h
            db      020h
            db      0bah
            db      06fh       
            db      0bbh
            db      02eh
            db      0ffh                 ;������ ����� ������
tsoed:      db      063h                 ;����� ����������                
            db      06fh
            db      065h
            db      0e3h
            db      0b8h       
            db      0bdh
            db      065h
            db      0bdh
            db      0b8h
            db      0b9h       
            db      0ffh                 ;������ ����� ������
totvet:     db      06fh                 ;����� �������������                
            db      0bfh
            db      0b3h
            db      065h
            db      0bfh       
            db      020h
            db      063h
            db      0bfh
            db      0ffh                 ;������ ����� ������
t2otv:      db      032h                 ;����� 2-�����������                
            db      02dh
            db      0b4h
            db      06fh
            db      020h       
            db      06fh
            db      0bfh
            db      0b3h
            db      0ffh                 ;������ ����� ������
tpriem:     db      0beh                 ;����� �����������������                
            db      070h
            db      0b8h
            db      0b5h
            db      0bch       
            db      020h
            db      0b3h
            db      0c3h
            db      0b7h
            db      06fh
            db      0b3h       
            db      061h
            db      0ffh                 ;������ ����� ������
tmezgor:    db      0bch                 ;����� ��������                
            db      065h
            db      0b6h
            db      0b4h
            db      06fh       
            db      070h
            db      06fh
            db      0e3h
            db      0ffh                 ;������ ����� ������
tkontrsoe:  db      0bah                 ;����� �����.����������.                
            db      06fh
            db      0bdh
            db      0bfh
            db      070h       
            db      02eh
            db      020h
            db      063h
            db      06fh
            db      065h
            db      0e3h       
            db      02eh
            db      0ffh                 ;������ ����� ������
totboy:     db      04fh                 ; ����� ����� ��.
            db      054h
            db      0a0h
            db      04fh       
            db      0a6h
            db      020h
            db      041h 
            db      0a0h 
            db      02eh
            db      0ffh                 ;������ ����� ������
tstart:     db      063h                 ;����� �����?                
            db      0bfh
            db      061h
            db      070h
            db      0bfh       
            db      020h
            db      03fh
            db      0ffh                 ;������ ����� ������
tnet:       db      048h                 ;����� ���                
            db      045h
            db      054h    
            db      0ffh                 ;������ ����� ������
tcifr:      db      030h                 ;����� ������ 
            db      031h
            db      032h
            db      033h
            db      034h
            db      035h
            db      036h
            db      037h
            db      038h
            db      039h
            db      050h                 
            db      054h
            db      057h
            db      023h
            db      02ah 
            db      002h
            db      020h
            db      0ffh
tpredust:   db      030h                 ;080h   �������� ������������� ������ ��������� 
            db      032h                 ;21,2c 20
            db      031h
            db      02ch
            db      032h
            db      063h
            db      020h
            db      032h
            db      030h                 ;088h
            db      030h                 ;089h 
            db      036h                 ;62,4c 20 
            db      032h
            db      02ch
            db      034h
            db      063h
            db      020h
            db      032h
            db      030h                 ;091h             
            db      031h                 ;092h
            db      032h                 ;123,6c 20
            db      033h
            db      02ch
            db      036h
            db      063h
            db      020h
            db      032h
            db      030h                 ;09ah
            db      031h                 ;09bh
            db      038h                 ;184,8c 10
            db      034h
            db      02ch
            db      038h
            db      063h
            db      020h
            db      031h
            db      030h                 ;0A3h
            db      036h                 ;0A4h
            db      030h                 ;605,5c 5
            db      035h
            db      02ch
            db      035h
            db      063h
            db      020h
            db      030h
            db      035h                 ;0ACh
            db      0ffh
traz:       db      070h                 ;�����  ���
            db      061h
            db      0b7h
            db      0ffh
tcifr1:     db      030h
            db      031h                 ;�����
            db      032h
            db      033h
            db      034h
            db      035h
            db      036h
            db      037h
            db      038h
            db      039h
            db      0ffh
ozid:       db      06fh                 ;����� ��������
            db      0b6h
            db      0b8h
            db      0e3h
            db      061h
            db      0bdh
            db      0b8h
            db      065h
            db      0ffh
netnom:     db      048h                 ;����� ��� ������� ! 
            db      045h
            db      054h
            db      020h
            db      0bdh                        
            db      06fh
            db      0bch
            db      065h       
            db      070h
            db      06fh            
            db      0b3h
            db      021h
            db      0ffh
proba:      db      0beh                 ;����� �����
            db      070h
            db      06fh
            db      0b2h
            db      061h
            db      020h
            db      03fh
            db      0ffh
tprobe:     db      04fh                 ;080h   �������� ������������� ������ ����� 
            db      070h                 ;10,0c 01
            db      0bbh
            db      06fh
            db      0b3h
            db      020h
            db      0efh
            db      020h
            db      032h                 ;088h
            db      030h                 ;089h 
            db      030h                 ;00,0c 00 
            db      035h
            db      0ffh
tvse:     db      0a8h                 ;����� ���������
            db      050h                 
            db      04fh
            db      0a1h
            db      050h
            db      041h
            db      04dh
            db      04dh
            db      041h                
            db      0ffh    
tvse1:     db      0a4h                 ;����� ���������
            db      041h                 
            db      042h
            db      045h
            db      050h
            db      0ach
            db      045h
            db      048h
            db      041h                
            db      0ffh           
  END