(require 'evil)
(require 'evil-leader)
(require 'smartparens)

(define-minor-mode evil-smartparens-mode
  "A minor mode for integrating evil and smartparens"
  :lighter " SP/e"
  :keymap (make-sparse-keymap)
  (if evil-smartparens-mode
      (smartparens-mode t)
    (smartparens-mode -1)))

(evil-define-state smartparens
  "An evil state for smartparens"
  :tag "<()>"
  :cursor ("red" box)
  :suppress-keymap t)

(defun evil-smartparens--enter-state ()
  (interactive)
  (evil-smartparens-state))

(defun evil-smartparens--exit-state ()
  (interactive)
  (if (region-active-p)
      (deactivate-mark)
    (evil-normal-state)))

(evil-define-key 'normal evil-smartparens-mode-map
  "D" 'sp-kill-hybrid-sexp
  "," 'evil-smartparens--enter-state)

(evil-define-key 'normal evil-smartparens-mode-map
  "D" 'sp-kill-hybrid-sexp
  "," 'evil-smartparens--enter-state)

(define-key evil-smartparens-state-map [escape] 'evil-smartparens--exit-state)
(define-key evil-smartparens-state-map "," 'evil-smartparens--exit-state)

(let ((evil-smartparens--state-keybindings
       '(("C-g" . evil-smartparens--exit-state)
         (":"   . evil-ex)
         ("%"   . evil-jump-item)
         ("i"   . evil-insert-state)
         ("I"   . evil-insert-line)
         ("h"   . sp-backward-sexp)
         ("l"   . sp-forward-sexp)
         ("j"   . sp-next-sexp)
         ("k"   . sp-previous-sexp)
         ("x"   . sp-kill-sexp)
         ("u"   . undo-tree-undo)
         ("C-r" . undo-tree-redo)
         ("y"   . sp-copy-sexp)
         ("p"   . evil-paste-after)
         ("P"   . evil-paste-before)
         ("."   . sp-forward-slurp-sexp)
         (","   . sp-forward-barf-sexp)
         ("<"   . sp-backward-slurp-sexp)
         (">"   . sp-backward-barf-sexp))))
  (dolist (kb evil-smartparens--state-keybindings)
    (define-key evil-smartparens-state-map (kbd (car kb)) (cdr kb))))

(provide 'evil-smartparens)
