;********************************************************************
;
; Author        : Pal Eagleson
;
; Date          : 12 September  2021г.
;
; File          : KVART100.asm
;
; Hardware      : АТ89C51RD2
;
; Description   :Добавлена # в набор номера и посылка свистков для проверки коннекта(разных)
;                 
;               :Добавлена задержка в 3 сек перед занятием линии
;********************************************************************
$MOD52                          ; use 8052 predefined symbols


;____________________________________________________________________
;Использование регистров:
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
;Использование ресурсов:
;T0 
;Т1 
;	
;
;
;
;____________________________________________________________________
; MAIN PROGRAM
CSEG	#0afffh			;установка внутренней памяти программ
ORG  0000h
	  jmp	start		;

ORG  0003h	

ORG  000bh			

ORG  0013h	

ORG  001bh	
	
ORG  0023h
				
ORG  0040h			




start:       mov     r7,#0feh        ;1 цикл сброса DISP
init:        mov     P0,#01h	     ;2   очистка дисплея курсор в начало
	     lcall   disp_wcomm      ;3   вызов подпрограммы запись команды в дисплей
             mov     p0,#02h         ;4  
	     lcall   disp_wcomm      ;5
             mov     p0,#0ch         ;6
             lcall   disp_wcomm      ;7
             mov     p0,#038h        ;8 даннные 8 бит 2 строки шрифт 5x7
             lcall   disp_wcomm      ;9
             djnz    r7,init	     ;10
             mov     r7,#0bfh         ;1 очистка indirect RAM данных номеров АБ. 
             mov     r0,#040h         ;2 установка в пробел  20h
resetram:    mov     @r0,#020h        ;3 временное использование регистра r0
             inc     r0               ;4
             djnz    r7,resetram      ;5
             mov     r7,#028h         ;1 очистка indirect RAM данных номеров АБ. 
             mov     r0,#0d8h         ;2 установка в пробел  20h
resetram1a:  mov     @r0,#020h        ;3 временное использование регистра r0
             inc     r0               ;4
             djnz    r7,resetram1a    ;5
             mov     r7,#00ah         ;1 очистка indirect RAM данных с адреса 0b0h
             mov     r0,#0b0h         ;2 установка в пробел  030h
resetram1:   mov     @r0,#030h        ;3 временное использование регистра r0
             inc     r0               ;4
             djnz    r7,resetram1     ;5
             mov     r7,#008h         ;1 очистка indirect RAM данных с адреса 0c0h
             mov     r0,#0c0h         ;2 установка в NO   04eh
resetram2:   mov     @r0,#04eh        ;3 временное использование регистра r0
             inc     r0               ;4
             djnz    r7,resetram2     ;5
             mov     p0,#000h           ;1установка регистра упр в 00  
             mov     p1,#0a0h           ;2
             mov     p1,#0b0h           ;3
             mov     009h,#000h             ;ячейку памяти коммутатора в 0
             setb    p1.7                     ;установка номеронабирателя в рабочий режим
             jnb     p2.0,eagle                             ;1 этто и далее есть отшень кхитри функций !!! тихо ША!!!
             ljmp    abcde
eagle:       jnb     p2.1,eagle1                            ;2
             ljmp    abcde
eagle1:      mov     p0,#001h       
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h                                ;  вывод текста длья кхитри функций !!!.
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
              lcall   disp_wcomm                         ;программирование знакогенератора для вывода инверсной 8
              mov     p0,#0fbh                           ;код символа    #002h
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
              mov     r0,#0b1h                      ;предварительная установка ОЖ ОТВ СТАН =10сек
              mov     @r0,#031h                             ;
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              inc     r0                                    ;
              mov     @r0,#032h                 ;предварительная установка ОЖ 2го ОТВ СТАН =20сек
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              inc     r0                                    ;
              mov     @r0,#031h                 ;предварительная установка ОЖ вызова =10сек
              inc     r0                                    ;
              mov     @r0,#030h                             ;
              mov     r0,#0c1h                  ;предварительная установка КОНТРОЛЬ СОЕД  "Y"  
              mov     @r0,#059h                             ; 
             mov     r0,#080h        ;1 запись в память предустановок длит. и кол. с адреса #080h 
             mov     dptr,#tpredust  
predust:     mov     a,#00h
             movc    a,@a+dptr
             mov     @r0,a
             inc     dptr
             inc     r0
             mov     a,#00h
             movc    a,@a+dptr
             cjne    a,#0ffh,predust ;8
             mov     r0,#080h        ;занес. во временную память значений первого времени и всех 
             mov     030h,@r0                        ;раз измерений
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
             mov     r1,#022h                ; предустановка ОТБОЙ - аб. А
             mov     @r1,#041h 



func1:       mov     p0,#001h       ;функция НОМЕР АБ. 1
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     p0,#000h                                 ;установка реле в 000
             mov     p1,#090h
             mov     p1,#0b0h
             mov     r7,#80h                    ;  вывод текста НОМЕР.
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
             mov     p0,#031h                    ;вывод цифры 1 в конце строки 1
             lcall   disp_wdata
kf00:        jnb     p2.2,kf00            ;1 ожидание отжатия клавиш
             jnb     p2.4,kf00            ;2
kf001:       jnb     p2.4,funca2          ;1 ожидание нажатия клавиш
             jnb     p2.2,nomer           ;2
             ajmp    kf001                ;3
funca2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    func2
nomer:                                ;ввод номера абонента
             mov     p0,#01h              ;1  очистка DISP
             lcall   disp_wcomm           ;2
             mov     p0,#00ch             ;3 включить DISP
             lcall   disp_wcomm
             mov     r0,#040h                  ;  установка указателя памяти номера вывода на DISP
             mov     r1,#040h                  ;  установка указателя записи в память номера
             mov     dptr,#tcifr               ;  вывод 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    func1
func2:      mov     p0,#01h        ;функция НОМЕР АБ. 2
            lcall   disp_wcomm
            mov     p0,#00ch                                                    
            lcall   disp_wcomm
            mov     r7,#80h               ;вывод текста НОМЕР
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
            mov     dptr,#tab             ;вывод текста АБ 
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
            mov     p0,r7                 ;вывод цифры 2 в конце строки 1
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
nomer1:                                ;ввод номера абонента
             mov     p0,#001h                  ;1  очистка DISP
             lcall   disp_wcomm                ;2
             mov     p0,#008h                  ;3 включить DISP
             lcall   disp_wcomm
             mov     r0,#058h                  ;  установка указателя памяти номера вывода на DISP
             mov     r1,#058h                  ;  установка указателя записи в память номера
             mov     dptr,#tcifr               ;  вывод 
             lcall   vyv3
             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    func2


funca2b:       mov     p0,#001h     ;функция НОМЕР АБ. 3
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h              ;вывод текста НОМЕР.
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
             mov     p0,#033h             ;вывод цифры 3 в конце строки 1
             lcall   disp_wdata
kfb00:        jnb     p2.2,kfb00              ;1 ожидание отжатия клавиш
             jnb     p2.4,kfb00               ;2
kfb001:       jnb     p2.4,funcab2            ;1 ожидание нажатия клавиш
             jnb     p2.2,nomerb              ;2
             ajmp    kfb001                   ;3
funcab2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    funca2g
nomerb:                                ;ввод номера абонента
             mov     p0,#01h                  ;1  очистка DISP
             lcall   disp_wcomm               ;2
             mov     p0,#00ch                 ;3 включить DISP
             lcall   disp_wcomm
             mov     r0,#0d0h                 ;  установка указателя памяти номера вывода на DISP
             mov     r1,#0d0h                 ;  установка указателя записи в память номера
             mov     dptr,#tcifr              ;  вывод 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    funca2b


funca2g:       mov     p0,#001h    ;функция НОМЕР АБ. 4
             lcall   disp_wcomm
             mov     p0,#00ch                                                  
             lcall   disp_wcomm
             mov     r7,#80h                 ;вывод текста НОМЕР.
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
             mov     p0,#034h               ;вывод цифры 4 в конце строки 1
             lcall   disp_wdata
kfg00:        jnb     p2.2,kfg00               ;1 ожидание отжатия клавиш
             jnb     p2.4,kfg00                ;2
kfg001:       jnb     p2.4,funcag2             ;1 ожидание нажатия клавиш
             jnb     p2.2,nomerg               ;2
             ajmp    kfg001                    ;3
funcag2:      mov     p0,#00ch                                                    
             lcall   disp_wcomm
             mov     p0,#001h
             lcall   disp_wcomm
             ljmp    func3
nomerg:                                 ;ввод номера абонента
             mov     p0,#01h                   ;1  очистка DISP
             lcall   disp_wcomm                ;2
             mov     p0,#00ch                  ;3 включить DISP
             lcall   disp_wcomm
             mov     r0,#0e8h                  ;  установка указателя памяти номера вывода на DISP
             mov     r1,#0e8h                  ;  установка указателя записи в память номера
             mov     dptr,#tcifr               ;  вывод 
             lcall   vyv3

             mov     p0,#00ch
             lcall   disp_wcomm
             ajmp    funca2g

