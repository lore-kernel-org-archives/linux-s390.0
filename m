Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 15/28] s390/seccomp: pass syscall arguments via seccomp_data
Date: Tue, 23 Jun 2020 13:35:10 -0400
Message-Id: <20200623173523.1355411-15-sashal@kernel.org>
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 664f5f8de825648d1d31f6f5652e3cd117c77b50 ]

Use __secure_computing() and pass the register data via
seccomp_data so secure computing doesn't have to fetch it
again.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ptrace.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 58faa12542a1b..9eee345568890 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -839,6 +839,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	unsigned long mask = -1UL;
 
+	if (is_compat_task())
+		mask = 0xffffffff;
+
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
 	 * call number to gprs[2].
@@ -855,17 +858,35 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		return -1;
 	}
 
+#ifdef CONFIG_SECCOMP
 	/* Do the secure computing check after ptrace. */
-	if (secure_computing()) {
-		/* seccomp failures shouldn't expose any additional code. */
-		return -1;
+	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
+		struct seccomp_data sd;
+
+		if (is_compat_task()) {
+			sd.instruction_pointer = regs->psw.addr & 0x7fffffff;
+			sd.arch = AUDIT_ARCH_S390;
+		} else {
+			sd.instruction_pointer = regs->psw.addr;
+			sd.arch = AUDIT_ARCH_S390X;
+		}
+
+		sd.nr = regs->gprs[2] & 0xffff;
+		sd.args[0] = regs->orig_gpr2 & mask;
+		sd.args[1] = regs->gprs[3] & mask;
+		sd.args[2] = regs->gprs[4] & mask;
+		sd.args[3] = regs->gprs[5] & mask;
+		sd.args[4] = regs->gprs[6] & mask;
+		sd.args[5] = regs->gprs[7] & mask;
+
+		if (__secure_computing(&sd) == -1)
+			return -1;
 	}
+#endif /* CONFIG_SECCOMP */
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gprs[2]);
 
-	if (is_compat_task())
-		mask = 0xffffffff;
 
 	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2 & mask,
 			    regs->gprs[3] &mask, regs->gprs[4] &mask,
-- 
2.25.1
