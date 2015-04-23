(require 'f)

(defvar jq-support-path
  (f-dirname load-file-name))

(defvar jq-features-path
  (f-parent jq-support-path))

(defvar jq-root-path
  (f-parent jq-features-path))

(add-to-list 'load-path jq-root-path)

(require 'jq)
(require 'espuds)
(require 'ert)
