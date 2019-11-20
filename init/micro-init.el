
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 自定义插件配置 ;;设置插件路径
(defun micro-system-chk()
  (if (eq system-type `windows-nt)
    (progn ;;; if windows 
       (defvar micro-plugin-path 
            "C:\\tools\\emacs\\init\\plugin\\")
       
       (defvar micro-config-path 
            "C:\\tools\\emacs\\init\\micro-config\\")
       (add-to-list 'load-path micro-config-path)
       
       (defvar micro-run-path 
            "C:\\tools\\emacs\\init\\run-command\\")
       
       (defvar micro-theme-path 
            "C:\\tools\\emacs\\init\\themes\\"))
    (progn 
        (defvar micro-plugin-path 
             "~/github/svn/emacs-resources/trunk/init/plugin/")
        
        (defvar micro-config-path 
             "~/github/svn/emacs-resources/trunk/init/micro-config/")
        (add-to-list 'load-path micro-config-path)
        
        (defvar micro-run-path 
             "~/github/svn/emacs-resources/trunk/init/run-command/")
        
        (defvar micro-theme-path 
             "~/github/svn/emacs-resources/trunk/init/themes/"))))

(micro-system-chk)

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
          (load (concat micro-config-path "ranger-config")))

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

(add-hook 'org-mode-hook 
          (load (concat micro-config-path "deft-config")))

(require 'personal-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;auto run command ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'perl-mode (load (concat micro-run-path "run-perl")))
(add-hook 'python-mode (load (concat micro-run-path "run-python")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my config func ends here
(provide 'micro-init)
