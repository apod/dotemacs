;;; ap-cider-debug.el
;;; Cider experimentation and debugging

;;; FIXME: There is a weird race condition error when evil is at play, this is a temporary fix

(defun ap-cider-eval-print-last-sexp ()
  (interactive)
  (cider-interactive-eval (cider-last-sexp)
                          (ap-cider-eval-print-handler)))

(defun ap-cider-eval-print-handler (&optional buffer)
  "Make a handler for evaluating and printing result in BUFFER."
  (nrepl-make-response-handler (or buffer (current-buffer))
                               (lambda (buffer value)
                                 (with-current-buffer buffer
                                   (when (and (evil-normal-state-p)
                                              (not (or (eobp) (eolp))))
                                     (forward-char))
                                   (insert (format "\n;;=> %s\n" value))))
                               (lambda (_buffer out)
                                 (cider-emit-interactive-eval-output out))
                               (lambda (_buffer err)
                                 (cider-emit-interactive-eval-err-output err))
                               '()))

(ap-set-key-for-modes (clojure-mode cider-clojure-interaction-mode)
                      "mp" 'ap-cider-eval-print-last-sexp)

(provide 'ap-cider-debug)
