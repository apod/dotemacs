;;; ap-essentials.el
;;; Essential packages

;;; Projectile
(use-package projectile
  :ensure t
  :defer t
  :init (projectile-global-mode t)
  :config (setq projectile-cache-file
                (expand-file-name "projectile.cache" ap-data-directory)
                projectile-known-projects-file
                (expand-file-name "projectile-bookmarks.eld" ap-data-directory)))

;;; Magit
(use-package magit
  :ensure t
  :defer t)

(provide 'ap-essentials)
