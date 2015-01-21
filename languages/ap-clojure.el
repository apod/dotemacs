;;; ap-clojure.el
;;; Clojure configuration

(use-package clojure-mode
  :ensure t
  :init (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  :config (ap-set-key-for-modes (clojure-mode cider-clojure-interaction-mode)
            "mi" 'ap-indent-defun
            "mj" 'cider-jack-in
            "mz" 'cider-switch-to-repl-buffer
            "mx" 'cider-eval-defun-at-point
            "me" 'cider-eval-last-sexp
            "mr" 'cider-eval-region
            "mp" 'cider-eval-print-last-sexp
            "m`" 'ap-cider-eval-defun-at-point-in-repl
            "md" 'cider-doc))

(use-package cider
  :ensure t
  :init (progn
          (add-hook 'cider-mode-hook #'eldoc-mode)
          (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode))
  :config (setq nrepl-hide-special-buffers t
                  cider-repl-pop-to-buffer-on-connect nil
                  cider-show-error-buffer 'only-in-repl
                  cider-repl-history-file (expand-file-name "cider-repl-history" ap-data-directory))
  :pin melpa-stable)

(provide 'ap-clojure)
