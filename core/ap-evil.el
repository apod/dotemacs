;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil
  :ensure t

  :init
  (setq evil-want-C-u-scroll t)
  (setq-default evil-symbol-word-search t)

  (setq evil-normal-state-cursor      `(,ap-theme-light0 box)
        evil-emacs-state-cursor       `(,ap-theme-light1 box)
        evil-insert-state-cursor      `(,ap-theme-color1 (bar . 2))
        evil-replace-state-cursor     `(,ap-theme-color2 (bar . 2))
        evil-visual-state-cursor      `(,ap-theme-color3 (hbar . 2))
        evil-motion-state-cursor      `(,ap-theme-color4 box)
        evil-smartparens-state-cursor `(,ap-theme-color5 box))

  :config
  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode t))
  (evil-mode t))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode t))

(use-package evil-visualstar
  :ensure t
  :config (global-evil-visualstar-mode t))

(use-package evil-nerd-commenter
  :ensure t
  :bind (:map evil-normal-state-map
         ("gc" . evilnc-comment-operator)
         :map evil-visual-state-map
         ("gc" . evilnc-comment-operator)))

(use-package evil-exchange
  :ensure t
  :config (evil-exchange-install))

(use-package evil-lion
  :ensure t
  :config (evil-lion-mode))

(use-package evil-matchit
  :ensure t
  :config (global-evil-matchit-mode t))

(use-package evil-smartparens
  :load-path "lisp/")

(provide 'ap-evil)
