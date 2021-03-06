;;; ap-packages.el
;;; Package system configuration

(require 'package)

;; Set package archive repositories
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-pinned-packages
      (append package-pinned-packages '((cider . "melpa-stable")
                                        (clj-refactor . "melpa-stable"))))

;; Make sure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(provide 'ap-packages)
