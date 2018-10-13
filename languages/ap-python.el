;;; ap-python.el
;;; Python configuration

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :init
  (setq-default indent-tabs-mode nil)
  :config
  (setq python-indent-offset 4)
  (add-hook 'python-mode-hook 'smartparens-mode))

(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))
  :config
  (evil-leader/set-key-for-mode 'python-mode
    "me" 'elpy-shell-send-statement
    "mm" 'elpy-shell-send-statement
    "mr" 'elpy-shell-send-region-or-buffer))

(provide 'ap-python)
