;;; ap-defuns.el
;;; Helper functions

;;; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun ap-narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

;; Partial functionality from vim-unimpaired
(defun ap-newline-above (times)
  (interactive "p")
  (let ((column (current-column)))
    (beginning-of-line)
    (newline times)
    (forward-char column)))

(defun ap-newline-below (times)
  (interactive "p")
  (save-excursion
    (end-of-line)
    (newline times)))

(defun ap-move-line-above ()
  (interactive)
  (let ((column (current-column)))
    (transpose-lines 1)
    (forward-line -2)
    (forward-char column)))

(defun ap-move-line-below ()
  (interactive)
  (let ((column (current-column)))
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)
    (forward-char column)))

;;; Indentation functions
(defun ap-indent-defun ()
  "Indent current defun"
  (interactive)
 (let ((l (save-excursion (beginning-of-defun 1) (point)))
        (r (save-excursion (end-of-defun 1) (point))))
    (indent-region l r)))

;;; Window functions
(defun ap-split-window-horizontally-and-focus ()
  "Split window horizontally and focus"
  (interactive)
  (split-window-horizontally)
  (other-window 1))

(defun ap-split-window-vertically-and-focus ()
  "Split window vertically and focus"
  (interactive)
  (split-window-vertically)
  (other-window 1))

(defun ap-move-splitter-left (arg)
  "Move window splitter left."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))

(defun ap-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

(defun ap-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

(defun ap-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

;; Other commands
(defun ap-run-curl-command ()
  (interactive)
  (let ((command (if (region-active-p)
                     (buffer-substring-no-properties (region-beginning) (region-end))
                   (buffer-substring-no-properties (line-beginning-position) (line-beginning-position 2))))
        (curl "curl -s ")
        (the-buf (get-buffer-create "*CURL*")))
    (with-current-buffer the-buf
      (erase-buffer)
      (js-mode)
      (insert (shell-command-to-string (concat curl command)))
      (json-pretty-print-buffer))
    (pop-to-buffer the-buf)))

;;; Macros
(defmacro ap-set-key-for-modes (modes key def &rest bindings)
  "Define evil leader key bindings for multiple major modes"
  `(progn
     ,@(mapcar (lambda (mode)
                 `(evil-leader/set-key-for-mode (quote ,mode) ,key ,def ,@bindings))
               modes)))

(provide 'ap-defuns)
