;;; ap-markdown.el
;;; Markdown configuration

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))


(provide 'ap-markdown)
