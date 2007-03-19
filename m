Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 19 Mar 2007 14:08:51 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] powerpc minor pagefault optimization with kprobes enabled
Message-ID: <20070319140851.GA11285@infradead.org>
References: <20070319133149.GA5781@infradead.org> <200703191500.34563.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703191500.34563.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andi Kleen <ak@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

> Agreed, it should be fixed generically.
> 
> I think the right fix would be to make the notifier call an inline
> that checks the call chain in the caller. That would be cheap enough,
> except for the cache line that might need to be referenced.
> 
> For the cache line the short term fix would be to find some other
> global cache line that is referenced in the fault path anyways and put
> it on the same (e.g. by just putting the variable next to it or
> using a shared structure) 
> 
> Longer term might be something like Ben LaHaise's patch that can patch
> code inline for rarely-read globals.

I've attached a patch below the optimizes this code path for powerpc,
but the scheme applies to all architectures aswell.  It just rips out all
the callachin madness, and does as good as it gets in the pagefault
handler:

 - first we check for a user mode pagefault as that check is cheap
 - then we check kprobes_running which unfortunately requires a
   pagefault_disable
 - finally we do a direct function call to kprobe_fault_handler

> 
> > Please do the right thing to optimize this instead and rip out the brandead
> > notifier chain mechanisms and directly call into the krobes handler if
> > kprobes are active, 
> 
> No, we should keep the debugger hooks here. Otherwise there will be a zillion
> external patches patches code in at these places for the various debuggers,
> resulting in a merge nightmare for lots of people.

So get them to get their debuggers merged upstream.  Anyway, we need to
keep the die notifiers because we've actually grown some users for it.
I don't agree on the page fault notifiers, though - this code path
is too important to bloat it for posisble existing external parasites.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.20/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/mm/fault.c	2007-03-19 14:50:41.000000000 +0100
+++ linux-2.6.20/arch/powerpc/mm/fault.c	2007-03-19 15:00:00.000000000 +0100
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
Index: linux-2.6.20/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/kernel/kprobes.c	2007-03-19 14:53:01.000000000 +0100
+++ linux-2.6.20/arch/powerpc/kernel/kprobes.c	2007-03-19 15:03:41.000000000 +0100
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
Index: linux-2.6.20/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.20.orig/include/asm-powerpc/kdebug.h	2007-03-19 14:55:13.000000000 +0100
+++ linux-2.6.20/include/asm-powerpc/kdebug.h	2007-03-19 15:03:27.000000000 +0100
@@ -18,8 +18,20 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern int register_page_fault_notifier(struct notifier_block *);
-extern int unregister_page_fault_notifier(struct notifier_block *);
+
+/*
+ * These are only here because kprobes.c wants them to implement a
+ * blatant layer violation.  Will hopefully go away soon once all
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
Index: linux-2.6.20/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.20.orig/include/asm-powerpc/kprobes.h	2007-03-19 15:01:14.000000000 +0100
+++ linux-2.6.20/include/asm-powerpc/kprobes.h	2007-03-19 15:01:55.000000000 +0100
@@ -100,5 +100,6 @@ struct kprobe_ctlblk {
 
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data);
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_KPROBES_H */
