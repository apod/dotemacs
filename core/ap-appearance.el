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

(use-package nlinum-relative
  :ensure t
  :config (progn
            (setq nlinum-format "%4d   ")
            (setq nlinum-relative-redisplay-delay -1)
            (add-hook 'prog-mode-hook 'nlinum-relative-mode)))

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
  :config (progn (load-theme 'gruvbox 'no-confirm)
                 (set-face-attribute 'nlinum-relative-current-face nil
                                     :background "#3c3836"
                                     :foreground "#a89984"
                                     :weight 'bold)))
(provide 'ap-appearance)
