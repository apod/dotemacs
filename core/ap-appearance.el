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

;;; Fonts

(when (member "M+ 1mn" (font-family-list))
  (set-face-attribute 'default nil :font "M+ 1mn-11"))

;;; Themes

;; Fully unload previous theme before loading a new one
(defadvice load-theme
  (before theme-dont-propagate activate)
  (mapc #'disable-theme custom-enabled-themes))

;;; Theme colors

(defvar ap-theme-dark0   "#282828")
(defvar ap-theme-dark1   "#3c3836")
(defvar ap-theme-dark2   "#504945")
(defvar ap-theme-light0  "#a89984")
(defvar ap-theme-light1  "#f2dbae")
(defvar ap-theme-light2  "#fbf1c7")
(defvar ap-theme-color1  "#83a598")
(defvar ap-theme-color2  "#8ec07c")
(defvar ap-theme-color3  "#fe8019")
(defvar ap-theme-color4  "#d3869b")
(defvar ap-theme-color5  "#f9647e")

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox 'no-confirm))

;;; Line numbers
(use-package nlinum-relative
  :ensure t
  :config
  (setq nlinum-format "%4d ")
  (setq nlinum-relative-redisplay-delay -1)

  (set-face-attribute 'nlinum-relative-current-face nil
                      :background ap-theme-dark1
                      :foreground ap-theme-light0
                      :weight 'bold)

  (add-hook 'prog-mode-hook 'nlinum-relative-mode))

(provide 'ap-appearance)
