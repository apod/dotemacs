;;; ap-web.el
;;; Configuration of packages related to general web development

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'"       . web-mode)
         ("\\.handlebars\\'" . web-mode)
         ("\\.hbs\\'"        . web-mode)
         ("\\.erb\\'"        . web-mode)))

(use-package css-mode
  :defer t
  :config (setq css-indent-offset 2))

(use-package scss-mode
  :ensure t
  :mode ("\\.scss\\'" . scss-mode))

(use-package rainbow-mode
  :ensure t
  :defer t
  :init (dolist (mode '(css-mode html-mode scss-mode))
          (add-hook (intern (format "%s-hook" mode)) 'rainbow-mode))
  :config (setq rainbow-html-colors nil))

(provide 'ap-web)
