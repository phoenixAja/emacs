;;; jupyter-kernelspec.el --- Jupyter kernelspecs -*- lexical-binding: t -*-

;; Copyright (C) 2018 Nathaniel Nicandro

;; Author: Nathaniel Nicandro <nathanielnicandro@gmail.com>
;; Created: 17 Jan 2018
;; Version: 0.7.1

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Functions to work with kernelspecs found by the shell command
;;
;;     jupyter kernelspec list

;;; Code:

(require 'json)

(defgroup jupyter-kernelspec nil
  "Jupyter kernelspecs"
  :group 'jupyter)

(declare-function jupyter-read-plist "jupyter-base" (file))

(defvar jupyter--kernelspecs (make-hash-table :test #'equal :size 5)
  "An alist matching kernel names to their kernelspec directories.")

(defun jupyter-read-kernelspec (dir)
  "Return the kernelspec found in DIR.
If DIR contains a \"kernel.json\" file, assume that it is the
kernelspec of a kernel and return the plist created by a call to
`jupyter-read-plist'."
  (let ((file (expand-file-name "kernel.json" dir)))
    (if (file-exists-p file) (jupyter-read-plist file)
      (error "No kernel.json file found in %s" dir))))

(defun jupyter-available-kernelspecs (&optional refresh)
  "Get the available kernelspecs.
Return an alist mapping kernel names to (DIRECTORY . PLIST) pairs
where DIRECTORY is the resource directory of the kernel and PLIST
is its kernelspec plist. The alist is formed by a call to the
shell command

    jupyter kernelspec list

By default the available kernelspecs are cached. To force an
update of the cached kernelspecs, give a non-nil value to
REFRESH.

If the `default-directory' is a remote directory, return the
mapping for the remote host. In this case, each DIRECTORY in the
kernelspec will be a remote file name with the connection
information of the host as a prefix."
  (let ((host (or (file-remote-p default-directory) "local")))
    (or (and (not refresh) (gethash host jupyter--kernelspecs))
        (let ((spec-list
               (cdr
                (split-string
                 (shell-command-to-string "jupyter kernelspec list")
                 "\n" 'omitnull "[ \t]+")))
              (get-kernelspec
               (lambda (s)
                 (cl-destructuring-bind (kernel dir)
                     (split-string s " " 'omitnull)
                   (unless (equal host "local")
                     (setq dir (concat host dir)))
                   (let ((spec (jupyter-read-kernelspec dir)))
                     (cons kernel (cons dir spec)))))))
          (puthash host (delq nil (mapcar get-kernelspec spec-list))
                   jupyter--kernelspecs)))))

(defun jupyter-get-kernelspec (name &optional refresh)
  "Get the kernelspec for a kernel named NAME.
If no kernelspec is found, return nil. Otherwise return a
cons cell

    (DIRECTORY . PLIST)

where DIRECTORY is the resource directory of the kernel named
NAME and PLIST is its kernelspec plist. Optional argument REFRESH
has the same meaning as in `jupyter-available-kernelspecs'."
  (cdr (assoc name (jupyter-available-kernelspecs refresh))))

(defun jupyter-find-kernelspecs (re &optional refresh)
  "Find all specs of kernels that have names matching matching RE.
RE is a regular expression use to match the name of a kernel.
Return an alist with elements of the form:

    (KERNEL-NAME . (DIRECTORY . PLIST))

where KERNEL-NAME is the name of a kernel that matches RE,
DIRECTORY is the kernel's resource directory, and PLIST is the
kernelspec propery list read from the \"kernel.json\" file in the
resource directory.

Optional argument REFRESH has the same meaning as in
`jupyter-available-kernelspecs'."
  (delq nil (mapcar (lambda (s) (and (string-match-p re (car s)) s))
               (jupyter-available-kernelspecs refresh))))

(defun jupyter-completing-read-kernelspec (&optional specs refresh)
  "Use `completing-read' to select a kernel and return its kernelspec.
The returned kernelspec has the form

    (KERNEL-NAME . (DIRECTORY . PLIST))

where KERNEL-NAME is the name of the kernel, DIRECTORY is the
resource directory of the kernel, and PLIST is the kernelspec
plist.

If SPECS is non-nil then it should be a list of kernelspecs that
will be used to select from otherwise the list of kernelspecs
will be taken from `jupyter-available-kernelspecs'.

Optional argument REFRESH has the same meaning as in
`jupyter-available-kernelspecs'."
  (let* ((specs (or specs (jupyter-available-kernelspecs refresh)))
         (display-names (if (null specs) (error "No kernelspecs available")
                          (mapcar (lambda (k) (plist-get (cddr k) :display_name))
                             specs)))
         (name (completing-read "kernel: " display-names nil t)))
    (when (equal name "")
      (error "No kernelspec selected"))
    (nth (- (length display-names)
            (length (member name display-names)))
         specs)))

;; TODO: Define a kernel-spec mode alist mapping languages
;; to the modes that they may use.
(defun jupyter-kernelspecs-for-mode (&optional mode refresh)
  "Attempt to find available kernelspecs for MODE.
MODE should be a major mode symbol and defaults to `major-mode'.
REFRESH has the same meaning as in
`jupyter-available-kernelspecs'. Return a list of available
kernelspecs or nil if none could be found. Note that this does
not mean that no kernel exists for MODE.

Currently this just concatenates the kernelspec language name
with `-mode' to see if `major-mode' is equivalent. This is
sufficient for `python' and `julia' kernels using their standard
major modes, but most likely will fail for other cases."
  (cl-loop
   for kernelspec in (jupyter-available-kernelspecs refresh)
   for (_kernel . (_dir . spec)) = kernelspec
   for language = (plist-get spec :language)
   ;; attempt to match the major mode to a spec
   if (eq (intern (concat language "-mode"))
          (or mode major-mode))
   collect kernelspec))

(provide 'jupyter-kernelspec)

;;; jupyter-kernelspec.el ends here
