;;; ap-graphviz-dot.el
;;; Graphviz Dot configuration

(use-package graphviz-dot-mode
  :ensure t
  :mode "\\.dot\\'"
  :config
  (evil-leader/set-key-for-mode 'graphviz-dot-mode
    "mc" 'compile
    "mv" 'graphviz-dot-preview))

(provide 'ap-graphviz-dot)
