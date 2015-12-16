;;; ap-mode-line.el
;;; Mode-line configuration

(use-package spaceline
  :ensure t
  :config (progn
            (setq powerline-default-separator 'bar)
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

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
               (buffer-id
                buffer-modified)
               (ap-projectile)
               (ap-vc :fallback version-control))

             `(major-mode
               (((minor-modes :separator spaceline-minor-modes-separator)
                 process)
                :when active)
               ((selection-info
                 ap-line-column)
                :face highlight-face)))))

(provide 'ap-mode-line)
