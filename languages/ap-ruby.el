;;; ap-ruby.el
;;; Ruby configuration

(use-package enh-ruby-mode
  :ensure t
  :defer t
  :mode (("\\.rb\\'"       . enh-ruby-mode)
         ("\\.ru\\'"       . enh-ruby-mode)
         ("\\.gemspec\\'"  . enh-ruby-mode)
         ("\\.rake\\'"     . enh-ruby-mode)
         ("Rakefile\\'"    . enh-ruby-mode)
         ("Gemfile\\'"     . enh-ruby-mode)
         ("Guardfile\\'"   . enh-ruby-mode)
         ("Capfile\\'"     . enh-ruby-mode)
         ("Vagrantfile\\'" . enh-ruby-mode)))

(use-package rbenv
  :ensure t
  :defer t
  :init (progn
          (setq rbenv-show-active-ruby-in-modeline nil)
          (global-rbenv-mode)
          (add-hook 'enh-ruby-mode-hook 'rbenv-use-corresponding)))

(use-package inf-ruby
  :ensure t
  :defer t
  :config (evil-leader/set-key-for-mode 'enh-ruby-mode
            "mr" 'ruby-send-region
            "mb" 'ruby-send-block))

(use-package robe
  :ensure t
  :defer t
  :init (add-hook 'enh-ruby-mode-hook 'robe-mode)
  :config (evil-leader/set-key-for-mode 'enh-ruby-mode
            "md" 'robe-doc
            "mz" 'robe-start))

(use-package slim-mode
  :ensure t
  :mode ("\\.slim\\'" . slim-mode))

(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'"  . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(provide 'ap-ruby)
