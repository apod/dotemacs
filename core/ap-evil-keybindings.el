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

(provide 'ap-evil-keybindings)
