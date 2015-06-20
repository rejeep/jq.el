;;; test-helper --- Test helper for jq

;;; Commentary:
;; test helper inspired from https://github.com/tonini/overseer.el/blob/master/test/test-helper.el

;;; Code:

(require 'f)

(defvar cpt-path
  (f-parent (f-this-file)))

(defvar jq-test-path
  (f-dirname (f-this-file)))

(defvar jq-root-path
  (f-parent jq-test-path))

(defvar jq-sandbox-path
  (f-expand "sandbox" jq-test-path))

(when (f-exists? jq-sandbox-path)
  (error "Something is already in %s. Check and destroy it yourself" jq-sandbox-path))

(defmacro within-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(let ((default-directory jq-sandbox-path))
     (when (f-exists? jq-sandbox-path)
       (f-delete default-directory :force))
     (f-mkdir jq-sandbox-path)
     ,@body
     (f-delete default-directory :force)))

(require 'ert)
(require 'jq (f-expand "jq" jq-root-path))

(provide 'test-helper)
;;; test-helper.el ends here
