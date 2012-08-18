(defproject sicp "0.1.0-SNAPSHOT"
  :description "parts of SICP in clojure in no particular order..."
  :repositories {"stuart" "http://stuartsierra.com/maven2"}
  :dependencies [[org.clojure/clojure "1.4.0"]
                 [midje "1.4.0"]]
  :profiles {:dev
             {:plugins [[lein-midje "2.0.0-SNAPSHOT"]]
              :java-opts ["-Dclojure.compiler.disable-locals-clearing=true"]
              :dependencies [[com.stuartsierra/lazytest "1.2.3"]]}})
