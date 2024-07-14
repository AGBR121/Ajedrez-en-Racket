#lang racket

#|
- Fecha:  18/05/2024
- Hora de Publicacion: 10:00pm
- Version del código: 3.0
- Autor: Ing(c) Burbano Rodriguez Angel Gabriel
- Lenguaje utilizado: Racket
- Versión del lenguaje: 8.8
- Presentado a: Doctor Ricardo Moreno Laverde
- Universidad Tecnológica de Pereira
- Programa de Ingeniería de Sistemas y Computación
- Descripcion del programa: Este programa consiste en un algoritmo para jugar ajedrez con sus respectivas reglas.
Te avisará cuando hagas un movimiento ilegal, un jaque o jaque mate.
- SALVEDAD: El programa no tiene las funciones para realizar enroque y peón al paso
|#

;Llamamos la libreria graphics
(require graphics/graphics)
;Abrimos los graficos
(open-graphics)
;Definimos la ventana
(define chess (open-viewport "Ajedrez" 1200 800))

#|--------------------------------------------------
Funcion DrawBoard que dibuja los cuadros en la ventana
- Identificador local x: guarda la posicion en x del tablero
- Identificador local y: guarda la posicion en y del tablero
- Identificador local counter: cuenta cuantas casillas ha dibujado
|#

(define (DrawBoard x y colorCounter) 
       ( if (<= y 700)
            ( if (<= x 700)
                ( if ( = (remainder colorCounter 2) 1 )
                     [begin
                     ((draw-solid-rectangle chess) (make-posn x y) 100 100 "AliceBlue")
                     (DrawBoard (+ 100 x) y (+ 1 colorCounter))
                     ];Fin begin
                ;De lo contrario
                     [begin
                     ((draw-solid-rectangle chess) (make-posn x y) 100 100 "CadetBlue")
                     (DrawBoard (+ 100 x) y (+ 1 colorCounter))
                     ];Fin begin
                );Fin if ( = (remainder colorCounter 2) 1 )
            ;De lo contrario
                ( if ( = (remainder colorCounter 2) 1 )     
                  (DrawBoard 0 (+ 100 y) 0)
                ;De lo contrario
                  (DrawBoard 0 (+ 100 y) 1)
                );Fin if ( = (remainder colorCounter 2) 1 )
            ); Fin if (<= x 700)
       ;De lo contrario 
            [void]
       );Fin if (<= y 800)
);fin función drawGame

;--------------------------------------------------------

;Hacemos llamado a la función DrawBoard
(DrawBoard 0 0 1)

;---------------PIEZAS-NEGRAS-----------------------------

(define T "torrenegro.png")
(define C "caballonegro.png")
(define A "alfilnegro.png")
(define D "damanegro.png")
(define R "reynegro.png")
(define P "peonnegro.png")

;---------------PIEZAS-BLANCAS-----------------------------

(define t "torreblanco.png")
(define c "caballoblanco.png")
(define a "alfilblanco.png")
(define d "damablanco.png")
(define r "reyblanco.png")
(define p "peonblanco.png")

#|--------------------------------------------------
Funcion ImprimirPiezas que dibuja las piezas en la ventana
|#

(define (ImprimirPiezas) 
;---------------PIEZAS-NEGRAS-----------------------------
  
(((draw-pixmap-posn T ) chess) (make-posn 0 0))
(((draw-pixmap-posn C ) chess) (make-posn 100 0))
(((draw-pixmap-posn A ) chess) (make-posn 200 0))
(((draw-pixmap-posn D ) chess) (make-posn 300 0))
(((draw-pixmap-posn R ) chess) (make-posn 400 0))
(((draw-pixmap-posn A ) chess) (make-posn 500 0))
(((draw-pixmap-posn C ) chess) (make-posn 600 0))
(((draw-pixmap-posn T ) chess) (make-posn 700 0))
(((draw-pixmap-posn P ) chess) (make-posn 0 100))
(((draw-pixmap-posn P ) chess) (make-posn 100 100))
(((draw-pixmap-posn P ) chess) (make-posn 200 100))
(((draw-pixmap-posn P ) chess) (make-posn 300 100))
(((draw-pixmap-posn P ) chess) (make-posn 400 100))
(((draw-pixmap-posn P ) chess) (make-posn 500 100))
(((draw-pixmap-posn P ) chess) (make-posn 600 100))
(((draw-pixmap-posn P ) chess) (make-posn 700 100))

;---------------PIEZAS-BLANCAS-----------------------------
  
(((draw-pixmap-posn t ) chess) (make-posn 0 700))
(((draw-pixmap-posn c ) chess) (make-posn 100 700))
(((draw-pixmap-posn a ) chess) (make-posn 200 700))
(((draw-pixmap-posn d ) chess) (make-posn 300 700))
(((draw-pixmap-posn r ) chess) (make-posn 400 700))
(((draw-pixmap-posn a ) chess) (make-posn 500 700))
(((draw-pixmap-posn c ) chess) (make-posn 600 700))
(((draw-pixmap-posn t ) chess) (make-posn 700 700))
(((draw-pixmap-posn p ) chess) (make-posn 0 600))
(((draw-pixmap-posn p ) chess) (make-posn 100 600))
(((draw-pixmap-posn p ) chess) (make-posn 200 600))
(((draw-pixmap-posn p ) chess) (make-posn 300 600))
(((draw-pixmap-posn p ) chess) (make-posn 400 600))
(((draw-pixmap-posn p ) chess) (make-posn 500 600))
(((draw-pixmap-posn p ) chess) (make-posn 600 600))
(((draw-pixmap-posn p ) chess) (make-posn 700 600))
);Fin función ImprimirPiezas

;------------------------------------------------------

