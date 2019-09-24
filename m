Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393206AbfIXGo2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Sep 2019 02:44:28 -0400
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v1] seccomp: simplify secure_computing()
Date: Tue, 24 Sep 2019 08:44:20 +0200
Message-Id: <20190924064420.6353-1-christian.brauner@ubuntu.com>
In-Reply-To: <20190920131907.6886-1-christian.brauner@ubuntu.com>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: christian.brauner@ubuntu.com
Cc: keescook@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, luto@kernel.org, oleg@redhat.com, tglx@linutronix.de, wad@chromium.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>

Afaict, the struct seccomp_data argument to secure_computing() is unused
by all current callers. So let's remove it.
The argument was added in [1]. It was added because having the arch
supply the syscall arguments used to be faster than having it done by
secure_computing() (cf. Andy's comment in [2]). This is not true anymore
though.

/* References */
[1]: 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
[2]: https://lore.kernel.org/r/CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Drewry <wad@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
---
/* v1 */
- Borislav Petkov <bp@alien8.de>:
  - provide context for the arg addition to secure_computing() in the
    commit message

/* v0 */
Link: https://lore.kernel.org/r/20190920131907.6886-1-christian.brauner@ubuntu.com
---
 arch/arm/kernel/ptrace.c              | 2 +-
 arch/arm64/kernel/ptrace.c            | 2 +-
 arch/parisc/kernel/ptrace.c           | 2 +-
 arch/s390/kernel/ptrace.c             | 4 ++--
 arch/um/kernel/skas/syscall.c         | 2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 include/linux/seccomp.h               | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 324352787aea..b606cded90cd 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -923,7 +923,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-	if (secure_computing(NULL) == -1)
+	if (secure_computing() == -1)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3cf3b135027e..010a835302d3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1816,7 +1816,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (secure_computing() == -1)
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 9f6ff7bc06f9..f8c07dcbfb49 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -342,7 +342,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	}
 
 	/* Do the secure computing check after ptrace. */
-	if (secure_computing(NULL) == -1)
+	if (secure_computing() == -1)
 		return -1;
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index ad71132374f0..ed80bdfbf5fe 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -439,7 +439,7 @@ static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
-	ptrace_area parea; 
+	ptrace_area parea;
 	int copied, ret;
 
 	switch (request) {
@@ -856,7 +856,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	}
 
 	/* Do the secure computing check after ptrace. */
-	if (secure_computing(NULL)) {
+	if (secure_computing()) {
 		/* seccomp failures shouldn't expose any additional code. */
 		return -1;
 	}
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 44bb10785075..fc37259d5971 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -35,7 +35,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	/* Do the seccomp check after ptrace; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (secure_computing() == -1)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e7c596dea947..b10cbf71a8cc 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -222,7 +222,7 @@ bool emulate_vsyscall(unsigned long error_code,
 	 */
 	regs->orig_ax = syscall_nr;
 	regs->ax = -ENOSYS;
-	tmp = secure_computing(NULL);
+	tmp = secure_computing();
 	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 84868d37b35d..03583b6d1416 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -33,10 +33,10 @@ struct seccomp {
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 extern int __secure_computing(const struct seccomp_data *sd);
-static inline int secure_computing(const struct seccomp_data *sd)
+static inline int secure_computing(void)
 {
 	if (unlikely(test_thread_flag(TIF_SECCOMP)))
-		return  __secure_computing(sd);
+		return  __secure_computing(NULL);
 	return 0;
 }
 #else
@@ -59,7 +59,7 @@ struct seccomp { };
 struct seccomp_filter { };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(struct seccomp_data *sd) { return 0; }
+static inline int secure_computing(void) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
-- 
2.23.0