;funca2d:       mov     p0,#001h       ;функция НОМЕР АБ. Д
;             lcall   disp_wcomm
;             mov     p0,#00ch                                                  
;             lcall   disp_wcomm
;             mov     r7,#80h                ;вывод текста НОМЕР.
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
;             mov     p0,#0e0h               ;вывод буквы  Д в конце строки 1
;             lcall   disp_wdata
;kfd00:        jnb     p2.2,kfd00                  ;1 ожидание отжатия клавиш
;             jnb     p2.4,kfd00                   ;2
;kfd001:       jnb     p2.4,funcad2                ;1 ожидание нажатия клавиш
;             jnb     p2.2,nomerd                  ;2
;             ajmp    kfd001                       ;3
;funcad2:      mov     p0,#00ch                                                    
;             lcall   disp_wcomm
;             mov     p0,#001h
;             lcall   disp_wcomm
;             ljmp    func3
;nomerd:                                 ;ввод номера абонента
;             mov     p0,#01h                      ;1  очистка DISP
;             lcall   disp_wcomm                   ;2
;             mov     p0,#00ch                     ;3 включить DISP
;             lcall   disp_wcomm
;             mov     r0,#0d8h                     ;  установка указателя памяти номера вывода на DISP
;             mov     r1,#0d8h                     ;  установка указателя записи в память номера
;             mov     dptr,#tcifr                  ;  вывод 
;             lcall   vyv3
;
;             mov     p0,#00ch
;             lcall   disp_wcomm
;             ljmp    funca2d







func3:      mov     p0,#01h          ;длит и кол 
            lcall   disp_wcomm
            mov     p0,#00ch          
            lcall   disp_wcomm
            mov     r7,#80h                  ;вывод текста ДЛИТ И КОЛ 
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
            mov     r7,#0c0h                 ;вывод текста СОЕДИНЕНИЙ 
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
dat:         mov     r0,#080h                        ;занесение в память введенных значений первого времени и всех 
             mov     @r0,030h                        ;раз измерений ,хранившихся во временной памяти
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
             mov     p0,#001h                    ;установка курсора в начало после вывода памяти ввод ПРОВЕРКА 1
             lcall   disp_wcomm
             mov     p0,#00eh                    ;включить disp и курсор
             lcall   disp_wcomm
             mov     r0,#080h
             mov     r1,#080h
             lcall   data11
             mov     r0,#080h                        ;занесение во временную память введенных значений первого времени и 
             mov     030h,@r0                        ;раз измерений
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
             mov     p0,#001h                    ;установка курсора в начало после вывода памяти ввод ПРОВЕРКА 2
             lcall   disp_wcomm
             mov     p0,#00eh                    ;включить disp и курсор
             lcall   disp_wcomm
             mov     r0,#089h
             mov     r1,#089h
             lcall   data11 
             mov     r0,#090h                         ;занесение во временную память введенных значений раз измерений
             mov     037h,@r0
             inc     r0
             mov     038h,@r0
             mov     p0,#001h                    ;установка курсора в начало после вывода памяти ввод ПРОВЕРКА 3
             lcall   disp_wcomm
             mov     p0,#00eh                    ;включить disp и курсор
             lcall   disp_wcomm
             mov     r0,#092h
             mov     r1,#092h
             lcall   data11
             mov     r0,#099h                         ;занесение во временную память введенных значений раз измерений
             mov     039h,@r0
             inc     r0
             mov     03ah,@r0
             mov     p0,#001h                    ;установка курсора в начало после вывода памяти ввод ПРОВЕРКА 4
             lcall   disp_wcomm
             mov     p0,#00eh                    ;включить disp и курсор
             lcall   disp_wcomm
             mov     r0,#09bh
             mov     r1,#09bh
             lcall   data11
             mov     r0,#0a2h                         ;занесение во временную память введенных значений раз измерений
             mov     03bh,@r0
             inc     r0
             mov     03ch,@r0
             mov     p0,#001h                    ;установка курсора в начало после вывода памяти ввод ПРОВЕРКА 5
             lcall   disp_wcomm
             mov     p0,#00eh                    ;включить disp и курсор
             lcall   disp_wcomm
             mov     r0,#0a4h
             mov     r1,#0a4h
             lcall   data11
             mov     r0,#0abh                          ;занесение во временную память введенных значений раз измерений
             mov     03dh,@r0
             inc     r0
             mov     03eh,@r0
             mov     p0,#00ch                    ;включить disp и выкл курсор
             lcall   disp_wcomm
             ljmp    func3
   
            
            
            
            
             
func4:      mov     p0,#01h          ;функция АБ 4 =) АБ 1
            lcall   disp_wcomm
            mov     r7,#80h                   ;  вывод текста  АБ 4 =) АБ 1 
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
             mov     p0,#0c0h                 ; вывод в начале второй строки           
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
             mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm


            mov     p0,#001h            ;ож ответ ст
            lcall   disp_wcomm
            mov     p0,#00ch            ;выкл курсор
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста ОЖ 
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
            dec     r7                       ;  вывод текста ОТВЕТ СТ 
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
            mov     r0,#0b1h                 ; адрес памяти старшей цифры
            mov     r1,#0b2h                 ; адрес памяти младшей цифры 
            cjne    @r0,#030h,func502               ; сравнить с памятью цифр если нули то выводим N  и ждем ввода 
            cjne    @r1,#030h,func502
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa50:     ;  mov     r6,#080h        ;  цикл ожидания отжатия клавиш
;waitkfa50:   djnz    r6,waitkfa50	    
             jnb     p2.2,kfa50
             jnb     p2.4,kfa50
kfa51:      ; mov     r6,#080h        ; цикл ожидания нажатия клавиш
;waitkfa510:  djnz    r6,waitkfa510	    
             jnb     p2.2,func502
             jnb     p2.4,func59
             ajmp    kfa51
func502:     lcall   func52
func59:  ;    mov     p0,#001h            ;сбросить disp и курсор
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm




          
;func6
            mov     p0,#01h               ;ож 2 го отв ст
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста ОЖ 
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
            dec     r7                       ;  вывод текста 2го ОТВ 
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
            mov     r0,#0b3h                 ; адрес памяти старшей цифры
            mov     r1,#0b4h                 ; адрес памяти младшей цифры 
            cjne    @r0,#030h,func602               ; сравнить с памятью цифр если нули то выводим N  и ждем ввода 
            cjne    @r1,#030h,func602
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa60:      ; mov     r6,#080h        ;  цикл ожидания отжатия клавиш
;waitkfa60:   djnz    r6,waitkfa60	    
             jnb     p2.2,kfa60
             jnb     p2.4,kfa60
kfa61:   ;    mov     r6,#080h        ; цикл ожидания нажатия клавиш
;waitkfa610:  djnz    r6,waitkfa610	    
             jnb     p2.2,func602
             jnb     p2.4,func69
             ajmp    kfa61
func602:     lcall   func52
func69:  ;    mov     p0,#001h            ;сбросить disp и  курсор
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm
            

;func7
            mov     p0,#01h             ;прием выз
            lcall   disp_wcomm
            mov     r7,#080h 
            mov     dptr,#tpriem        ; вывод ПРИЕМ ВЫЗОВА    
func70:     mov     p0,r7
            lcall   disp_wcomm
            mov     a,#00h
            movc    a,@a+dptr
            mov     p0,a
            lcall   disp_wdata
            inc     dptr
            inc     r7
            cjne    a,#0ffh,func70
            mov     r0,#0b5h                 ; адрес памяти старшей цифры
            mov     r1,#0b6h                 ; адрес памяти младшей цифры 
            cjne    @r0,#030h,func702               ; сравнить с памятью цифр если нули то выводим N  и ждем ввода 
            cjne    @r1,#030h,func702
            mov     p0,#0c0h
            lcall   disp_wcomm
            mov     p0,#04eh
            lcall   disp_wdata
kfa70:       mov     r6,#080h        ;  цикл ожидания отжатия клавиш
waitkfa70:   djnz    r6,waitkfa70	    
             jnb     p2.2,kfa70
             jnb     p2.4,kfa70
kfa71:       mov     r6,#080h        ; цикл ожидания нажатия клавиш
waitkfa710:  djnz    r6,waitkfa710	    
             jnb     p2.2,func702
             jnb     p2.4,func79
             ajmp    kfa71
func702:     lcall   func52
func79:  ;    mov     p0,#001h            ;сбросить disp и  курсор
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm
 