;Texto inicial
((draw-solid-rectangle chess) (make-posn 800 0) 400 800 "LightGray")
((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "DimGray")
((draw-rectangle chess) (make-posn 900 575) 200 100 "Black")
((draw-string chess) (make-posn 955 625) "Juegan Blancas" "Yellow")

((draw-solid-rectangle chess) (make-posn 900 680) 200 100 "Red")
((draw-rectangle chess) (make-posn 900 680) 200 100 "Black")
((draw-string chess) (make-posn 955 735) "Finalizar Juego" "Black")
;Llamado a la función
(ImprimirPiezas) 

#|--------------------------------------------------
Función SquareWhiteBlack que sirve para dibujar el cuadro con su respectivo color
- Identificador local x: guarda el valor de x de donde estaba la pieza
- Identificador local y: guarda el valor de y de donde estaba la pieza
|#

(define (SquareWhiteBlack x y) 
  (if (or ( and (or (= (* (quotient x 100) 100) 0) (= (* (quotient x 100) 100) 200) (= (* (quotient x 100) 100) 400)
                (= (* (quotient x 100) 100) 600))
            (or (= (* (quotient y 100) 100) 0) (= (* (quotient y 100) 100) 200) (= (* (quotient y 100) 100) 400)
                (= (* (quotient y 100) 100) 600) (= (* (quotient y 100) 100) 800)))
          ( and (or (= (* (quotient x 100) 100) 100) (= (* (quotient x 100) 100) 300) (= (* (quotient x 100) 100) 500)
                (= (* (quotient x 100) 100) 700) )
            (or (= (* (quotient y 100) 100) 100) (= (* (quotient y 100) 100) 300) (= (* (quotient y 100) 100) 500)
                (= (* (quotient y 100) 100) 700) ))
      )
      ((draw-solid-rectangle chess) (make-posn (* (quotient x 100) 100) (* (quotient y 100) 100)) 100 100 "AliceBlue")
      ;De lo contrario
      ((draw-solid-rectangle chess) (make-posn (* (quotient x 100) 100) (* (quotient y 100) 100)) 100 100 "CadetBlue")
  );Fin if 
);Fin función SquareWhiteBlack

;------------------------------------------------------

;Identificador stringChess con la cadena de string inicial del juego

(define stringChess "TCADRACTPPPPPPPP                                pppppppptcadract")

#|--------------------------------------------------

Función FindPiece que sirve para encontrar la pieza dentro del string
- Identificador local string: guarda la cadena de string del juego
- Identificador local initial: guarda la posición del primer click donde se dio en la pantalla
|#
(define (FindPiece string initial)
(substring string initial ( + initial 1))
);Fin función encontrarPieza

#|--------------------------------------------------

Funcion ChangeChar que sirve para cambiar un caracter en una cadena ya dada en una posicion que el
usuario necesite y el char, lo pone el usuario
- Identificador local str: es la cadena de string a cambiar
- Identificador local char: es el caracter por el cual reemplazaremos
- Identificador local pos: es el valor de la posicion
|#

(define (ChangeChar str char pos)
  (string-append (substring str 0 pos)
                 char
                 (substring str (+ pos 1))
  )
);Fin función ChangeChar

;--------------------------------------------------

;Función PrintPiece que imprime la pieza de acuerdo a la posicion dada
;Identificador Local piece: guarda la pieza jugada
;Identificador local x: guarda el valor de x en donde se jugó la pieza
;Identificador local y: guarda el valor de y en donde se jugó la pieza

(define (PrintPiece piece x y)
    (if (char=? (string-ref piece 0) #\T)
      (((draw-pixmap-posn T ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
    ;De lo contrario
      (if (char=? (string-ref piece 0) #\C)
       (((draw-pixmap-posn C ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
      ;De lo contrario
       (if (char=? (string-ref piece 0) #\A)
        (((draw-pixmap-posn A ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
       ;De lo contrario
        (if (char=? (string-ref piece 0) #\D)
         (((draw-pixmap-posn D ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
        ;De lo contrario
         (if (char=? (string-ref piece 0) #\R)
          (((draw-pixmap-posn R ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
         ;De lo contrario
          (if (char=? (string-ref piece 0) #\P)
           (((draw-pixmap-posn P ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
          ;De lo contrario
          (if (char=? (string-ref piece 0) #\t)
           (((draw-pixmap-posn t ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
          ;De lo contrario
           (if (char=? (string-ref piece 0) #\c)
            (((draw-pixmap-posn c ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
           ;De lo contrario
            (if (char=? (string-ref piece 0) #\a)
             (((draw-pixmap-posn a ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
            ;De lo contrario
              (if (char=? (string-ref piece 0) #\d)
               (((draw-pixmap-posn d ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
              ;De lo contrario
               (if (char=? (string-ref piece 0) #\r)
                (((draw-pixmap-posn r ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
               ;De lo contrario
                (((draw-pixmap-posn p ) chess) (make-posn (* (quotient x 100) 100) (*(quotient y 100)100) ))
              );Fin if (char=? (string-ref pieza 0) #\r)
             );Fin if (char=? (string-ref pieza 0) #\d)
            );Fin if (char=? (string-ref pieza 0) #\a)
           );Fin if (char=? (string-ref pieza 0) #\c)
          );Fin if (char=? (string-ref pieza 0) #\t)
         );Fin if (char=? (string-ref pieza 0) #\P)
        );Fin if (char=? (string-ref pieza 0) #\R)
       );Fin if (char=? (string-ref pieza 0) #\D)
      );Fin if (char=? (string-ref pieza 0) #\A)
     );Fin if (char=? (string-ref pieza 0) #\C)
    );Fin if (char=? (string-ref pieza 0) #\T)
);Fin función ImprimirPieza

#|-------------------------------------------------------

Funcion BlackAlliedPiece que verifica si la pieza negra, va a caer encima de otra pieza negra, si es verdad,
devolvemos falso para que no haga la jugada, de lo contrario, que la haga
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
|#

(define (BlackAlliedPiece string pos)
 (if (char-upper-case? (string-ref string pos))
     #f
     ;De lo contrario
     #t
 );Fin if (char-upper-case? (string-ref string pos))
);Fin función BlackAlliedPiece

#|-------------------------------------------------------

Funcion WhiteAlliedPiece que verifica si la pieza blanca, va a caer encima de otra pieza blanca, si es verdad,
devolvemos falso para que no haga la jugada, de lo contrario, que la haga
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
|#

(define (WhiteAlliedPiece string pos)
 (if (char-lower-case? (string-ref string pos))
     #f
     ;De lo contrario
     #t
 );Fin if (char-lower-case? (string-ref string pos))
);Fin función WhiteAlliedPiece

#|-------------------------------------------------------

Funcion PawnBlackEnemy que verifica si el peón negro puede capturar la pieza
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (PawnBlackEnemy string pos x y xf yf)
 (if (and (char-lower-case? (string-ref string pos)) (or (= (- x 1) xf ) (= (+ x 1) xf ) ) (= (+ y 1) yf ) )
     #t
     ;De lo contrario
     #f
 );Fin if (char-lower-case? (string-ref string pos))
);Fin función PawnBlackEnemy

#|-------------------------------------------------------

Funcion PawnBlackEnemy que verifica si el peón negro puede capturar la pieza
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (PawnWhiteEnemy string pos x y xf yf)
 (if (and (char-upper-case? (string-ref string pos)) (or (= (- x 1) xf ) (= (+ x 1) xf ) ) (= (- y 1) yf ) )
     #t
     ;De lo contrario
     #f
 );Fin if (char-upper-case? (string-ref string pos))
);Fin función PawnBlackEnemy

#|-------------------------------------------------------

Funcion StopPawnWhite que detiene el peon blanco si hay uno adelante de el
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (StopPawnWhite string pos y yf)
 (if (and (char-alphabetic? (string-ref string pos)) (or (= (- y 1) yf ) (= (- y 2) yf ) ) )
     #f
     ;De lo contrario
     #t
 );Fin if (and (char-alphabetic? (string-ref string pos)) (or (= (- y 1) yf ) (= (- y 2) yf ) ) )
);Fin función StopPawnWhite

#|-------------------------------------------------------

Funcion StopPawnBlack que detiene el peon blanco si hay uno adelante de el
- Identificador local string: guarda el string del juego
- Identificador local pos: guarda la posición en donde se realizará la jugada
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

( define ( StopPawnBlack string pos y yf )
 ( if ( and ( char-alphabetic? ( string-ref string pos)) (or (= (+ y 1) yf ) (= (+ y 2) yf ) ) )
     #f
     ;De lo contrario
     #t
 );Fin if (and ( char-alphabetic? (string-ref string pos)) (or (= (+ y 1) yf ) (= (+ y 2) yf ) ) )
);Fin función StopPawnBlack

#|-------------------------------------------------------

Funcion DownUp que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion final desde abajo
hasta arriba
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define ( DownUp string initialPos y yf counter )
 (if ( = y ( + yf 1 ) )
     #t
 ;De lo contrario
     (if ( char-alphabetic? ( string-ref string ( - initialPos (* counter 8) ) ) )
         #f
     ;De lo contrario
         ( DownUp string initialPos ( - y 1 ) yf ( + 1 counter ) )
     );Fin if ( char-alphabetic? ( string-ref string ( - initialPos (* counter 8) ) ) )
 );Fin if ( = y ( + yf 1 ) )
);Fin funcion DownUp

#|-------------------------------------------------------

Funcion UpDown que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion final desde arriba
hasta abajo
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (UpDown string initialPos y yf counter)
 (if (= y (- yf 1) )
     #t
 ;De lo contrario
     ( if ( char-alphabetic? ( string-ref string ( + initialPos (* counter 8) ) ) )
         #f
     ;De lo contrario
         ( UpDown string initialPos ( + y 1 ) yf ( + 1 counter ) )
     );Fin if (char-alphabetic? (string-ref string (+ initialPos (* counter 8) ) ) )
 );Fin if (= y (- yf 1) )
);Fin función UpDown

#|-------------------------------------------------------

Funcion LeftRight que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la izquierda hasta la derecha
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
|#

(define (LeftRight string initialPos x xf counter)
 (if (= x (- xf 1))
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (+ initialPos counter )))
         #f
     ;De lo contrario
         (LeftRight string initialPos (+ x 1) xf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (+ initialPos counter )))
 );Fin if (= x (- xf 1)) 
);Fin función LeftRight

#|-------------------------------------------------------

Funcion RightLeft que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la derecha hasta la izquierda
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
|#

(define (RightLeft string initialPos x xf counter)
 (if (= x (+ xf 1))
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (- initialPos counter )))
         #f
     ;De lo contrario
         (RightLeft string initialPos (- x 1) xf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (- initialPos counter )))
 );Fin if (= x (+ xf 1))
);Fin función RightLeft


#|-------------------------------------------------------

Funcion DiagonalTopLeft que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la derecha superior hasta la izquierda inferior
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (DiagonalTopLeft string initialPos x xf y yf counter)
 (if (and (= x (+ xf 1)) (= y (+ yf 1)) )
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (- initialPos (+ (* counter 8) counter ) )))
         #f
     ;De lo contrario
         (DiagonalTopLeft string initialPos (- x 1) xf (- y 1) yf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (- initialPos counter )))
 );Fin if (= x (+ xf 1))
);Fin funcion DiagonalTopLeft

#|-------------------------------------------------------

Funcion DiagonalBottomRight que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la izquierda superior hasta la derecha inferior
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (DiagonalBottomRight string initialPos x xf y yf counter)
 (if (and (= x (- xf 1)) (= y (- yf 1)) )
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (+ initialPos (+ (* counter 8) counter ) )))
         #f
     ;De lo contrario
         (DiagonalBottomRight string initialPos (+ x 1) xf (+ y 1) yf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (- initialPos counter )))
 );Fin if (= x (+ xf 1))
);Fin funcion DiagonalBottomRight

#|-------------------------------------------------------

Funcion DiagonalBottomLeft que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la derecha inferior hasta la izquierda superior
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (DiagonalBottomLeft string initialPos x xf y yf counter)
 (if (and (= x (+ xf 1)) (= y (- yf 1)) )
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (+ initialPos (- (* counter 8) counter ) )))
         #f
     ;De lo contrario
         (DiagonalBottomLeft string initialPos (- x 1) xf (+ y 1) yf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (- initialPos counter )))
 );Fin if (= x (+ xf 1))
);Fin funcion DiagonalBottomLeft

#|-------------------------------------------------------

Funcion DiagonalTopRight que eavlua si hay una pieza en el camino entre la posicion inicial y la posicion
final desde la izquierda inferior hasta la derecha superior
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde está inicialmente la pieza
- Identificador local x: guarda la posicion en x de la pieza
- Identificador local xf: guarda la posicion en x de la pieza donde se jugará
- Identificador local y: guarda la posicion en y de la pieza
- Identificador local yf: guarda la posicion en y de la pieza donde se jugará
|#

(define (DiagonalTopRight string initialPos x xf y yf counter)
 (if (and (= x (- xf 1)) (= y (+ yf 1)) )
     #t
 ;De lo contrario
     (if (char-alphabetic? (string-ref string (- initialPos (- (* counter 8) counter ) )))
         #f
     ;De lo contrario
         (DiagonalTopRight string initialPos (+ x 1) xf (- y 1) yf (+ 1 counter))
     );Fin if (char-alphabetic? (string-ref string (- initialPos counter )))
 );Fin if (= x (+ xf 1))
);Fin funcion DiagonalTopRight

#|-------------------------------------------------------

Funcion StopBlackPieces que evita que las piezas negras no salten como si fuera un caballo de acuerdo a la situacion
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde se encuentra la pieza
- Identificador local x: guarda el valor de x en el primer click
- Identificador local y: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local counter: es el contador de casillas de acuerdo al espacio entre la posicion de la pieza y donde
se quiere jugar
- Identificador local finalPos: guarda la posición en donde se realizará la jugada
|#

(define (StopBlackPieces string initialPos x y xf yf counter finalPos)
 ( if (or (= (- x 1) xf) (= (+ x 1) xf) (= (- y 1) yf) (= (+ y 1) yf))
      (BlackAlliedPiece string finalPos)
 ;De lo contrario
      (if (and (= x xf ) (> y yf) )
          (DownUp string initialPos y yf counter)
      ;De lo contrario
          (if (and (= x xf ) (< y yf) )
              (UpDown string initialPos y yf counter)
          ;De lo contrario
              (if (and (< x xf ) (= y yf) )
                  (LeftRight string initialPos x xf counter)
              ;De lo contrario    
                  (if (and (> x xf ) (= y yf) )
                      (RightLeft string initialPos x xf counter)
                  ;De lo contrario
                      (if (and (> x xf ) (> y yf) )
                          (DiagonalTopLeft string initialPos x xf y yf counter)
                       ;De lo contrario
                          (if (and (< x xf ) (< y yf) )
                              (DiagonalBottomRight string initialPos x xf y yf counter)
                          ;De lo contrario
                              (if (and (> x xf ) (< y yf) )
                                  (DiagonalBottomLeft string initialPos x xf y yf counter)
                              ;De lo contrario
                                  (if (and (< x xf ) (> y yf) )
                                      (DiagonalTopRight string initialPos x xf y yf counter)
                                  ;De lo contrario
                                      (void)
                                  );Fin if (and (< x xf ) (> y yf) )
                              );Fin if (and (> x xf ) (< y yf) )
                          );Fin if (and (< x xf ) (< y yf) ) 
                      );Fin if (and (> x xf ) (> y yf) )
                  );Fin if (and (> x xf ) (= y yf) ) 
              );Fin (and (< x xf ) (= y yf) )  
          );Fin if (and (= x xf ) (< y yf) )  
     );Fin if (and (= x xf ) (> y yf) )
 );Fin if (or (= (- x 1) xf) (= (+ x 1) xf) (= (- y 1) yf) (= (+ y 1) yf))
);Fin función StopBlackPieces
#|-------------------------------------------------------

Funcion StopWhitePieces que evita que las piezas blancas no salten como si fuera un caballo de acuerdo a la situacion
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde se encuentra la pieza
- Identificador local x: guarda el valor de x en el primer click
- Identificador local y: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local counter: es el contador de casillas de acuerdo al espacio entre la posicion de la pieza y donde
se quiere jugar
- Identificador local finalPos: guarda la posición en donde se realizará la jugada
|#

(define (StopWhitePieces string initialPos x y xf yf counter finalPos)
 (if (or (= (- x 1) xf) (= (+ x 1) xf) (= (- y 1) yf) (= (+ y 1) yf))
     (WhiteAlliedPiece string finalPos)
 ;De lo contrario
      (if (and (= x xf ) (> y yf) )
          (DownUp string initialPos y yf counter)
      ;De lo contrario
          (if (and (= x xf ) (< y yf) )
              (UpDown string initialPos y yf counter)
          ;De lo contrario
              (if (and (< x xf ) (= y yf) )
                  (LeftRight string initialPos x xf counter)
              ;De lo contrario    
                  (if (and (> x xf ) (= y yf) )
                      (RightLeft string initialPos x xf counter)
                  ;De lo contrario
                      (if (and (> x xf ) (> y yf) )
                          (DiagonalTopLeft string initialPos x xf y yf counter)
                       ;De lo contrario
                          (if (and (< x xf ) (< y yf) )
                              (DiagonalBottomRight string initialPos x xf y yf counter)
                          ;De lo contrario
                              (if (and (> x xf ) (< y yf) )
                                  (DiagonalBottomLeft string initialPos x xf y yf counter)
                              ;De lo contrario
                                  (if (and (< x xf ) (> y yf) )
                                      (DiagonalTopRight string initialPos x xf y yf counter)
                                  ;De lo contrario
                                      (void)
                                  );Fin if (and (< x xf ) (> y yf) )
                              );Fin if (and (> x xf ) (< y yf) )
                          );Fin if (and (< x xf ) (< y yf) ) 
                      );Fin if (and (> x xf ) (> y yf) )  
                  );Fin if (and (> x xf ) (= y yf) ) 
              );Fin (and (< x xf ) (= y yf) )  
          );Fin if (and (= x xf ) (< y yf) )  
     );Fin if (and (= x xf ) (> y yf) )
 );Fin if (or (= (- x 1) xf) (= (+ x 1) xf) (= (- y 1) yf) (= (+ y 1) yf))
);Fin función StopWhitePieces

#|-------------------------------------------------------
Funcion menu que dibujará las opciones a escoger
- Identificador local turn: guarda el turno del jugador y así mismo coloca el color de la pieza a coronar.
|#

(define (Menu turn)
( if (= turn 1)
     [begin
       ((draw-solid-rectangle chess) (make-posn 940 25) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 25) 125 125 "Black" )
       (((draw-pixmap-posn d ) chess) (make-posn 952 37))
  
       ((draw-solid-rectangle chess) (make-posn 940 160) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 160) 125 125 "Black" )
       (((draw-pixmap-posn t ) chess) (make-posn 952 172))

       ((draw-solid-rectangle chess) (make-posn 940 295) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 295) 125 125 "Black" )
       (((draw-pixmap-posn c ) chess) (make-posn 952 307))

       ((draw-solid-rectangle chess) (make-posn 940 430) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 430) 125 125 "Black" )
       (((draw-pixmap-posn a ) chess) (make-posn 952 442))
     ];Fin begin
;De lo contrario     
     [begin
       ((draw-solid-rectangle chess) (make-posn 940 25) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 25) 125 125 "Black" )
       (((draw-pixmap-posn D ) chess) (make-posn 952 37))
  
       ((draw-solid-rectangle chess) (make-posn 940 160) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 160) 125 125 "Black" )
       (((draw-pixmap-posn T ) chess) (make-posn 952 172))

       ((draw-solid-rectangle chess) (make-posn 940 295) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 295) 125 125 "Black" )
       (((draw-pixmap-posn C ) chess) (make-posn 952 307))

       ((draw-solid-rectangle chess) (make-posn 940 430) 125 125 "White")
       ((draw-rectangle chess) (make-posn 940 430) 125 125 "Black" )
       (((draw-pixmap-posn A ) chess) (make-posn 952 442))
     ];Fin begin
);Fin if (= turn 1)
);Fin funcion menu

#|-------------------------------------------------------

Funcion EndCoronation que termina el proceso de la coronación del peón y continua el juego
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde se encuentra la pieza
- Identificador local xi: guarda el valor de x en el primer click
- Identificador local yi: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local counter: es el contador de casillas de acuerdo al espacio entre la posicion de la pieza y donde
se quiere jugar
- Identificador local pieza: guarda la pieza coronada
|#
   
(define (EndCoronation turn string xi xf yi yf initialPlace finalPlace counter pieza)
(if (equal? pieza #t)
    (void)
;De lo contrario
    [begin  
      ((draw-solid-rectangle chess) (make-posn 800 0) 400 556 "LightGray")
      (SquareWhiteBlack xf yf)  
      (PrintPiece ( ~a pieza) xf yf) 
      (SquareWhiteBlack xi yi)
      (printf (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace))
      (newline)
      ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "DimGray")
      ((draw-rectangle chess) (make-posn 900 575) 200 100 "Black")
      ((draw-string chess) (make-posn 955 625) (if (= turn 1) "Juegan Negras" "Juegan Blancas") "Yellow")
      (if (if (= turn 1)
              (BlackCheckmate (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace) 0 0 #t)
          ;De lo contrario
              (WhiteCheckmate (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace) 0 0 #t)
          );Fin if (= turn 1)
          [begin   
             ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
             ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
             ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "LightGray")
             ((draw-string chess) (make-posn 955 405) (if (= turn 1) "Ganan Blancas" "Ganan Negras") "Yellow")
             (EndGame)
          ];Fin begin
     ;De lo contrario
          (Game (if (= turn 1) 2 1) (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace) (void) (void) (void) (+ counter 1))     
     )#|Fin if (if (= turn 1)
              (CheckMateBlack (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace) 0 0 #t)
          ;De lo contrario
              (CheckMateWhite (ChangeChar (ChangeChar string ( ~a pieza) finalPlace) " " initialPlace) 0 0 #t)
          )|#
      
    ];Fin begin
);Fin if (equal? pieza #t)
);Fin funcion EndCoronation

#|-------------------------------------------------------

Funcion CrownBlackPawn que realiza la funcion para coronar un peon negro
- Identificador local turn: guarda el turno del juego
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde se encuentra la pieza
- Identificador local xi: guarda el valor de x en el primer click
- Identificador local yi: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local counter: es el contador de casillas de acuerdo al espacio entre la posicion de la pieza y donde
se quiere jugar
- Identificador local initialPlace: guarda la posición del primer click
- Identificador local finalPlace: guarda la posición del segundo click
|#

( define (CrownBlackPawn turn string xi xf yi yf initialPlace finalPlace counter)

;Llamamos a la funcion menu   
(Menu turn)

;Funcion Answer que recibe que va a escoger el usuario
(define (Answer)
;Definimos el click
(define pieza (get-mouse-click chess))
;Definimos el valor de x del click
(define x (posn-x (mouse-click-posn pieza)))
;Definimos el valor de y del click  
(define y (posn-y (mouse-click-posn pieza)))
( if (and (< x 1100) (> x 900) (> y 680) (< y 780))
     [begin
     (close-viewport chess)
     #t
     ];Fin begin
;De lo contrario
     (if (and (< x 1055) (> x 940) )
         (if (and (> y 25) (< y 150))
             #\D
         ;De lo contrario
             (if (and (> y 160) (< y 285))
                 #\T
             ;De lo contrario    
                 (if (and (> y 295) (< y 420))
                     #\C
                 ;De lo contrario    
                     (if (and (> y 430) (< y 555))
                         #\A
                     ;De lo contrario
                         (Answer)
                     );Fin if (and (> y 450) (< y 525))
                 );Fin if (and (> y 325) (< y 400))
            );Fin if (and (> y 200) (< y 275))
         );Fin if (and (> y 75) (< y 150))
     ;De lo contrario    
         (Answer)
     );Fin if (and (< x 1100) (> x 900) )
);Fin if (and (< x 1100) (> x 900) (> y 680) (< y 780)) 
)
;Llamamos la función EndCoronation
(EndCoronation turn string xi xf yi yf initialPlace finalPlace counter (Answer))  
);Fin funcion CrownBlackPawn   

#|-------------------------------------------------------

Funcion CrownwWhitePawn que realiza la funcion para coronar un peon blanco
- Identificador local turn: guarda el turno del juego
- Identificador local string: guarda el string del juego
- Identificador local initialPos: guarda la posición en donde se encuentra la pieza
- Identificador local xi: guarda el valor de x en el primer click
- Identificador local yi: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local counter: es el contador de casillas de acuerdo al espacio entre la posicion de la pieza y donde
se quiere jugar
- Identificador local initialPlace: guarda la posición del primer click
- Identificador local finalPlace: guarda la posición del segundo click
|#

( define (CrownwWhitePawn turn string xi xf yi yf initialPlace finalPlace counter)

;Llamamos a la funcion menu   
(Menu turn)

;Funcion Answer que recibe que va a escoger el usuario
(define (Answer)
;Definimos el click
(define piece (get-mouse-click chess))
;Definimos el valor de x del click
(define x (posn-x (mouse-click-posn piece)))
;Definimos el valor de y del click  
(define y (posn-y (mouse-click-posn piece)))
( if (and (< x 1100) (> x 900) (> y 680) (< y 780))
     [begin
     (close-viewport chess)
     #t
     ];Fin begin
;De lo contrario
     (if (and (< x 1055) (> x 940) )
         (if (and (> y 25) (< y 150))
             #\d
         ;De lo contrario
             (if (and (> y 160) (< y 285))
                 #\t
             ;De lo contrario    
                 (if (and (> y 295) (< y 420))
                     #\c
                 ;De lo contrario    
                     (if (and (> y 430) (< y 555))
                         #\a
                     ;De lo contrario
                         (Answer)
                     );Fin if (and (> y 450) (< y 525))
                 );Fin if (and (> y 325) (< y 400))
            );Fin if (and (> y 200) (< y 275))
         );Fin if (and (> y 75) (< y 150))
     ;De lo contrario    
         (Answer)
     );Fin if (and (< x 1100) (> x 900) )
);Fin if (and (< x 1100) (> x 900) (> y 680) (< y 780)) 
)
;Llamamos la función EndCoronation
(EndCoronation turn string xi xf yi yf initialPlace finalPlace counter (Answer))  
);Fin funcion CrownwWhitePawn

#|-------------------------------------------------------

Funcion MovementPieces que restringe los movimientos de las piezas de acuerdo a la situación
- Identificador local piece: guarda la pieza que se jugará
- Identificador local string: guarda el string del juego
- Identificador local x: guarda el valor de x en el primer click
- Identificador local y: guarda el valor de y en el primer click
- Identificador local xf: guarda el valor de x en el segundo click
- Identificador local yf: guarda el valor de y en el segundo click
- Identificador local finalPos: guarda la posición en donde se realizará la jugada
|#

(define (MovementPieces piece string x y xf yf finalPos initialPos)
  
 (cond
    
;-------------------CASO-TORRE-NEGRA----------------------------
  
  ((char=? (string-ref piece 0) #\T)
   (if (and (or (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf)) (and (> x xf) (= y yf)))
            (BlackAlliedPiece string finalPos) (StopBlackPieces string initialPos x y xf yf 1 finalPos) )
       #t
   ;De lo contrario
       #f
   );Fin if 
  )
    
;-------------------CASO-TORRE-BLANCA-----------------------------
  
  ((char=? (string-ref piece 0) #\t)
   (if (and (or (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf)) (and (> x xf) (= y yf)))
            (WhiteAlliedPiece string finalPos) (StopWhitePieces string initialPos x y xf yf 1 finalPos))
       #t
   ;De lo contrario
       #f
   );Fin if
  )
    
;-------------------CASO-CABALLO-NEGRO-----------------------
  
  ((char=? (string-ref piece 0) #\C)
   (if (and (or (and (= (+ x 1) xf) (= (- y 2) yf)) (and (= (- x 1) xf) (= (- y 2) yf)) (and (= (+ x 1) xf) (= ( + y 2) yf))
           (and (= (- x 1) xf) (= (+ y 2) yf)) (and (= (- x 2) xf) (= (+ y 1) yf)) (and (= (- x 2) xf) (= (- y 1) yf))
           (and (= (+ x 2) xf) (= (+ y 1) yf)) (and (= (+ x 2) xf) (= (- y 1) yf)))
            (BlackAlliedPiece string finalPos))
       #t
   ;De lo contrario
       #f
   );Fin if
  )
    
;-------------------CASO-CABALLO-BLANCO-----------------------
  
  ((char=? (string-ref piece 0) #\c)
   (if (and (or (and (= (+ x 1) xf) (= (- y 2) yf)) (and (= (- x 1) xf) (= (- y 2) yf)) (and (= (+ x 1) xf) (= ( + y 2) yf))
           (and (= (- x 1) xf) (= (+ y 2) yf)) (and (= (- x 2) xf) (= (+ y 1) yf)) (and (= (- x 2) xf) (= (- y 1) yf))
           (and (= (+ x 2) xf) (= (+ y 1) yf)) (and (= (+ x 2) xf) (= (- y 1) yf)))
            (WhiteAlliedPiece string finalPos))
       #t
    ;De lo contrario
       #f
    );Fin if
   )
    
;-------------------CASO-ALFIL-NEGRO-----------------------
  
  ((char=? (string-ref piece 0) #\A)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) )
            (BlackAlliedPiece string finalPos) (StopBlackPieces string initialPos x y xf yf 1 finalPos))
       #t
   ;De lo contrario
       #f
   );Fin if
  )
    
;-------------------CASO-ALFIL-BLANCO-----------------------
  
  ((char=? (string-ref piece 0) #\a)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) )
            (WhiteAlliedPiece string finalPos) (StopWhitePieces string initialPos x y xf yf 1 finalPos))
       #t
       ;De lo contrario
       #f
    );Fin if
   )
    
;-------------------CASO-DAMA-BLANCA-----------------------
  
  ((char=? (string-ref piece 0) #\d)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf))
           (and (> x xf) (= y yf)) )
           (WhiteAlliedPiece string finalPos) (StopWhitePieces string initialPos x y xf yf 1 finalPos) )
       #t
       ;De lo contrario
       #f
    );Fin if
   )
    
;-------------------CASO-DAMA-NEGRA-----------------------
  
  ((char=? (string-ref piece 0) #\D)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf))
           (and (> x xf) (= y yf)) )
           (BlackAlliedPiece string finalPos) (StopBlackPieces string initialPos x y xf yf 1 finalPos))
       #t
       ;De lo contrario
       #f
    );Fin if
   )
    
;-------------------CASO-REY-NEGRO-----------------------
  
  ((char=? (string-ref piece 0) #\R)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf))
           (and (> x xf) (= y yf)) ) ( or (= (abs (- x xf)) 1) (= (abs (- y yf)) 1)) (BlackAlliedPiece string finalPos))
       #t
       ;De lo contrario
       #f
    );Fin if
   )
  
;-------------------CASO-REY-BLANCO-----------------------
  
  ((char=? (string-ref piece 0) #\r)
   (if (and (or (= (abs (- x xf)) (abs (- y yf)) ) (and (= x xf) (< y yf)) (and (= x xf) (> y yf)) (and (< x xf) (= y yf))
           (and (> x xf) (= y yf)) ) ( or (= (abs (- x xf)) 1) (= (abs (- y yf)) 1)) (WhiteAlliedPiece string finalPos))
       #t
       ;De lo contrario
       #f
    );Fin if
   )
    
;-------------------CASO-PEON-NEGRO-----------------------
  
  ((char=? (string-ref piece 0) #\P)
    (if ( and (or (and (or (and (= x xf) (= (+ y 1 ) yf) ) (and (= x xf) (= (+ y 2) yf) (= y 1)))
            (BlackAlliedPiece string finalPos) (StopPawnBlack string finalPos y yf))
            (PawnBlackEnemy string finalPos x y xf yf) ) (StopBlackPieces string initialPos x y xf yf 1 finalPos) ) 
       #t
       ;De lo contrario
       #f
    );Fin if
   )
  
;-------------------CASO-PEON-BLANCO-----------------------
    
  ((char=? (string-ref piece 0) #\p)
    (if (and (or (and (or (and (= x xf) (= (- y 1 ) yf) ) (and (= x xf) (= (- y 2 ) yf) (= y 6)))
             (WhiteAlliedPiece string finalPos) (StopPawnWhite string finalPos y yf) )
             (PawnWhiteEnemy string finalPos x y xf yf) ) (StopWhitePieces string initialPos x y xf yf 1 finalPos) )
       #t
       ;De lo contrario
       #f
    );Fin if
   )
  
;---------------------NINGUN-CASO------------------------
  
  [else #f]
  
 );Fin cond
);Fin función MovementPieces

#|-------------------------------------------------------
Funcion TurnColor que identifica el turno de acuerdo a la pieza tocada
- Identificador local string: guarda el string del juego
- Identificador local initial: guarda la posicion de la casilla del primer click, ya que ahí debería de encontrarse
una pieza
|#

(define (TurnColor string initial)
 (if (char-upper-case? (string-ref string initial) )
    2
 ;De lo contrario
    1
 );Fin if (char-upper-case? (string-ref string initial) )
);Fin función TurnColor

#|-------------------------------------------------------
Funcion FindWhiteKing que identifica la posicion del rey blanco dentro del string
- Identificador local string: guarda el string del juego
- Identificador local counter: guarda la posicion de la casilla donde estamos evaluando
|#

(define (FindWhiteKing string counter)
(if (< counter 64)
    (if (char=? (string-ref string counter) #\r)
        counter
    ;De lo contrario
        (FindWhiteKing string (+ counter 1))
    );Fin if (char=? (string-ref string counter) #\r)
;De lo contrario
    (void)
);Fin if (< counter 64)
);Fin funcion FindWhiteKing

#|-------------------------------------------------------
Funcion FindBlackKing que identifica la posicion del rey negro dentro del string
- Identificador local string: guarda el string del juego
- Identificador local counter: guarda la posicion de la casilla donde estamos evaluando
|#
(define (FindBlackKing string counter)
(if (< counter 64)
    (if (char=? (string-ref string counter) #\R)
        counter
    ;De lo contrario
        (FindBlackKing string (+ counter 1))
    );Fin if (char=? (string-ref string counter) #\R)
;De lo contrario
    (void)
);Fin if (< counter 64)
);Fin funcion FindBlackKing

#|-------------------------------------------------------
Funcion WhiteCheck que identifica si el rey blanco está en jaque
- Identificador local string: guarda el string del juego
- Identificador local counterFunction: guarda la posicion de la casilla donde se encuentra alguna pieza enemiga
|#
(define (WhiteCheck string counterFunction)
(if (< counterFunction 64)
    (if (char-upper-case? (string-ref string counterFunction))
        ( if (MovementPieces (FindPiece string counterFunction) string (remainder counterFunction 8)
                             (quotient counterFunction 8) (remainder (FindWhiteKing string 0) 8)
                             (quotient (FindWhiteKing string 0) 8) (FindWhiteKing string 0) counterFunction)
             #t
        ;De lo contrario
             (WhiteCheck string (+ counterFunction 1) )
        );Fin if (MovementPieces...)
    ;De lo contrario
        (WhiteCheck string (+ counterFunction 1) )
    );Fin if (char-upper-case? (string-ref string counterFunction))
;De lo contrario
    #f
);Fin if (< counterFunction 64)
);Fin funcion WhiteCheck

#|-------------------------------------------------------
Funcion WhiteCheckmate que identifica si el rey blanco está en jaque mate
- Identificador local string: guarda el string del juego
- Identificador local counterPiece: guarda la posicion de la casilla donde se encuentra alguna pieza aliada
- Identificador local counterSquare: guarda la posicion de la casilla donde se desea mover la pieza aliada y
evitar el jaque
- Identificador local state: guarda el estado de la partida, si está en jaque mate o no
|#
(define (WhiteCheckmate string counterPiece counterSquare state)
(if (< counterPiece 64)
  (if (< counterSquare 64)
    (if (char-lower-case? (string-ref string counterPiece))
        (if (MovementPieces (FindPiece string counterPiece) string (remainder counterPiece 8)
                             (quotient counterPiece 8) (remainder counterSquare 8)
                             (quotient counterSquare 8) counterSquare counterPiece)            
            (if (WhiteCheck (ChangeChar (ChangeChar string (FindPiece string counterPiece) counterSquare) " " counterPiece) 0)
                (WhiteCheckmate string counterPiece (+ counterSquare 1) state)
            ;De lo contrario
                (WhiteCheckmate string counterPiece (+ counterSquare 1) #f)
            );Fin if CheckWhite
        ;De lo contrario
            (WhiteCheckmate string counterPiece (+ counterSquare 1) state)
        );Fin if MovementPieces
    ;De lo contrario
        (WhiteCheckmate string (+ counterPiece 1) 0 state)
    );Fin if (char-lower-case? (string-ref string counterPiece))
  ;De lo contrario
    (WhiteCheckmate string (+ counterPiece 1) 0 state)
  );Fin if (< counterSquare 64)
;De lo contrario
    state
);Fin if (< counterPiece 64)
);Fin funcion WhiteCheckmate

#|-------------------------------------------------------
Funcion BlackCheck que identifica si el rey blanco está en jaque
- Identificador local string: guarda el string del juego
- Identificador local counterFunction: guarda la posicion de la casilla donde se encuentra alguna pieza enemiga
|#
(define (BlackCheck string counterFunction)
(if (< counterFunction 64)
    (if (char-lower-case? (string-ref string counterFunction))
        ( if (MovementPieces (FindPiece string counterFunction) string (remainder counterFunction 8)
                             (quotient counterFunction 8) (remainder (FindBlackKing string 0) 8)
                             (quotient (FindBlackKing string 0) 8) (FindBlackKing string 0) counterFunction)
             #t
        ;De lo contrario
             (BlackCheck string (+ counterFunction 1) )
        );Fin if (char-lower-case? (string-ref string counterFunction))
    ;De lo contrario
        (BlackCheck string (+ counterFunction 1) )
    );Fin if (char-lower-case? (string-ref string counterFunction))
;De lo contrario
    #f
);Fin if (< counterFunction 64)
);Fin funcion BlackCheck

#|-------------------------------------------------------
Funcion BlackCheckmate que identifica si el rey negro está en jaque mate
- Identificador local string: guarda el string del juego
- Identificador local counterPiece: guarda la posicion de la casilla donde se encuentra alguna pieza aliada
- Identificador local counterSquare: guarda la posicion de la casilla donde se desea mover la pieza aliada y
evitar el jaque
- Identificador local state: guarda el estado de la partida, si está en jaque mate o no
|#
(define (BlackCheckmate string counterPiece counterSquare state)
(if (< counterPiece 64)
    (if (< counterSquare 64)
        (if (char-upper-case? (string-ref string counterPiece))
            (if (MovementPieces (FindPiece string counterPiece) string (remainder counterPiece 8)
                                (quotient counterPiece 8) (remainder counterSquare 8)
                                (quotient counterSquare 8) counterSquare counterPiece)            
                (if (BlackCheck (ChangeChar (ChangeChar string (FindPiece string counterPiece) counterSquare) " " counterPiece) 0)
                    (BlackCheckmate string counterPiece (+ counterSquare 1) state)
                ;De lo contrario
                    (BlackCheckmate string counterPiece (+ counterSquare 1) #f)
                );Fin if BlackCheck
            ;De lo contrario
                (BlackCheckmate string counterPiece (+ counterSquare 1) state)
            );Fin if MovementPieces
        ;De lo contrario
            (BlackCheckmate string (+ counterPiece 1) 0 state)
        );Fin if (char-upper-case? (string-ref string counterPiece))
    ;De lo contrario
        (BlackCheckmate string (+ counterPiece 1) 0 state)
    );Fin if (< counterSquare 64)
;De lo contrario
    state
);Fin if (< counterPiece 64)
);Fin funcion BlackCheckmate

#|-------------------------------------------------------
Funcion SaveWhiteCheck que identifica si el rey movimiento hecho evita el jaque blanco
- Identificador local turn: guarda el turno del juego
- Identificador local string: guarda el string del juego
- Identificador local initialPlace: guarda la posicion del primer click dentro del string
- Identificador local xi: guarda la posicion del primer click en el eje x
- Identificador local yi: guarda la posicion del primer click en el eje y
|#
(define (SaveWhiteCheck turn string initialPlace xi yi counter)
;Identificador finalPos que recibe el click
(define finalPos (get-mouse-click chess))
;Identificador xf que obtiene la posicion en x del click
(define xf (posn-x (mouse-click-posn finalPos)))
;Identificador yf que obtiene la posicion en y del click  
(define yf (posn-y (mouse-click-posn finalPos)))
;Identificador finalPlace que guarda la posicion del click dentro del string  
(define finalPlace  ( + ( quotient xf 100 ) ( * ( quotient yf 100 ) 8 ) ) )  
( if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
     (close-viewport chess)
;De lo contrario
     ( if (< xf 800)
          (if (= (remainder counter 2) 1)
              (if (not (equal? (FindPiece string finalPlace) " "))
                  (if (= (TurnColor string finalPlace) turn )
                      [begin
                        ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")                          
                        (SaveWhiteCheck turn string finalPlace xf yf (+ counter 1))
                      ];Fin begin
                  ;De lo contrario
                      [begin
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                        ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                        ((draw-string chess) (make-posn 950 405) (if (= turn 1) "Turno del Blanco" "Turno del Negro" ) "Yellow")
                        (sleep 1.25)
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                        (SaveWhiteCheck turn string initialPlace xi yi counter)
                     ];Fin begin
                 );Fin if (= (TurnColor string finalPlace) turn )
              ;De lo contrario
                 (SaveWhiteCheck turn string initialPlace xi yi counter)
              );Fin if (not (equal? (FindPiece string finalPlace) " "))
          ;De lo contrario    
              ( if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
                   [begin
                     (SquareWhiteBlack xi yi)
                     (PrintPiece (FindPiece string initialPlace) xi yi)
                     ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")  
                     (SaveWhiteCheck turn string finalPlace xf yf counter)
                   ];Fin begin
              ;De lo contrario
                   (if (and (< xi 800) (< xf 800) )
                       (if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn ) )
                           (if (not (WhiteCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )             
                               (if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                                   (if (= turn 1)
                                       (CrownwWhitePawn turn string xi xf yi yf initialPlace finalPlace counter)
                                   ;De lo contrario
                                       (CrownBlackPawn turn string xi xf yi yf initialPlace finalPlace counter)
                                   );Fin if (= turn 1)
                               ;De lo contrario
                                   [begin
                                     (SquareWhiteBlack xf yf)  
                                     (PrintPiece (FindPiece string initialPlace) xf yf) 
                                     (SquareWhiteBlack xi yi)
                                     (printf (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace))
                                     (newline)
                                     ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "DimGray")
                                     ((draw-rectangle chess) (make-posn 900 575) 200 100 "Black")
                                     ((draw-string chess) (make-posn 955 625) (if (= turn 1) "Juegan Negras" "Juegan Blancas") "Yellow")
                                     (if (if (= turn 1)
                                             (BlackCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         ;De lo contrario
                                             (WhiteCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         );Fin if (= turn 1)
                                         [begin   
                                           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                                           ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                                           ((draw-string chess) (make-posn 955 405) "Ganan Blancas" "Yellow")
                                           ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "LightGray")
                                           (EndGame)
                                         ];Fin begin
                                     ;De lo contrario
                                         (Game (if (= turn 1) 2 1) (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) (void) (void) (void) (+ counter 1))
                                     );Fin if (if (= turn 1)...)
                                   ];Fin begin
                                );Fin if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                               [begin
                                 ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                                 ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                                 ((draw-string chess) (make-posn 955 405) "Jugada Inválida" "Yellow")
                                 (sleep 1.25)
                                 ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")  
                                 (SaveWhiteCheck turn string initialPlace xi yi counter)
                               ];Fin begin
                          );Fin if (not (WhiteCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                          [begin
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                            ((draw-string chess) (make-posn 955 405) "Jugada Inválida" "Yellow")
                            ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                            (sleep 1.25)
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                            (SaveWhiteCheck turn string initialPlace xi yi counter)
                          ];Fin begin
                     )#|Fin if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn ) )|#
                 ;De lo contrario      
                     (SaveWhiteCheck turn string initialPlace xi yi counter)
                 );Fin if (and (< xi 800) (< xf 800) )
           );Fin if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
        );Fin if (= (remainder counter 2) 1)
    ;De lo contrario
        (SaveWhiteCheck turn string initialPlace xi yi counter)
    );Fin if (< xf 800)
);Fin if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
);Fin funcion SaveWhiteCheck

#|-------------------------------------------------------
Funcion SaveBlackCheck que identifica si el rey movimiento hecho evita el jaque negro
- Identificador local turn: guarda el turno del juego
- Identificador local string: guarda el string del juego
- Identificador local initialPlace: guarda la posicion del primer click dentro del string
- Identificador local xi: guarda la posicion del primer click en el eje x
- Identificador local yi: guarda la posicion del primer click en el eje y
|#
(define (SaveBlackCheck turn string initialPlace xi yi counter)
;Identificador finalPos que recibe el click
(define finalPos (get-mouse-click chess))
;Identificador xf que obtiene la posicion en x del click
(define xf (posn-x (mouse-click-posn finalPos)))
;Identificador yf que obtiene la posicion en y del click  
(define yf (posn-y (mouse-click-posn finalPos)))
;Identificador finalPlace que guarda la posicion del click dentro del string  
(define finalPlace  ( + ( quotient xf 100 ) ( * ( quotient yf 100 ) 8 ) ) )   
( if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
     (close-viewport chess)
;De lo contrario
     ( if (< xf 800)
          (if (= (remainder counter 2) 1)
              (if (not (equal? (FindPiece string finalPlace) " "))
                  (if (= (TurnColor string finalPlace) turn )
                      [begin
                        ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")                          
                        (SaveBlackCheck turn string finalPlace xf yf (+ counter 1))
                      ];Fin begin
                  ;De lo contrario
                      [begin
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                        ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                        ((draw-string chess) (make-posn 950 405) (if (= turn 1) "Turno del Blanco" "Turno del Negro" ) "Yellow")
                        (sleep 1.25)
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                        (SaveBlackCheck turn string initialPlace xi yi counter)
                     ];Fin begin
                 );Fin if (= (TurnColor string finalPlace) turn )
              ;De lo contrario
                 (SaveBlackCheck turn string initialPlace xi yi counter)
              );Fin if (not (equal? (FindPiece string finalPlace) " "))
          ;De lo contrario    
              ( if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
                   [begin
                     (SquareWhiteBlack xi yi)
                     (PrintPiece (FindPiece string initialPlace) xi yi)
                     ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")  
                     (SaveBlackCheck turn string finalPlace xf yf counter)
                   ];Fin begin
                   (if (and (< xi 800) (< xf 800) )
                       (if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn ) )
                           (if (not (BlackCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )             
                               (if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                                   (if (= turn 1)
                                       (CrownwWhitePawn turn string xi xf yi yf initialPlace finalPlace counter)
                                   ;De lo contrario
                                       (CrownBlackPawn turn string xi xf yi yf initialPlace finalPlace counter)
                                   );Fin if(= turn 1)
                                ;De lo contrario
                                   [begin
                                     (SquareWhiteBlack xf yf)  
                                     (PrintPiece (FindPiece string initialPlace) xf yf) 
                                     (SquareWhiteBlack xi yi)
                                     (printf (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace))
                                     (newline)
                                     ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "DimGray")
                                     ((draw-rectangle chess) (make-posn 900 575) 200 100 "Black")
                                     ((draw-string chess) (make-posn 955 625) (if (= turn 1) "Juegan Negras" "Juegan Blancas") "Yellow")
                                     (if (if (= turn 1)
                                             (BlackCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         ;De lo contario
                                             (WhiteCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         );Fin if (= turn 1)
                                         [begin   
                                           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                                           ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                                           ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "LightGray")
                                           ((draw-string chess) (make-posn 955 405) "Ganan Negras" "Yellow")
                                           (EndGame)
                                         ];Fin begin
                                     ;De lo contrario    
                                         (Game (if (= turn 1) 2 1) (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) (void) (void) (void) (+ counter 1)) 
                                     )#|Fin if (if (= turn 1)
                                             (BlackCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         ;De lo contario
                                             (WhiteCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                         )|#
                                  ];Fin begin
                               );Fin if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                               [begin
                                 ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                                 ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                                 ((draw-string chess) (make-posn 955 405) "Jugada Inválida" "Yellow")
                                 (sleep 1.25)
                                 ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")  
                                 (SaveBlackCheck turn string initialPlace xi yi counter)
                               ];Fin begin
                           );Fin if (not (BlackCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                       ;De lo contrario
                           [begin
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                            ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                            ((draw-string chess) (make-posn 955 405) "Jugada Inválida" "Yellow")
                            (sleep 1.25)
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                            (SaveBlackCheck turn string initialPlace xi yi counter)
                          ];Fin begin
                     )#|Fin if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn ) ) |#
                 ;De lo contrario    
                     (SaveBlackCheck turn string initialPlace xi yi counter)
                 );Fin if (and (< xi 800) (< xf 800) )
           );Fin if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
        );Fin if (= (remainder counter 2) 1)
    ;De lo contrario
        (SaveBlackCheck turn string initialPlace xi yi counter)
    );Fin if (< xf 800)
);Fin if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
);Fin función SaveBlackCheck

#|-------------------------------------------------------------------
Funcion EndGame que recibe el click para cerrar la ventana despues de terminar el juego
|#
(define (EndGame)
;Identificador finalClick que recibe el click
(define finalClick (get-mouse-click chess))
;Identificador x que guarda el valor de x del click
(define x (posn-x (mouse-click-posn finalClick)))
;Identificador y que guarda el valor de y del click  
(define y (posn-y (mouse-click-posn finalClick)))
( if (and (< x 1100) (> x 900) (> y 680) (< y 780))
     (close-viewport chess)
;De lo contrario
     (EndGame)
);Fin if (and (< x 1100) (> x 900) (> y 680) (< y 780))
);Fin funcion EndGame

#|-------------------------------------------------------
Funcion Game que procesa todo el juego
- Identificador local turn: guarda el turno del juego
- Identificador local string: guarda el string del juego
- Identificador local initialPlace: guarda la posicion del primer click dentro del string
- Identificador local xi: guarda la posicion del primer click en el eje x
- Identificador local yi: guarda la posicion del primer click en el eje y
- Identificador local counter: cuenta si es el primer click o el segundo
|#
(define (Game turn string initialPlace xi yi counter)
(if (= turn 1)
    (if (WhiteCheck string 0)
        [begin
           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
           ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
           ((draw-string chess) (make-posn 980 405) "Jaque" "Yellow")
           (sleep 1.25)
           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
        ];Fin begin
    ;De lo contrario    
        (void)
    );Fin if (WhiteCheck string 0)
;De lo contrario
    (if (BlackCheck string 0)
        [begin
           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
           ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
           ((draw-string chess) (make-posn 980 405) "Jaque" "Yellow")
           (sleep 1.25)
           ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
        ];Fin begin
    ;De lo contrario
        (void)
    );Fin if (BlackCheck string 0)
);Fin if (= turn 1)
  
;------------------------POSICION-PIEZA-----------------------------------------------

;Identificador finalPos que recibe el click
(define finalPos (get-mouse-click chess))
;Identificador xf que obtiene la posicion en x del click
(define xf (posn-x (mouse-click-posn finalPos)))
;Identificador yf que obtiene la posicion en y del click  
(define yf (posn-y (mouse-click-posn finalPos)))
;Identificador finalPlace que guarda la posicion del click dentro del string  
(define finalPlace  ( + ( quotient xf 100 ) ( * ( quotient yf 100 ) 8 ) ) ) 
  
;------------------------------VERIFICACION----------------------------------------

( if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
     (close-viewport chess)
     ( if (< xf 800)
          (if (= (remainder counter 2) 1)
              (if (not (equal? (FindPiece string finalPlace) " "))
                  (if (= (TurnColor string finalPlace) turn )
                      [begin
                        ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")
                        (if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0))
                            (if (= turn 1)
                                (SaveWhiteCheck turn string finalPlace xf yf (+ counter 1))
                            ;De lo contrario
                                (SaveBlackCheck turn string finalPlace xf yf (+ counter 1))
                            );Fin if (= turn 1)
                        ;De lo contrario
                            (Game turn string finalPlace xf yf (+ counter 1))
                        );Fin if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0))
                      ];Fin begin
                  ;De lo contrario    
                      [begin
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                        ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                        ((draw-string chess) (make-posn 950 405) (if (= turn 1) "Turno del Blanco" "Turno del Negro" ) "Yellow")
                        (sleep 1.25)
                        ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                        (if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0))
                            (if (= turn 1)
                                (SaveWhiteCheck turn string initialPlace xi yi counter)
                            ;De lo contrario
                                (SaveBlackCheck turn string initialPlace xi yi counter)
                            );Fin if (= turn 1)
                        ;De lo contrario
                            (Game turn string initialPlace xi yi counter)
                        );Fin if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0))
                     ];Fin begin
                 );Fin if (= (TurnColor string finalPlace) turn )
              ;De lo contrario
                 (if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0))
                         (if (= turn 1)
                             (SaveWhiteCheck turn string initialPlace xi yi  counter)
                         ;De lo contrario
                             (SaveBlackCheck turn string initialPlace xi yi  counter)
                         );Fin if (= turn 1)
                 ;De lo contrario
                         (Game turn string initialPlace xi yi counter)
                 );Fin if (if (= turn 1) (WhiteCheck string 0) (BlackCheck string 0)) 
              );Fin if (not (equal? (FindPiece string finalPlace) " "))
          ;De lo contrario    
              ( if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
                   [begin
                     (SquareWhiteBlack xi yi)
                     (PrintPiece (FindPiece string initialPlace) xi yi)
                     ((draw-rectangle chess) (make-posn (+ 5 (* (quotient xf 100) 100) ) ( + 5 (* (quotient yf 100) 100))) 90 90 "Crimson")  
                     (Game turn string finalPlace xf yf counter)
                   ];Fin begin
              ;De lo contrario
                   (if (and (< xi 800) (< xf 800) )
                       (if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn )
                                (if (= turn 1)
                                    (not (WhiteCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                                ;De lo contrario
                                    (not (BlackCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                                );Fin if (= turn 1)
                           )
                           (if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                               (if (= turn 1)
                                   (CrownwWhitePawn turn string xi xf yi yf initialPlace finalPlace counter)
                               ;De lo contrario
                                   (CrownBlackPawn turn string xi xf yi yf initialPlace finalPlace counter)
                               );Fin if (= turn 1)
                           ;De lo contrario
                               [begin
                                 (SquareWhiteBlack xf yf)  
                                 (PrintPiece (FindPiece string initialPlace) xf yf) 
                                 (SquareWhiteBlack xi yi)
                                 (printf (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace))
                                 (newline)
                                 ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "DimGray")
                                 ((draw-rectangle chess) (make-posn 900 575) 200 100 "Black")
                                 ((draw-string chess) (make-posn 955 625) (if (= turn 1) "Juegan Negras" "Juegan Blancas") "Yellow")
                                 (if (if (= turn 1)
                                         (BlackCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                     ;De lo contrario
                                         (WhiteCheckmate (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0 0 #t)
                                     );Fin if (= turn 1)
                                     [begin   
                                       ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                                       ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                                       ((draw-solid-rectangle chess) (make-posn 900 575) 200 100 "LightGray")
                                       ((draw-string chess) (make-posn 955 405) (if (= turn 1) "Ganan Blancas" "Ganan Negras") "Yellow")
                                       (EndGame)
                                     ];Fin begin
                                ;De lo contrario
                                     (Game (if (= turn 1) 2 1) (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) (void) (void) (void) (+ counter 1))     
                                )
                             ];Fin begin
                           );Fin if (and (or ( equal? (FindPiece string initialPlace) "P" ) ( equal? (FindPiece string initialPlace) "p" ) ) (or (= (quotient yf 100) 0) (= (quotient yf 100) 7) ) )
                     ;De lo contrario
                           [begin
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "DimGray")
                            ((draw-rectangle chess) (make-posn 900 350) 200 100 "Black")
                            ((draw-string chess) (make-posn 955 405) "Jugada Inválida" "Yellow")
                            (sleep 1.25)
                            ((draw-solid-rectangle chess) (make-posn 900 350) 200 100 "LightGray")
                            (Game turn string initialPlace xi yi counter)
                          ];Fin begin
                     )#|Fin if (and (MovementPieces (FindPiece string initialPlace) string (quotient xi 100) (quotient yi 100) (quotient xf 100) (quotient yf 100) finalPlace initialPlace)
                                (= (TurnColor string initialPlace) turn )
                                (if (= turn 1)
                                    (not (WhiteCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                                ;De lo contrario
                                    (not (BlackCheck (ChangeChar (ChangeChar string (FindPiece string initialPlace) finalPlace) " " initialPlace) 0) )
                                );Fin if (= turn 1)
                           )|#
                  ;De lo contrario
                       (Game turn string initialPlace xi yi counter)
                 );Fin if (and (< xi 800) (< xf 800) )
           );Fin if (not (if (= turn 1 )(WhiteAlliedPiece string finalPlace) (BlackAlliedPiece string finalPlace)) )
        );Fin if (= (remainder counter 2) 1)
    ;De lo contrario
        (Game turn string initialPlace xi yi counter)
    );Fin (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
);Fin if (and (< xf 1100) (> xf 900) (> yf 680) (< yf 780))
);Fin función Game

;Llamamos a la función Game
(Game 1 stringChess (void) (void) (void) 1)
