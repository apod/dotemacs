;;; ap-emacs-lisp.el
;;; Emacs lisp configuration

(use-package lisp-mode
  :config (progn
            (defadvice eval-print-last-sexp (around evil activate)
              "In normal-state, last sexp ends at point."
              (if (evil-normal-state-p)
                  (progn
                    (unless (or (eobp) (eolp)) (forward-char))
                    ad-do-it)
                ad-do-it))

            (add-hook 'emacs-lisp-mode-hook (lambda ()
                                              (evil-smartparens-mode t)
                                              (eldoc-mode t)))
            (ap-set-key-for-modes (emacs-lisp-mode lisp-interaction-mode)
              "mi" 'ap-indent-defun
              "me" 'eval-last-sexp
              "mp" 'eval-print-last-sexp
              "mx" 'eval-defun
              "mr" 'eval-region
              "mb" 'eval-buffer)))

(provide 'ap-emacs-lisp)
