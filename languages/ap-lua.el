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

(defun ap-love-play ()
  (interactive)
  (let ((buffer-name "*love-output*")
        (project-dir (locate-dominating-file (file-name-directory (buffer-file-name))
                                             "main.lua")))
    (when (get-buffer buffer-name)
      (kill-buffer buffer-name))
    (let* ((project-dir (if project-dir
                            (expand-file-name project-dir)
                          (file-name-directory (buffer-file-name))))
           (love-process (start-process "love-process"
                                        buffer-name
                                        love-exe
                                        project-dir)))
      (message project-dir)
      (display-buffer (process-buffer love-process)))))

(use-package love-minor-mode
  :ensure t
  :config
  (evil-leader/set-key-for-mode 'lua-mode
    "m5" 'ap-love-play))

(provide 'ap-lua)
