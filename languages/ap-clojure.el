;;; ap-clojure.el
;;; Clojure configuration

(use-package clojure-mode
  :ensure t
  :config (progn
            (add-hook 'clojure-mode-hook 'evil-smartparens-mode)
            (ap-set-key-for-modes (clojure-mode cider-clojure-interaction-mode)
              "m-" 'cider-debug-defun-at-point
              "mi" 'ap-indent-defun
              "mj" 'cider-jack-in
              "mz" 'cider-switch-to-repl-buffer
              "mx" 'cider-eval-defun-at-point
              "me" 'cider-eval-last-sexp
              "mr" 'cider-eval-region
              "mk" 'cider-load-buffer
              "mp" 'ap-cider-eval-defun-and-print
              "mP" 'ap-cider-eval-last-sexp-and-print
              "mm" 'cider-macroexpand-1
              "mM" 'cider-macroexpand-all
              "mn" 'clojure-insert-ns-form
              "m`" 'ap-cider-eval-defun-at-point-or-region-in-repl
              "m5" 'ap-cider-eval-refresh-in-repl
              "md" 'cider-doc)))

(use-package cider
  :ensure t
  :init (progn
          (push '(cider-repl-mode :stick t) popwin:special-display-config)
          (push '("*cider-error*" :width 0.5 :position right) popwin:special-display-config)

          (setq nrepl-hide-special-buffers t
                cider-repl-pop-to-buffer-on-connect nil
                cider-repl-history-file (expand-file-name "cider-repl-history" ap-data-directory)))
  :config (progn
            (add-hook 'cider-mode-hook 'eldoc-mode)
            (add-hook 'cider-repl-mode-hook 'evil-smartparens-mode)

            (evil-leader/set-key-for-mode 'cider-repl-mode
              "mz" 'cider-switch-to-last-clojure-buffer)

            (defun ap-cider-eval-refresh-in-repl ()
              (interactive)
              (set-buffer (cider-current-repl-buffer))
              (goto-char (point-max))
              (cider-repl-delete-current-input)
              (insert "(reloaded.repl/reset)")
              (cider-repl-return))

            (defun ap-cider-eval-defun-at-point-or-region-in-repl ()
              (interactive)
              (let ((form (if (region-active-p)
                              (buffer-substring-no-properties (region-beginning) (region-end))
                            (cider-defun-at-point))))
                (while (string-match "\\`\s+\\|\n+\\'" form)
                  (setq form (replace-match "" t t form)))
                (set-buffer (cider-current-repl-buffer))
                (goto-char (point-max))
                (cider-repl-delete-current-input)
                (insert form)
                (cider-repl-return)))

            (defun ap-cider-eval-print-handler (&optional buffer)
              "Make a handler for evaluating and printing result in BUFFER."
              (nrepl-make-response-handler (or buffer (current-buffer))
                                           (lambda (buffer value)
                                             (with-current-buffer buffer
                                               (insert (format ";;=> %s\n" value))))
                                           (lambda (buffer out)
                                             (with-current-buffer buffer
                                               (insert (format ";; %s" out))))
                                           (lambda (_buffer err)
                                             (cider-emit-interactive-eval-err-output err))
                                           '()))

            (defun ap-cider-eval-defun-and-print ()
              (interactive)
              (let ((form (cider-defun-at-point)))
                (while (string-match "\\`\s+\\|\n+\\'" form)
                  (setq form (replace-match "" t t form)))
                (end-of-defun)
                (unless (bolp)
                  (newline))
                (cider-interactive-eval form
                                        (ap-cider-eval-print-handler))))

            (defun ap-cider-eval-last-sexp-and-print ()
              (interactive)
              (let ((form (cider-last-sexp)))
                (unless (bolp)
                  (newline))
                (cider-interactive-eval form
                                        (ap-cider-eval-print-handler))))

            (defadvice cider-last-sexp (around evil activate)
              "In normal-state, last sexp ends at point."
              (if (evil-normal-state-p)
                  (progn
                    (unless (or (eobp) (eolp)) (forward-char))
                    ad-do-it)
                ad-do-it))))

(provide 'ap-clojure)
