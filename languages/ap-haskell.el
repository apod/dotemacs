;;; ap-haskell.el
;;; Haskell configuration

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  :config

  (use-package intero
    :ensure t
    :config
    (add-hook 'haskell-mode-hook 'intero-mode)
    (evil-leader/set-key-for-mode 'haskell-mode
      "mf" 'haskell-mode-stylish-buffer
      "mt" 'intero-type-at
      "mi" 'intero-info
      "ml" 'intero-repl-load)))

(provide 'ap-haskell)
