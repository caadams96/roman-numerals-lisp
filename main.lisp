(load "~/quicklisp/setup.lisp")
(asdf:load-system "cl-ppcre")
(asdf:load-system "cl-unicode")

(defparameter *roman-map* (make-hash-table))
(setf (gethash '1000 *roman-map*) "M")
(setf (gethash '500 *roman-map*) "D")
(setf (gethash '100 *roman-map*) "C")
(setf (gethash '50 *roman-map*) "L")
(setf (gethash '10 *roman-map*) "X")
(setf (gethash '5 *roman-map*) "V")
(setf (gethash '1 *roman-map*) "I")

(defparameter *long-to-short-map* (make-hash-table))
(setf (gethash 'DCCCC *long-to-short-map*) "CM")
(setf (gethash 'CCCC *long-to-short-map*) "CD")
(setf (gethash 'LXXXX *long-to-short-map*) "XC")
(setf (gethash 'XXXX *long-to-short-map*) "XL")
(setf (gethash 'VIIII *long-to-short-map*) "IX")
(setf (gethash 'IIII *long-to-short-map*) "IV")

(defun to-roman(number)
  (let* ((difference 0) (amount 0) (roman " "))
    ;;build roman numeral
    (maphash (lambda (key val) 
	       (setf difference (- number ( mod number key)))
	       (setf amount (/ difference key))
	       (loop for i from 1 to amount do 
	 (setf roman (concatenate 'string roman val)))
	       (setf number (- number difference))
	     )
             *roman-map*)
    ;; swap out long form to short  
    (maphash (lambda (key val) 
	     (setf roman (ppcre:regex-replace (write-to-string key) roman val)))
	   *long-to-short-map*)
  ;;return roman numeral
  roman)  
  )

(format t "~&~A ~&" (to-roman 2844))


