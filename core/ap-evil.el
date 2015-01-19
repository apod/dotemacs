;;; ap-evil.el
;;; Evil configuration

(use-package undo-tree
  :diminish "")

(use-package evil
  :ensure t
  :pre-load (progn
              ;; C-u for scrolling upwards
              (setq evil-want-C-u-scroll t)

              ;; * and # work on symbols instead of words
              (setq-default evil-symbol-word-search t))
  :init (evil-mode t)
  :config (progn
            ;; Remap j/k to work on visual lines and gj/gk on actual lines
            (bind-key "j"  'evil-next-visual-line evil-motion-state-map)
            (bind-key "k"  'evil-previous-visual-line evil-motion-state-map)
            (bind-key "gj" 'evil-next-line evil-motion-state-map)
            (bind-key "gk" 'evil-previous-line evil-motion-state-map)

            ;; Remap Y to y$
            (bind-key "Y" "y$" evil-normal-state-map)

            ;; Partial functionality form vim-unimpaired
            (bind-key "] SPC" 'ap-newline-below   evil-normal-state-map)
            (bind-key "[ SPC" 'ap-newline-above   evil-normal-state-map)
            (bind-key "] e"   'ap-move-line-below evil-normal-state-map)
            (bind-key "[ e"   'ap-move-line-above evil-normal-state-map)

            ;; C-g works like esc
            (bind-key "C-g" 'evil-normal-state evil-normal-state-map)
            (bind-key "C-g" 'evil-normal-state evil-visual-state-map)
            (bind-key "C-g" 'evil-normal-state evil-insert-state-map)

            ;; Esc works consistently
            (bind-key [escape] 'keyboard-quit evil-normal-state-map)
            (bind-key [escape] 'keyboard-quit evil-visual-state-map)
            (bind-key [escape] 'keyboard-escape-quit minibuffer-local-map)
            (bind-key [escape] 'keyboard-escape-quit minibuffer-local-ns-map)
            (bind-key [escape] 'keyboard-escape-quit minibuffer-local-completion-map)
            (bind-key [escape] 'keyboard-escape-quit minibuffer-local-must-match-map)
            (bind-key [escape] 'keyboard-escape-quit minibuffer-local-isearch-map)))

(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode t)
  :configure (evil-leader/set-leader "<SPC>"))

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
