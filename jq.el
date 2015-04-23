;;; jq.el --- Interactive JQ

;; Copyright (C) 2015 Johan Andersson

;; Author: Johan Andersson <johan.rejeep@gmail.com>
;; Maintainer: Johan Andersson <johan.rejeep@gmail.com>
;; Version: 0.0.1
;; Keywords: speed, convenience
;; URL: http://github.com/rejeep/jq.el
;; Package-Requires: ((s "1.9.0") (dash "2.10.0") (f "0.17.2") (emacs "24"))

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:

(defvar jq-mode-hook nil
  "Mode hook for `jq-mode'.")

(defvar jq-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-q") 'jq-quit)
    (define-key map (kbd "C-c C-s") 'jq-toggle-slurp)
    (define-key map (kbd "C-c C-p") 'jq-toggle-pretty)
    (define-key map (kbd "C-c C-r") 'jq-toggle-raw)
    (define-key map (kbd "C-c C-j") 'jq-toggle-join)
    map)
  "Keymap for jq-mode.")

(defvar jq-input-buffer "JQ Input"
  "Name of input buffer.")

(defvar jq-output-buffer "JQ Output"
  "Name of output buffer.")

(defvar jq-file nil
  "Current file being jq'd.")

(defvar jq-options '("-c")
  "Options to run jq with.")

(defvar jq-max-lines 10
  "Max number of lines use as input.

This is a performance option.")

(defun jq--update ()
  ""
  (when (eq major-mode 'jq-mode)
    (let ((line (s-trim (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))
      (shell-command (format "head -n %d %s | jq %s %s" jq-max-lines jq-file (s-join " " jq-options) line)
                     (get-buffer jq-output-buffer)
                     ))))

(defun jq--toggle-option (option)
  ""
  (if (-contains? jq-options option)
      (setq jq-options (--remove (string= it option) jq-options))
    (add-to-list 'jq-options option 'append 'string=)))

(defun jq--init-output-buffer ()
  ""
  (switch-to-buffer (get-buffer-create jq-output-buffer))
  (erase-buffer)
  (insert (f-read jq-file))
  (js-mode))

(defun jq--init-input-buffer ()
  ""
  (select-window
   (or (get-buffer-window jq-input-buffer)
       (split-window (selected-window) (- (window-height) 4))))
  (switch-to-buffer (get-buffer-create jq-input-buffer))
  (erase-buffer)
  (insert "\n''")
  (forward-char -1)
  (jq-mode))

(defun jq-toggle-slurp ()
  "Toggle slurp option on/off."
  (interactive)
  (jq--toggle-option "-s"))

(defun jq-toggle-pretty ()
  "Toggle compact/pretty option on/off."
  (interactive)
  (jq--toggle-option "-c"))

(defun jq-toggle-raw ()
  "Toggle raw option on/off."
  (interactive)
  (jq--toggle-option "-r"))

(defun jq-toggle-join ()
  "Toggle join option on/off."
  (interactive)
  (jq--toggle-option "-j"))

(defun jq-quit ()
  "Quit `jq-mode'."
  (interactive)
  (kill-buffer jq-input-buffer)
  (kill-buffer jq-output-buffer)
  (delete-window))

;;;###autoload
(defun jq (&optional file)
  "Run `jq-mode' on FILE."
  (interactive)
  (if file
      (setq jq-file file)
    (setq jq-file (read-file-name "JSON File: ")))
  (jq--init-output-buffer)
  (jq--init-input-buffer))

;;;###autoload
(defun jq-mode ()
  "Interactive JQ."
  (kill-all-local-variables)
  (setq mode-name "JQ")
  (setq major-mode 'jq-mode)
  (use-local-map jq-mode-map)
  (add-hook 'post-command-hook 'jq--update))

(provide 'jq)

;;; jq.el ends here
