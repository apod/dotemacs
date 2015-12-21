;;; ap-mode-line.el
;;; Mode-line configuration

(use-package spaceline
  :ensure t
  :config (progn
            (setq powerline-default-separator 'box)

            (dolist (s '((spaceline-evil-normal  "#a89984")
                         (spaceline-evil-insert  "#83a598")
                         (spaceline-evil-emacs   "#fbf1c7")
                         (spaceline-evil-replace "#8ec07c")
                         (spaceline-evil-visual  "#fe8019")
                         (spaceline-evil-motion  "#d3869b")))
              (set-face-attribute (nth 0 s) nil :background (nth 1 s)
                                  :foreground "#2c2827"))
            (defface spaceline-evil-smartparens
              `((t (:background "#f9647e"
                                :foreground "#2c2827"
                                :inherit 'mode-line)))
              "Evil smartparens state face."
              :group 'spaceline)

            (add-to-list 'spaceline-evil-state-faces '(smartparens . spaceline-evil-smartparens))
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

            (set-face-attribute 'powerline-active1 nil :background "#504945"
                                                       :foreground "#a89984")
            (set-face-attribute 'powerline-active2 nil :background "#3c3836"
                                                       :foreground "#a89984")
            (set-face-attribute 'mode-line nil :background "#3c3836"
                                               :foreground "#f2dbae")
            (set-face-attribute 'powerline-inactive1 nil :background "#1d2021"
                                                         :foreground "#a89984")
            (set-face-attribute 'powerline-inactive2 nil :background "#1d2021"
                                                         :foreground "#a89984")
            (set-face-attribute 'mode-line-inactive nil :background "#1d2021"
                                                        :foreground "#a89984")
            (require 'spaceline-segments)

            (spaceline-define-segment ap-evil-state
              "The current evil state, without the tag brackets."
              (let ((state
                     (replace-regexp-in-string "\\s-*<\\(.+\\)>\\s-*"
                                               " \\1 "
                                               (evil-state-property evil-state :tag t))))
                (propertize state 'face 'bold))
              :when (bound-and-true-p evil-local-mode))

            (spaceline-define-segment ap-projectile
              "The current project name based on projectile."
              (projectile-project-name)
              :when (and (functionp 'projectile-project-name)
                         (not (string= (projectile-project-name) "-"))))

            ;; Update vc info every auto-revert-interval
            (setq auto-revert-check-vc-info t)

            (spaceline-define-segment ap-vc
              "Current branch."
              (substring-no-properties vc-mode 5)
              :when (and vc-mode
                         (string= (vc-backend (buffer-file-name (current-buffer))) "Git")))

            (spaceline-define-segment ap-line-column
              "The current line and column numbers."
              "%2l:%2c")

            (spaceline-install
             `((ap-evil-state :face highlight-face)
               (ap-projectile :face other-face)
               (ap-vc :fallback version-control :face default-face)
               ((buffer-id buffer-modified) :face default-face))

             `((major-mode :face other-face)
               (((minor-modes :separator spaceline-minor-modes-separator)
                 process)
                :when active
                :face other-face)
               ((selection-info
                 ap-line-column)
                :face highlight-face)))))

(provide 'ap-mode-line)
