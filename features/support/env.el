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

(defvar backup--jq-options jq-options)
(defvar backup--buffer-list (buffer-list))

(Before
 (-each (buffer-list)
   (lambda (buffer)
     (unless (-contains? backup--buffer-list buffer)
       (kill-buffer buffer))))
 (delete-other-windows)
 (setq jq-options backup--jq-options))
