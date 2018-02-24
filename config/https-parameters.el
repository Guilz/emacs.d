;; Emacs configuration

;; Settings to make Emacs correctly find GnuPG. This will work only after
;; `exec-path-from-shell' is loaded (this is done in `pkg-parameters.el').
(setq-default epg-gpg-program "gpg2"
              epg-gpg-home-directory "~/.gnupg/")

;; Settings to enforce verification of HTTPS connections.
;; Taken from <https://glyph.twistedmatrix.com/2015/11/editor-malware.html>.
;; This configuration only works if Emacs was built with GnuTLS
;; embedded. See the end of this file if Emacs uses an external
;; installation of GnuTLS.

;; Set global network security policy, log important messages from
;; GnuTLS, and always check certificates validity.
(setq-default network-security-level 'medium
              gnutls-log-level 2
              gnutls-verify-error t)

;; Path to a certificate bundle. This file should be maintained up to date.
;; To do that, run the following command monthly in ~/emacs.d:
;; curl --remote-name --time-cond cacert.pem https://curl.haxx.se/ca/cacert.pem
;; This will download an up-to-date copy of the Mozilla CA certificate bundle,
;; kindly provided in the correct format (PEM) by the cURL developpers.
;; In case we cannot get this file, abort loading the configuration. In no
;; circumstance we should allow unverified HTTPS connections.
(unless (file-exists-p "~/.emacs.d/update-cacert.sh")
  (error "File not found: ~/.emacs.d/update-cacert.sh"))
(unless (file-executable-p "~/.emacs.d/update-cacert.sh")
  ;; The following doesn't work when ~/.emacs.d/update-cacert.pem is a symlink to
  ;; the actual location of the script...
  ;; (progn (message "Making file executable: ~/.emacs.d/update-cacert.sh")
  ;;        (chmod "~/.emacs.d/update-cacert.sh" 744)))
  (error "File is not executable: ~/.emacs.d/update-cacert.sh"))
(call-process "~/.emacs.d/update-cacert.sh")
(setq-default gnutls-trustfiles (list "~/.emacs.d/cacert.pem"))

;; If GnuTLS is not embedded in Emacs, but accessed from a separate
;; installation, then the following lines are also required.
;; (setq-default tls-checktrust t)
;; (setq-default tls-program
;;               (format "gnutls-cli --x509cafile %s -p %%p %%h"
;;                       gnutls-trustfiles))

