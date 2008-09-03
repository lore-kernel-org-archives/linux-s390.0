From: Jarod Wilson <jwilson@redhat.com>
Date: Wed, 03 Sep 2008 15:18:29 +0000
Subject: [PATCH] CVE-2008-1514: s390 - prevent ptrace padding area read/write in 31-bit mode
Message-Id: <200809031118.29256.jwilson@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi there,

When running a 31-bit ptrace, on either an s390 or s390x kernel,
reads and writes into a padding area in struct user_regs_struct32
will result in a kernel panic.

This is also known as CVE-2008-1514.

Test case available here:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/tests/ptrace-tests/tests/user-area-padding.c?cvsroot=systemtap

Steps to reproduce:
1) wget the above
2) gcc -o user-area-padding-31bit user-area-padding.c -Wall -ggdb2 -D_GNU_SOURCE -m31
3) ./user-area-padding-31bit
<panic>


Test status
-----------
Without patch, both s390 and s390x kernels panic. With patch, the test case,
as well as the gdb testsuite, pass without incident, padding area reads
returning zero, writes ignored.

Nb: original version returned -EINVAL on write attempts, which broke the
gdb test and made the test case slightly unhappy, Jan Kratochvil suggested
the change to return 0 on write attempts.


Signed-off-by: Jarod Wilson <jarod@redhat.com>
Tested-by: Jan Kratochvil <jan.kratochvil@redhat.com>

---

 arch/s390/kernel/compat_ptrace.h |    1 +
 arch/s390/kernel/ptrace.c        |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/s390/kernel/compat_ptrace.h b/arch/s390/kernel/compat_ptrace.h
index cde81fa..a2be3a9 100644
--- a/arch/s390/kernel/compat_ptrace.h
+++ b/arch/s390/kernel/compat_ptrace.h
@@ -42,6 +42,7 @@ struct user_regs_struct32
 	u32 gprs[NUM_GPRS];
 	u32 acrs[NUM_ACRS];
 	u32 orig_gpr2;
+	/* nb: there's a 4-byte hole here */
 	s390_fp_regs fp_regs;
 	/*
 	 * These per registers are in here so that gdb can modify them
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 2815bfe..d00e403 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -170,6 +170,13 @@ static unsigned long __peek_user(struct task_struct *child, addr_t addr)
 		 */
 		tmp = (addr_t) task_pt_regs(child)->orig_gpr2;
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent reads of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		tmp = 0;
+
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/* 
 		 * floating point regs. are stored in the thread structure
@@ -270,6 +277,13 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		 */
 		task_pt_regs(child)->orig_gpr2 = data;
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent writes of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		return 0;
+
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure
@@ -428,6 +442,13 @@ static u32 __peek_user_compat(struct task_struct *child, addr_t addr)
 		 */
 		tmp = *(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4);
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent reads of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		tmp = 0;
+
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 
@@ -514,6 +535,13 @@ static int __poke_user_compat(struct task_struct *child,
 		 */
 		*(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4) = tmp;
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent writess of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		return 0;
+
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 

-- 
Jarod Wilson
jarod@redhat.com