;func9 
            mov     p0,#01h             ;контр  соед
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста КОНТРОЛЬ СОЕД 
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
             mov     p0,#0c0h        ; вывод в начале второй строки           
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             mov     a,@r0                                       ;смотрим шо там в памяти КОНТРОЛЯ
             cjne    a,#059h,kfa90                            ;и идем на вывод того что соответственно
             ljmp    kfa96                                    ;

kfa90:       mov     r6,#080h        ;  цикл ожидания отжатия клавиш
waitkfa990:  djnz    r6,waitkfa990	    
             jnb     p2.2,kfa90
             jnb     p2.4,kfa90
kfa91:       mov     r6,#080h        ; цикл ожидания нажатия клавиш
waitkfa951:  djnz    r6,waitkfa951	    
             jnb     p2.2,func92
             jnb     p2.4,func95
             ajmp    kfa91             
func92:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#059h
             lcall   disp_wdata
             mov     @r1,#059h
kfa96:       mov     r6,#080h        ;  цикл ожидания отжатия клавиш
waitkfa960:  djnz    r6,waitkfa960	    
             jnb     p2.2,kfa96
             jnb     p2.4,kfa96
kfa97:       mov     r6,#080h        ; цикл ожидания нажатия клавиш
waitkfa971:  djnz    r6,waitkfa971	    
             jnb     p2.2,func93
             jnb     p2.4,func95
             ajmp    kfa97         
func93:      mov     p0,#0c0h            
             lcall   disp_wcomm
             mov     p0,#04eh
             lcall   disp_wdata
             mov     @r1,#04eh
kfa98:       mov     r6,#080h        ;  цикл ожидания отжатия клавиш
waitkfa980:  djnz    r6,waitkfa980	    
             jnb     p2.2,kfa98
             jnb     p2.4,kfa98
kfa99:       mov     r6,#080h        ; цикл ожидания нажатия клавиш
waitkfa991:  djnz    r6,waitkfa991	    
             jnb     p2.2,func92
             jnb     p2.4,func95
             ajmp    kfa99         
func95:  ;    mov     p0,#001h            ;сброс DISP и курсора
         ;    lcall   disp_wcomm
             mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm

;func111 
            mov     p0,#01h             ;функция ОТБОЙ АБ.
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста ОТБОЙ АБ.
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
             mov     p0,#0c0h        ; вывод в начале второй строки           
             lcall   disp_wcomm
             mov     p0,@r0
             lcall   disp_wdata
             mov     a,@r0                                       ;смотрим шо там в памяти КОНТРОЛЯ
             cjne    a,#041h,kfa119                            ;и идем на вывод того что соответственно
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
func195:      mov     p0,#00ch            ;включить disp и выкл курсор
             lcall   disp_wcomm



;func10
            mov     p0,#01h          ;функция старт
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста СТАРТ 
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
func1111:    mov     r0,#080h                        ;занесение в память введенных значений                                                      ;первого времени и всех 
             mov     @r0,030h                        ;раз измерений ,хранившихся во временной                                                      ;памяти
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


funcr11:    mov     p0,#01h          ;функция ПРОБА
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста ПРОБА 
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




; начало программы испытаний
otschet:    mov     010h,#058h              ;запись во временную память начального адреса где                                                                            ;хранятся цифры набора АБ 2
            mov     011h,#000h                   ;запись во времен. память номера проверки для                                                                                ;АБонентов(АБ А=0)АБ Б=1 итд
            mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                     ;станции
            mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                      ;вызовов
            mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                    ;межгорода
            mov     r0,#0c1h
            mov     021h,@r0
            mov     r0,#040h                  ;проверка есть ли цифры набора в памяти номера АБ.1
            cjne    @r0,#020h,nach            ;если нет то вывод текста НЕТ НОМЕРОВ!
netuti:     mov     r7,#080h                  ;и проверяем есть ли номер АБ.2   
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
            ljmp    func1                     ;и идем на самое начало 
nach:       mov     r0,#058h                  ;проверка есть ли цифры набора в памяти номера АБ.2
            cjne    @r0,#020h,nachalo         ;если нет то вывод текста НЕТ НОМЕРОВ!
            ljmp    netuti                     


nachalo:    mov     01fh,#000h                   ;установка номера проверки в 0 (первая проверка)          
            mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                        ;станции
            mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                        ;вызовов
            mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                        ;межгорода
            mov     r0,#080h               ;запись в регистр адреса старшей цифры отсчета времени
            mov     r1,#087h               ;запись в регистр адреса старшей цифры количества раз
            mov     013h,@r0                 ;запись в о временную память цифр отсчета времени
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
            mov     017h,@r1                 ;запись во временную память количества раз проверок
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1                 
            mov     r0,#0c1h
            mov     021h,@r0
            inc     011h                 ;увеличение на 1 номера набора АБ для перехода в                                          ;последующем на набор следующего АБ
            mov     a,017h                   ;проверка на 0 количества раз при первой проверке      
            cjne    a,#030h,progra                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,progra                 ;младшая цифра количества раз
            ljmp    prov2                             ;если количество раз при первой проверке                                                       ;равно нулю перейти к пров 2
            
; начало функций набора номера и всяческих проверок ответов станции
progra:     mov     p0,#01h               
            lcall   disp_wcomm
            mov     r0,#0c1h
            mov     021h,@r0
            setb    p1.7                     ;установка номеронабирателя в рабочий режим
            mov     a,017h                   ;проверка на 0 количества раз проверок      
            cjne    a,#030h,progra1                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,progra1                 ;младшая цифра количества раз
            ljmp    kom                             ;если количество раз при проверке равно нулю                                                                                                        ;перейти к KOM
progra1:    lcall   sek                      ;задержка на 3 сек перед занятием линии
            lcall   sek                      ;
            lcall   sek                      ;
            mov     a,009h
            orl     a,#010h
            mov     p0,a          ; вкл линию аб А 
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            mov     r0,#0b1h                 ; адрес памяти старшей цифры ожидания ответа ст
            mov     r1,#0b2h                 ; адрес памяти младшей цифры ожидания ответа ст
            cjne    @r0,#030h,connect1               ;1 сравнить с памятью цифр если нули то не                                                                                   ;проверяем отв ст 
            cjne    @r1,#030h,connect2               ;2
progra11:   ljmp    nabnom
connect1:   mov     a,@r0                    ;чтение старшей цифры ож
            anl     a,#00fh                  ;установка старшего полубайта в 0
            mov     r5,a                     ;запись времени ож  в сек во временный рег R5
            mov     r3,#00ah                 ;установка множителя 10хсек
connect11:  ;jnb     p2.7,progra11              ; проверка наличия отв ст(0) если нет (1) то                                                                                 ;ожидание если есть то набор
            ;lcall   sek             
            mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     r7,#0c0h           ;  вывод текста Ответ ст на второй строке
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
            jnb     p2.7,progra11              ; проверка наличия отв ст(0) если нет (1) то                                                                                 ;ожидание если есть то набор
            lcall   sek 
            jnb     p2.4,pryg1                  ;принудительный выход из проверок по нажат "OK"
            djnz    r3,connect11
            djnz    r5,connect11
connect2:   cjne    @r1,#030h,connect21
            jnb     p2.7,progra11                          
            mov     p0,#000h                 ;1выкл линии аб А
            mov     p1,#0a0h                 ;2
            mov     p1,#0b0h                 ;3
func302:    mov     p0,#01h               ;вывод текста НЕТ ОТВ СТ
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста НЕТ 
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
            mov     r7,#0c0h                       ;  вывод текста Ответ ст
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
            mov     p0,#080h          ; выкл линию аб А и вкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg1                  ;принудительный выход из проверок по нажат "OK" 
            
            djnz    r4,net1
            inc     011h
            ljmp    kommab
net1:       ljmp    progra
pryg1:      ljmp    func1
connect21:  mov     a,@r1                    ;чтение младшей цифры ож
            anl     a,#00fh                  ;установка старшего полубайта в 0
            mov     r5,a                     ;запись времени ож во временный рег R5
connect211:  mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     r7,#0c0h           ;  вывод текста Ответ ст на второй строке
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
            jnb     p2.7,nabnom                     ; проверка наличия отв ст(0) если нет (1) то                                                                                 ;ожидание
            lcall   sek             
            jnb     p2.4,pryg1                  ;принудительный выход из проверок по нажат "OK" 
            djnz    r5,connect211
            ljmp    func302


nabnom:     setb    p1.7                     ;установка номеронабирателя в рабочий режим
            mov     r0,010h           ;набор номера----установка адреса памяти номера аб А из                                                                      ;временной памяти
            mov     r1,#0c2h             ;1предустановка байта @0c2 (T/P) в P
            mov     @r1,#01fh            ;2
            mov     r4,#080h                              ;адрес вывода набираемой цифры на экран
            mov     p0,#001h          
            lcall   disp_wcomm
nabnom0:    mov     a,@r0              ;чтение первой цифры набора номера
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
nabnom6:    cjne    a,#002h,nabnom7               ;проверка на межгород ( 8 инверсная )
            ljmp    mezgor   
