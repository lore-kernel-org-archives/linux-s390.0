Return-Path: <linux-arch-owner@vger.kernel.org>
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 20 Apr 2018 09:38:04 -0500
Message-ID: <20180420143811.9994-15-ebiederm@xmission.com>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Subject: [REVIEW][PATCH 15/22] signal/s390: Use force_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180420143804.MWF9PdU4sZyYgBpecQjW1HBbinUl5ZWqBUKJtgmFHqk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/s390/kernel/traps.c | 32 ++++++--------------------------
 arch/s390/mm/fault.c     | 23 ++++++-----------------
 2 files changed, 12 insertions(+), 43 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 3ba649d8aa5a..8003b38c1688 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -44,15 +44,8 @@ int is_valid_bugaddr(unsigned long addr)
 
 void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
-		clear_siginfo(&info);
-		info.si_signo = si_signo;
-		info.si_errno = 0;
-		info.si_code = si_code;
-		info.si_addr = get_trap_ip(regs);
-		force_sig_info(si_signo, &info, current);
+		force_sig_fault(si_signo, si_code, get_trap_ip(regs), current);
 		report_user_fault(regs, si_signo, 0);
         } else {
                 const struct exception_table_entry *fixup;
@@ -81,19 +74,12 @@ NOKPROBE_SYMBOL(do_trap);
 
 void do_per_trap(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	if (notify_die(DIE_SSTEP, "sstep", regs, 0, 0, SIGTRAP) == NOTIFY_STOP)
 		return;
 	if (!current->ptrace)
 		return;
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_HWBKPT;
-	info.si_addr =
-		(void __force __user *) current->thread.per_event.address;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_HWBKPT,
+		(void __force __user *) current->thread.per_event.address, current);
 }
 NOKPROBE_SYMBOL(do_per_trap);
 
@@ -178,15 +164,9 @@ void illegal_op(struct pt_regs *regs)
 		if (get_user(*((__u16 *) opcode), (__u16 __user *) location))
 			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
-			if (current->ptrace) {
-				siginfo_t info;
-				clear_siginfo(&info);
-				info.si_signo = SIGTRAP;
-				info.si_errno = 0;
-				info.si_code = TRAP_BRKPT;
-				info.si_addr = location;
-				force_sig_info(SIGTRAP, &info, current);
-			} else
+			if (current->ptrace)
+				force_sig_fault(SIGTRAP, TRAP_BRKPT, location, current);
+			else
 				signal = SIGILL;
 #ifdef CONFIG_UPROBES
 		} else if (*((__u16 *) opcode) == UPROBE_SWBP_INSN) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b3ff0e8e5860..e074480d3598 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -265,15 +265,10 @@ void report_user_fault(struct pt_regs *regs, long signr, int is_mm_fault)
  */
 static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
 {
-	struct siginfo si;
-
 	report_user_fault(regs, SIGSEGV, 1);
-	clear_siginfo(&si);
-	si.si_signo = SIGSEGV;
-	si.si_errno = 0;
-	si.si_code = si_code;
-	si.si_addr = (void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK);
-	force_sig_info(SIGSEGV, &si, current);
+	force_sig_fault(SIGSEGV, si_code,
+			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK),
+			current);
 }
 
 static noinline void do_no_context(struct pt_regs *regs)
@@ -317,19 +312,13 @@ static noinline void do_low_address(struct pt_regs *regs)
 
 static noinline void do_sigbus(struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
-	struct siginfo si;
-
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	clear_siginfo(&si);
-	si.si_signo = SIGBUS;
-	si.si_errno = 0;
-	si.si_code = BUS_ADRERR;
-	si.si_addr = (void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK);
-	force_sig_info(SIGBUS, &si, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR,
+			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK),
+			current);
 }
 
 static noinline int signal_return(struct pt_regs *regs)
-- 
2.14.1
