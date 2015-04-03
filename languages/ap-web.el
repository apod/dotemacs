;;; ap-web.el
;;; Configuration of packages related to general web development

(use-package web-mode
  :ensure t
  :defer t
  :mode (("\\.html\\'"       . web-mode)
         ("\\.handlebars\\'" . web-mode)
         ("\\.hbs\\'"        . web-mode)
         ("\\.erb\\'"        . web-mode))
  :init (setq web-mode-markup-indent-offset 2
              web-mode-css-indent-offset    2
              web-mode-code-indent-offset   2))

(use-package css-mode
  :defer t
  :init (setq css-indent-offset 2))

(use-package js-mode
  :init (setq js-indent-level 2))

(use-package scss-mode
  :ensure t
  :mode ("\\.scss\\'" . scss-mode))

(use-package rainbow-mode
  :ensure t
  :defer t
  :init (setq rainbow-html-colors nil)
  :config (dolist (mode '(css-mode html-mode scss-mode))
            (add-hook (intern (format "%s-hook" mode)) 'rainbow-mode)))

(provide 'ap-web)
