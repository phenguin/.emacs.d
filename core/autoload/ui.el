;;; ui.el

;;;###autoload
(defun doom/toggle-fullscreen ()
  "Toggle fullscreen Emacs (non-native on MacOS)."
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (unless (frame-parameter nil 'fullscreen)
     'fullboth)))

;;;###autoload
(defun doom/toggle-line-numbers (&optional arg)
  "Toggle `linum-mode'."
  (interactive "P")
  (cond ((featurep 'nlinum)
         (nlinum-mode (or arg (if nlinum-mode -1 +1))))
        ((featurep 'linum-mode)
         (linum-mode (or arg (if linum-mode -1 +1))))
        (t
         (error "No line number plugin detected"))))

;;;###autoload
(defun doom-resize-window (new-size &optional horizontal)
  "Resize a window to NEW-SIZE. If HORIZONTAL, do it width-wise."
  (enlarge-window (- new-size (if horizontal (window-width) (window-height)))
                  horizontal))

;;;###autoload
(defun doom/window-zoom ()
  "Maximize and isolate the current buffer. Activate again to undo this. If the
window changes before then, the undo expires."
  (interactive)
  (if (and (one-window-p)
           (assoc ?_ register-alist))
      (jump-to-register ?_)
    (window-configuration-to-register ?_)
    (delete-other-windows)))

(defvar doom--window-enlargened nil)

;;;###autoload
(defun doom/window-enlargen ()
  "Enlargen the current window. Activate again to undo."
  (interactive)
  (setq doom--window-enlargened
        (if (and doom--window-enlargened
                 (assoc ?_ register-alist))
            (ignore (jump-to-register ?_))
          (window-configuration-to-register ?_)
          (doom-resize-window (truncate (/ (frame-width)  1.2)) t)
          (doom-resize-window (truncate (/ (frame-height) 1.2)))
          t)))
