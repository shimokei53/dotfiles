;; http://sakito.jp/emacs/emacs24.html#id9
;; 
;; Emacs24 では Emacs Lips パッケージの管理機能が追加されています。
;; M-x list-packages でインストール可能なパッケージ一覧が表示されます。
;; インストールしたいパッケージで i を押すとインストール候補になり、 x でインストールを実行するか確認されますので、 yes でインストールします。
;; インストールしたパッケージはデフォルトでは .emacs.d/elpa/ に保存されます。
;; 初期設定ではパッケージ一覧は http://elpa.gnu.org/packages/ から取得しますが、追加することも可能です。
;; 現在以下の二つのURLが安定して利用できます。
;; http://melpa.milkbox.net/
;; http://marmalade-repo.org/
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; add to load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp" )

;; http://tech.kayac.com/archive/emacs.html
(setq make-backup-files nil)

;;====== shell-pop.el ===========
(require 'shell-pop)
(shell-pop-set-universal-key [f8])
