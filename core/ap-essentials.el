;;; ap-essentials.el
;;; Essential packages

;;; Projectile
(use-package projectile
  :ensure t
  :init (projectile-global-mode t)
  :config (setq projectile-cache-file
                (expand-file-name "projectile.cache" ap-data-directory)
                projectile-known-projects-file
                (expand-file-name "projectile-bookmarks.eld" ap-data-directory)))

;;; Magit
(use-package magit
  :ensure t)

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Smartparens
(use-package smartparens
  :ensure t
  :diminish ""
  :init (smartparens-global-mode t)
  :config (require 'smartparens-config))

;;; Expand-region
(use-package expand-region
  :ensure t
  :config (bind-key "v" 'er/expand-region evil-visual-state-map))

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :ensure t
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;;; Eldoc
(use-package eldoc-mode
  :diminish eldoc-mode
  :defer t)

(provide 'ap-essentials)
