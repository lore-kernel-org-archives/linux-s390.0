From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 17/23] arm64: ptrace: handle ptrace_request differently for
 aarch32 and ilp32
Date: Tue, 24 May 2016 03:04:46 +0300
Message-ID: <1464048292-30136-18-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: kilobyte@angband.pl, pinskia@gmail.com, szabolcs.nagy@arm.com, Nathan_Lynch@mentor.com, heiko.carstens@de.ibm.com, agraf@suse.de, geert@linux-m68k.org, Prasun.Kapoor@caviumnetworks.com, klimov.linux@gmail.com, broonie@kernel.org, ynorov@caviumnetworks.com, schwidefsky@de.ibm.com, bamvor.zhangjian@huawei.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
detection of the task type.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/unistd32.h |  2 +-
 arch/arm64/kernel/ptrace.c        | 50 ++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/sys32.c         |  1 +
 include/linux/ptrace.h            |  6 +++++
 kernel/ptrace.c                   | 10 ++++----
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5b925b7..f57bbe3 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -74,7 +74,7 @@ __SYSCALL(__NR_getuid, sys_getuid16)
 			/* 25 was sys_stime */
 __SYSCALL(25, sys_ni_syscall)
 #define __NR_ptrace 26
-__SYSCALL(__NR_ptrace, compat_sys_ptrace)
+__SYSCALL(__NR_ptrace, compat_sys_aarch32_ptrace)
 			/* 27 was sys_alarm */
 __SYSCALL(27, sys_ni_syscall)
 			/* 28 was sys_fstat */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 38a09338..a861105 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/user.h>
 #include <linux/seccomp.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/init.h>
 #include <linux/signal.h>
 #include <linux/uaccess.h>
@@ -1114,7 +1115,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1191,8 +1192,55 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+
+COMPAT_SYSCALL_DEFINE4(aarch32_ptrace, compat_long_t, request, compat_long_t, pid,
+		       compat_long_t, addr, compat_long_t, data)
+{
+	struct task_struct *child;
+	long ret;
+
+	if (request == PTRACE_TRACEME) {
+		ret = ptrace_traceme();
+		goto out;
+	}
+
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		goto out;
+	}
+
+	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
+		ret = ptrace_attach(child, request, addr, data);
+		goto out_put_task_struct;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
+				  request == PTRACE_INTERRUPT);
+	if (!ret) {
+		ret = compat_a32_ptrace(child, request, addr, data);
+		if (ret || request != PTRACE_DETACH)
+			ptrace_unfreeze_traced(child);
+	}
+
+ out_put_task_struct:
+	put_task_struct(child);
+ out:
+	return ret;
+}
+
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_COMPAT
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	return compat_ptrace_request(child, request, caddr, cdata);
+}
+
+#endif /* CONFIG_COMPAT */
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index a40b134..3752443 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -38,6 +38,7 @@ asmlinkage long compat_sys_fadvise64_64_wrapper(void);
 asmlinkage long compat_sys_sync_file_range2_wrapper(void);
 asmlinkage long compat_sys_fallocate_wrapper(void);
 asmlinkage long compat_sys_mmap2_wrapper(void);
+asmlinkage long compat_sys_aarch32_ptrace(void);
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 504c98a..75887a0 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -97,6 +97,12 @@ int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
 			    unsigned long data);
 int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
 			    unsigned long data);
+int ptrace_traceme(void);
+struct task_struct *ptrace_get_task_struct(pid_t pid);
+int ptrace_attach(struct task_struct *task, long request,
+			 unsigned long addr, unsigned long flags);
+int ptrace_check_attach(struct task_struct *child, bool ignore_state);
+void ptrace_unfreeze_traced(struct task_struct *task);
 
 /**
  * ptrace_parent - return the task that is tracing the given task
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d49bfa1..cadf24c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -136,7 +136,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	return ret;
 }
 
-static void ptrace_unfreeze_traced(struct task_struct *task)
+void ptrace_unfreeze_traced(struct task_struct *task)
 {
 	if (task->state != __TASK_TRACED)
 		return;
@@ -168,7 +168,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  * RETURNS:
  * 0 on success, -ESRCH if %child is not ready.
  */
-static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
+int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
 	int ret = -ESRCH;
 
@@ -292,7 +292,7 @@ bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return !err;
 }
 
-static int ptrace_attach(struct task_struct *task, long request,
+int ptrace_attach(struct task_struct *task, long request,
 			 unsigned long addr,
 			 unsigned long flags)
 {
@@ -406,7 +406,7 @@ out:
  * Performs checks and sets PT_PTRACED.
  * Should be used by all ptrace implementations for PTRACE_TRACEME.
  */
-static int ptrace_traceme(void)
+ int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
@@ -1056,7 +1056,7 @@ int ptrace_request(struct task_struct *child, long request,
 	return ret;
 }
 
-static struct task_struct *ptrace_get_task_struct(pid_t pid)
+struct task_struct *ptrace_get_task_struct(pid_t pid)
 {
 	struct task_struct *child;
 
-- 
2.5.0
