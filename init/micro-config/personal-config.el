;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;�Զ��庯��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;add-code-review-note ��ݼ� C-M-n �������ʼ�
;;ska-point-to-register ��ǵ�ǰ��������ļ���λ��
;;��ݼ� C-c ��
;;ska-jump-to-register  �ص������λ��  
;;��ݼ� C-c ��
;;go-to-char  ��ݼ� C-c f ��ǰ����һ����ĸ
;;go-bto-char ��ݼ� C-c b ������һ����ĸ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;�Զ��庯����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;���ͣ��Դ�������Ҫ����ע��λ�ã�Ȼ��ִ�иú�����
;;emacs�ᴴ��һ���µĽ���NOTES�Ļ�������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;����ΪĬ�ϴ�ֱ�ָ��
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(defun add-code-review-note ()
   "Add note for current file and line number"
   (interactive)
   (let ((file-name (buffer-file-name))
         (file-line (line-number-at-pos)))
     (switch-to-buffer-other-window (get-buffer-create "NOTES"))
     (goto-char (point-min))
     (when (not (search-forward "-*- mode:compilation-shell-minor"
                                nil t))
       (compilation-shell-minor-mode 1)
       (insert "-*- mode:compilation-shell-minor -*-\n\n"))
     (goto-char (point-max))
     (if (/= (current-column) 0)
         (newline))
     (insert file-name ":" (number-to-string file-line) ": ")))

(global-set-key (kbd "C-M-n") 'add-code-review-note)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;������һ���ļ�����һЩ������Ȼ��ܿ��������
;;C-.���
;;C-,����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c .") 'ska-point-to-register)
(global-set-key (kbd "C-c ,") 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 7))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 7)
        (set-register 7 tmp)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c a x (x ������һ���ַ�) ʱ���� ��ͻᵽ��һ�� x �����ٴΰ� x��
;; ���͵���һ�� x������ C-c a w w , C-c a b b b 
;; C-c b x (x ������һ���ַ�) ʱ���� ��ͻᵽ��һ�� x ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c f") 'go-to-char)

(defun go-bto-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-bto-char-key' again will move backwad to the previous Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c b") 'go-bto-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;shell command short cut
;;;����shell ����
(defun zj-open-directory-with-explorer ()
"��windows����explorer�����ǰĿ¼"
(interactive)
 (shell-command"explorer.exe .")
 (browse-url"www.google.cn")
)

;;;����shell�������
(defun zj-display-directory-files ()
"ִ��shell��������������������Ϊ��ʾ��ǰĿ¼�µ��ļ�"
(interactive)
 (message (shell-command-to-string"ls -l")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;���ѹ������� C-gֹͣ��ʾ
;;M-x my-pomodoro ��ʼ��ʱ
(defun v-ding-ding()
  (interactive)
  (message "time to have a rest,ha ha ha...")
  (setq i 1)
  (while (< i 77)    ;;loop 77 times
     (ding)
     (other-frame 0)
     (sit-for 1)        ;;wait 1s
     (setq i (+ i 1)))) 
  
(defun v-my-pomodoro()
  (interactive)
  (message "pomodoro time enabled")
  (org-clock-in)
 ;; (run-at-time "25 min" nil
  (run-at-time "30" nil
               (lambda ()
                 (progn
                   (org-clock-out) 
                   (setq visible-bell nil)
                   (ding-ding)
                   (setq visible-bell t))
                 t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;person config end here
(provide 'personal-config)
