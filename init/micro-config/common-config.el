;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;��������
;;(set-frame-position (selected-frame) 0 0)
;;(setq default-frame-alist
;;             '((height . 28) (width . 130) (menu-bar-lines . 20) (tool-bar-lines . 2)))
;;(global-linum-mode 1)  ;;�����ʾ�к�

;;(global-hl-line-idle-mode 1);;����ʱ������ǰ��
;;ͨ��M-x describe-face���س���֮��ѡ��high-light������ʾ��ɫ��
;;��ͨ���������������
   ;; (1)click on MenuBar Options option,
   ;; (2)then click on Customize Emacs,
   ;; (3)then click on Browse Customization Groups,
   ;; (4)expand Convenience group,
   ;; (5)expand Hl line group
   ;; (6)and then customize HighlineMode options.
(global-hl-line-mode 1)
;;���ÿ��ܱ����⸲�ǣ���������
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
(set-face-underline 'highlight t)

(setq echo-keystrokes 0.1)   ;;;������ʾ��������
(setq visible-bell t);;�رշ��˵ĳ���ʱ����ʾ��
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-margin 3
      scroll-conservatively 10000)           ;;;���ֻ�Ử����߽�3�е�λ��
(setq frame-title-format
      (list  "%b"
       "("
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")) ;;��ʾ��ǰbuffer·����
      ")"))
;; Ĭ����ʾ 80�оͻ���
(setq default-fill-column 80) 
;; һ�򿪾����� text ģʽ��
(setq default-major-mode 'text-mode) 
(setq default-tab-width 4) 
(setq indent-tabs-mode nil) 
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)
(setq-default make-backup-files nil);;��������ʱ�ļ�
(setq make-backup-files nil);;��������ʱ�ļ�
(mouse-avoidance-mode 'animate)
;;��꿿�����ָ��ʱ�������ָ���Զ��ÿ�����ס���ߡ�
;;����emacs���ⲿ���������ճ��
(setq select-enable-clipboard t)
(blink-cursor-mode -1)  ;;ָ�벻Ҫ�����ҵ��۾�����
(global-auto-revert-mode t);;�ļ����ĺ��Զ������ļ�
;;(setq auto-save-default nil);;Ĭ��300s�Զ�����һ��
(global-unset-key  (kbd "C-SPC"))
(global-set-key  (kbd "M-SPC") 'set-mark-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;��������
(add-to-list 'custom-theme-load-path 
             micro-theme-path)
;;(load-theme 'solarized-[light|dark] t))
(load-theme 'molokai t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;������Ӣ�����壬ʹ��Ӣ�����嶼�������ʾ
;;�������ַ�ʽ���������õ�ʹ��
(set-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; (defun micro-set-font()
;;   (if (eq system-type `windows-nt)
;;       (set-frame-font "Consolas-12")
;;       (set-frame-font "UbuntuMonoRegular-12")))
;; (micro-set-font)

;;(set-fontset-font "fontset-default"  
;;                  'gb18030' ("����" . "unicode-bmp"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;������ʾ����ƥ��
(show-paren-mode t)  
(setq show-paren-style 'parenthesis)

(provide 'common-config)

