;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil
  :ensure t
  :pre-load (progn
              (setq evil-want-C-u-scroll t)
              (setq-default evil-symbol-word-search t)

              (setq evil-emacs-state-cursor  '("cyan" box))
              (setq evil-normal-state-cursor '("#f8f8f8" box))
              (setq evil-insert-state-cursor '("#f92672"  (bar . 2)))
              (setq evil-visual-state-cursor '("gray" (hbar . 2)))
              (setq evil-motion-state-cursor '("plum3" box))
              (setq evil-smartparens-state-cursor '("#562aa6" box)))
  :init (evil-mode t))

(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode t)
  :config (evil-leader/set-leader "<SPC>"))

(use-package evil-surround
  :ensure t
  :init (global-evil-surround-mode t))

(use-package evil-visualstar
  :ensure t
  :init (global-evil-visualstar-mode t))

(use-package evil-nerd-commenter
  :ensure t
  :pre-load (setq evilnc-hotkey-comment-operator "gc"))

(use-package evil-exchange
  :ensure t
  :init (evil-exchange-install))

(use-package evil-smartparens
  :load-path "lisp/")

(provide 'ap-evil)
