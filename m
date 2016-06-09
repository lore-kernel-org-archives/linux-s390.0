Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 02/14] seccomp: Add a seccomp_data parameter secure_computing()
Date: Thu,  9 Jun 2016 14:01:52 -0700
Message-ID: <1465506124-21866-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210152.edXN5td_n_Bis1qhyhhnsh3K6XHfN7HxTRHpDbRSdWE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

Currently, if arch code wants to supply seccomp_data directly to
seccomp (which is generally much faster than having seccomp do it
using the syscall_get_xyz() API), it has to use the two-phase
seccomp hooks. Add it to the easy hooks, too.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/ptrace.c              | 2 +-
 arch/arm64/kernel/ptrace.c            | 2 +-
 arch/mips/kernel/ptrace.c             | 2 +-
 arch/parisc/kernel/ptrace.c           | 2 +-
 arch/powerpc/kernel/ptrace.c          | 2 +-
 arch/s390/kernel/ptrace.c             | 2 +-
 arch/tile/kernel/ptrace.c             | 2 +-
 arch/um/kernel/skas/syscall.c         | 2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 include/linux/seccomp.h               | 8 ++++----
 kernel/seccomp.c                      | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ef9119f7462e..ad5e90ab165c 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -934,7 +934,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 
 	/* Do the secure computing check first; failures should be fast. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3f6cd5c5234f..6e2cf046615d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1247,7 +1247,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0dcf69194473..c50af846ecf9 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -893,7 +893,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 
 	current_thread_info()->syscall = syscall;
 
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index b5458b37fc5b..8edc47c0b98e 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -312,7 +312,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	/* Do the secure computing check first. */
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 30a03c03fe73..ed799e994773 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1783,7 +1783,7 @@ static int do_seccomp(struct pt_regs *regs)
 	 * have already loaded -ENOSYS into r3, or seccomp has put
 	 * something else in r3 (via SECCOMP_RET_ERRNO/TRACE).
 	 */
-	if (__secure_computing())
+	if (__secure_computing(NULL))
 		return -1;
 
 	/*
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 49b1c13bf6c9..c238e9958c2a 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -824,7 +824,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	/* Do the secure computing check first. */
-	if (secure_computing()) {
+	if (secure_computing(NULL)) {
 		/* seccomp failures shouldn't expose any additional code. */
 		ret = -1;
 		goto out;
diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index 54e7b723db99..8c6d2f2fefa3 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,7 +255,7 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 work = ACCESS_ONCE(current_thread_info()->flags);
 
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return -1;
 
 	if (work & _TIF_SYSCALL_TRACE) {
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 48b0dcbd87be..9c5570f0f397 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -21,7 +21,7 @@ void handle_syscall(struct uml_pt_regs *r)
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
 	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing() == -1)
+	if (secure_computing(NULL) == -1)
 		return;
 
 	if (syscall_trace_enter(regs))
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 174c2549939d..85acde5fa442 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -207,7 +207,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	 */
 	regs->orig_ax = syscall_nr;
 	regs->ax = -ENOSYS;
-	tmp = secure_computing();
+	tmp = secure_computing(NULL);
 	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 2296e6b2f690..9eaa7b34d6da 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -28,11 +28,11 @@ struct seccomp {
 };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-extern int __secure_computing(void);
-static inline int secure_computing(void)
+extern int __secure_computing(const struct seccomp_data *sd);
+static inline int secure_computing(const struct seccomp_data *sd)
 {
 	if (unlikely(test_thread_flag(TIF_SECCOMP)))
-		return  __secure_computing();
+		return  __secure_computing(sd);
 	return 0;
 }
 
@@ -61,7 +61,7 @@ struct seccomp { };
 struct seccomp_filter { };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void) { return 0; }
+static inline int secure_computing(struct seccomp_data *sd) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 7002796f14a4..06816290a212 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -554,9 +554,9 @@ void secure_computing_strict(int this_syscall)
 		BUG();
 }
 #else
-int __secure_computing(void)
+int __secure_computing(const struct seccomp_data *sd)
 {
-	u32 phase1_result = seccomp_phase1(NULL);
+	u32 phase1_result = seccomp_phase1(sd);
 
 	if (likely(phase1_result == SECCOMP_PHASE1_OK))
 		return 0;
-- 
2.7.4