nabnom7:    cjne    a,#023h,nabnom3                ;проверка на(#) если да то принуд зап кода 0bh
            mov     a,#00bh                        ;в номеронабиратель
            ljmp    nabnom42
nabnom3:    cjne    a,#02ah,nabnom35                ;проверка на(*) если да то принуд зап кода 00h
            mov     a,#000h                        ;в номеронабиратель
            ljmp    nabnom42  
nabnom35:   cjne    a,#020h,nabnom4
            ljmp    nabnom5
nabnom21:   inc     r0
            ljmp    nabnom0
nabnom4: 
            lcall   ind            ;вывод набираемой цифры на экран
            anl     a,@r1         
nabnom42:   setb    p1.7                ;включение ВЫВОД ЦИФРЫ в номеронабирателе 
            mov     p0,a                ;1 запись цифры в номеронабиратель             
            setb    p1.3                ;2 
            clr     p1.3                ;3 
;            mov     p1,#030h                ;1 запись цифры в номеронабиратель
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
nabnom41:   jnb     p2.5,nabnom41           ;ожидание готовности номеронабирателя
            inc     r0
            ljmp    nabnom0
nabnom5:     mov     p0,#01h        ;прием вызова       
            lcall   disp_wcomm
            mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                     ;станции
            mov     r0,#0b5h                 ; адрес памяти старшей цифры ожидания приема выз
            mov     r1,#0b6h                 ; адрес памяти младшей цифры ожидания приема выз
            cjne    @r0,#030h,connecto1               ;1 сравнить с памятью цифр если нули то не   проверяем отв ст          
            cjne    @r1,#030h,connecto2               ;2
con111:     ljmp    connecto3
connecto1:   mov     a,@r0                    ;чтение старшей цифры ож
            anl     a,#00fh                  ;установка старшего полубайта в 0
            mov     r5,a                     ;запись времени ож  в сек во временный рег R5
            mov     r3,#00ah                 ;установка множителя 10хсек
connecto11: mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     dptr,#tpriem         ;  вывод текста ПРИЕМ ВЫЗОВА на второй строке    
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
            jnb     p2.6,con111                     ; проверка наличия приема выз(0) если нет (1)                                                                                ;то ожидание
            lcall   sek             
            djnz    r3,connecto11
            djnz    r5,connecto11
connecto2:   cjne    @r1,#030h,connecto21
            jnb     p2.6,con111                          
            mov     p0,#000h                 ;1выкл линии аб А и аб Б
            mov     p1,#0a0h                 ;2
            mov     p1,#0b0h                 ;3
funco302:    mov     p0,#01h               ;вывод текста НЕТ ПРИЕМА ВЫЗ
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста НЕТ 
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
            mov     r7,#0c0h                       ;  вывод текста прием выз
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
            mov     p0,#080h          ; выкл линию аб А и аб Б и вкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; выкл линию аб А и аб Б и выкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg2                    ;принуд выход из проверок по наж "OK"
            djnz    027h,net2
            inc     011h
            ljmp    kommab
net2:       ljmp    progra
pryg2:      ljmp    func1
connecto21:  mov     a,@r1                    ;чтение младшей цифры ож
            anl     a,#00fh                  ;установка старшего полубайта в 0
            mov     r5,a                     ;запись времени ож во временный рег R5
connecto211: mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     dptr,#tpriem         ;  вывод текста ПРИЕМ ВЫЗОВА на второй строке    
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

            jnb     p2.6,connecto3                     ; проверка наличия приема выз(0) если нет                                                         ;(1) то ожидание
            lcall   sek             
            djnz    r5,connecto211
            ljmp    funco302

connecto3:  mov     p0,#001h            ;сброс DISP и курсора 
            lcall   disp_wcomm
            mov     p0,#00ch            ;включить disp и выкл курсор
            lcall   disp_wcomm 
            mov     p0,#080h              ;вывод временной памяти на экран
            lcall   disp_wcomm
            mov     p0,013h
            lcall   disp_wdata
            mov     p0,#081h              ;вывод временной памяти на экран
            lcall   disp_wcomm
            mov     p0,014h
            lcall   disp_wdata
            mov     p0,#082h              ;вывод временной памяти на экран
            lcall   disp_wcomm
            mov     p0,015h
            lcall   disp_wdata
            mov     p0,#083h              ;вывод запятой на экран
            lcall   disp_wcomm
            mov     p0,#02ch
            lcall   disp_wdata
            mov     p0,#084h              ;вывод временной памяти на экран
            lcall   disp_wcomm
            mov     p0,016h
            lcall   disp_wdata
            mov     p0,#085h              ;вывод буквы С на экран
            lcall   disp_wcomm
            mov     p0,#063h               
            lcall   disp_wdata
            mov     p0,#0c0h              ;вывод второй строки временной памяти на экран
            lcall   disp_wcomm
            mov     p0,017h
            lcall   disp_wdata
            mov     p0,#0c1h              ;вывод второй строки временной памяти на экран
            lcall   disp_wcomm
            mov     p0,018h
            lcall   disp_wdata 
            mov     p0,#0c2h             
            lcall   disp_wcomm
            mov     p0,#020h
            lcall   disp_wdata 
             mov    r7,#0c3h
             mov     dptr,#traz        ; вывод раз                
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
             mov     p0,#0c8h          ;вывод на экран "время c" для индикации отсчетов в сек при  проверках   
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


             mov     a,#030h                         ;проверка на 0 младшей цифры раз
             cjne    a,018h,ots2  
             cjne    a,017h,ots2                         ;проверка на 0 старшей цифры раз 
             ljmp    kom



ots2:      mov     029h,#00h         ; очистка ячеек делителя для счетчика 29 мл. и 2A ст.
             mov     02ah,#00h
             mov     a,016h              ; перевод дес. знач. времени в делитель для счетчика
             mov     029h,a              ; занесение времени отсчета в МС в мл. ячейку делителя
             anl     029h,#00fh               
             dec     029h              ;уменьшение на 1 количества МСек для норм. работы счетчика     
             mov     02bh,015h              ;занесение в промежуточный регистр значений времени в СЕК    
             anl     02bh,#00fh            ; перевод в HEX
             mov     r5,02bh             ; занесение в промежуточный регистр значений времени в СЕК
             mov     a,#00h                         ;занесение в аккк. значения для проверки на 00 кол. СЕК
             cjne     a,02bh,ots2b               ; проверить на 0 кол СЕК , если =0 то идти к ДЕС СЕК
             ljmp      ots2a1

ots2b:       mov      r6,#00ah                      ;занесение в пром регистр множителя х10 для суммирования СЕК
ots2bb:      inc      029h                       ; добавление в делитель количества СЕК
             djnz     r6,ots2bb             
             djnz     r5,ots2b                    ;

ots2a1:      mov      02bh,014h              ;занесение в промежуточный регистр значений времени в ДЕС СЕК    
             anl      02bh,#00fh            ; перевод в HEX
             mov      r5,02bh             ; занесение в промежуточный регистр значений времени в ДЕС СЕК
             mov      a,#00h                         ;занесение в аккк. значения для проверки на 00 кол. ДЕС СЕК
             cjne     a,02bh,ots2a              ; проверить на 0 кол ДЕС СЕК , если =0 то идти к СОТ СЕК
             ljmp     ots2c1
ots2a:       mov      r6,#064h                      ;занесение в пром регистр множителя х100 для суммирования ДЕС СЕК
             mov      a,#0ffh                         ;занесение в аккк. значения для проверки на переполнение 029
ots2aa:      inc      029h                       ; добавление в делитель количества ДЕС СЕК
             cjne     a,029h,ots2ab                ; проверка на переполнение мл. разряда счетчика времени изм.    
             lcall    ots2d                             ; если есть FF то увеличить на 1 ст. разряды
ots2ab:      djnz     r6,ots2aa             
             djnz     r5,ots2a                    ;

ots2c1:      mov      02bh,013h              ;занесение в промежуточный регистр значений времени в СОТ СЕК    
             anl      02bh,#00fh            ; перевод в HEX
             mov      r5,02bh             ; занесение в промежуточный регистр значений времени в СОТ СЕК
             mov      a,#00h                         ;занесение в аккк. значения для проверки на 00 кол. СОТ СЕК
             cjne     a,02bh,ots2c            ; проверить на 0 кол СОТ СЕК , если =0 то идти к счету
             ljmp     counter

ots2c:       mov      r6,#064h                      ;занесение в пром регистр R6 множителя х100 для суммирования СОТ СЕК
ots2ce:      mov      r4,#00ah                    ;занесение в пром регистр R4 множителя Х10 для отсчета
             mov      a,#0ffh                         ;занесение в аккк. значения для проверки на переполнение 029  
