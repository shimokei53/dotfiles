;; http://sheephead.homelinux.org/2011/06/17/6724/
(require 'package)
;;リポジトリにMarmaladeを追加
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;インストールするディレクトリを指定
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))
;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)

;;======= http://futurismo.biz/archives/2213 =======
;;======= Ruby-mode =========
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(defun ruby-mode-set-encoding () nil)
(setq ruby-insert-encoding-magic-comment nil)

;;===== ruby-electric =====
;;(require 'ruby-electric)
;;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;;(setq ruby-electric-expand-delimiters-list nil)

;; ruby-block.el --- highlight matching block
;;(require 'ruby-block)
;;(ruby-block-mode t)
;;(setq ruby-block-highlight-toggle t)

;;=====便利コマンド=====
(global-set-key "\M-g" 'goto-line)
(defun revert-buffer-force()
  (interactive)
  (revert-buffer nil t)
)
(global-set-key "\C-cv" 'revert-buffer-force)

;;=======web-mode========
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq tab-width web-mode-markup-indent-offset)
  (setq indent-tabs-mode t))
(add-hook 'web-mode-hook 'web-mode-hook)

;;=============Global Options =====================
;; http://tech.kayac.com/archive/emacs.html
(setq make-backup-files nil)

;; http://www.cozmixng.org/~kou/emacs/dot_emacs
(setq kill-whole-line t)

;; hide date time
(display-time-mode 0)

;; 最終行に必ず一行挿入する
(setq require-final-newline t)

(setq backup-inhibited t)

;; iswitchb-mode on
(iswitchb-mode t)
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
      (lambda ()
        (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
        (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; Language settings
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)

;; colorize region  http://blog.livedoor.jp/t100life/archives/51680860.html
(transient-mark-mode 1)

;; disable tab
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(safe-local-variable-values (quote ((encoding . utf-8)))))

;; show line-number
(line-number-mode t)

;; hide menu bar
(menu-bar-mode nil)

;; set start up message off
(setq inhibit-startup-message t)

;; hilight parenthes
(show-paren-mode t)


;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#backward-delete-char-untabify-method
(setq backward-delete-char-untabify-method 'hungry)


(setq c-set-style "stroustrup")

;; hilight current line
;; http://emacsblog.org/2007/04/09/highlight-the-current-line/
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(global-hl-line-mode t)

;; To customize the background color(
(set-face-background 'hl-line "#aaaaf7")

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; tramp ( ssh as default)
(setq tramp-default-method "ssh")

;; http://www23.atwiki.jp/selflearn/pages/41.html#id_4af821e2
;; recent files
(require 'recentf)
(recentf-mode 1)

;; open recent files
(global-set-key "\C-xf" 'recentf-open-files)

;; compare-window
(global-set-key "\C-cw" 'compare-windows)


;; copy current word
;; http://sh1.2-d.jp/b/2006-07-16-00-44.html
(ffap-bindings)
(global-set-key "\C-cc" 'ffap-copy-string-as-kill)

;; ansi-color
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)

(setq ansi-color-names-vector
      ["#000000"           ; black
       "#ff6565"           ; red
       "#93d44f"           ; green
       "#eab93d"           ; yellow
       "#204a87"           ; blue
       "#ce5c00"           ; magenta
       "#89b6e2"           ; cyan
       "#ffffff"]          ; white
      )
(ansi-color-for-comint-mode-on)

;; Show tab, zenkaku-space, white spaces at end of line
;; http://openlab.dino.co.jp/wp-content/uploads/2008/07/dotemacs-show-white-spaces.txt
;; http://www.bookshelf.jp/soft/meadow_26.html#SEC317
(defface my-face-tab         '((t (:background "Gray"))) nil :group 'my-faces)
(defface my-face-zenkaku-spc '((t (:background "LightBlue"))) nil :group 'my-faces)
(defface my-face-spc-at-eol  '((t (:foreground "Red" :underline t))) nil :group 'my-faces)
(defvar my-face-tab         'my-face-tab)
(defvar my-face-zenkaku-spc 'my-face-zenkaku-spc)
(defvar my-face-spc-at-eol  'my-face-spc-at-eol)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
;;     ("\t" 0 my-face-tab append)
     ("　" 0 my-face-zenkaku-spc append)
     ("[ \t]+$" 0 my-face-spc-at-eol append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; settings for text file
(add-hook 'text-mode-hook
          '(lambda ()
             (progn
               (font-lock-mode t)
               (font-lock-fontify-buffer))))

;; chmod +x as you save it
;; http://www.namazu.org/~tsuchiya/elisp/index.html#chmod
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)

;;======== スペース・タブ文字まわり ==========
;;======== http://d.hatena.ne.jp/syohex/20110119/1295450495 ==========
;; for whitespace-mode
(require 'whitespace)
;; see whitespace.el for more details
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)
(global-set-key (kbd "C-x w") 'global-whitespace-mode)

;;=============== shell-pop ===============
;; https://github.com/kyagi/shell-pop-el
(require 'shell-pop)
(global-set-key [f8] 'shell-pop)

;; カレントバッファのファイル絶対パスを表示
(defun show-file-path()
  (interactive)
  (message (buffer-file-name))
  )
(global-set-key  "\C-cp" 'show-file-path)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;==== cua mode ====
;;==== http://tech.kayac.com/archive/emacs-rectangle.html ====
(cua-mode t)
(setq cua-enable-cua-keys nil) ; そのままだと C-x が切り取りになってしまったりするので無効化
(define-key global-map (kbd "M-SPC") 'cua-set-rectangle-mark)

;; ==== ag ====
;; ==== http://codeout.hatenablog.com/entry/2014/07/08/185826 ====
; ag
;;(setq default-process-coding-system 'utf-8-unix)  ; ag 検索結果のエンコード指定
(require 'ag)
(setq ag-highlight-search t)  ; 検索キーワードをハイライト
(setq ag-reuse-buffers t)     ; 検索用バッファを使い回す (検索ごとに新バッファを作らない)

; wgrep
(add-hook 'ag-mode-hook '(lambda ()
                           (require 'wgrep)
                           (require 'wgrep-ag)
                           (setq wgrep-auto-save-buffer t)  ; 編集完了と同時に保存
                           (setq wgrep-enable-key "r")      ; "r" キーで編集モードに
                           (wgrep-ag-setup)))

(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

;;;###autoload
(defun wgrep-ag-setup ()
  ;; ag.el prints a column number too, so we catch that
  ;; if it exists.  Here \2 is a colon + whitespace separator.  This
  ;; might need to change if (caar grep-regexp-alist) does.
  (set (make-local-variable 'wgrep-line-file-regexp)
       (concat
        (caar grep-regexp-alist)
        "\\(?:\\([1-9][0-9]*\\)\\2\\)?"))
  (wgrep-setup-internal))

;;;###autoload
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

;; For `unload-feature'
(defun wgrep-ag-unload-function ()
  (remove-hook 'ag-mode-hook 'wgrep-ag-setup))

(provide 'wgrep-ag)

;;=== window resizer ===
;;=== http://d.hatena.ne.jp/khiker/20100119/window_resize ===
(global-set-key "\C-c\C-r" 'my-window-resizer)
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

;;=== window move ===
;;=== http://www.emacswiki.org/emacs/WindMove ===
(global-set-key (kbd "M-N")  'windmove-left)
(global-set-key (kbd "M-P") 'windmove-right)
(global-set-key (kbd "M-p")    'windmove-up)
(global-set-key (kbd "M-n")  'windmove-down)
