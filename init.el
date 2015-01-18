;;; init.el

;; Maximum number of lines to keep in the message log buffer
(setq message-log-max 16384)

;; Reduce the frequency of garbage collection
(setq gc-cons-threshold 50000000)

;; Turn off interface elements early to avoid momentary display
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

;;; Custom directories

(defvar ap-data-directory (expand-file-name ".data" user-emacs-directory)
  "This directory stores emacs related data (auto-generated files, save files,
   history-files etc.")
(unless (file-exists-p ap-data-directory)
  (make-directory ap-data-directory))

(defvar ap-backup-directory (expand-file-name "backup" ap-data-directory)
  "This directory stores file backups and auto saves.")

(defvar ap-local-directory (expand-file-name "local" user-emacs-directory)
  "This directory contains all the local machine configurations.")
(unless (file-exists-p ap-local-directory)
  (make-directory ap-local-directory))

;;; Core

(defvar ap-core-directory (expand-file-name "core" user-emacs-directory)
  "This directory contains all the core configuration.")

;; Add core directory to load-path
(add-to-list 'load-path ap-core-directory)

(require 'ap-packages)
(require 'ap-core)
(require 'ap-essentials)

;;; Final loads

;; File to store the config changes made through customize ui
(setq custom-file (expand-file-name "custom.el" ap-local-directory))

;; Load local machine configurations
(when (file-exists-p ap-local-directory)
  (mapc 'load (directory-files ap-local-directory 't "^[^#].*el$")))