ots2cc:      inc      029h                       
             cjne     a,029h,ots2cb                ; проверка на переполнение мл. разряда счетчика времени изм.    
             lcall    ots2d                             ; если есть FF то увеличить на 1 ст. разряды
ots2cb:      djnz     r4,ots2cc
             djnz     r6,ots2ce             
             djnz     r5,ots2c                    ;   
             ljmp     counter
ots2d:       inc      02ah
             ret








counter:      mov     tmod,#0d1h      ;установка режимов счетчиков Т0 в счет. 1 сек , Т1 в счет. 10 ГЦ 
              mov     a,029h                  ; подготовка коэффициента счета для занесения в счетчик
              cpl     a                        
              mov     029h,a
              mov     tl1,a                        ;запись коэфф. деления счета МЛ 
              mov     a,02ah
              cpl     a
              mov     02ah,a                 ;
              mov     th1,a                        ;запись коэфф. деления счета СТ
              mov     th0,#00h                   ;установки счетчика 1 СЕК
              mov     tl0,#0ffh
              clr     tr0                               ;сброс счетчиков
              clr     tf0 
              clr     tr1                              ;сброс счетчиков
              clr     tf1
              mov     r1,#0c1h          ;запись в рег. адреса ячейки памяти с информацией ЕСТЬ или НЕТ проверка линии
              mov     r3,#003h            ;количество сбоев контроля линии =3

;начало счета, включение линий

             mov     a,009h                  ; вкл линию аб А и линию аб Б 
             orl     a,#030h
             mov     p0,a                   
             mov     p1,#0a0h               ;1 запись в регистр упр 
             mov     p1,#0b0h               ;2          
 
             setb    tr1                                ;старт счета 10ГЦ

count1:      mov     p0,#001h                ;контроль соединения
             setb    p1.3
             clr     p1.3   
;             mov     p1,#000h               ;1 запись тональной цифры 1 в номеронабиратель и включение режима ТОН
;             mov     p1,#008h                ;2 удержание цифры
             clr     p1.7                   ;включение режима ТЕСТ в номеронабирателе  
               mov     r7,#017h                   ;установки счетчика 1 СЕК и запуск
count1a:       setb    tr0                                ;старт счета 1ГЦ

countsek:      jbc     tf1,count10                 ;проверка конца счета 10ГЦ, сброс готовности и переход на КОЛ ПРОВЕРОК 
               jnb     tf0,countsek           ;проверка конца счета 1СЕК, если есть то вывод цифр     
               clr     tr0                               ;сброс счетчиков
               clr     tf0 
               djnz    r7,count1a
               cjne    @r1,#059h,countsek1                  ; проверка НАДО ЛИ проверять линию?           
               jb      p3.4,countsek1                               ;чтение контрольного сигнала наличия линии
               djnz    r3,countsek1
               ljmp    hy                                   ;включение сигнала аварии

countsek1:     lcall   dubizm                ; вывод и подсчет секунд до конца проверки
               mov     th0,#00h                   ;установки счетчика 1 СЕК
               mov     tl0,#0ffh             
               jnb     p2.4,stoper                          ; проверка нажатия клавиш для ОТКАЗ от проверки, клавиша "OK"
	    
               ljmp    count1


count10:       clr     tr1                               ;сброс счетчиков
               clr     tf1 
               mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
               mov     p1,#0a0h             ;1 запись в регистр упр 
               mov     p1,#0b0h             ;2
               clr     tr0                               ;сброс счетчиков
               clr     tf0 
               ljmp    raz3

stoper:        clr     tr1                               ;сброс счетчиков
               clr     tf1 
               mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
               mov     p1,#0a0h             ;1 запись в регистр упр 
               mov     p1,#0b0h             ;2
               clr     tr0                               ;сброс счетчиков
               clr     tf0 
               setb    p1.7
               ljmp    func1                         ; насильный конец проверок




raz3:        mov     a,#030h                         ;проверка на 0 младшей цифры раз
             cjne    a,018h,raz2a  
             cjne    a,017h,raz1                     ;проверка на 0 старшей цифры раз 

              
kom:         mov     a,01fh
             cjne    a,#000h,sr1 
             mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода
             ljmp    prov2
sr1:         cjne    a,#001h,sr2 
             mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода
             ljmp    prov3
sr2:         cjne    a,#002h,sr3
             mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода
             ljmp    prov4
sr3:         cjne    a,#003h,sr4
             mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода
             ljmp    prov5
sr4:         cjne    a,#004h,sr5
             mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода
             ljmp    kommab              
sr5:        mov     r4,#00ah                           ;запись 10 для отсчета отсутсвий ответов                                                                                                           ;станции
             mov     027h,#00ah                         ;запись 10 для отсчета отсутсвий приема                                                                                                             ;вызовов
             mov     028h,#00ah                         ;запись 10 для отсчета отсутсвий стгналов                                                                                                          ;межгорода 
            ljmp    kommab

pryg10:      setb    p1.7
             ljmp    func1
raz2a:     ljmp    raz2         
raz1:        mov     018h,#039h                        ;запись 9 в младшую цифру раз и декремент                                                                                         ;старшей цифры
             dec     017h 
             mov     019h,013h
             mov     01ah,014h
             mov     01bh,015h

            mov     r0,#022h               ;отбой абонентов
            mov     a,@r0
            cjne    a,#041h,kommut7a              ;проверка --отбой аб. А потом Б? Если нет то идти на отбой аб. Б.
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
kommut7a:    mov     p0,#010h                           ; отбой аб. Б потом А
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4                
            

;             mov     p0,#000h                 ;1выкл линии аб А
;             mov     p1,#0a0h                 ;2
;             mov     p1,#0b0h                 ;3
;             lcall   sek
;             setb    p1.7
             ljmp    progra
raz2:        dec     018h
             mov     019h,013h
             mov     01ah,014h
             mov     01bh,015h
            mov     r0,#022h               ;отбой абонентов
            mov     a,@r0
            cjne    a,#041h,kommut7b              ;проверка --отбой аб. А потом Б? Если нет то идти на отбой аб. Б.
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
kommut7b:    mov     p0,#010h                           ; отбой аб. Б потом А
            clr     p1.4 
            setb    p1.4 
            lcall   sek
            lcall   sek
            lcall   sek
            mov     p0,#000h     
            clr     p1.4 
            setb    p1.4                
                         
;             mov     p0,#000h                 ;1выкл линии аб А
;             mov     p1,#0a0h                 ;2
;             mov     p1,#0b0h                 ;3
;             lcall   sek
;             setb    p1.7
             ljmp    progra
             
prov2:      inc     01fh
            mov     r0,#089h               ;запись в регистр адреса старшей цифры отсчета времени
            mov     r1,#090h               ;запись в регистр адреса старшей цифры количества раз
            mov     013h,@r0                 ;запись в о временную память цифр отсчета времени
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
            mov     017h,@r1                 ;запись во временную память количества раз проверок
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;проверка на 0 количества раз
            cjne    a,#030h,prov21                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,prov21                 ;младшая цифра количества раз
            ljmp    prov3                    ;если количество раз при первой проверке равно нулю                                              ;перейти к пров 3
prov21:     setb    p1.7
            ljmp    progra
prov3:      inc     01fh
            mov     r0,#092h               ;запись в регистр адреса старшей цифры отсчета времени
            mov     r1,#099h               ;запись в регистр адреса старшей цифры количества раз
            mov     013h,@r0                 ;запись в о временную память цифр отсчета времени
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
            mov     017h,@r1                 ;запись во временную память количества раз проверок
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;проверка на 0 количества раз
            cjne    a,#030h,prov31                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,prov31                 ;младшая цифра количества раз
            ljmp    prov4                    ;если количество раз при первой проверке равно нулю                                              ;перейти к пров 4
prov31:     ljmp    progra
prov4:      inc     01fh
            mov     r0,#09bh               ;запись в регистр адреса старшей цифры отсчета времени
            mov     r1,#0a2h               ;запись в регистр адреса старшей цифры количества раз
            mov     013h,@r0                 ;запись в о временную память цифр отсчета времени
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
            mov     017h,@r1                 ;запись во временную память количества раз проверок
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;проверка на 0 количества раз
            cjne    a,#030h,prov41                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,prov41                 ;младшая цифра количества раз
            ljmp    prov5                    ;если количество раз при первой проверке равно нулю                                              ;перейти к пров 5
prov41:     setb    p1.7
            ljmp    progra
prov5:      inc     01fh
            mov     r0,#0a4h               ;запись в регистр адреса старшей цифры отсчета времени
            mov     r1,#0abh               ;запись в регистр адреса старшей цифры количества раз
            mov     013h,@r0                   ;запись в о временную память цифр отсчета времени
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
            mov     017h,@r1                 ;запись во временную память количества раз проверок
            mov     01dh,@r1   
            inc     r1
            mov     018h,@r1
            mov     01eh,@r1             
            mov     a,017h                   ;проверка на 0 количества раз
            cjne    a,#030h,prov51                 ;старшая цифра количества раз
            mov     a,018h
            cjne    a,#030h,prov51                 ;младшая цифра количества раз
            ljmp    kommab                   ;если количество раз при проверке равно нулю перейти                                              ;к проверке набора ном. АБ
