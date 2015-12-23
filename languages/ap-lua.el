;;; ap-lua.el
;;; Lua configuration

(use-package lua-mode
  :ensure t
  :defer t
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode)
  :init (setq lua-indent-level 2)
  :config (progn
            (bind-keys :map lua-mode-map
                       ("C-c C-r" . lua-send-region)
                       ("C-c C-e" . lua-send-current-line)
                       ("C-M-x"   . lua-send-defun))

            (evil-leader/set-key-for-mode 'lua-mode
              "ml" 'lua-send-buffer
              "mr" 'lua-send-current-region
              "me" 'lua-send-current-line
              "mx" 'lua-send-defun)))

(provide 'ap-lua)
