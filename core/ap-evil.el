;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil
  :ensure t
  :init (progn
          (setq evil-want-C-u-scroll t)
          (setq-default evil-symbol-word-search t)
          (setq evil-normal-state-cursor '("#a89984" box)
                evil-emacs-state-cursor  '("#fbf1c7" box)
                evil-insert-state-cursor '("#83a598"  (bar . 2))
                evil-replace-state-cursor '("#8ec07c"  (bar . 2))
                evil-visual-state-cursor '("#fe8019" (hbar . 2))
                evil-motion-state-cursor '("#d3869b" box)
                evil-smartparens-state-cursor '("#f9647e" box)))
  :config (progn
            (use-package evil-leader
              :ensure t
              :config (progn
                        (evil-leader/set-leader "<SPC>")
                        (global-evil-leader-mode t)))
            (evil-mode t)))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode t))

(use-package evil-visualstar
  :ensure t
  :config (global-evil-visualstar-mode t))

(use-package evil-nerd-commenter
  :ensure t
  :config (progn
            (bind-key "gc" 'evilnc-comment-operator  evil-normal-state-map)
            (bind-key "gc" 'evilnc-comment-operator  evil-visual-state-map)))

(use-package evil-exchange
  :ensure t
  :config (evil-exchange-install))

(use-package evil-smartparens
  :load-path "lisp/")

(provide 'ap-evil)
