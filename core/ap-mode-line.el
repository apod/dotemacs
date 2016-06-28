;;; ap-mode-line.el
;;; Mode-line configuration

(use-package spaceline
  :ensure t
  :config (progn
            (dolist (s '((powerline-active1 "#504945" "#a89984")
                         (powerline-active2 "#3c3836" "#a89984")
                         (mode-line "#3c3836" "#f2dbae")
                         (powerline-inactive1 "#282828" "#a89984")
                         (powerline-inactive2 "#282828" "#a89984")
                         (mode-line-inactive "#282828" "#a89984")))
              (set-face-attribute (nth 0 s) nil :background (nth 1 s)
                                  :foreground (nth 2 s)))
            ;; Spaceline state faces
            (dolist (s '((spaceline-evil-normal  "#a89984")
                         (spaceline-evil-insert  "#83a598")
                         (spaceline-evil-emacs   "#fbf1c7")
                         (spaceline-evil-replace "#8ec07c")
                         (spaceline-evil-visual  "#fe8019")
                         (spaceline-evil-motion  "#d3869b")))
              (set-face-attribute (nth 0 s) nil :background (nth 1 s)
                                  :foreground "#2c2827"))

            ;; Add a custom face for smartparens state
            (defface ap-spaceline-evil-smartparens
              `((t (:background "#f9647e"
                                :foreground "#2c2827"
                                :inherit 'mode-line)))
              "Evil smartparens state face."
              :group 'spaceline)

            (add-to-list 'spaceline-evil-state-faces
                         '(smartparens . ap-spaceline-evil-smartparens))

            ;; Change mode-line face depending on state
            (setq spaceline-highlight-face-func
                  'spaceline-highlight-face-evil-state)

            ;; Custom spaceline segments
            (require 'spaceline-segments)
            (spaceline-define-segment ap-evil-state
              "The current evil state, without the tag brackets."
              (let ((state
                     (replace-regexp-in-string "\\s-*<\\(.+\\)>\\s-*"
                                               " \\1 "
                                               (evil-state-property evil-state :tag t))))
                (propertize state 'face 'bold))
              :when (bound-and-true-p evil-local-mode))

            (spaceline-define-segment ap-vc
              "Current branch."
              (substring-no-properties vc-mode 5)
              :when (and vc-mode
                         (string= (vc-backend (buffer-file-name (current-buffer))) "Git")))

            (spaceline-define-segment ap-line-column
              "The current line and column numbers."
              "%2l:%2c")

            ;; Buffer with modified faces
            (defface ap-spaceline-modified
              `((t (:foreground "#83a598"
                                :inherit 'mode-line)))
              "Spaceline buffer modified."
              :group 'spaceline)

            (defface ap-spaceline-read-only
              `((t (:foreground "#d3869b"
                                :inherit 'mode-line)))
              "Spaceline buffer modified."
              :group 'spaceline)

            (spaceline-define-segment ap-buffer
              "Name of buffer with modified faces"
              (powerline-buffer-id
               (cond
                ((not active)        'mode-line-inactive)
                (buffer-read-only    'ap-spaceline-read-only)
                ((buffer-modified-p) 'ap-spaceline-modified)
                (t                   'mode-line))))

            (setq spaceline-byte-compile t)
            (setq powerline-default-separator 'bar)
            (setq powerline-height 24)

            ;; Setup mode-line segments
            (spaceline-compile "default"
                               ;; Left side
                               `((ap-evil-state :face highlight-face)
                                 (projectile-root :face other-face)
                                 (ap-vc :fallback version-control :face default-face)
                                 (ap-buffer :face default-face))
                               ;; Right side
                               `((major-mode :face other-face)
                                 (((minor-modes :separator spaceline-minor-modes-separator)
                                   process)
                                  :when active
                                  :face other-face)
                                 ((selection-info
                                   ap-line-column)
                                  :face highlight-face)))

            (setq-default mode-line-format '("%e" (:eval (spaceline-ml-default))))))


(provide 'ap-mode-line)
