;;; ap-core.el
;;; Core

;; Make sure the coding system is utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Store backup files
(setq backup-directory-alist
      `((".*" . ,ap-backup-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "\\1" ap-backup-directory) t)))
(setq auto-save-list-file-prefix
      (expand-file-name ".saves-"
                        (expand-file-name "auto-save-list" ap-data-directory)))

;; Revert buffer if the file was changed
(global-auto-revert-mode t)

;; Update vc info every auto-revert-interval
(setq auto-revert-check-vc-info t)

;; Delete selection on key press
(delete-selection-mode t)

;; Don't set point position when you focus the frame
(setq x-mouse-click-focus-ignore-position t)

;; Disable mouse wheel scroll
(mouse-wheel-mode -1)

;; Answer questions with y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Inhibit startup screen
(setq inhibit-startup-screen t)

;; Lower the delay for displaying keystrokes in minibuffer
(setq echo-keystrokes 0.1)

;; Scrolling
(setq scroll-margin 3
      scroll-conservatively 100000
      scroll-preserve-screen-position t)

;;; Whitespace

;; Don't use tab character for indentation
(setq-default indent-tabs-mode nil)

;; Whitespace mode configuration
(setq whitespace-display-mappings '((newline-mark 10 [172 10])
                                    (space-mark 32 [183] [46])
                                    (tab-mark 9 [187 9] [92 9])))

;; Show trailing whitespace on programming modes
(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))


;; Create non-existent directories
(defun ap-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions #'ap-create-non-existent-directory)

;; Meaningful names for buffers with the same name
(use-package uniquify
  :init (setq uniquify-buffer-name-style 'forward
              uniquify-separator "/"
              uniquify-ignore-buffers-re "^\\*"
              uniquify-after-kill-buffer-p t))

;; Save last pointer position
(use-package saveplace
  :init (progn
          (setq save-place-file (expand-file-name "saveplace" ap-data-directory))
          (setq-default save-place t)))

;; Save minibuffer history
(setq history-length 1000)

(use-package savehist
  :init (setq savehist-file (expand-file-name "savehist" ap-data-directory)
              savehist-additional-variables '(search ring regexp-search-ring)
              savehist-autosave-interval 60)
  :config (savehist-mode t))

(provide 'ap-core)
