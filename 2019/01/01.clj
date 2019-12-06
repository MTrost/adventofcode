(defn read-inputs! [path]
  (-> path slurp clojure.string/split-lines))

(defn mass->fuel [mass]
  (-> mass (/ 3) int (- 2)))

;; Calculate 1st solution
(->> (read-inputs! "./input")
     (map (comp mass->fuel read-string))
     (reduce +))
;; => 3270338

;; Calculate 2nd solution
(defn mass-string->fuel-plus [mass-string]
  (->> mass-string
       read-string
       mass->fuel
       (iterate mass->fuel)
       (take-while pos?)
       (reduce +)))

(->> (read-inputs! "./input")
     (map mass-string->fuel-plus)
     (reduce +))
;; => 4902650
