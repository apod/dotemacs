;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil-leader
  :ensure t
  :config (progn
            (evil-leader/set-leader "<SPC>")
            (global-evil-leader-mode t)))

(use-package evil
  :ensure t
  :init (progn
          (setq evil-want-C-u-scroll t)
          (setq-default evil-symbol-word-search t)
          (setq evil-normal-state-cursor '("#f8f8f8" box)
                evil-emacs-state-cursor  '("cyan" box)
                evil-insert-state-cursor '("#f92672"  (bar . 2))
                evil-visual-state-cursor '("gray" (hbar . 2))
                evil-motion-state-cursor '("plum3" box)
                evil-smartparens-state-cursor '("#f9647e" box)))
  :config (evil-mode t))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode t))

(use-package evil-visualstar
  :ensure t
  :config (global-evil-visualstar-mode t))

(use-package evil-nerd-commenter
  :ensure t
  :init (setq evilnc-hotkey-comment-operator "gc"))

(use-package evil-exchange
  :ensure t
  :config (evil-exchange-install))

(use-package evil-smartparens
  :load-path "lisp/")

(provide 'ap-evil)
