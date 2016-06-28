;;; ap-git.el
;;; Git packages

(use-package magit
  :ensure t)

(use-package gitconfig-mode
  :ensure t
  :mode ("/\\.git/?config\\'"
         "/\\.gitconfig\\.local\\'"
         "/\\.gitmodules\\'"))

(use-package gitignore-mode
  :ensure t
  :mode ("/\\.gitignore\\'"
         "/\\.gitignore\\.global\\'"))

(use-package gitattributes-mode
  :ensure t
  :mode "/\\.gitattributes\\'")


(provide 'ap-git)
