;;; ap-ruby.el
;;; Ruby configuration

(use-package ruby-mode
  :mode ("\\.rb\\'"
         "\\.rake\\'"
         "\\.gemspec\\'"
         "/\\(Gem\\|Cap\\|Vagrant\\|Rake\\)file\\'")
  :interpreter "ruby")

(use-package slim-mode
  :ensure t
  :mode "\\.slim\\'")

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(provide 'ap-ruby)
