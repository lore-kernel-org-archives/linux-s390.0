Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgFONAz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jun 2020 09:00:55 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] exec: add a kernel_execveat helper
Date: Mon, 15 Jun 2020 15:00:31 +0200
Message-Id: <20200615130032.931285-6-hch@lst.de>
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
References: <20200615130032.931285-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Add a kernel_execveat helper to execute a binary with kernel space argv
and envp pointers.  Switch executing init and user mode helpers to this
new helper instead of relying on the implicit set_fs(KERNEL_DS) for early
init code and kernel threads, and move the getname call into the
do_execve helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c               | 116 +++++++++++++++++++++++++++++++---------
 include/linux/binfmts.h |   6 +--
 init/main.c             |   6 +--
 kernel/umh.c            |   8 ++-
 4 files changed, 97 insertions(+), 39 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 696b1e8180d7d8..9e16d56aa53e86 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -439,6 +439,21 @@ static int count_strings(const char __user *const __user *argv)
 	return i;
 }
 
+static int count_kernel_strings(const char *const *argv)
+{
+	int i;
+
+	if (!argv)
+		return 0;
+
+	for (i = 0; argv[i]; i++) {
+		if (i >= MAX_ARG_STRINGS)
+			return -E2BIG;
+	}
+
+	return i;
+}
+
 static int check_arg_limit(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
@@ -615,6 +630,19 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(copy_string_kernel);
 
+static int copy_strings_kernel(int argc, const char *const *argv,
+		struct linux_binprm *bprm)
+{
+	int ret;
+
+	while (argc-- > 0) {
+		ret = copy_string_kernel(argv[argc], bprm);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 #ifdef CONFIG_MMU
 
 /*
@@ -1797,9 +1825,11 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return 0;
 }
 
-int do_execveat(int fd, struct filename *filename,
+static int __do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp,
+		const char *const *kernel_argv,
+		const char *const *kernel_envp,
 		int flags, struct file *file)
 {
 	char *pathbuf = NULL;
@@ -1880,16 +1910,30 @@ int do_execveat(int fd, struct filename *filename,
 	if (retval)
 		goto out_unmark;
 
-	bprm->argc = count_strings(argv);
-	if (bprm->argc < 0) {
-		retval = bprm->argc;
-		goto out;
-	}
+	if (unlikely(kernel_argv)) {
+		bprm->argc = count_kernel_strings(kernel_argv);
+		if (bprm->argc < 0) {
+			retval = bprm->argc;
+			goto out;
+		}
 
-	bprm->envc = count_strings(envp);
-	if (bprm->envc < 0) {
-		retval = bprm->envc;
-		goto out;
+		bprm->envc = count_kernel_strings(kernel_envp);
+		if (bprm->envc < 0) {
+			retval = bprm->envc;
+			goto out;
+		}
+	} else {
+		bprm->argc = count_strings(argv);
+		if (bprm->argc < 0) {
+			retval = bprm->argc;
+			goto out;
+		}
+
+		bprm->envc = count_strings(envp);
+		if (bprm->envc < 0) {
+			retval = bprm->envc;
+			goto out;
+		}
 	}
 
 	retval = check_arg_limit(bprm);
@@ -1906,13 +1950,22 @@ int do_execveat(int fd, struct filename *filename,
 		goto out;
 
 	bprm->exec = bprm->p;
-	retval = copy_strings(bprm->envc, envp, bprm);
-	if (retval < 0)
-		goto out;
 
-	retval = copy_strings(bprm->argc, argv, bprm);
-	if (retval < 0)
-		goto out;
+	if (unlikely(kernel_argv)) {
+		retval = copy_strings_kernel(bprm->envc, kernel_envp, bprm);
+		if (retval < 0)
+			goto out;
+		retval = copy_strings_kernel(bprm->argc, kernel_argv, bprm);
+		if (retval < 0)
+			goto out;
+	} else {
+		retval = copy_strings(bprm->envc, envp, bprm);
+		if (retval < 0)
+			goto out;
+		retval = copy_strings(bprm->argc, argv, bprm);
+		if (retval < 0)
+			goto out;
+	}
 
 	retval = exec_binprm(bprm);
 	if (retval < 0)
@@ -1963,6 +2016,23 @@ int do_execveat(int fd, struct filename *filename,
 	return retval;
 }
 
+static int do_execveat(int fd, const char *filename,
+		       const char __user *const __user *argv,
+		       const char __user *const __user *envp, int flags)
+{
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
+
+	return __do_execveat(fd, name, argv, envp, NULL, NULL, flags, NULL);
+}
+
+int kernel_execveat(int fd, const char *filename, const char *const *argv,
+		const char *const *envp, int flags, struct file *file)
+{
+	return __do_execveat(fd, getname_kernel(filename), NULL, NULL, argv,
+			     envp, flags, file);
+}
+
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
@@ -1992,7 +2062,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
+	return do_execveat(AT_FDCWD, filename, argv, envp, 0);
 }
 
 SYSCALL_DEFINE5(execveat,
@@ -2001,10 +2071,7 @@ SYSCALL_DEFINE5(execveat,
 		const char __user *const __user *, envp,
 		int, flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-	struct filename *name = getname_flags(filename, lookup_flags, NULL);
-
-	return do_execveat(fd, name, argv, envp, flags, NULL);
+	return do_execveat(fd, filename, argv, envp, flags);
 }
 
 /*
@@ -2017,7 +2084,7 @@ COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
 		       const char __user *const __user *, argv,
 		       const char __user *const __user *, envp)
 {
-	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
+	return do_execveat(AT_FDCWD, filename, argv, envp, 0);
 }
 
 COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
@@ -2026,9 +2093,6 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 		       const char __user *const __user *, envp,
 		       int,  flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-	struct filename *name = getname_flags(filename, lookup_flags, NULL);
-
-	return do_execveat(fd, name, argv, envp, flags, NULL);
+	return do_execveat(fd, filename, argv, envp, flags);
 }
 #endif /* CONFIG_X86_X32 */
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index bed702e4b1fbd9..1e61c980c16354 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -134,9 +134,7 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
-int do_execveat(int fd, struct filename *filename,
-		const char __user *const __user *__argv,
-		const char __user *const __user *__envp,
-		int flags, struct file *file);
+int kernel_execveat(int fd, const char *filename, const char *const *argv,
+		const char *const *envp, int flags, struct file *file);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/init/main.c b/init/main.c
index 838950ea7bca22..33de235dc2aa00 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1329,10 +1329,8 @@ static int run_init_process(const char *init_filename)
 	pr_debug("  with environment:\n");
 	for (p = envp_init; *p; p++)
 		pr_debug("    %s\n", *p);
-	return do_execveat(AT_FDCWD, getname_kernel(init_filename),
-			(const char __user *const __user *)argv_init,
-			(const char __user *const __user *)envp_init,
-			0, NULL);
+	return kernel_execveat(AT_FDCWD, init_filename, argv_init, envp_init, 0,
+			       NULL);
 }
 
 static int try_to_run_init_process(const char *init_filename)
diff --git a/kernel/umh.c b/kernel/umh.c
index 7aa9a5817582ca..1284823dbad338 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -103,11 +103,9 @@ static int call_usermodehelper_exec_async(void *data)
 	commit_creds(new);
 
 	sub_info->pid = task_pid_nr(current);
-	retval = do_execveat(AT_FDCWD,
-			sub_info->path ? getname_kernel(sub_info->path) : NULL,
-			(const char __user *const __user *)sub_info->argv,
-			(const char __user *const __user *)sub_info->envp,
-			0, sub_info->file);
+	retval = kernel_execveat(AT_FDCWD, sub_info->path,
+			(const char *const *)sub_info->argv,
+			(const char *const *)sub_info->envp, 0, sub_info->file);
 	if (sub_info->file && !retval)
 		current->flags |= PF_UMH;
 out:
-- 
2.26.2
