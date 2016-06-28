;;; ap-web.el
;;; Configuration of packages related to general web development

(use-package js
  :mode ("\\.js\\'" . js-mode)
  :config
  (setq js-indent-level 2))

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.handlebars\\'" "\\.hbs\\'" "\\.erb\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset    2
        web-mode-code-indent-offset   2)
  (evil-leader/set-key-for-mode 'web-mode
    "mt" 'web-mode-element-close))

(use-package css-mode
  :mode "\\.css\\'"
  :config
  (setq css-indent-offset 2))

(use-package scss-mode
  :ensure t
  :mode "\\.scss\\'")

(use-package rainbow-mode
  :ensure t
  :commands (rainbow-mode))

(provide 'ap-web)
