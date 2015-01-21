;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil
  :ensure t
  :pre-load (progn
              (setq evil-want-C-u-scroll t)
              (setq-default evil-symbol-word-search t))
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

(provide 'ap-evil)