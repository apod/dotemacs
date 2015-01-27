;;; ap-clojure.el
;;; Clojure configuration

(use-package clojure-mode
  :ensure t
  :init (add-hook 'clojure-mode-hook 'evil-smartparens-mode)
  :config (ap-set-key-for-modes (clojure-mode cider-clojure-interaction-mode)
            "mi" 'ap-indent-defun
            "mj" 'cider-jack-in
            "mz" 'cider-switch-to-repl-buffer
            "mx" 'cider-eval-defun-at-point
            "me" 'cider-eval-last-sexp
            "mr" 'cider-eval-region
            "mk" 'cider-load-buffer
            "mp" 'cider-eval-print-last-sexp
            "m`" 'ap-cider-eval-defun-at-point-in-repl
            "md" 'cider-doc))

(use-package cider
  :ensure t
  :init (progn
          (add-hook 'cider-mode-hook 'eldoc-mode)
          (add-hook 'cider-repl-mode-hook 'evil-smartparens-mode))
  :config (progn
            (setq nrepl-hide-special-buffers t
                  cider-repl-pop-to-buffer-on-connect nil
                  cider-show-error-buffer 'only-in-repl
                  cider-repl-history-file (expand-file-name "cider-repl-history" ap-data-directory))

            (evil-leader/set-key-for-mode 'cider-repl-mode
              "mz" 'cider-switch-to-last-clojure-buffer)

            (dolist (map '(cider-docview-mode-map cider-stacktrace-mode-map))
              (evil-define-key 'normal (eval map) "q" 'cider-popup-buffer-quit-function))

            (defun ap-cider-eval-defun-at-point-in-repl ()
              (interactive)
              (let ((form (cider-defun-at-point)))
                (while (string-match "\\`\s+\\|\n+\\'" form)
                  (setq form (replace-match "" t t form)))
                (set-buffer (cider-current-repl-buffer))
                (goto-char (point-max))
                (insert form)
                (cider-repl-return)))

            (defadvice cider-last-sexp (around evil activate)
              "In normal-state, last sexp ends at point."
              (if (evil-normal-state-p)
                  (progn
                    (unless (or (eobp) (eolp)) (forward-char))
                    ad-do-it)
                ad-do-it)))
  :pin melpa-stable)

(require 'ap-cider-debug)

(provide 'ap-clojure)
