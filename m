Return-Path: <linux-kernel-owner+w=401wt.eu-S1761255AbZAWQMp@vger.kernel.org>
Date: Fri, 23 Jan 2009 17:12:32 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 fixes for 2.6.29-rc3
Message-ID: <20090123171232.7a247bc6@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

 please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (3):
      [S390] personality: fix personality loss on execve
      [S390] cputime: fix lowcore initialization on cpu hotplug
      [S390] etr/stp: fix possible deadlock

Michael Holzheu (2):
      [S390] fix compat sigaltstack syscall table entry
      [S390] Add missing compat system call wrappers.

 arch/s390/include/asm/elf.h       |   16 +++++++-------
 arch/s390/kernel/compat_wrapper.S |   38 +++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls.S       |   12 +++++-----
 arch/s390/kernel/time.c           |    6 +++-
 arch/s390/kernel/vtime.c          |    4 +++
 5 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index d480f39..74d0bbb 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -172,14 +172,14 @@ extern char elf_platform[];
 #ifndef __s390x__
 #define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 #else /* __s390x__ */
-#define SET_PERSONALITY(ex)				\
-do {							\
-	if (current->personality != PER_LINUX32)	\
-		set_personality(PER_LINUX);		\
-	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
-		set_thread_flag(TIF_31BIT);		\
-	else						\
-		clear_thread_flag(TIF_31BIT);		\
+#define SET_PERSONALITY(ex)					\
+do {								\
+	if (personality(current->personality) != PER_LINUX32)	\
+		set_personality(PER_LINUX);			\
+	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
+		set_thread_flag(TIF_31BIT);			\
+	else							\
+		clear_thread_flag(TIF_31BIT);			\
 } while (0)
 #endif /* __s390x__ */
 
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 6035cd2..62c706e 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1767,3 +1767,41 @@ sys_dup3_wrapper:
 sys_epoll_create1_wrapper:
 	lgfr	%r2,%r2			# int
 	jg	sys_epoll_create1	# branch to system call
+
+	.globl	sys32_readahead_wrapper
+sys32_readahead_wrapper:
+	lgfr	%r2,%r2			# int
+	llgfr	%r3,%r3			# u32
+	llgfr	%r4,%r4			# u32
+	lgfr	%r5,%r5			# s32
+	jg	sys32_readahead		# branch to system call
+
+	.globl	sys32_sendfile64_wrapper
+sys32_sendfile64_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	llgtr	%r4,%r4			# compat_loff_t *
+	lgfr	%r5,%r5			# s32
+	jg	sys32_sendfile64	# branch to system call
+
+	.globl	sys_tkill_wrapper
+sys_tkill_wrapper:
+	lgfr	%r2,%r2			# pid_t
+	lgfr	%r3,%r3			# int
+	jg	sys_tkill		# branch to system call
+
+	.globl	sys_tgkill_wrapper
+sys_tgkill_wrapper:
+	lgfr	%r2,%r2			# pid_t
+	lgfr	%r3,%r3			# pid_t
+	lgfr	%r4,%r4			# int
+	jg	sys_tgkill		# branch to system call
+
+	.globl	compat_sys_keyctl_wrapper
+compat_sys_keyctl_wrapper:
+	llgfr	%r2,%r2			# u32
+	llgfr	%r3,%r3			# u32
+	llgfr	%r4,%r4			# u32
+	llgfr	%r5,%r5			# u32
+	llgfr	%r6,%r6			# u32
+	jg	compat_sys_keyctl	# branch to system call
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 76d16e0..fe5b25a 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -194,7 +194,7 @@ SYSCALL(sys_chown16,sys_ni_syscall,sys32_chown16_wrapper)	/* old chown16 syscall
 SYSCALL(sys_getcwd,sys_getcwd,sys32_getcwd_wrapper)
 SYSCALL(sys_capget,sys_capget,sys32_capget_wrapper)
 SYSCALL(sys_capset,sys_capset,sys32_capset_wrapper)		/* 185 */
-SYSCALL(sys_sigaltstack,sys_sigaltstack,sys32_sigaltstack)
+SYSCALL(sys_sigaltstack,sys_sigaltstack,sys32_sigaltstack_wrapper)
 SYSCALL(sys_sendfile,sys_sendfile64,sys32_sendfile_wrapper)
 NI_SYSCALL							/* streams1 */
 NI_SYSCALL							/* streams2 */
@@ -230,8 +230,8 @@ SYSCALL(sys_mincore,sys_mincore,sys32_mincore_wrapper)
 SYSCALL(sys_madvise,sys_madvise,sys32_madvise_wrapper)
 SYSCALL(sys_getdents64,sys_getdents64,sys32_getdents64_wrapper)	/* 220 */
 SYSCALL(sys_fcntl64,sys_ni_syscall,compat_sys_fcntl64_wrapper)
-SYSCALL(sys_readahead,sys_readahead,sys32_readahead)
-SYSCALL(sys_sendfile64,sys_ni_syscall,sys32_sendfile64)
+SYSCALL(sys_readahead,sys_readahead,sys32_readahead_wrapper)
+SYSCALL(sys_sendfile64,sys_ni_syscall,sys32_sendfile64_wrapper)
 SYSCALL(sys_setxattr,sys_setxattr,sys32_setxattr_wrapper)
 SYSCALL(sys_lsetxattr,sys_lsetxattr,sys32_lsetxattr_wrapper)	/* 225 */
 SYSCALL(sys_fsetxattr,sys_fsetxattr,sys32_fsetxattr_wrapper)
@@ -245,11 +245,11 @@ SYSCALL(sys_removexattr,sys_removexattr,sys32_removexattr_wrapper)
 SYSCALL(sys_lremovexattr,sys_lremovexattr,sys32_lremovexattr_wrapper)
 SYSCALL(sys_fremovexattr,sys_fremovexattr,sys32_fremovexattr_wrapper)	/* 235 */
 SYSCALL(sys_gettid,sys_gettid,sys_gettid)
-SYSCALL(sys_tkill,sys_tkill,sys_tkill)
+SYSCALL(sys_tkill,sys_tkill,sys_tkill_wrapper)
 SYSCALL(sys_futex,sys_futex,compat_sys_futex_wrapper)
 SYSCALL(sys_sched_setaffinity,sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 SYSCALL(sys_sched_getaffinity,sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)	/* 240 */
-SYSCALL(sys_tgkill,sys_tgkill,sys_tgkill)
+SYSCALL(sys_tgkill,sys_tgkill,sys_tgkill_wrapper)
 NI_SYSCALL							/* reserved for TUX */
 SYSCALL(sys_io_setup,sys_io_setup,sys32_io_setup_wrapper)
 SYSCALL(sys_io_destroy,sys_io_destroy,sys32_io_destroy_wrapper)
@@ -288,7 +288,7 @@ SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapper)
 SYSCALL(sys_kexec_load,sys_kexec_load,compat_sys_kexec_load_wrapper)
 SYSCALL(sys_add_key,sys_add_key,compat_sys_add_key_wrapper)
 SYSCALL(sys_request_key,sys_request_key,compat_sys_request_key_wrapper)
-SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl)		/* 280 */
+SYSCALL(sys_keyctl,sys_keyctl,compat_sys_keyctl_wrapper)		/* 280 */
 SYSCALL(sys_waitid,sys_waitid,compat_sys_waitid_wrapper)
 SYSCALL(sys_ioprio_set,sys_ioprio_set,sys_ioprio_set_wrapper)
 SYSCALL(sys_ioprio_get,sys_ioprio_get,sys_ioprio_get_wrapper)
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index d649600..fc468ca 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -399,8 +399,10 @@ static struct workqueue_struct *time_sync_wq;
 
 static void __init time_init_wq(void)
 {
-	if (!time_sync_wq)
-		time_sync_wq = create_singlethread_workqueue("timesync");
+	if (time_sync_wq)
+		return;
+	time_sync_wq = create_singlethread_workqueue("timesync");
+	stop_machine_create();
 }
 
 /*
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 2fb36e4..ecf0304 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -516,8 +516,12 @@ EXPORT_SYMBOL(del_virt_timer);
  */
 void init_cpu_vtimer(void)
 {
+	struct thread_info *ti = current_thread_info();
 	struct vtimer_queue *vq;
 
+	S390_lowcore.user_timer = ti->user_timer;
+	S390_lowcore.system_timer = ti->system_timer;
+
 	/* kick the virtual timer */
 	asm volatile ("STCK %0" : "=m" (S390_lowcore.last_update_clock));
 	asm volatile ("STPT %0" : "=m" (S390_lowcore.last_update_timer));
