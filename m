Return-Path: <linux-kernel-owner+w=401wt.eu-S932318AbXD3K4x@vger.kernel.org>
Date: Mon, 30 Apr 2007 11:56:46 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] powerpc: minor fault path optimization
Message-ID: <20070430105646.GA15919@infradead.org>
References: <20070427140503.087958775@de.ibm.com> <20070427140516.523272684@de.ibm.com> <17970.53875.506097.699517@cargo.ozlabs.ibm.com> <20070428083409.GA22156@infradead.org> <17973.16109.113219.634346@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17973.16109.113219.634346@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Call the kprobes pagefault handler directly instead of going through
the complex notifier chain.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c	2007-03-23 20:07:28.000000000 +0100
+++ linux-2.6/arch/powerpc/mm/fault.c	2007-04-30 11:33:36.000000000 +0200
@@ -39,37 +39,26 @@
 #include <asm/kdebug.h>
 #include <asm/siginfo.h>
 
-#ifdef CONFIG_KPROBES
-ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
-/* Hook to register for page fault notifications */
-int register_page_fault_notifier(struct notifier_block *nb)
+#ifdef CONFIG_KPROBES
+static inline int notify_page_fault(struct pt_regs *regs)
 {
-	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
-}
+	int ret = 0;
 
-int unregister_page_fault_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
-}
+	/* kprobe_running() needs smp_processor_id() */
+	if (!user_mode(regs)) {
+		preempt_disable();
+		if (kprobe_running() && kprobe_fault_handler(regs, 11))
+			ret = 1;
+		preempt_enable();
+	}
 
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
-{
-	struct die_args args = {
-		.regs = regs,
-		.str = str,
-		.err = err,
-		.trapnr = trap,
-		.signr = sig
-	};
-	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
+	return ret;
 }
 #else
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
+static inline int notify_page_fault(struct pt_regs *regs)
 {
-	return NOTIFY_DONE;
+	return 0;
 }
 #endif
 
@@ -175,8 +164,7 @@ int __kprobes do_page_fault(struct pt_re
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
-	if (notify_page_fault(DIE_PAGE_FAULT, "page_fault", regs, error_code,
-				11, SIGSEGV) == NOTIFY_STOP)
+	if (notify_page_fault(regs))
 		return 0;
 
 	if (trap == 0x300) {
Index: linux-2.6/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/kprobes.c	2007-04-02 20:18:18.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/kprobes.c	2007-04-30 11:33:36.000000000 +0200
@@ -376,7 +376,7 @@ out:
 	return 1;
 }
 
-static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -461,14 +461,6 @@ int __kprobes kprobe_exceptions_notify(s
 		if (post_kprobe_handler(args->regs))
 			ret = NOTIFY_STOP;
 		break;
-	case DIE_PAGE_FAULT:
-		/* kprobe_running() needs smp_processor_id() */
-		preempt_disable();
-		if (kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			ret = NOTIFY_STOP;
-		preempt_enable();
-		break;
 	default:
 		break;
 	}
Index: linux-2.6/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kdebug.h	2007-03-23 20:07:29.000000000 +0100
+++ linux-2.6/include/asm-powerpc/kdebug.h	2007-04-30 11:51:04.000000000 +0200
@@ -18,8 +18,20 @@ struct die_args {
 
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
 extern struct atomic_notifier_head powerpc_die_chain;
 
 /* Grossly misnamed. */
@@ -29,7 +41,6 @@ enum die_val {
 	DIE_DABR_MATCH,
 	DIE_BPT,
 	DIE_SSTEP,
-	DIE_PAGE_FAULT,
 };
 
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
Index: linux-2.6/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kprobes.h	2007-02-11 08:17:32.000000000 +0100
+++ linux-2.6/include/asm-powerpc/kprobes.h	2007-04-30 11:33:36.000000000 +0200
@@ -105,5 +105,6 @@ struct kprobe_ctlblk {
 
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data);
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_KPROBES_H */
