
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
 ;;'(custom-enabled-themes (quote (molokai)))
 '(display-time-mode t)
 '(line-number-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 自定义插件配置 ;;设置插件路径
(setq micro-plugin-path 
	     "C:\\tools\\emacs\\init\\plugin\\")

(setq micro-config-path 
	     "C:\\tools\\emacs\\init\\micro-config\\")
(add-to-list 'load-path micro-config-path)

(setq micro-run-path 
	     "C:\\tools\\emacs\\init\\run-command\\")

(setq micro-theme-path 
	     "C:\\tools\\emacs\\init\\themes\\")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;common settiong
;;evil 
;;helm or ivy
;;which-key config
;;sr-speedbar config
;;org-capture config
;;auto complete
;;yasnippet
;;org-mode config
;;personal config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "common-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "evil-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "ivy-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "which-key-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "sr-speedbar-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "org-capture-config")))

(eval-after-load 'c-mode 
                 '(load (concat micro-config-path "auto-complete-config")))
(eval-after-load 'verilog-mode 
                 '(load (concat micro-config-path "auto-complete-config")))
   
(eval-after-load 'c-mode 
                 '(load (concat micro-config-path "yasnippet-config")))
(eval-after-load 'verilog-mode 
                 '(load (concat micro-config-path "yasnippet-config")))

(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
(add-hook 'org-mode-hook 
          (load (concat micro-config-path "org-config")))

(require 'personal-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;auto run conmand ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'perl-mode (load (concat micro-run-path "run-perl")))
(add-hook 'python-mode (load (concat micro-run-path "run-python")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;myconfigfunc ends here
(provide 'micro-init)
