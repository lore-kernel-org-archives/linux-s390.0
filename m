From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 30 Apr 2007 11:16:38 +0000
Subject: [PATCH] s390: some more minor fault path optimization
Message-Id: <20070430111638.GA18415@infradead.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

And here's a port of the powerpc patch to get rid of the notifier
chain completely to s390.  It's ontop of Martins patch as that one
is in mainline already.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/s390/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/kprobes.c	2007-04-30 11:50:52.000000000 +0200
+++ linux-2.6/arch/s390/kernel/kprobes.c	2007-04-30 12:03:51.000000000 +0200
@@ -516,7 +516,7 @@ out:
 	return 1;
 }
 
-static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -603,7 +603,6 @@ int __kprobes kprobe_exceptions_notify(s
 			ret = NOTIFY_STOP;
 		break;
 	case DIE_TRAP:
-	case DIE_PAGE_FAULT:
 		/* kprobe_running() needs smp_processor_id() */
 		preempt_disable();
 		if (kprobe_running() &&
Index: linux-2.6/arch/s390/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/s390/mm/fault.c	2007-04-30 11:50:52.000000000 +0200
+++ linux-2.6/arch/s390/mm/fault.c	2007-04-30 12:03:51.000000000 +0200
@@ -52,38 +52,24 @@ extern int sysctl_userprocess_debug;
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
 
@@ -319,7 +305,7 @@ do_exception(struct pt_regs *regs, unsig
 	int space;
 	int si_code;
 
-	if (notify_page_fault(regs, error_code) == NOTIFY_STOP)
+	if (notify_page_fault(regs, error_code))
 		return;
 
 	tsk = current;
Index: linux-2.6/include/asm-s390/kdebug.h
===================================================================
--- linux-2.6.orig/include/asm-s390/kdebug.h	2007-04-30 11:50:52.000000000 +0200
+++ linux-2.6/include/asm-s390/kdebug.h	2007-04-30 12:03:51.000000000 +0200
@@ -22,8 +22,21 @@ struct die_args {
  */
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern int register_page_fault_notifier(struct notifier_block *);
-extern int unregister_page_fault_notifier(struct notifier_block *);
+
+/*
+ * These are only here because kprobes.c wants them to implement a
+ * blatant layering violation.  Will hopefully go away soon once all
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
@@ -39,7 +52,6 @@ enum die_val {
 	DIE_GPF,
 	DIE_CALL,
 	DIE_NMI_IPI,
-	DIE_PAGE_FAULT,
 };
 
 static inline int notify_die(enum die_val val, const char *str,
Index: linux-2.6/include/asm-s390/kprobes.h
===================================================================
--- linux-2.6.orig/include/asm-s390/kprobes.h	2007-04-30 11:50:52.000000000 +0200
+++ linux-2.6/include/asm-s390/kprobes.h	2007-04-30 12:03:51.000000000 +0200
@@ -97,18 +97,10 @@ void kretprobe_trampoline(void);
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
