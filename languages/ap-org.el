;;; ap-org.el
;;; Org configuration

(use-package org
  :ensure t
  :defer t
  :init (setq org-log-done 'time))

(provide 'ap-org)