prov51:    setb    p1.7
           ljmp    progra

kommab:    mov     a,011h
           cjne    a,#001h,kommab1
           ljmp    ab2
kommab1:   cjne    a,#002h,kommab2
           ljmp    ab3 
kommab2:   cjne    a,#003h,kommutp
           ljmp    kommutp
kommab3:   cjne    a,#004h,kommutp          ;если набраны все АБоненты то перейти к проверке                                                                             ;переключ коммутатора линий
           ljmp    kommut
kommutp:   ljmp    kommut

ab2:       mov     010h,#0d0h              ;запись во временную память начального адреса где                                            ;хранятся цифры набора АБ 3
           mov     r0,#0d0h                  ;проверка есть ли цифры набора в памяти номера АБ.3
           cjne    @r0,#020h,ab2a            ;если нет то уст номер пров для АБ в 1 т.е есть                                              ;набираем номер АБ 1
           mov     p0,#050h                                 ;установка реле в 101  "2 на 1"
           mov     p1,#090h
           mov     p1,#0b0h                                
           mov     010h,#040h              ;запись во временную память начального адреса где                                            ;хранятся цифры набора АБ 1
           mov     r0,#040h   
           ljmp    nachalo                    ;и идем на набор АБ 1
ab2a:      mov     p0,#010h                                 ;установка реле в 001  "2 на 3"
           mov     p1,#090h
           mov     p1,#0b0h
           ljmp    nachalo                   ;и идем на набор АБ 3
ab3:       mov     010h,#0d0h              ;запись во временную память начального адреса где                                            ;хранятся цифры набора АБ 3
           mov     r0,#0d0h                  ;проверка есть ли цифры набора в памяти номера АБ.3
           cjne    @r0,#020h,ab3a            ;если нет то идем на проверку АБ 4                      
           inc     011h                      ; 
           inc     011h 
           ljmp    kommab                    ;и идем на коммутатор абонентов
ab3a:      mov     p0,#060h                                 ;установка реле в 110  "3 на 1"
           mov     p1,#090h
           mov     p1,#0b0h
           mov     010h,#040h              ;запись во временную память начального адреса где                                                                            ;хранятся цифры набора АБ 1
           mov     r0,#040h              

           setb    p1.7
           ljmp    nachalo 


          ljmp    nachalo
ab4:       mov     010h,#040h              ;запись во временную память начального адреса где                                                                            ;хранятся цифры набора АБ Г
           mov     r0,#040h                  ;проверка есть ли цифры набора в памяти номера АБ.Г
           cjne    @r0,#020h,ab4a            ;если нет то уст номер пров для АБ в 1 т.е есть                                                                              ;набираем номер АБ.Д
           inc     011h                      ; 
           ljmp    kommab                    ;и идем на коммутатор абонентов
ab4a:      ljmp    nachalo

ab5:       mov     010h,#0e8h              ;запись во временную память начального адреса где                                                                                                   ;хранятся цифры набора АБ 4
           mov     r0,#0e8h                  ;проверка есть ли цифры набора в памяти номера АБ.4
           cjne    @r0,#020h,ab5a            ;
           inc     011h                      ; 
           ljmp    kommab                    ;и идем на коммутатор абонентов
ab5a:       mov     p0,#000h             ;сброс всех сигналов управлен 
            clr     p1.5
            setb    p1.5                      ;запись в рег. упр. по новому

;            mov     p1,#0a0h             ;1 запись в регистр упр 
;            mov     p1,#0b0h             ;2
;            mov     p0,#000h                                 ;установка реле в 000  "4 на 1"
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            mov     p0,#01h               
            lcall   disp_wcomm
            mov     p0,#010h                ; вкл линию аб Д 
            clr     p1.4
            setb    p1.4                      ;запись в рег. упр. по новому
;            mov     p1,#0a0h                ;1 запись в регистр упр 
;            mov     p1,#0b0h                ;2
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     r7,#0c0h           ;  вывод текста Ответ ст на второй строке
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
            jnb     p2.7,sosnab              ; проверка наличия отв ст(0) если нет (1) то                                                                                 ;ожидание если есть то набор
            jnb     p2.4,stop1                          ; проверка нажатия клавиш для ОТКАЗ от проверки, клавиша "OK"
            lcall   sek                          ;ожидание ответа ст в течение 3 сек
            jnb     p2.4,stop1                          ; проверка нажатия клавиш для ОТКАЗ от проверки, клавиша "OK"
            lcall   sek                          ;
            lcall   sek                          ;
            jnb     p2.7,sosnab              ; проверка наличия отв ст(0) если нет (1) то по новой если есть то набор  
            jnb     p2.4,stop1                          ; проверка нажатия клавиш для ОТКАЗ от проверки, клавиша "OK" 
            ljmp     ab5a
stop1:      ljmp    func1
sosnab:     mov     r0,010h           ;набор номера----установка адреса памяти номера аб Д из 
                                       ;временной памяти
            mov     r1,#0c2h                   ;1предустановка байта @0c2 (T/P) в P
            mov     @r1,#01fh                  ;2
            mov     r4,#080h                              ;адрес вывода набираемой цифры на экран
            mov     p0,#001h          
            lcall   disp_wcomm
sosnom0:    mov     a,@r0              ;чтение первой цифры набора номера
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
sosnom6:    cjne    a,#038h,sosnom3                  ;проверка на межгород ( 8 )
            cjne    r4,#080h,sos                     ;межгор первая цифра номера?если да то                                                      ;проверка готовности ответа ст
            ljmp    sosgor   
sos:        cjne    r4,#081h,sosnom3                 ;межгор вторая цифра номера?если да то  
            ljmp    sosgor                           ;проверка готовности ответа ст
sosnom3:    cjne    a,#020h,sosnom4
            ljmp    sosnom5
sosnom21:   inc     r0
            ljmp    sosnom0
sosnom4: 
            lcall   ind                 ;вывод набираемой цифры на экран
            anl     a,@r1          
            setb    p1.7 
            mov     p0,a
            setb    p1.3
            clr     p1.3 
;            mov     p1,#030h                   ;1 запись цифры в номеронабиратель
;            mov     p1,#038h                   ;2 
;            mov     p1,#030h                   ;3
sosnom41:   jnb     p2.5,sosnom41              ;ожидание готовности номеронабирателя
            inc     r0
            ljmp    sosnom0
sosnom5:     mov     r4,#010h           ;уст. множителя для повторения писков в течение 32 сек
sosnom51:    mov     p0,#0cbh                        ;вывод крякозябрика  ^             
             lcall   disp_wcomm
             mov     p0,#0d9h                        ;вывод крякозябрика  ^             
             lcall   disp_wdata
             jnb     p2.4,sosnom7
             setb    p1.7 
             mov     p0,#001h                  ;
             setb    p1.3
             clr     p1.3 
;             mov     p1,#030h                  ;1 запись тональной цифры 1 в номеронабиратель
;             mov     p1,#038h                  ;2 
;             mov     p1,#030h                  ;3
             lcall   sek
             mov     p0,#0cbh                        ;вывод крякозябрика  ^             
             lcall   disp_wcomm
             mov     p0,#0dah                        ;вывод крякозябрика  ^             
             lcall   disp_wdata
             lcall   sek
             jnb     p2.4,sosnom7
             djnz    r4,sosnom51
             mov     p0,#000h             ;сброс всех сигналов управлен 
             mov     p1,#0a0h             ;1 запись в регистр упр 
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
;            mov     p1,#030h                ;1 запись цифры в номеронабиратель
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
sosmez:     jnb     p2.5,sosmez 
            lcall   sek                           ;ожидание ответа межгорода в теч 4 сек
            lcall   sek                           ;
            lcall   sek                           ;
            lcall   sek                           ;
            ljmp    sosnom21
















kommut:     mov     r0,#0c0h               ;переключение АБ.Д))АБ.А
            mov     a,@r0
            cjne    a,#059h,kommut1              ;проверка --надо ли переключать
            mov     009h,#040h                          ;ячейку памяти коммутатора в коммутацию
;            mov     a,#04eh                      ;если надо то сбросить байт переключения в N
;            mov     @r0,a    
            mov     p0,#000h                   ;запись в порт упр комманды перекл коммутатора
            clr     p1.5
            setb    p1.5 
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            lcall   sek
            mov     010h,#0d8h                  ;установить адрес хранения номера набора АБ.Д
            mov     011h,#003h                    ;установить точку проверки для подпрогр kommab

            ljmp    ab5
