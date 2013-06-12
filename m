From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 5/6] KVM: s390,perf: Detect if perf samples belong to KVM host or guest
Date: Wed, 12 Jun 2013 13:54:56 +0200
Message-ID: <1371038097-28577-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

This patch is based on an original patch of David Hildenbrand.

The perf core implementation calls architecture specific code in order
to ask for specific information for a particular sample:

perf_instruction_pointer()
When perf core code asks for the instruction pointer, architecture
specific code must detect if a KVM guest was running when the sample
was taken. A sample can be associated with a  KVM guest when the PSW
supervisor state bit is set and the PSW instruction pointer part
contains the address of 'sie_exit'.
A KVM guest's instruction pointer information is then retrieved via
gpsw entry pointed to by the sie control-block.

perf_misc_flags()
perf code code calls this function in order to associate the kernel
vs. user state infomation with a particular sample. Architecture
specific code must also first detectif a KVM guest was running
at the time the sample was taken.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h   |  1 +
 arch/s390/include/asm/perf_event.h | 10 ++++++++
 arch/s390/kernel/entry64.S         |  1 +
 arch/s390/kernel/perf_event.c      | 52 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/s390_ksyms.c      |  1 +
 5 files changed, 65 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d3ffd7e..4339069 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -275,4 +275,5 @@ struct kvm_arch{
 };
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
+extern char sie_exit;
 #endif
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index 5f0173a..1141fb3 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -14,3 +14,13 @@
 /* Per-CPU flags for PMU states */
 #define PMU_F_RESERVED			0x1000
 #define PMU_F_ENABLED			0x2000
+
+#ifdef CONFIG_64BIT
+
+/* Perf callbacks */
+struct pt_regs;
+extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_misc_flags(struct pt_regs *regs);
+#define perf_misc_flags(regs) perf_misc_flags(regs)
+
+#endif /* CONFIG_64BIT */
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 51d99ac..b094ced 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -964,6 +964,7 @@ sie_done:
 # See also HANDLE_SIE_INTERCEPT
 rewind_pad:
 	nop	0
+	.globl sie_exit
 sie_exit:
 	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index f58f37f..a6fc037 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
+#include <linux/kvm_host.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <asm/irq.h>
@@ -39,6 +40,57 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL(perf_num_counters);
 
+static struct kvm_s390_sie_block *sie_block(struct pt_regs *regs)
+{
+	struct stack_frame *stack = (struct stack_frame *) regs->gprs[15];
+
+	if (!stack)
+		return NULL;
+
+	return (struct kvm_s390_sie_block *) stack->empty1[0];
+}
+
+static bool is_in_guest(struct pt_regs *regs)
+{
+	unsigned long ip = instruction_pointer(regs);
+
+	if (user_mode(regs))
+		return false;
+
+	return ip == (unsigned long) &sie_exit;
+}
+
+static unsigned long guest_is_user_mode(struct pt_regs *regs)
+{
+	return sie_block(regs)->gpsw.mask & PSW_MASK_PSTATE;
+}
+
+static unsigned long instruction_pointer_guest(struct pt_regs *regs)
+{
+	return sie_block(regs)->gpsw.addr & PSW_ADDR_INSN;
+}
+
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	return is_in_guest(regs) ? instruction_pointer_guest(regs)
+				 : instruction_pointer(regs);
+}
+
+static unsigned long perf_misc_guest_flags(struct pt_regs *regs)
+{
+	return guest_is_user_mode(regs) ? PERF_RECORD_MISC_GUEST_USER
+					: PERF_RECORD_MISC_GUEST_KERNEL;
+}
+
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	if (is_in_guest(regs))
+		return perf_misc_guest_flags(regs);
+
+	return user_mode(regs) ? PERF_RECORD_MISC_USER
+			       : PERF_RECORD_MISC_KERNEL;
+}
+
 void perf_event_print_debug(void)
 {
 	struct cpumf_ctr_info cf_info;
diff --git a/arch/s390/kernel/s390_ksyms.c b/arch/s390/kernel/s390_ksyms.c
index 9bdbcef..3bac589 100644
--- a/arch/s390/kernel/s390_ksyms.c
+++ b/arch/s390/kernel/s390_ksyms.c
@@ -7,6 +7,7 @@ EXPORT_SYMBOL(_mcount);
 #endif
 #if defined(CONFIG_KVM) || defined(CONFIG_KVM_MODULE)
 EXPORT_SYMBOL(sie64a);
+EXPORT_SYMBOL(sie_exit);
 #endif
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-- 
1.8.1.6
