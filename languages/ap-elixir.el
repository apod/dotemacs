;;; ap-elixir.el
;;; Elixir configuration

(use-package elixir-mode
  :ensure t
  :mode "\\.exs?\\'")

(use-package alchemist
  :ensure t
  :config
  (add-hook 'elixir-mode-hook 'company-mode)
  (add-hook 'elixir-mode-hook 'alchemist-mode)

  (evil-leader/set-key-for-mode 'elixir-mode
    "mz" 'alchemist-iex-project-run
    "mZ" 'alchemist-iex-run
    "me" 'alchemist-iex-send-current-line
    "mr" 'alchemist-iex-send-region
    "mb" 'alchemist-iex-compile-this-buffer
    "mk" 'alchemist-iex-reload-module
    "m." 'alchemist-goto-definition-at-point
    "m," 'alchemist-goto-jump-back
    "md" 'alchemist-help-search-at-point)

  (dolist (mode (list alchemist-compile-mode-map
                      alchemist-eval-mode-map
                      alchemist-execute-mode-map
                      alchemist-message-mode-map
                      alchemist-help-minor-mode-map
                      alchemist-mix-mode-map
                      alchemist-macroexpand-mode-map
                      alchemist-refcard-mode-map
                      alchemist-test-report-mode-map))

    (evil-define-key 'normal mode
      (kbd "q") 'quit-window)))

(provide 'ap-elixir)
