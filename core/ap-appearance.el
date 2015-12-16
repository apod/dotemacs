;;; ap-appearance.el
;;; Appearance configuration

;; Disable blinking cursor
(blink-cursor-mode -1)

;; Frame title, format: "buffer_name (file_path) - invocation_name"
(setq-default frame-title-format
              '(:eval (format "%s %s %s"
                              (buffer-name)
                              (cond
                               (buffer-file-truename
                                (concat "(" buffer-file-truename ")"))
                               (dired-directory
                                (concat "{" dired-directory "}"))
                               (t
                                "[no file]"))
                              (concat "- " invocation-name))))

;;; Line numbers

(use-package linum
  :config (add-hook 'prog-mode-hook 'linum-mode))

(use-package linum-relative
  :ensure t
  :init (setq linum-relative-current-symbol ""
              linum-relative-format "%4s ")
  :config (linum-relative-on))



;;; Fonts

(when (member "M+ 1mn" (font-family-list))
  (set-face-attribute 'default nil :font "M+ 1mn-11"))

;;; Themes

;; Fully unload previous theme before loading a new one
(defadvice load-theme
  (before theme-dont-propagate activate)
  (mapc #'disable-theme custom-enabled-themes))


(use-package gruvbox-theme
  :ensure t
  :config (load-theme 'gruvbox 'no-confirm))

(use-package dracula-theme
  :ensure t
  :disabled t
  :config (progn (load-theme 'dracula 'no-confirm)
                 (set-face-attribute 'linum-relative-current-face nil :background "#373844"
                                                                      :foreground "#6272a4"
                                                                      :weight 'bold)))

;;; Modeline
(use-package spaceline
  :ensure t
  :config (progn
            (setq powerline-default-separator 'bar)
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

            (require 'spaceline-segments)
            (spaceline-install
             `((evil-state :face highlight-face)
               buffer-id
               (version-control :when active))

             `(major-mode
               (((minor-modes :separator spaceline-minor-modes-separator)
                 process)
                :when active)
               selection-info
               ((point-position
                 line-column)
                :face highlight-face)))))


;; Show column number
(column-number-mode t)

(provide 'ap-appearance)

