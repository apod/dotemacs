;;; ap-essentials.el
;;; Essential packages

;;; Projectile
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (setq projectile-cache-file
        (expand-file-name "projectile.cache" ap-data-directory)
        projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" ap-data-directory))

  :config
  (projectile-global-mode t))

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Smartparens
(use-package smartparens
  :ensure t
  :diminish ""
  :config
  (require 'smartparens-config)

  (setq sp-show-pair-delay 0
        sp-show-pair-from-inside t)

  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

;;; Expand-region
(use-package expand-region
  :ensure t
  :commands (er/expand-region))

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :ensure t
  :commands (zygospore-toggle-delete-other-windows)
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;;; Eldoc
(use-package eldoc-mode
  :diminish eldoc-mode)

;;; Comint
(use-package comint
  :init
  (defun ap-comint-clear-buffer ()
    (interactive)
    (let ((comint-buffer-maximum-size 0))
      (comint-truncate-buffer)))
  :bind (:map comint-mode-map
              ("C-c M-o" . ap-comint-clear-buffer)))

;;; Ace-window
(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window)
  :commands (ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-background t))

;;; Which key
(use-package which-key
  :ensure t
  :diminish ""
  :config (which-key-mode))

;;; Company
(use-package company
  :ensure t
  :commands (company-mode global-company-mode)
  :config (setq company-tooltip-align-annotations t))

(provide 'ap-essentials)
