;;; ap-mode-line.el
;;; Mode-line configuration

(use-package spaceline
  :ensure t
  :config (progn
            (setq powerline-default-separator 'bar)
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

            (require 'spaceline-segments)
            (spaceline-define-segment ap-evil-state
              (let ((state
                     (replace-regexp-in-string "\\s-*<\\(.+\\)>\\s-*"
                                               " \\1 "
                                               (evil-state-property evil-state :tag t))))
                (propertize state 'face 'bold))
              :when (bound-and-true-p evil-local-mode))

            (spaceline-install
             `((ap-evil-state :face highlight-face)
               (buffer-id
                buffer-modified)
               (version-control :when active))

             `(major-mode
               (((minor-modes :separator spaceline-minor-modes-separator)
                 process)
                :when active)
               ((selection-info
                 point-position
                 line-column)
                :face highlight-face)))))

(provide 'ap-mode-line)
