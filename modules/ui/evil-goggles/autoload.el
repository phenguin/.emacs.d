;;; feature/ui/evil-goggles/autoload.el

;;;###autoload
(defun +evil-goggles/toggle ()
  "Toggle evil goggles mode."
  (interactive)
  (if evil-goggles-mode
      (evil-goggles-mode -1)
    (evil-goggles-mode +1)))
