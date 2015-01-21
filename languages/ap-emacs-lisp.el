;;; ap-emacs-lisp.el
;;; Emacs lisp configuration

(use-package lisp-mode
  :init (add-hook 'emacs-lisp-mode-hook (lambda ()
                                          (smartparens-strict-mode t)
                                          (eldoc-mode t)))
  :config (progn
            (defadvice eval-print-last-sexp (around evil activate)
              "In normal-state, last sexp ends at point."
              (if (evil-normal-state-p)
                  (progn
                    (unless (or (eobp) (eolp)) (forward-char))
                    ad-do-it)
                ad-do-it))

            (ap-set-key-for-modes (emacs-lisp-mode lisp-interaction-mode)
              "mi" 'ap-indent-defun
              "me" 'eval-last-sexp
              "mp" 'eval-print-last-sexp
              "mx" 'eval-defun
              "mr" 'eval-region
              "mb" 'eval-buffer)))

(provide 'ap-emacs-lisp)
