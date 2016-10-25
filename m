Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Oct 2016 09:09:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.9-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161025090906.3fd118ab@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

A few more s390 patches for 4.9:

 - A fix for an overflow in the dasd driver reported by UBSAN
 - Fix a regression and add hotplug memory to the zone movable again
 - Add ignore defines for the pkey system calls
 - Fix the ouput of the merged stack tracer
 - Replace printk with pr_cont in arch/s390 where appropriate
 - Remove the arch specific return_address function again
 - Ignore reserved channel paths at boot time
 - Add a missing hugetlb_bad_size call to the arch backend

Christian Borntraeger (1):
      s390/dasd: avoid undefined behaviour

Gerald Schaefer (1):
      s390/mm: fix zone calculation in arch_add_memory()

Heiko Carstens (6):
      s390: ignore pkey system calls
      s390/dumpstack: restore reliable indicator for call traces
      s390/dumpstack: use pr_cont where appropriate
      s390/disassambler: use pr_cont where appropriate
      s390/dumpstack: get rid of return_address again
      s390/dumpstack: use pr_cont within show_stack and die

Sebastian Ott (1):
      s390/cio: don't register chpids in reserved state

Shyam Saini (1):
      s390/mm: use hugetlb_bad_size()

 arch/s390/include/asm/ftrace.h    |  4 +--
 arch/s390/include/asm/processor.h |  2 +-
 arch/s390/include/asm/unistd.h    |  3 ++
 arch/s390/kernel/dis.c            |  4 +--
 arch/s390/kernel/dumpstack.c      | 63 ++++++++++++++-------------------------
 arch/s390/kernel/perf_event.c     |  2 +-
 arch/s390/kernel/stacktrace.c     |  4 +--
 arch/s390/mm/hugetlbpage.c        |  1 +
 arch/s390/mm/init.c               | 38 ++++++++++++-----------
 arch/s390/oprofile/init.c         |  2 +-
 drivers/s390/block/dasd_eckd.c    |  4 +--
 drivers/s390/cio/chp.c            |  6 ++--
 12 files changed, 61 insertions(+), 72 deletions(-)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 64053d9..836c562 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -12,9 +12,7 @@
 
 #ifndef __ASSEMBLY__
 
-unsigned long return_address(int depth);
-
-#define ftrace_return_address(n) return_address(n)
+#define ftrace_return_address(n) __builtin_return_address(n)
 
 void _mcount(void);
 void ftrace_caller(void);
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 0332317..602af69 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -192,7 +192,7 @@ struct stack_frame {
 struct mm_struct;
 struct seq_file;
 
-typedef int (*dump_trace_func_t)(void *data, unsigned long address);
+typedef int (*dump_trace_func_t)(void *data, unsigned long address, int reliable);
 void dump_trace(dump_trace_func_t func, void *data,
 		struct task_struct *task, unsigned long sp);
 
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 02613ba..3066031 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -9,6 +9,9 @@
 #include <uapi/asm/unistd.h>
 
 #define __IGNORE_time
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
 
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 43446fa..c74c592 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -2014,12 +2014,12 @@ void show_code(struct pt_regs *regs)
 			*ptr++ = '\t';
 		ptr += print_insn(ptr, code + start, addr);
 		start += opsize;
-		printk("%s", buffer);
+		pr_cont("%s", buffer);
 		ptr = buffer;
 		ptr += sprintf(ptr, "\n          ");
 		hops++;
 	}
-	printk("\n");
+	pr_cont("\n");
 }
 
 void print_fn_code(unsigned char *code, unsigned long len)
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 6693383..55d4fe1 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -38,10 +38,10 @@
 		if (sp < low || sp > high - sizeof(*sf))
 			return sp;
 		sf = (struct stack_frame *) sp;
+		if (func(data, sf->gprs[8], 0))
+			return sp;
 		/* Follow the backchain. */
 		while (1) {
-			if (func(data, sf->gprs[8]))
-				return sp;
 			low = sp;
 			sp = sf->back_chain;
 			if (!sp)
@@ -49,6 +49,8 @@
 			if (sp <= low || sp > high - sizeof(*sf))
 				return sp;
 			sf = (struct stack_frame *) sp;
+			if (func(data, sf->gprs[8], 1))
+				return sp;
 		}
 		/* Zero backchain detected, check for interrupt frame. */
 		sp = (unsigned long) (sf + 1);
@@ -56,7 +58,7 @@
 			return sp;
 		regs = (struct pt_regs *) sp;
 		if (!user_mode(regs)) {
-			if (func(data, regs->psw.addr))
+			if (func(data, regs->psw.addr, 1))
 				return sp;
 		}
 		low = sp;
@@ -85,33 +87,12 @@ void dump_trace(dump_trace_func_t func, void *data, struct task_struct *task,
 }
 EXPORT_SYMBOL_GPL(dump_trace);
 
