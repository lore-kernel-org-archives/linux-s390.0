Return-Path: <linux-kernel-owner+w=401wt.eu-S1031399AbXEDQwU@vger.kernel.org>
Message-Id: <20070504165241.217510982@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/9] get rid of kprobes notifier call chain.
Content-Disposition: inline; filename=001-kprobes-chain.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

And here's a port of the powerpc patch to get rid of the notifier
chain completely to s390.  It's ontop of Martins patch as that one
is in mainline already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/kprobes.c |    3 +--
 arch/s390/mm/fault.c       |   38 ++++++++++++--------------------------
 include/asm-s390/kdebug.h  |   18 +++++++++++++++---
 include/asm-s390/kprobes.h |   16 ++++------------
 4 files changed, 32 insertions(+), 43 deletions(-)

Index: quilt-2.6/arch/s390/kernel/kprobes.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/kprobes.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/kprobes.c	2007-05-04 18:50:14.000000000 +0200
@@ -516,7 +516,7 @@
 	return 1;
 }
 
-static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -603,7 +603,6 @@
 			ret = NOTIFY_STOP;
 		break;
 	case DIE_TRAP:
-	case DIE_PAGE_FAULT:
 		/* kprobe_running() needs smp_processor_id() */
 		preempt_disable();
 		if (kprobe_running() &&
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/arch/s390/mm/fault.c	2007-05-04 18:50:14.000000000 +0200
@@ -52,38 +52,24 @@
 extern void die(const char *,struct pt_regs *,long);
 
 #ifdef CONFIG_KPROBES
-static ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
-int register_page_fault_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
-}
-
-int unregister_page_fault_notifier(struct notifier_block *nb)
+static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
-	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
-}
+	int ret = 0;
 
-static int __kprobes __notify_page_fault(struct pt_regs *regs, long err)
-{
-	struct die_args args = { .str = "page fault",
-				 .trapnr = 14,
-				 .signr = SIGSEGV };
-	args.regs = regs;
-	args.err = err;
-	return atomic_notifier_call_chain(&notify_page_fault_chain,
-					  DIE_PAGE_FAULT, &args);
-}
+	/* kprobe_running() needs smp_processor_id() */
+	if (!user_mode(regs)) {
+		preempt_disable();
+		if (kprobe_running() && kprobe_fault_handler(regs, 14))
+			ret = 1;
+		preempt_enable();
+	}
 
-static inline int notify_page_fault(struct pt_regs *regs, long err)
-{
-	if (unlikely(kprobe_running()))
-		return __notify_page_fault(regs, err);
-	return NOTIFY_DONE;
+	return ret;
 }
 #else
 static inline int notify_page_fault(struct pt_regs *regs, long err)
 {
-	return NOTIFY_DONE;
+	return 0;
 }
 #endif
 
@@ -319,7 +305,7 @@
 	int space;
 	int si_code;
 
-	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code))
 		return;
 
 	tsk = current;
Index: quilt-2.6/include/asm-s390/kdebug.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/kdebug.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/include/asm-s390/kdebug.h	2007-05-04 18:50:14.000000000 +0200
@@ -22,8 +22,21 @@
  */
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern int register_page_fault_notifier(struct notifier_block *);
-extern int unregister_page_fault_notifier(struct notifier_block *);
+
+/*
+ * These are only here because kprobes.c wants them to implement a
+ * blatant layering violation. Will hopefully go away soon once all
+ * architectures are updated.
+ */
+static inline int register_page_fault_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline int unregister_page_fault_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
 extern struct atomic_notifier_head s390die_chain;
 
 enum die_val {
@@ -39,7 +52,6 @@
 	DIE_GPF,
 	DIE_CALL,
 	DIE_NMI_IPI,
-	DIE_PAGE_FAULT,
 };
 
 static inline int notify_die(enum die_val val, const char *str,
Index: quilt-2.6/include/asm-s390/kprobes.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/kprobes.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/include/asm-s390/kprobes.h	2007-05-04 18:50:14.000000000 +0200
@@ -97,18 +97,10 @@
 int  is_prohibited_opcode(kprobe_opcode_t *instruction);
 void get_instruction_type(struct arch_specific_insn *ainsn);
 
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+int kprobe_exceptions_notify(struct notifier_block *self,
+	unsigned long val, void *data);
+
 #define flush_insn_slot(p)	do { } while (0)
 
 #endif	/* _ASM_S390_KPROBES_H */
-
-#ifdef CONFIG_KPROBES
-
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-					unsigned long val, void *data);
-#else	/* !CONFIG_KPROBES */
-static inline int kprobe_exceptions_notify(struct notifier_block *self,
-						unsigned long val, void *data)
-{
-	return 0;
-}
-#endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
