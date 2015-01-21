;;; ap-emacs-lisp.el
;;; Emacs lisp configuration

(use-package lisp-mode
  :init (add-hook 'emacs-lisp-mode-hook (lambda ()
                                          (smartparens-strict-mode t)
                                          (eldoc-mode t)))
  :config (progn
            (evil-leader/set-key-for-mode 'emacs-lisp-mode
              "mi" 'ap-indent-defun
              "me" 'eval-last-sexp
              "mx" 'eval-defun
              "mr" 'eval-region
              "mb" 'eval-buffer)))

(provide 'ap-emacs-lisp)