-struct return_address_data {
-	unsigned long address;
-	int depth;
-};
-
-static int __return_address(void *data, unsigned long address)
-{
-	struct return_address_data *rd = data;
-
-	if (rd->depth--)
-		return 0;
-	rd->address = address;
-	return 1;
-}
-
-unsigned long return_address(int depth)
-{
-	struct return_address_data rd = { .depth = depth + 2 };
-
-	dump_trace(__return_address, &rd, NULL, current_stack_pointer());
-	return rd.address;
-}
-EXPORT_SYMBOL_GPL(return_address);
-
-static int show_address(void *data, unsigned long address)
+static int show_address(void *data, unsigned long address, int reliable)
 {
-	printk("([<%016lx>] %pSR)\n", address, (void *)address);
+	if (reliable)
+		printk(" [<%016lx>] %pSR \n", address, (void *)address);
+	else
+		printk("([<%016lx>] %pSR)\n", address, (void *)address);
 	return 0;
 }
 
@@ -138,14 +119,14 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 		else
 			stack = (unsigned long *)task->thread.ksp;
 	}
+	printk(KERN_DEFAULT "Stack:\n");
 	for (i = 0; i < 20; i++) {
 		if (((addr_t) stack & (THREAD_SIZE-1)) == 0)
 			break;
-		if ((i * sizeof(long) % 32) == 0)
-			printk("%s       ", i == 0 ? "" : "\n");
-		printk("%016lx ", *stack++);
+		if (i % 4 == 0)
+			printk(KERN_DEFAULT "       ");
+		pr_cont("%016lx%c", *stack++, i % 4 == 3 ? '\n' : ' ');
 	}
-	printk("\n");
 	show_trace(task, (unsigned long)sp);
 }
 
@@ -163,13 +144,13 @@ void show_registers(struct pt_regs *regs)
 	mode = user_mode(regs) ? "User" : "Krnl";
 	printk("%s PSW : %p %p", mode, (void *)regs->psw.mask, (void *)regs->psw.addr);
 	if (!user_mode(regs))
-		printk(" (%pSR)", (void *)regs->psw.addr);
-	printk("\n");
+		pr_cont(" (%pSR)", (void *)regs->psw.addr);
+	pr_cont("\n");
 	printk("           R:%x T:%x IO:%x EX:%x Key:%x M:%x W:%x "
 	       "P:%x AS:%x CC:%x PM:%x", psw->r, psw->t, psw->i, psw->e,
 	       psw->key, psw->m, psw->w, psw->p, psw->as, psw->cc, psw->pm);
-	printk(" RI:%x EA:%x", psw->ri, psw->eaba);
-	printk("\n%s GPRS: %016lx %016lx %016lx %016lx\n", mode,
+	pr_cont(" RI:%x EA:%x\n", psw->ri, psw->eaba);
+	printk("%s GPRS: %016lx %016lx %016lx %016lx\n", mode,
 	       regs->gprs[0], regs->gprs[1], regs->gprs[2], regs->gprs[3]);
 	printk("           %016lx %016lx %016lx %016lx\n",
 	       regs->gprs[4], regs->gprs[5], regs->gprs[6], regs->gprs[7]);
@@ -205,14 +186,14 @@ void die(struct pt_regs *regs, const char *str)
 	printk("%s: %04x ilc:%d [#%d] ", str, regs->int_code & 0xffff,
 	       regs->int_code >> 17, ++die_counter);
 #ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
+	pr_cont("PREEMPT ");
 #endif
 #ifdef CONFIG_SMP
-	printk("SMP ");
+	pr_cont("SMP ");
 #endif
 	if (debug_pagealloc_enabled())
-		printk("DEBUG_PAGEALLOC");
-	printk("\n");
+		pr_cont("DEBUG_PAGEALLOC");
+	pr_cont("\n");
 	notify_die(DIE_OOPS, str, regs, 0, regs->int_code & 0xffff, SIGSEGV);
 	print_modules();
 	show_regs(regs);
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 17431f6..955a7b6 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -222,7 +222,7 @@ static int __init service_level_perf_register(void)
 }
 arch_initcall(service_level_perf_register);
 
-static int __perf_callchain_kernel(void *data, unsigned long address)
+static int __perf_callchain_kernel(void *data, unsigned long address, int reliable)
 {
 	struct perf_callchain_entry_ctx *entry = data;
 
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 44f84b2..355db9d 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -27,12 +27,12 @@ static int __save_address(void *data, unsigned long address, int nosched)
 	return 1;
 }
 
-static int save_address(void *data, unsigned long address)
+static int save_address(void *data, unsigned long address, int reliable)
 {
 	return __save_address(data, address, 0);
 }
 
