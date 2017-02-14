;;; ap-clojure.el
;;; Clojure configuration

(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'"  . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode)
         ("\\.cljx\\'" . clojurex-mode)
         ("\\.edn\\'"  . clojure-mode))
  :config
  (add-hook 'clojure-mode-hook 'evil-smartparens-mode)
  (add-hook 'clojurescript-mode-hook 'evil-smartparens-mode)

  (ap-set-key-for-modes (clojure-mode clojurescript-mode cider-clojure-interaction-mode)
                        "m-" 'cider-debug-defun-at-point
                        "mi" 'ap-indent-defun
                        "mj" 'cider-jack-in
                        "mJ" 'cider-jack-in-clojurescript
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
                        "md" 'cider-doc
                        "m." 'cider-find-var)

  (use-package clj-refactor
    :ensure t
    :init
    (defun ap-clj-refactor ()
      (setq cljr-favor-private-functions nil)
      (clj-refactor-mode t))

    (add-hook 'clojure-mode-hook 'ap-clj-refactor)

    :config
    (ap-set-key-for-modes (clojure-mode cider-clojure-interaction-mode)
                          "ru"  'cljr-find-usages
                          "rnc" 'cljr-clean-ns
                          "rnp" 'cljr-sort-project-dependencies
                          "rtf" 'cljr-thread-first-all
                          "rtl" 'cljr-thread-last-all
                          "rtu" 'cljr-unwind
                          "rtU" 'cljr-unwind-all
                          "re" 'cljr-extract-function)))

(use-package cider
  :ensure t
  :commands (cider-jack-in cider-jack-in-clojurescript)
  :init
  (setq nrepl-hide-special-buffers t
        cider-repl-display-help-banner nil
        cider-repl-pop-to-buffer-on-connect nil
        cider-repl-history-file (expand-file-name "cider-repl-history" ap-data-directory))
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'evil-smartparens-mode)

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
                                 (lambda (buffer err)
                                   (with-current-buffer buffer
                                     (insert (format ";; %s" err)))
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
      ad-do-it))

  :config

  (evil-leader/set-key-for-mode 'cider-repl-mode
    "mz" 'cider-switch-to-last-clojure-buffer)

  (evil-define-key 'normal cider-inspector-mode-map
    (kbd "RET") 'cider-inspector-operate-on-point
    (kbd "DEL") 'cider-inspector-pop
    (kbd "r")   'cider-inspector-refresh
    (kbd "q")   'cider-popup-buffer-quit
    (kbd "p")   'cider-inspector-next-page
    (kbd "P")   'cider-inspector-previous-page
    (kbd "s")   'cider-inspector-set-page-size))

(provide 'ap-clojure)
