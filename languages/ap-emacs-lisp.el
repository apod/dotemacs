;;; ap-emacs-lisp.el
;;; Emacs lisp configuration

(use-package lisp-mode
  :init (progn
          (use-package eldoc-mode
            :diminish eldoc-mode
            :defer t)
          (add-hook 'emacs-lisp-mode-hook (lambda ()
                                            (smartparens-strict-mode t)
                                            (eldoc-mode t)))))


(provide 'ap-emacs-lisp)
