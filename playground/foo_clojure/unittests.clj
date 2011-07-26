(ns this.test.namespace
   (:use clojure.test))

(load-file "./code.clj")

(deftest test-adder
  (is (= 24  (add2 22))))

(run-tests 'this.test.namespace)
