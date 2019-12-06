(defun file-to-string (path)
  (with-open-file (stream path)
    (let ((data (make-string (file-length stream))))
      (read-sequence data stream)
      data)))

(defun string-split (c strg &optional (start 0))
  (let ((end (position c strg :start start)))
    (cond (end (cons (subseq strg start end)
                     (string-split c strg (+ 1 end)))) ;; missing line ...
          (t (list (subseq strg start))))))

(defun simple-csv (string)
    (mapcar (lambda (x) (string-split #\, x)) (string-split #\Newline string)))


;; parse-float
;; Parse string to float if possible, else return NIL
;;
(defun parse-float (strg)
  (with-input-from-string (s strg)
    (let ((res (read s)))
      (if (eq (type-of res) 'single-float) res nil))))

;; zip-to-alist
;; Merge two lists to an alist
;;
(defun zip-to-alist (lst1 lst2)
  (cond ((or (null lst1) (null lst2)) nil)
        (t (cons (cons (car lst1) (car lst2))
                 (zip-to-alist (cdr lst1) (cdr lst2))))))

;;(zip-to-alist '(1 2 3) '(3 2 1))

(defvar *products* (simple-csv (file-to-string "/home/trostm/ownCloud/semester_5/psp/_praktikum/lispPraktikum2/products.csv")))

(string-split #\Newline (file-to-string "/home/trostm/ownCloud/semester_5/psp/_praktikum/lispPraktikum2/products.csv"))
