;;======= よく忘れがちな便利コマンド =========
;; tramp
;; /sudo::/etc/
;; /ssh:web1:/home/prj01hon
;; /web1:~
;; /jikken:~
;;============= path and packages ================
;; add to load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp" )

;; http://sheephead.homelinux.org/2011/06/17/6724/
(require 'package)
;;リポジトリにMarmaladeを追加
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;インストールするディレクトリを指定
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))
;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)

;;======= GIT config ========
(setenv "GIT_PAGER" "cat")

;;=============Global Keymap =====================
;;==== 鬼軍曹 =========
;; https://github.com/k1LoW/emacs-drill-instructor
;; (require 'drill-instructor)
;; (setq drill-instructor-global t)

;; C-h as backspace
(global-set-key "\C-h" 'delete-backward-char)
;; M-h as backspace for word
;; http://d.hatena.ne.jp/akisute3/
(global-set-key (kbd "M-h") 'backward-kill-word)

;; C-M-%が使えないので、代替。
(global-set-key "\M-$" 'replace-regexp)

;; http://flex.ee.uec.ac.jp/texi/faq-jp/faq-jp_79.html
;; override mark-whole-buffer
(global-set-key "\C-ch" 'help-command)

;; disable toggle-input-method
(global-unset-key "\C-\\")

;;
(global-set-key "\M-g" 'goto-line)

(defun revert-buffer-force()
  (interactive)
  (revert-buffer nil t)
)
(global-set-key "\C-cv" 'revert-buffer-force)


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

;; Language settings
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)


;; colorize region  http://blog.livedoor.jp/t100life/archives/51680860.html
(transient-mark-mode 1)

;; disable tab
(custom-set-variables
 '(indent-tabs-mode nil))

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


;; keybind for find-grep

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



;;=============== HTML mode ===============

;; 拡張子tplのファイルはhtml-modeで開く
;;http://blog.livedoor.jp/ubuntumini/archives/51253507.html
(setq auto-mode-alist
      (cons (cons "\\.tpl$" 'html-mode) auto-mode-alist))



;; Settings For php-mode

;; require php-mode
;; (load-library "php-mode")
;; (require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(setq interpreter-mode-alist
      (cons '("php" . php-mode)
            interpreter-mode-alist))



;; http://www.phppro.jp/phptips/archives/vol5/
(add-hook 'php-mode-user-hook
          '(lambda ()
             (define-abbrev php-mode-abbrev-table "ex" "extends")
             (c-set-style "stroustrup")
             (c-set-offset 'comment-intro 0)
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (setq c-hanging-comment-ender-p nil)
             (setq php-mode-force-pear t)
             (setq indent-tabs-mode nil)
             (setq php-manual-path "/home/userdqn/php/doc/html")
             (setq php-manual-url "http://www.phppro.jp/phpmanual/")
             )

          )


(add-hook 'php-mode-hook
  '(lambda ()
     (c-set-style "stroustrup")
     (setq php-manual-path "/home/userdqn/php/doc/html")
     (setq php-search-url "http://www.phppro.jp/")
     (setq php-manual-url "http://www.phppro.jp/phpmanual")
     ))

;; js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.\\(js\\|json\\|js\\.erb\\|js\\.coffee\\)$" . js2-mode))

;; js2-modeのインデント問題を回避するhack
;; http://16777215.blogspot.jp/2011/05/emacs23-js2-mode-without-espresso.html
(autoload 'js-mode "js")
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (js--proper-indentation parse-status))
           node)
      (save-excursion
        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ js-indent-level 2))))
        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))
      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))
(defun my-js2-mode-hook ()
  (require 'js)
  (setq js-indent-level 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
;  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)]
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

;; exec current test file
(defun prove-quiet()
  (interactive)
  (shell-command
   (concat "prove -Q  " (file-name-nondirectory (buffer-file-name)))))

;; (define-key php-mode-map "\C-cq" 'prove-quiet)


;; run current file
(defun run-file()
  (interactive)
  (shell-command
   (concat "./" (file-name-nondirectory (buffer-file-name)))))

(global-set-key  "\C-cr" 'run-file)

;; run test
(defun run-test()
  (interactive)
  (shell-command
   ( buffer-file-name)))
;; (define-key php-mode-map "\C-ct" 'run-test)


(defun my-php-mode ()
  (c-toggle-hungry-state 1))
(add-hook 'php-mode-user-hook 'my-php-mode)

;; http://www.namazu.org/~tsuchiya/elisp/index.html#script
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; ============= svn-mv-this ===================
;; http://www.bookshelf.jp/texi/elisp-intro/jp/emacs-lisp-intro_5.html#SEC53
(defun svn-mv-this(file)
  ;;(cd (file-name-nondirectory (buffer-file-name))
  (interactive "Fsvn mv to:")
  ;;(message (concat "svn mv  " (buffer-file-name) " " file))
  (shell-command   (concat "svn mv  " (buffer-file-name) " " file))
)
(global-set-key "\C-xvm" 'svn-mv-this)




(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 再帰的にファイルを検索させて、etags を実行させる。
(defun etags-find (dir pattern)
  " find DIR -name 'PATTERN' |etags -"
  (interactive
   "DFind-name (directory): \nsFind-name (filename wildcard): ")
  (shell-command
   (concat "find " dir " -type f -name \"" pattern "\" | etags -")))



;; http://www.bookshelf.jp/soft/meadow_30.html#SEC405
;; exchange right <->left window

(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)

(global-set-key "\C-cx" 'swap-screen)


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


;; dsvn.el
;; http://dev.ariel-networks.com/Members/matsuyama/dsvn

(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

(put 'set-goal-column 'disabled nil)

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


;;======= yasnippet ===================
;;https://github.com/capitaomorte/yasnippet
;;(put 'upcase-region 'disabled nil)
;;(put 'scroll-left 'disabled nil)

;; ============ Programming Launaguage Support ===================
;;  flymake いったんやめる
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html

;; ============# -*- coding: utf-8 -*- を入れないようにする=============
;; from http://d.hatena.ne.jp/akm/20080605#1212644489
(require 'ruby-mode)
(defun ruby-mode-set-encoding () ())

;; 分割ウィンドウを矢印キーで移動
;; http://www.emacswiki.org/emacs/WindMove
(windmove-default-keybindings)
(global-set-key "\M-N"  'windmove-left)
(global-set-key "\M-n"  'windmove-down)
(global-set-key "\M-p"    'windmove-up)
(global-set-key "\M-P" 'windmove-right)