-static int save_address_nosched(void *data, unsigned long address)
+static int save_address_nosched(void *data, unsigned long address, int reliable)
 {
 	return __save_address(data, address, 1);
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index cd404aa..4a0c5bc 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -217,6 +217,7 @@ static __init int setup_hugepagesz(char *opt)
 	} else if (MACHINE_HAS_EDAT2 && size == PUD_SIZE) {
 		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
 	} else {
+		hugetlb_bad_size();
 		pr_err("hugepagesz= specifies an unsupported page size %s\n",
 			string);
 		return 0;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f56a39b..b3e9d18 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -151,36 +151,40 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 {
-	unsigned long normal_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
-	unsigned long dma_end_pfn = PFN_DOWN(MAX_DMA_ADDRESS);
+	unsigned long zone_start_pfn, zone_end_pfn, nr_pages;
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long size_pages = PFN_DOWN(size);
-	unsigned long nr_pages;
-	int rc, zone_enum;
+	pg_data_t *pgdat = NODE_DATA(nid);
+	struct zone *zone;
+	int rc, i;
 
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
 
-	while (size_pages > 0) {
-		if (start_pfn < dma_end_pfn) {
-			nr_pages = (start_pfn + size_pages > dma_end_pfn) ?
-				   dma_end_pfn - start_pfn : size_pages;
-			zone_enum = ZONE_DMA;
-		} else if (start_pfn < normal_end_pfn) {
-			nr_pages = (start_pfn + size_pages > normal_end_pfn) ?
-				   normal_end_pfn - start_pfn : size_pages;
-			zone_enum = ZONE_NORMAL;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdat->node_zones + i;
+		if (zone_idx(zone) != ZONE_MOVABLE) {
+			/* Add range within existing zone limits, if possible */
+			zone_start_pfn = zone->zone_start_pfn;
+			zone_end_pfn = zone->zone_start_pfn +
+				       zone->spanned_pages;
 		} else {
-			nr_pages = size_pages;
-			zone_enum = ZONE_MOVABLE;
+			/* Add remaining range to ZONE_MOVABLE */
+			zone_start_pfn = start_pfn;
+			zone_end_pfn = start_pfn + size_pages;
 		}
-		rc = __add_pages(nid, NODE_DATA(nid)->node_zones + zone_enum,
-				 start_pfn, size_pages);
+		if (start_pfn < zone_start_pfn || start_pfn >= zone_end_pfn)
+			continue;
+		nr_pages = (start_pfn + size_pages > zone_end_pfn) ?
+			   zone_end_pfn - start_pfn : size_pages;
+		rc = __add_pages(nid, zone, start_pfn, nr_pages);
 		if (rc)
 			break;
 		start_pfn += nr_pages;
 		size_pages -= nr_pages;
+		if (!size_pages)
+			break;
 	}
 	if (rc)
 		vmem_remove_mapping(start, size);
diff --git a/arch/s390/oprofile/init.c b/arch/s390/oprofile/init.c
index 16f4c39..9a4de45 100644
--- a/arch/s390/oprofile/init.c
+++ b/arch/s390/oprofile/init.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <asm/processor.h>
 
-static int __s390_backtrace(void *data, unsigned long address)
+static int __s390_backtrace(void *data, unsigned long address, int reliable)
 {
 	unsigned int *depth = data;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 831935a..a7a8847 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1205,7 +1205,7 @@ static int verify_fcx_max_data(struct dasd_device *device, __u8 lpm)
 				 mdc, lpm);
 			return mdc;
 		}
-		fcx_max_data = mdc * FCX_MAX_DATA_FACTOR;
+		fcx_max_data = (u32)mdc * FCX_MAX_DATA_FACTOR;
 		if (fcx_max_data < private->fcx_max_data) {
 			dev_warn(&device->cdev->dev,
 				 "The maximum data size for zHPF requests %u "
@@ -1675,7 +1675,7 @@ static u32 get_fcx_max_data(struct dasd_device *device)
 			 " data size for zHPF requests failed\n");
 		return 0;
 	} else
-		return mdc * FCX_MAX_DATA_FACTOR;
+		return (u32)mdc * FCX_MAX_DATA_FACTOR;
 }
 
 /*
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 46be25c..876c7e6 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -780,7 +780,7 @@ static int cfg_wait_idle(void)
 static int __init chp_init(void)
 {
 	struct chp_id chpid;
-	int ret;
+	int state, ret;
 
 	ret = crw_register_handler(CRW_RSC_CPATH, chp_process_crw);
 	if (ret)
@@ -791,7 +791,9 @@ static int __init chp_init(void)
 		return 0;
 	/* Register available channel-paths. */
 	chp_id_for_each(&chpid) {
-		if (chp_info_get_status(chpid) != CHP_STATUS_NOT_RECOGNIZED)
+		state = chp_info_get_status(chpid);
+		if (state == CHP_STATUS_CONFIGURED ||
+		    state == CHP_STATUS_STANDBY)
 			chp_new(chpid);
 	}
 
