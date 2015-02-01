;;; ap-appearance.el
;;; Appearance configuration

;; Disable blinking cursor
(blink-cursor-mode -1)

;; Show matching parens
(use-package paren
  :init (show-paren-mode t))

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
  :init (add-hook 'prog-mode-hook 'linum-mode))

(use-package linum-relative
  :ensure t
  :config (setq linum-relative-current-symbol ""
                linum-relative-format "%4s "))


;;; Fonts

(when (member "M+ 1mn" (font-family-list))
  (set-face-attribute 'default nil :font "M+ 1mn-11"))

;;; Themes

;; Fully unload previous theme before loading a new one
(defadvice load-theme
  (before theme-dont-propagate activate)
  (mapc #'disable-theme custom-enabled-themes))

(use-package monokai-theme
  :ensure t
  :disabled t
  :init (progn
          (setq monokai-use-variable-pitch nil
                monokai-height-minus-1 1.0
                monokai-height-plus-1 1.0
                monokai-height-plus-2 1.0
                monokai-height-plus-3 1.0
                monokai-height-plus-4 1.0)
          (load-theme 'monokai 'no-confirm))
  :config (progn
            (set-face-attribute 'show-paren-match nil :background "#000000"
                                                      :foreground nil)
            (set-face-attribute 'region nil :background "#333333")
            (set-face-attribute 'linum-relative-current-face nil :background "#49483e"
                                                                 :foreground "#a6e22e"
                                                                 :weight 'bold)))

(use-package zenburn-theme
  :ensure t
  :init (progn
          (load-theme 'zenburn 'no-confirm))
  :config (progn
            (set-face-attribute 'mode-line nil :box nil)
            (set-face-attribute 'mode-line-inactive nil :box nil)
            (set-face-attribute 'fringe nil :background "#3f3f3f")
            (set-face-attribute 'linum-relative-current-face nil :background "#49483e"
                                :foreground "#e0cf9f"
                                :weight 'bold)))

;;; Modeline

;; Show column number
(column-number-mode t)

(provide 'ap-appearance)

