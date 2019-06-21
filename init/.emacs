
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "Chinese-GBK")
 '(custom-enabled-themes (quote (molokai)))
 '(display-time-mode t)
 '(line-number-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(add-hook 'after-init-hook 
          (lambda ()
             (add-to-list 'load-path "C:\\tools\\emacs\\init\\")
             (require 'micro-init)))