kommut1:
;           mov     p0,#000h                   ;запись в порт упр сброс всех сигналов
;            clr     p1.5 
;            setb    p1.5
;            mov     p1,#0a0h
;            mov     p1,#0b0h
            mov     009h,#000h
            mov     r0,#022h               ;отбой абонентов
            mov     a,@r0
            cjne    a,#041h,kommut7              ;проверка --отбой аб. А потом Б? Если нет то идти на отбой аб. Б.
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
kommut7:    mov     p0,#010h                           ; отбой аб. Б потом А
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
            mov     r7,#80h            ;  вывод текста ПРОГРАММА на первой строке 
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
            mov     r7,#0c0h           ;  вывод текста ЗАВЕРШЕНА на второй строке
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
vsek:      jnb     p2.4,vsek            ; ожидание нажатия клавиши ОК
vsek1:    jnb     p2.4,vsek2
             ljmp    vsek1

vsek2:    ljmp    funcr11
    
hy:
;            mov     p0,#080h          ;выкл лин.аб А и вкл ГЕН-все это индик. нарушения линии!!!!
;            mov     p1,#0a0h             ;1 запись в регистр упр 
;            mov     p1,#0b0h             ;2
;            jnb     p2.4,hy1
;            lcall   sek
;            mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
;            mov     p1,#0a0h             ;1 запись в регистр упр 
;            mov     p1,#0b0h             ;2
;            mov     p0,#080h          ; выкл линию аб А и вкл ГЕН
;            mov     p1,#0a0h             ;1 запись в регистр упр 
;            mov     p1,#0b0h             ;2
;            jnb     p2.4,hy1
;            lcall   sek
;            mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
;            mov     p1,#0a0h             ;1 запись в регистр упр 
;            mov     p1,#0b0h             ;2
             lcall   sek
             jnb     p2.4,hy1
              mov     r0,#080h               ;запись в регистр адреса старшей цифры отсчета времени       
              mov     019h,@r0                 ;запись в о временную память цифр отсчета времени
              inc     r0              
              mov     01ah,@r0
              inc     r0
              mov     01bh,@r0
;             ljmp     ab5 
             ljmp     progra
hy1:         ljmp     func1                ; (ab5)

prob:        mov     r0,#080h         ;занесение в память значений первого времени  
             mov     a,#030h          ;10.0 cek и раз 01 пробы
             mov     @r0,a                           ;в остальные разы измерений 00 раз
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
ind:                                     ;подпр.выв.набираемых номеронабирателем цифр на экран
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
             









vyv3:        mov     r5,#080h         ;  установка указателя addr disp регистр R5           
vyv1:        mov     p0,r5            ;        R5- аддр на дисплее
             lcall   disp_wcomm       ;        R0- указатель памяти номера вывода на DISP        
             mov     p0,@r0           ;        R1- адрес памяти номера
             lcall   disp_wdata       ;        К3- адрес курсора
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
             mov     p0,#00eh           ;установка курсора в начало после вывода памяти номера
             lcall   disp_wcomm
             mov     p0,#002h          ;включить disp и курсор
             lcall   disp_wcomm
             mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
             mov     r3,#000h        ;установка адреса курсора







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
vvod:       mov     a,#00h             ;вывод цифр набора номера  
            movc    a,@a+dptr
            cjne    a,#0ffh,vvod1
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    vvod
vvod1:      mov     @r1,a
            mov     p0,r5
            lcall   disp_wcomm
            mov     p0,a 
            lcall   disp_wdata
            mov     p0,#010h          ;курсор назад после вывода цифры
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
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0            
nazad1:     jc      nazad2
            cjne    r5,#0cdh,nazad2
nazad11:    lcall   sek0
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0                     
nazad2:     cjne    r5,#080h,nazad21
            ljmp    nazad22
nazad21:    mov     p0,#010h
            lcall   disp_wcomm
            dec     r5
            dec     r1
nazad22:    
            lcall   sek0
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0
vpered:     cjne    r5,#08bh,vpered1
vpered0:    mov     p0,#0c0h
            lcall   disp_wcomm
            mov     r5,#0c0h
vpered01:   inc     r1 
            lcall   sek0
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0            
vpered1:    jc      vpered2
            cjne    r5,#0cbh,vpered2
vpered11:   
            lcall   sek0
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0                     
vpered2:    mov     p0,#014h
            lcall   disp_wcomm
            inc     r5
            inc     r1 
vpered21:  
            lcall   sek0
            mov     dptr,#tcifr        ;установка указателя адреса памяти цифр
            ljmp    kfa0            

data11:      mov     r5,#080h         ;  установка указателя addr disp регистр R5           
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
             mov     p0,#00eh            ;установка курсора в начало после вывода памяти 
             lcall   disp_wcomm
             mov     p0,#002h            ;включить disp и курсор
             lcall   disp_wcomm
             mov     dptr,#tcifr1        ;установка указателя адреса памяти цифр
             mov     r5,#080h            ;установка адреса курсора
            
kfa310:  ;    mov     r6,#080h           ;  цикл ожидания отжатия клавиш
waitkfa310:  	    
             jnb     p2.0,kfa310
             jnb     p2.1,kfa310
             jnb     p2.2,kfa310
             jnb     p2.4,kfa310
             djnz    r6,waitkfa310
kfa311:   ;   mov     r6,#030h        ; цикл ожидания нажатия клавиш
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
vvod310:     mov     a,#00h             ;вывод цифр набора номера  
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
             mov     p0,#010h          ;курсор назад после вывода цифры
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

;подпрограмма "ввода ХХ сек"
func52:      mov     p0,#00eh        ; разрешаем  курсор и дисплей 
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
             mov     dptr,#tsek        ; вывод сек    
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

             mov     r5,#0c0h        ; адрес вывода на DISP цифр
             mov     dptr,#tcifr1 
kfa52:       mov     r6,#080h        ;  цикл ожидания отжатия клавиш
waitkfa52:   djnz    r6,waitkfa52	    
             jnb     p2.0,kfa52
             jnb     p2.1,kfa52
             jnb     p2.2,kfa52
             jnb     p2.4,kfa52
kfa53:       mov     r6,#080h        ; цикл ожидания нажатия клавиш
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
f5cifr:      mov     a,#00h             ;вывод цифр набора номера  
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
             mov     p0,#010h          ;курсор назад после вывода цифры
             lcall   disp_wcomm
             inc     dptr
f5vvod32:    jnb     p2.2,f5vvod32
             ljmp    kfa52
f5vvod5:     mov     @r0,a
             ljmp    f5vvod51
f5vv:        ret


;подпрограмма формирования 1 сек
sek:         mov     tmod,#001h
;             clr     rs0
;             clr     rs1
             mov     r2,#014h                   ; или МОЖЕТ БЫТЬ 20 ?????????????          
sekloop:     mov     th0,#03ch
             mov     tl0,#0b0h
             setb    tr0
seklowai:    jnb     tf0,seklowai            
             clr     tr0
             clr     tf0 
             dec     r2
             cjne    r2,#000h,sekloop
             ret
;подпрограмма формирования 0,1 сек для отсчета
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
; подпрограмма формирования 1 сек для отсчета
sek1:         mov     tmod,#001h
;             clr     rs0
;             clr     rs1
             mov     r2,#014h                   ; или МОЖЕТ БЫТЬ 20 ?????????????          
sek1loop:    mov     th0,#000h
             mov     tl0,#0ffh
             setb    tr0
sek1owai:    jnb     tf0,sek1owai            
             clr     tr0
             clr     tf0 
             dec     r2
             cjne    r2,#000h,sek1loop
sek1b:       ret


;программа ожидания 2-го ответа станции 
mezgor:     lcall   ind
            mov     a,#038h
            anl     a,@r1         
            setb    p1.7
            mov     p0,a
            setb    p1.3
            clr     p1.3 
;            mov     p1,#030h                ;1 запись цифры в номеронабиратель
;            mov     p1,#038h                ;2 
;            mov     p1,#030h                ;3
nabmez:     jnb     p2.5,nabmez              ;ожидание готовности номеронабирателя


             mov     025h,r0            ;временное сохр регистров
             mov     026h,r1 

             mov     r0,#0b3h                 ; адрес памяти старшей цифры ож. 2-го ответа ст
             mov     r1,#0b4h                 ; адрес памяти младшей цифры ож. 2-го ответа ст
             cjne    @r0,#030h,connectm1               ;1 сравнить с памятью цифр если нули то не 
             cjne    @r1,#030h,connectm2               ;2 проверяем отв ст
             mov     r0,025h
             mov     r1,026h
             mov     p0,014h
             lcall   disp_wcomm
             ljmp    nabnom21
connectm1:   mov     a,@r0                    ;чтение старшей цифры ож
             anl     a,#00fh                  ;установка старшего полубайта в 0
             mov     r5,a                     ;запись времени ож  в сек во временный рег R5
             mov     r3,#00ah                 ;установка множителя 10хсек
