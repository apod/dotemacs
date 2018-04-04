;;; ap-lua.el
;;; Lua configuration

(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'"
  :init
  :config
  (evil-leader/set-key-for-mode 'lua-mode
    "mr" 'lua-send-region
    "mk" 'lua-send-buffer
    "me" 'lua-send-current-line
    "mx" 'lua-send-defun
    "mz" 'lua-show-process-buffer))

(use-package love-minor-mode
  :ensure t
  :config
  (evil-leader/set-key-for-mode 'lua-mode
    "m5" 'love/play))

(provide 'ap-lua)
