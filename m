Return-Path: <linux-kernel-owner+w=401wt.eu-S965859AbXCLNuK@vger.kernel.org>
Date: Mon, 12 Mar 2007 14:50:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] Wire up compat_sys_epoll_pwait.
Message-ID: <20070312135013.GA11426@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Wire up compat_sys_epoll_pwait.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |   11 +++++++++++
 arch/s390/kernel/syscalls.S       |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2007-03-12 13:52:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2007-03-12 13:53:00.000000000 +0100
@@ -1665,3 +1665,14 @@ sys_getcpu_wrapper:
 	llgtr	%r3,%r3			# unsigned *
 	llgtr	%r4,%r4			# struct getcpu_cache *
 	jg	sys_getcpu
+
+	.globl	compat_sys_epoll_pwait_wrapper
+compat_sys_epoll_pwait_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# struct compat_epoll_event *
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	llgtr	%r6,%r6			# compat_sigset_t *
+	llgf	%r0,164(%r15)		# compat_size_t
+	stg	%r0,160(%r15)
+	jg	compat_sys_epoll_pwait
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2007-03-12 13:52:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2007-03-12 13:53:00.000000000 +0100
@@ -320,4 +320,4 @@ SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
-SYSCALL(sys_epoll_pwait,sys_epoll_pwait,sys_ni_syscall)
+SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