connectm11:  mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     dptr,#t2otv         ;  вывод текста 2-го ОТВ на второй строке    
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
             jnb     p2.7,mezg7                     ; проверка наличия отв ст(0) если нет (1) то 
             lcall   sek                            ;ожидание
             jnb     p2.4,pryg3                    ;принуд выход из проверок по наж "OK"
             djnz    r3,connectm11
             djnz    r5,connectm11
connectm2:   cjne    @r1,#030h,connectm21
             jnb     p2.7,mezg7                          
             mov     p0,#000h                 ;1выкл линии аб А
             mov     p1,#0a0h                 ;2
             mov     p1,#0b0h                 ;3
funcm302:    mov     p0,#01h               ;вывод текста НЕТ 2-го ОТВ СТ
            lcall   disp_wcomm
            mov     r7,#080h                 ;  вывод текста НЕТ 
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
            mov     r7,#0c0h                       ;  вывод текста 2-го Ответа 
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
            mov     p0,#080h          ; выкл линию аб А и вкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            lcall   sek
            mov     p0,#000h          ; выкл линию аб А и выкл ГЕН
            mov     p1,#0a0h             ;1 запись в регистр упр 
            mov     p1,#0b0h             ;2
            jnb     p2.4,pryg3                    ;принуд выход из проверок по наж "OK"
            djnz    028h,net3
            inc     011h
            ljmp    kommab
net3:       ljmp    progra
mezg7:      ljmp    mezgor1
pryg3:      ljmp    func1

connectm21: mov     a,@r1                    ;чтение младшей цифры ож
            anl     a,#00fh                  ;установка старшего полубайта в 0
            mov     r5,a                     ;запись времени ож во временный рег R5
connectm211:mov     p0,#001h          
            lcall   disp_wcomm
            mov     r7,#80h            ;  вывод текста ОЖИДАНИЕ на первой строке 
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
            mov     dptr,#t2otv         ;  вывод текста 2-го ОТВ на второй строке    
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
            jnb     p2.7,mezgor1              ; проверка наличия отв ст(0) если нет (1) то 
            lcall   sek                       ;ожидание
            jnb     p2.4,pryg3                    ;принуд выход из проверок по наж "OK"
            djnz    r5,connectm211
            ljmp    funcm302
mezgor1:    mov     r0,025h                    ;восстан регистров            
            mov     r1,026h 
            mov     p0,#001h          
            lcall   disp_wcomm
            lcall   ind 
            ljmp    nabnom21
 

dubizm:                               ;индикация времени проверки на DISP в правом нижнем углу
             mov     a,#030h                ;проверка на 0 мл.разр счетчика сколько прошло 
             cjne    a,01bh,dub1            ;времени выводимого на экран
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
dubok:       mov     p0,#0c8h          ;вывод на экран "XXX c" для индикации отсчетов в сек    
             lcall   disp_wcq        ; при проверках
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

disp_wait:     mov     p1,#0b4h              ;уст. RS=0 RW=1 E=0  (чтение бита 7 готовности                                                                               ;дисплея)  ожидание гот. DISP
               mov     p1,#0b6h              ;уст. RS=0 RW=1 E=1  (если D7=1 то busy) 
               jb      p0.7,disp_wait
               mov     p1,#0b0h              ;уст. RS=0 RW=0 E=0
               mov     r6,#080h              ;1 задержка 
wait:          djnz    r6,wait	             ;2
               ret   	      
disp_wcomm:    mov     p1,#0b0h              ;уст  RS=0 RW=0    Запись команды(адреса) в DISP
               mov     p1,#0b2h              ;уст  E=1
               mov     p1,#0b0h              ;уст  E=0
               lcall   disp_wait
               ret
disp_wdata:    mov     p1,#0b1h              ;уст  RS=1 RW=0  Запись данных в DISP
               mov     p1,#0b3h              ;уст  E=1
               mov     p1,#0b0h              ;уст  RS=0 RW=0 E=0
               lcall   disp_wait
               ret              

;быстрый вывод
disp_wcq:      mov     p1,#0b0h              ;уст  RS=0 RW=0    Запись команды(адреса) в DISP
               mov     p1,#0b2h              ;уст  E=1
               mov     p1,#0b0h              ;уст  E=0
               lcall   disp_wq
               ret
disp_wdq:      mov     p1,#0b1h              ;уст  RS=1 RW=0  Запись данных в DISP
               mov     p1,#0b3h              ;уст  E=1
               mov     p1,#0b0h              ;уст  RS=0 RW=0 E=0
;               lcall   disp_wq
               ret              
disp_wq:       mov     p1,#0b4h              ;уст. RS=0 RW=1 E=0  (чтение бита 7 готовности дисплея)                 
                mov      p1,#0b6h              ;уст. RS=0 RW=1 E=1  (если D7=1 то busy)
                jb         p0.7,disp_wq
                ret   


tnomer1:    db      048h                 ;текст НОМЕР+ (пробел)        
            db      06fh
            db      0bch
            db      065h       
            db      070h
            db      020h
            db      0ffh                 ;маркер конец текста
tab:        db      061h                 ;текст АБ.        
            db      0b2h
            db      02eh
            db      0ffh       
tozid:      db      06fh                 ;текст ОЖ.+(пробел)
            db      0b6h
            db      02eh
            db      020h
            db      0ffh
tsek:       db      063h                 ;текст СЕК        
            db      065h
            db      0bah
            db      0ffh       
tdlit:      db      0e0h                 ;текст ДЛИТ. И КОЛ.                
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
            db      0ffh                 ;маркер конец текста
tsoed:      db      063h                 ;текст СОЕДИНЕНИЙ                
            db      06fh
            db      065h
            db      0e3h
            db      0b8h       
            db      0bdh
            db      065h
            db      0bdh
            db      0b8h
            db      0b9h       
            db      0ffh                 ;маркер конец текста
totvet:     db      06fh                 ;текст ОТВЕТпробелСТ                
            db      0bfh
            db      0b3h
            db      065h
            db      0bfh       
            db      020h
            db      063h
            db      0bfh
            db      0ffh                 ;маркер конец текста
t2otv:      db      032h                 ;текст 2-гопробелОТВ                
            db      02dh
            db      0b4h
            db      06fh
            db      020h       
            db      06fh
            db      0bfh
            db      0b3h
            db      0ffh                 ;маркер конец текста
tpriem:     db      0beh                 ;текст ПРИЕМпробелВЫЗОВА                
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
            db      0ffh                 ;маркер конец текста
tmezgor:    db      0bch                 ;текст МЕЖГОРОД                
            db      065h
            db      0b6h
            db      0b4h
            db      06fh       
            db      070h
            db      06fh
            db      0e3h
            db      0ffh                 ;маркер конец текста
tkontrsoe:  db      0bah                 ;текст КОНТР.пробелСОЕД.                
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
            db      0ffh                 ;маркер конец текста
totboy:     db      04fh                 ; текст ОТБОЙ АБ.
            db      054h
            db      0a0h
            db      04fh       
            db      0a6h
            db      020h
            db      041h 
            db      0a0h 
            db      02eh
            db      0ffh                 ;маркер конец текста
tstart:     db      063h                 ;текст СТАРТ?                
            db      0bfh
            db      061h
            db      070h
            db      0bfh       
            db      020h
            db      03fh
            db      0ffh                 ;маркер конец текста
tnet:       db      048h                 ;текст НЕТ                
            db      045h
            db      054h    
            db      0ffh                 ;маркер конец текста
tcifr:      db      030h                 ;цифры набора 
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
tpredust:   db      030h                 ;080h   значения предустановки данных испытаний 
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
traz:       db      070h                 ;текст  РАЗ
            db      061h
            db      0b7h
            db      0ffh
tcifr1:     db      030h
            db      031h                 ;цифры
            db      032h
            db      033h
            db      034h
            db      035h
            db      036h
            db      037h
            db      038h
            db      039h
            db      0ffh
ozid:       db      06fh                 ;текст ОЖИДАНИЕ
            db      0b6h
            db      0b8h
            db      0e3h
            db      061h
            db      0bdh
            db      0b8h
            db      065h
            db      0ffh
netnom:     db      048h                 ;текст НЕТ НОМЕРОВ ! 
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
proba:      db      0beh                 ;текст ПРОБА
            db      070h
            db      06fh
            db      0b2h
            db      061h
            db      020h
            db      03fh
            db      0ffh
tprobe:     db      04fh                 ;080h   значения предустановки данных теста 
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
tvse:     db      0a8h                 ;текст ПРОГРАММА
            db      050h                 
            db      04fh
            db      0a1h
            db      050h
            db      041h
            db      04dh
            db      04dh
            db      041h                
            db      0ffh    
tvse1:     db      0a4h                 ;текст ЗАВЕРШЕНА
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