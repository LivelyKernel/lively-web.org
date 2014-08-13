{:user
 {
  :plugins [[lein-try "0.4.1"]
            [lein-pprint "1.1.1"]
            [lein-pprint "1.1.1"]
            [cider/cider-nrepl "0.8.0-SNAPSHOT"]]

  :dependencies [
                 ;; [rksm/repl.utils "0.1.0-SNAPSHOT"]
                 ;; for vinyasa lein
                 [leiningen #=(leiningen.core.main/leiningen-version)]

                 ;; trace execution
                 [org.clojure/tools.trace "0.7.8"]

                 ;; install dependencies / packages without restart
                 [com.cemerick/pomegranate "0.3.0"]

                 ;; cljs repl ++
                 [com.cemerick/piggieback "0.1.4-SNAPSHOT"]

                 ;; "quick and dirty debugging
                 [spyscope "0.1.4"]
                 [org.clojars.gjahad/debug-repl "0.3.3"]

                 ;; reload namespaces, recursively tracking dependencies
                 [org.clojure/tools.namespace "0.2.4"]

                 ;; java reflection
                 [im.chit/iroh "0.1.11"]

                 ;; pretty stacktraces
                 [io.aviso/pretty "0.1.8"]

                 ;; inject stuff in namespace + other goodies
                 ;; see http://z.caudate.me/give-your-clojure-workflow-more-flow/
                 [im.chit/vinyasa "0.2.2"]]

  :injections [(require 'spyscope.core)
               (require 'vinyasa.inject)
               (require 'iroh.core)
               (vinyasa.inject/in
                clojure.core
                ;; [rksm.repl.utils lein search-for-symbol get-stack print-stack dumb-stack traced-fn]
                [vinyasa.pull [pull >pull]]
                [clojure.java.shell [sh >sh]]
                [clojure.repl apropos [dir >dir] [doc >doc] [find-doc >find-doc] [source >source] [root-cause >cause]]
                [clojure.tools.namespace.repl [refresh >refresh]]
                [clojure.pprint [pprint >pprint]]
                [iroh.core .% .%> .*]
                ;; [clojure.tools.trace dotrace trace-ns untrace-ns]
                )]}}
