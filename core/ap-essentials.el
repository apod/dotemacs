;;; ap-essentials.el
;;; Essential packages

;;; Projectile
(use-package projectile
  :ensure t
  :init (setq projectile-cache-file
              (expand-file-name "projectile.cache" ap-data-directory)
              projectile-known-projects-file
              (expand-file-name "projectile-bookmarks.eld" ap-data-directory))
  :config (projectile-global-mode t))

;;; Magit
(use-package magit
  :ensure t)

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Smartparens
(use-package smartparens
  :ensure t
  :diminish ""
  :config (progn
            (require 'smartparens-config)

            (setq sp-show-pair-delay 0
                  sp-show-pair-from-inside t)
            (smartparens-global-mode t)
            (show-smartparens-global-mode t)))

;;; Expand-region
(use-package expand-region
  :ensure t)

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :ensure t
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;;; Eldoc
(use-package eldoc-mode
  :diminish eldoc-mode)

;;; Comint
(use-package comint
  :bind ("C-c M-o" . ap-comint-clear-buffer)
  :config (defun ap-comint-clear-buffer ()
            (interactive)
            (let ((comint-buffer-maximum-size 0))
              (comint-truncate-buffer))))

(provide 'ap-essentials)
