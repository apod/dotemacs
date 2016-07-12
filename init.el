;;; init.el

(defconst ap-emacs-start-time
  (current-time)
  "The time when init.el is called")

;; Activate installed packages now
(setq package-enable-at-startup nil)
(package-initialize)

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

(defvar ap-languages-directory (expand-file-name "languages" user-emacs-directory)
  "This directory contains all the language configurations.")
(unless (file-exists-p ap-languages-directory)
  (make-directory ap-languages-directory))

;; Add core directory to load-path
(add-to-list 'load-path ap-core-directory)
(add-to-list 'load-path ap-languages-directory)

(require 'ap-packages)
(require 'ap-core)
(when (eq system-type 'darwin)
  (require 'ap-osx))
(require 'ap-appearance)
(require 'ap-mode-line)
(require 'ap-defuns)
(require 'ap-essentials)
(require 'ap-evil)
(require 'ap-evil-keybindings)
(require 'ap-git)
(require 'ap-ido)

;;; Languages

(require 'ap-emacs-lisp)

(require 'ap-org)
(require 'ap-markdown)

(require 'ap-clojure)
(require 'ap-ruby)
(require 'ap-web)
(require 'ap-sml)
(require 'ap-elm)

;;; Final loads

;; File to store the config changes made through customize ui
(setq custom-file (expand-file-name "custom.el" ap-local-directory))

;; Load local machine configurations
(when (file-exists-p ap-local-directory)
  (mapc 'load (directory-files ap-local-directory 't "^[^#].*el$")))

;; Alter scratch message to show load time
(setq initial-scratch-message
      (format ";; λx.x\n;; Loaded in %.3fs\n"
              (float-time (time-subtract after-init-time ap-emacs-start-time))))
