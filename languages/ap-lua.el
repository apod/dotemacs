;;; ap-lua.el
;;; Lua configuration

(use-package lua-mode
  :ensure t
  :defer t
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode)
  :bind (("C-c C-r" . lua-send-region)
         ("C-c C-e" . lua-send-current-line)
         ("C-M-x"   . lua-send-defun))
  :init (setq lua-indent-level 2)
  :config (progn
            (evil-leader/set-key-for-mode 'lua-mode
              "ml" 'lua-send-buffer
              "mr" 'lua-send-current-region
              "me" 'lua-send-current-line
              "mx" 'lua-send-defun)))

(provide 'ap-lua)
