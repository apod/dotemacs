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

;; Expand region
(bind-key "v" 'er/expand-region evil-visual-state-map)

;;; Leader key keybindings

;; Universal argument
(evil-leader/set-key "u" 'universal-argument)

;; Shell
(evil-leader/set-key "!" 'shell-command)

;; Smex
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "X" 'smex-major-mode-commands)

;; Files
(defun ido-find-file-org ()
  (interactive)
  (ido-find-file-in-dir "~/Dropbox/Org/"))

(defun ido-find-file-emacs ()
  (interactive)
  (ido-find-file-in-dir "~/.emacs.d/"))

(evil-leader/set-key
  "ff" 'ido-find-file
  "fe" 'ido-find-file-emacs
  "fo" 'ido-find-file-org)

;; Buffers
(evil-leader/set-key
  "TAB" 'evil-buffer
  "bb" 'ido-switch-buffer
  "bk" 'kill-buffer
  "bK" 'kill-buffer-and-window)

;; Narrowing
(evil-leader/set-key
  "nn" 'ap-narrow-or-widen-dwim
  "nr" 'narrow-to-region
  "nf" 'narrow-to-defun
  "nw" 'widen)

;; Toggle

(setq ap-initial-face-height (face-attribute 'default :height))

(defun ap-toggle-face-height ()
  (interactive)
  (let ((current-height (face-attribute 'default :height)))
    (if (= current-height ap-initial-face-height)
        (set-face-attribute 'default nil :height (+ ap-initial-face-height 60))
      (set-face-attribute 'default nil :height ap-initial-face-height))))

(evil-leader/set-key
  "tr" 'rainbow-mode
  "tt" 'ap-toggle-face-height
  "tn" 'global-linum-mode
  "th" 'whitespace-mode
  "ts" 'smartparens-strict-mode)

;; Magit
(evil-leader/set-key
  "gs" 'magit-status)

;; Projectile
(evil-leader/set-key
  "pp" 'projectile-switch-project
  "pf" 'projectile-find-file
  "pF" 'projectile-find-file-other-window
  "pb" 'projectile-switch-to-buffer
  "pB" 'projectile-switch-to-buffer-other-window)

;; Window management
(evil-leader/set-key
  "ww" 'ace-window
  "wm" 'ace-swap-window
  "wd" 'ace-delete-window
  "wh" 'windmove-left
  "wj" 'windmove-down
  "wk" 'windmove-up
  "wl" 'windmove-right
  "wH" 'ap-move-splitter-left
  "wJ" 'ap-move-splitter-down
  "wK" 'ap-move-splitter-up
  "wL" 'ap-move-splitter-right
  "w=" 'balance-windows
  "ws" 'ap-split-window-vertically-and-focus
  "wv" 'ap-split-window-horizontally-and-focus
  "wS" 'split-window-vertically
  "wV" 'split-window-horizontally
  "w1" 'zygospore-toggle-delete-other-windows
  "wq" 'delete-window)

(evil-leader/set-key
  "jo" 'dumb-jump-go-other-window
  "jt" 'dumb-jump-quick-look
  "jj" 'dumb-jump-go
  "jb" 'dumb-jump-back)

;; Frame management
(evil-leader/set-key
  "wfn" 'new-frame
  "wfd" 'delete-frame
  "wff" 'other-frame)



(provide 'ap-evil-keybindings)
