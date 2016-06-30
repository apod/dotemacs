;;; ap-mode-line.el
;;; Mode-line configuration

(use-package spaceline
  :ensure t
  :config
  (setq spaceline-byte-compile t)
  (setq powerline-default-separator 'bar)
  (setq powerline-height 24)

  ;; Face customization
  (dolist (s `((powerline-active1   ,ap-theme-dark2 ,ap-theme-light0)
               (powerline-active2   ,ap-theme-dark1 ,ap-theme-light0)
               (mode-line           ,ap-theme-dark1 ,ap-theme-light1)
               (powerline-inactive1 ,ap-theme-dark0 ,ap-theme-light0)
               (powerline-inactive2 ,ap-theme-dark0 ,ap-theme-light0)
               (mode-line-inactive  ,ap-theme-dark0 ,ap-theme-light0)))
    (set-face-attribute (nth 0 s) nil
                        :background (nth 1 s)
                        :foreground (nth 2 s)))

  (dolist (s `((spaceline-evil-normal  ,ap-theme-light0)
               (spaceline-evil-insert  ,ap-theme-color1)
               (spaceline-evil-emacs   ,ap-theme-light2)
               (spaceline-evil-replace ,ap-theme-color2)
               (spaceline-evil-visual  ,ap-theme-color3)
               (spaceline-evil-motion  ,ap-theme-color4)))
    (set-face-attribute (nth 0 s) nil
                        :background (nth 1 s)
                        :foreground ap-theme-dark0))

  ;; Custom faces
  (defface ap-spaceline-evil-smartparens
    `((t (:background ,ap-theme-color5 :foreground ,ap-theme-dark0 :inherit 'mode-line)))
    "Evil smartparens state face."
    :group 'spaceline)

  (defface ap-spaceline-modified
    `((t (:foreground ,ap-theme-color1 :inherit 'mode-line)))
    "Spaceline buffer modified."
    :group 'spaceline)

  (defface ap-spaceline-read-only
    `((t (:foreground ,ap-theme-color4 :inherit 'mode-line)))
    "Spaceline buffer is readline."
    :group 'spaceline)

  ;; Add smartparens state
  (add-to-list 'spaceline-evil-state-faces
               '(smartparens . ap-spaceline-evil-smartparens))

  ;; Change mode-line face depending on state
  (setq spaceline-highlight-face-func
        'spaceline-highlight-face-evil-state)

  ;; Custom segments
  (require 'spaceline-segments)

  (spaceline-define-segment ap-evil-state
    "The current evil state, without the tag brackets."
    (let ((state
           (replace-regexp-in-string "\\s-*<\\(.+\\)>\\s-*"
                                     " \\1 "
                                     (evil-state-property evil-state :tag t))))
      (propertize state 'face 'bold))
    :when (bound-and-true-p evil-local-mode))

  (spaceline-define-segment ap-vc-and-projectile
    "Current git branch and projectile project."
    (let ((vc (when (and vc-mode
                         (string= (vc-backend (buffer-file-name (current-buffer))) "Git"))
                (substring-no-properties vc-mode 5)))
          (pr (when (and (fboundp 'projectile-project-p)
                         (stringp (projectile-project-p))
                         (not (string= (projectile-project-name) (buffer-name))))
                (projectile-project-name))))
      (cond
       ((and vc pr) (concat pr " (" vc ")"))
       (pr pr)
       (t nil))))

  (spaceline-define-segment ap-buffer
    "Name of buffer with modified faces"
    (powerline-buffer-id
     (cond
      ((not active)        'mode-line-inactive)
      (buffer-read-only    'ap-spaceline-read-only)
      ((buffer-modified-p) 'ap-spaceline-modified)
      (t                   'mode-line))))

  (spaceline-define-segment ap-line-column
    "The current line and column numbers."
    "%2l:%2c")

  ;; Setup mode-line
  (spaceline-compile "default"
                     ;; Left side
                     `((ap-evil-state :face highlight-face :skip-alternate t)
                       (ap-vc-and-projectile)
                       (ap-buffer :tight t))
                     ;; Right side
                     `((major-mode :face other-face)
                       (((minor-modes :separator spaceline-minor-modes-separator)
                         process)
                        :when active
                        :face other-face)
                       ((selection-info
                         ap-line-column)
                        :when active
                        :face highlight-face)))

  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-default)))))


(provide 'ap-mode-line)
