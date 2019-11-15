;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;基本设置
;;(set-frame-position (selected-frame) 0 0)
;;(setq default-frame-alist
;;             '((height . 28) (width . 130) (menu-bar-lines . 20) (tool-bar-lines . 2)))
;;(global-linum-mode 1)  ;;左边显示行号

;;(global-hl-line-idle-mode 1);;空闲时高亮当前行
;;通过M-x describe-face，回车，之后选择high-light配置显示颜色等
;;或通过下面的命令配置
   ;; (1)click on MenuBar Options option,
   ;; (2)then click on Customize Emacs,
   ;; (3)then click on Browse Customization Groups,
   ;; (4)expand Convenience group,
   ;; (5)expand Hl line group
   ;; (6)and then customize HighlineMode options.
(global-hl-line-mode 1)
;;设置可能被主题覆盖，不起作用
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
(set-face-underline 'highlight t)

(setq echo-keystrokes 0.1)   ;;;尽快显示按键序列
(setq visible-bell t);;关闭烦人的出错时的提示声
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-margin 3
      scroll-conservatively 10000)           ;;;鼠标只会滑到离边界3行的位置
(setq frame-title-format
      (list  "%b"
       "("
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")) ;;显示当前buffer路径名
      ")"))
;; 默认显示 80列就换行
(setq default-fill-column 80) 
;; 一打开就起用 text 模式。
(setq default-major-mode 'text-mode) 
(setq default-tab-width 4) 
(setq indent-tabs-mode nil) 
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)
(setq-default make-backup-files nil);;不生成临时文件
(setq make-backup-files nil);;不生成临时文件
(mouse-avoidance-mode 'animate)
;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
;;允许emacs和外部其他程序的粘贴
(setq select-enable-clipboard t)
(blink-cursor-mode -1)  ;;指针不要闪，我得眼睛花了
(global-auto-revert-mode t);;文件更改后自动加载文件
;;(setq auto-save-default nil);;默认300s自动保存一次
(global-unset-key  (kbd "C-SPC"))
(global-set-key  (kbd "M-SPC") 'set-mark-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置主题
(add-to-list 'custom-theme-load-path 
             micro-theme-path)
;;(load-theme 'solarized-[light|dark] t))
(load-theme 'molokai t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置中英文字体，使中英文字体都舒服的显示
;;以下两种方式都可以良好的使用
(set-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; (defun micro-set-font()
;;   (if (eq system-type `windows-nt)
;;       (set-frame-font "Consolas-12")
;;       (set-frame-font "UbuntuMonoRegular-12")))
;; (micro-set-font)

;;(set-fontset-font "fontset-default"  
;;                  'gb18030' ("楷体" . "unicode-bmp"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;设置显示括号匹配
(show-paren-mode t)  
(setq show-paren-style 'parenthesis)

(provide 'common-config)

