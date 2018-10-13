;;; ap-tex.el
;;; Latex configuration

(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode)
  :defer t)

(use-package auctex-latexmk
  :ensure t
  :config
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  (auctex-latexmk-setup))

(provide 'ap-tex)
