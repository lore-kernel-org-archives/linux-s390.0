Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] sched, s390: Fix the fallout of increasing the offset of 'thread_struct' within 'task_struct'
Date: Mon, 20 Jul 2015 07:41:55 -0700
Message-Id: <1437403315-31221-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
moved the thread_struct to the bottom of task_struct. As a result, the
offset is now too large to be used in an immediate stfpc operation on s390,
resulting in the following compile error.

arch/s390/kernel/traps.c: Assembler messages:
arch/s390/kernel/traps.c:262: Error: operand out of range
	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
arch/s390/kernel/traps.c:300: Error: operand out of range
	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)

Use a local variable to store fpc to solve the problem.

Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only.
Wonder if storing fpc in current->thread.fp_regs.fpc is necessary.

 arch/s390/kernel/traps.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 4d96c9f53455..73bd46db1298 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -252,6 +252,7 @@ int alloc_vector_registers(struct task_struct *tsk)
 void vector_exception(struct pt_regs *regs)
 {
 	int si_code, vic;
+	__u32 fpc;
 
 	if (!MACHINE_HAS_VX) {
 		do_trap(regs, SIGILL, ILL_ILLOPN, "illegal operation");
@@ -259,8 +260,10 @@ void vector_exception(struct pt_regs *regs)
 	}
 
 	/* get vector interrupt code from fpc */
-	asm volatile("stfpc %0" : "=m" (current->thread.fp_regs.fpc));
-	vic = (current->thread.fp_regs.fpc & 0xf00) >> 8;
+	asm volatile("stfpc %0" : "=m" (fpc));
+	current->thread.fp_regs.fpc = fpc;
+	vic = (fpc & 0xf00) >> 8;
+
 	switch (vic) {
 	case 1: /* invalid vector operation */
 		si_code = FPE_FLTINV;
@@ -294,25 +297,27 @@ void data_exception(struct pt_regs *regs)
 {
 	__u16 __user *location;
 	int signal = 0;
+	__u32 fpc;
 
 	location = get_trap_ip(regs);
 
-	asm volatile("stfpc %0" : "=m" (current->thread.fp_regs.fpc));
+	asm volatile("stfpc %0" : "=m" (fpc));
+	current->thread.fp_regs.fpc = fpc;
 	/* Check for vector register enablement */
 	if (MACHINE_HAS_VX && !current->thread.vxrs &&
-	    (current->thread.fp_regs.fpc & FPC_DXC_MASK) == 0xfe00) {
+	    (fpc & FPC_DXC_MASK) == 0xfe00) {
 		alloc_vector_registers(current);
 		/* Vector data exception is suppressing, rewind psw. */
 		regs->psw.addr = __rewind_psw(regs->psw, regs->int_code >> 16);
 		clear_pt_regs_flag(regs, PIF_PER_TRAP);
 		return;
 	}
-	if (current->thread.fp_regs.fpc & FPC_DXC_MASK)
+	if (fpc & FPC_DXC_MASK)
 		signal = SIGFPE;
 	else
 		signal = SIGILL;
 	if (signal == SIGFPE)
-		do_fp_trap(regs, current->thread.fp_regs.fpc);
+		do_fp_trap(regs, fpc);
 	else if (signal)
 		do_trap(regs, signal, ILL_ILLOPN, "data exception");
 }
-- 
2.1.0
