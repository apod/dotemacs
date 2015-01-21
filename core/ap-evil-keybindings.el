;;; ap-evil-keybindings.el
;;; Evil keybindings

;;; General

;; C-g works like esc
(bind-key "C-g" 'evil-normal-state evil-normal-state-map)
(bind-key "C-g" 'evil-normal-state evil-visual-state-map)
(bind-key "C-g" 'evil-normal-state evil-insert-state-map)

;; Esc works consistently
(bind-key [escape] 'keyboard-quit evil-visual-state-map)
(bind-key [escape] 'keyboard-escape-quit minibuffer-local-map)
(bind-key [escape] 'keyboard-escape-quit minibuffer-local-ns-map)
(bind-key [escape] 'keyboard-escape-quit minibuffer-local-completion-map)
(bind-key [escape] 'keyboard-escape-quit minibuffer-local-must-match-map)
(bind-key [escape] 'keyboard-escape-quit minibuffer-local-isearch-map)

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
(bind-key "] b"   'switch-to-next-buffer evil-normal-state-map)
(bind-key "[ b"   'switch-to-prev-buffer evil-normal-state-map)

;;; Leader key keybindings

;; Universal argument
(evil-leader/set-key "u" 'universal-argument)

;; Shell
(evil-leader/set-key "!" 'shell-command)

;; Files
(evil-leader/set-key
  "ff" 'ido-find-file)

;; Buffers
(evil-leader/set-key
  "TAB" 'evil-buffer
  "bb" 'ido-switch-buffer
  "bk" 'kill-buffer
  "bK" 'kill-buffer-and-window)

;; Windows
(evil-leader/set-key
  "ww" 'zygospore-toggle-delete-other-windows
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "ws" 'split-window-below
  "wv" 'split-window-right)

;; Narrowing
(evil-leader/set-key
  "nn" 'ap-narrow-or-widen-dwim
  "nr" 'narrow-to-region
  "nf" 'narrow-to-defun
  "nw" 'widen)

;; Toggle
(evil-leader/set-key
  "tn" 'global-linum-mode
  "th" 'whitespace-mode
  "ts" 'smartparens-strict-mode)

;; Magit
(evil-leader/set-key
  "gs" 'magit-status)

;; Projectile
(evil-leader/set-key
  "pp" 'projectile-switch-project
  "pf" 'projectile-find-file)

(provide 'ap-evil-keybindings)
