;;; ap-sml.el
;;; SML configuration

(use-package sml-mode
  :ensure t
  :mode "\\.sml\\'"
  :bind (("C-c C-r" . ap-sml-send-region-or-line)
         ("C-c C-k" . ap-sml-kill-and-load-file))

  :init
  (defun ap-sml-send-region-or-line ()
    (interactive)
    (if (use-region-p)
        (sml-prog-proc-send-region (region-beginning)
                                   (region-end))
      (sml-prog-proc-send-region (line-beginning-position)
                                 (line-beginning-position 2))))

  (defun ap-sml-kill-and-load-file (file)
    (interactive
     (list (or buffer-file-name
               (read-file-name "File to load: " nil nil t))))
    (when (processp (get-buffer-process "*sml*"))
      (delete-process "*sml*"))
    (sml-prog-proc-load-file file)
    (other-window 1))

  :config
  (evil-leader/set-key-for-mode 'sml-mode
    "mr" 'ap-sml-send-region-or-line
    "mk" 'ap-sml-kill-and-load-file
    "ml" 'sml-prog-proc-load-file
    "mz" 'sml-prog-proc-switch-to))

(provide 'ap-sml)
