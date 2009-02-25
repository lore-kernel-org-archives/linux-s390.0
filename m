Return-Path: <linux-kernel-owner+w=401wt.eu-S1760865AbZBYPKb@vger.kernel.org>
Message-Id: <20090225150827.292879003@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 02/46] Automatic IPL after dump
Content-Disposition: inline; filename=101-reipl-after-dump.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

Provide new shutdown action "dump_reipl" for automatic ipl after dump.

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/include/asm/lowcore.h |   24 +++++-----
 arch/s390/include/asm/system.h  |   16 +++++++
 arch/s390/kernel/ipl.c          |   56 +++++++++++++++++++++++--
 arch/s390/kernel/setup.c        |    5 ++
 arch/s390/kernel/smp.c          |    9 ----
 drivers/s390/char/zcore.c       |   88 +++++++++++++++++++++++++++++++++++++++-
 6 files changed, 172 insertions(+), 26 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/lowcore.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/lowcore.h
+++ quilt-2.6/arch/s390/include/asm/lowcore.h
@@ -111,7 +111,7 @@
 
 #define __LC_PASTE			0xE40
 
-#define __LC_PANIC_MAGIC		0xE00
+#define __LC_DUMP_REIPL			0xE00
 #ifndef __s390x__
 #define __LC_PFAULT_INTPARM             0x080
 #define __LC_CPU_TIMER_SAVE_AREA        0x0D8
@@ -286,12 +286,14 @@ struct _lowcore
 	__u64        int_clock;                /* 0xc98 */
         __u8         pad11[0xe00-0xca0];       /* 0xca0 */
 
-        /* 0xe00 is used as indicator for dump tools */
-        /* whether the kernel died with panic() or not */
-        __u32        panic_magic;              /* 0xe00 */
+	/* 0xe00 contains the address of the IPL Parameter */
+	/* Information block. Dump tools need IPIB for IPL */
+	/* after dump.					   */
+	__u32	     ipib;		       /* 0xe00 */
+	__u32	     ipib_checksum;	       /* 0xe04 */
 
         /* Align to the top 1k of prefix area */
-	__u8         pad12[0x1000-0xe04];      /* 0xe04 */
+	__u8	     pad12[0x1000-0xe08];      /* 0xe08 */
 #else /* !__s390x__ */
         /* prefix area: defined by architecture */
 	__u32        ccw1[2];                  /* 0x000 */
@@ -379,12 +381,14 @@ struct _lowcore
 	__u64        int_clock;                /* 0xde8 */
         __u8         pad12[0xe00-0xdf0];       /* 0xdf0 */
 
-        /* 0xe00 is used as indicator for dump tools */
-        /* whether the kernel died with panic() or not */
-        __u32        panic_magic;              /* 0xe00 */
+	/* 0xe00 contains the address of the IPL Parameter */
+	/* Information block. Dump tools need IPIB for IPL */
+	/* after dump.					   */
+	__u64	     ipib;		       /* 0xe00 */
+	__u32	     ipib_checksum;	       /* 0xe08 */
 
 	/* Per cpu primary space access list */
-	__u8	     pad_0xe04[0xe38-0xe04];   /* 0xe04 */
+	__u8	     pad_0xe0c[0xe38-0xe0c];   /* 0xe0c */
 	__u64	     vdso_per_cpu_data;	       /* 0xe38 */
 	__u32	     paste[16];		       /* 0xe40 */
 
@@ -433,8 +437,6 @@ static inline __u32 store_prefix(void)
 	return address;
 }
 
-#define __PANIC_MAGIC           0xDEADC0DE
-
 #endif
 
 #endif
Index: quilt-2.6/arch/s390/include/asm/system.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/system.h
+++ quilt-2.6/arch/s390/include/asm/system.h
@@ -458,6 +458,22 @@ static inline unsigned short stap(void)
 	return cpu_address;
 }
 
+static inline u32 cksm(void *addr, unsigned long len)
+{
+	register unsigned long _addr asm("0") = (unsigned long) addr;
+	register unsigned long _len asm("1") = len;
+	unsigned long accu = 0;
+
+	asm volatile(
+		"0:\n"
+		"	cksm	%0,%1\n"
+		"	jnz	0b\n"
+		: "+d" (accu), "+d" (_addr), "+d" (_len)
+		:
+		: "cc", "memory");
+	return accu;
+}
+
 extern void (*_machine_restart)(char *command);
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -56,13 +56,14 @@ struct shutdown_trigger {
 };
 
 /*
- * Five shutdown action types are supported:
+ * The following shutdown action types are supported:
  */
 #define SHUTDOWN_ACTION_IPL_STR		"ipl"
 #define SHUTDOWN_ACTION_REIPL_STR	"reipl"
 #define SHUTDOWN_ACTION_DUMP_STR	"dump"
 #define SHUTDOWN_ACTION_VMCMD_STR	"vmcmd"
 #define SHUTDOWN_ACTION_STOP_STR	"stop"
+#define SHUTDOWN_ACTION_DUMP_REIPL_STR	"dump_reipl"
 
 struct shutdown_action {
 	char *name;
@@ -146,6 +147,7 @@ static enum ipl_method reipl_method = RE
 static struct ipl_parameter_block *reipl_block_fcp;
 static struct ipl_parameter_block *reipl_block_ccw;
 static struct ipl_parameter_block *reipl_block_nss;
+static struct ipl_parameter_block *reipl_block_actual;
 
 static int dump_capabilities = DUMP_TYPE_NONE;
 static enum dump_type dump_type = DUMP_TYPE_NONE;
@@ -835,6 +837,7 @@ static int reipl_set_type(enum ipl_type 
 			reipl_method = REIPL_METHOD_CCW_VM;
 		else
 			reipl_method = REIPL_METHOD_CCW_CIO;
+		reipl_block_actual = reipl_block_ccw;
 		break;
 	case IPL_TYPE_FCP:
 		if (diag308_set_works)
@@ -843,6 +846,7 @@ static int reipl_set_type(enum ipl_type 
 			reipl_method = REIPL_METHOD_FCP_RO_VM;
 		else
 			reipl_method = REIPL_METHOD_FCP_RO_DIAG;
+		reipl_block_actual = reipl_block_fcp;
 		break;
 	case IPL_TYPE_FCP_DUMP:
 		reipl_method = REIPL_METHOD_FCP_DUMP;
@@ -852,6 +856,7 @@ static int reipl_set_type(enum ipl_type 
 			reipl_method = REIPL_METHOD_NSS_DIAG;
 		else
 			reipl_method = REIPL_METHOD_NSS;
+		reipl_block_actual = reipl_block_nss;
 		break;
 	case IPL_TYPE_UNKNOWN:
 		reipl_method = REIPL_METHOD_DEFAULT;
@@ -1332,6 +1337,48 @@ static struct shutdown_action __refdata 
 	.init	= dump_init,
 };
 
+static void dump_reipl_run(struct shutdown_trigger *trigger)
+{
+	preempt_disable();
+	/*
+	 * Bypass dynamic address translation (DAT) when storing IPL parameter
+	 * information block address and checksum into the prefix area
+	 * (corresponding to absolute addresses 0-8191).
+	 * When enhanced DAT applies and the STE format control in one,
+	 * the absolute address is formed without prefixing. In this case a
+	 * normal store (stg/st) into the prefix area would no more match to
+	 * absolute addresses 0-8191.
+	 */
+#ifdef CONFIG_64BIT
+	asm volatile("sturg %0,%1"
+		:: "a" ((unsigned long) reipl_block_actual),
+		"a" (&lowcore_ptr[smp_processor_id()]->ipib));
+#else
+	asm volatile("stura %0,%1"
+		:: "a" ((unsigned long) reipl_block_actual),
+		"a" (&lowcore_ptr[smp_processor_id()]->ipib));
+#endif
+	asm volatile("stura %0,%1"
+		:: "a" (cksm(reipl_block_actual, reipl_block_actual->hdr.len)),
+		"a" (&lowcore_ptr[smp_processor_id()]->ipib_checksum));
+	preempt_enable();
+	dump_run(trigger);
+}
+
+static int __init dump_reipl_init(void)
+{
+	if (!diag308_set_works)
+		return -EOPNOTSUPP;
+	else
+		return 0;
+}
+
+static struct shutdown_action __refdata dump_reipl_action = {
+	.name	= SHUTDOWN_ACTION_DUMP_REIPL_STR,
+	.fn	= dump_reipl_run,
+	.init	= dump_reipl_init,
+};
+
 /*
  * vmcmd shutdown action: Trigger vm command on shutdown.
  */
@@ -1421,7 +1468,8 @@ static struct shutdown_action stop_actio
 /* action list */
 
 static struct shutdown_action *shutdown_actions_list[] = {
-	&ipl_action, &reipl_action, &dump_action, &vmcmd_action, &stop_action};
+	&ipl_action, &reipl_action, &dump_reipl_action, &dump_action,
+	&vmcmd_action, &stop_action};
 #define SHUTDOWN_ACTIONS_COUNT (sizeof(shutdown_actions_list) / sizeof(void *))
 
 /*
@@ -1434,11 +1482,11 @@ static int set_trigger(const char *buf, 
 		       size_t len)
 {
 	int i;
+
 	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
 		if (!shutdown_actions_list[i])
 			continue;
-		if (strncmp(buf, shutdown_actions_list[i]->name,
-			    strlen(shutdown_actions_list[i]->name)) == 0) {
+		if (sysfs_streq(buf, shutdown_actions_list[i]->name)) {
 			trigger->action = shutdown_actions_list[i];
 			return len;
 		}
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -86,6 +86,10 @@ volatile int __cpu_logical_map[NR_CPUS];
 int __initdata memory_end_set;
 unsigned long __initdata memory_end;
 
+/* An array with a pointer to the lowcore of every CPU. */
+struct _lowcore *lowcore_ptr[NR_CPUS];
+EXPORT_SYMBOL(lowcore_ptr);
+
 /*
  * This is set up by the setup-routine at boot-time
  * for S390 need to find out, what we have to setup
@@ -434,6 +438,7 @@ setup_lowcore(void)
 	lc->vdso_per_cpu_data = (unsigned long) &lc->paste[0];
 #endif
 	set_prefix((u32)(unsigned long) lc);
+	lowcore_ptr[0] = lc;
 }
 
 static void __init
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -50,12 +50,6 @@
 #include <asm/vdso.h>
 #include "entry.h"
 
-/*
- * An array with a pointer the lowcore of every CPU.
- */
-struct _lowcore *lowcore_ptr[NR_CPUS];
-EXPORT_SYMBOL(lowcore_ptr);
-
 static struct task_struct *current_set[NR_CPUS];
 
 static u8 smp_cpu_type;
@@ -82,9 +76,6 @@ void smp_send_stop(void)
 	/* Disable all interrupts/machine checks */
 	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
 
-	/* write magic number to zero page (absolute 0) */
-	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
-
 	/* stop all processors */
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -5,7 +5,7 @@
  *
  * For more information please refer to Documentation/s390/zfcpdump.txt
  *
- * Copyright IBM Corp. 2003,2007
+ * Copyright IBM Corp. 2003,2008
  * Author(s): Michael Holzheu
  */
 
@@ -48,12 +48,19 @@ struct sys_info {
 	union save_area	lc_mask;
 };
 
+struct ipib_info {
+	unsigned long	ipib;
+	u32		checksum;
+}  __attribute__((packed));
+
 static struct sys_info sys_info;
 static struct debug_info *zcore_dbf;
 static int hsa_available;
 static struct dentry *zcore_dir;
 static struct dentry *zcore_file;
 static struct dentry *zcore_memmap_file;
+static struct dentry *zcore_reipl_file;
+static struct ipl_parameter_block *ipl_block;
 
 /*
  * Copy memory from HSA to kernel or user memory (not reentrant):
@@ -527,6 +534,33 @@ static const struct file_operations zcor
 	.release	= zcore_memmap_release,
 };
 
+static ssize_t zcore_reipl_write(struct file *filp, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	if (ipl_block) {
+		diag308(DIAG308_SET, ipl_block);
+		diag308(DIAG308_IPL, NULL);
+	}
+	return count;
+}
+
+static int zcore_reipl_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int zcore_reipl_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static const struct file_operations zcore_reipl_fops = {
+	.owner		= THIS_MODULE,
+	.write		= zcore_reipl_write,
+	.open		= zcore_reipl_open,
+	.release	= zcore_reipl_release,
+};
+
 
 static void __init set_s390_lc_mask(union save_area *map)
 {
@@ -645,6 +679,39 @@ static int __init zcore_header_init(int 
 	return 0;
 }
 
+/*
+ * Provide IPL parameter information block from either HSA or memory
+ * for future reipl
+ */
+static int __init zcore_reipl_init(void)
+{
+	struct ipib_info ipib_info;
+	int rc;
+
+	rc = memcpy_hsa_kernel(&ipib_info, __LC_DUMP_REIPL, sizeof(ipib_info));
+	if (rc)
+		return rc;
+	if (ipib_info.ipib == 0)
+		return 0;
+	ipl_block = (void *) __get_free_page(GFP_KERNEL);
+	if (!ipl_block)
+		return -ENOMEM;
+	if (ipib_info.ipib < ZFCPDUMP_HSA_SIZE)
+		rc = memcpy_hsa_kernel(ipl_block, ipib_info.ipib, PAGE_SIZE);
+	else
+		rc = memcpy_real(ipl_block, ipib_info.ipib, PAGE_SIZE);
+	if (rc) {
+		free_page((unsigned long) ipl_block);
+		return rc;
+	}
+	if (cksm(ipl_block, ipl_block->hdr.len) != ipib_info.checksum) {
+		TRACE("Checksum does not match\n");
+		free_page((unsigned long) ipl_block);
+		ipl_block = NULL;
+	}
+	return 0;
+}
+
 static int __init zcore_init(void)
 {
 	unsigned char arch;
@@ -690,6 +757,10 @@ static int __init zcore_init(void)
 	if (rc)
 		goto fail;
 
+	rc = zcore_reipl_init();
+	if (rc)
+		goto fail;
+
 	zcore_dir = debugfs_create_dir("zcore" , NULL);
 	if (!zcore_dir) {
 		rc = -ENOMEM;
@@ -707,9 +778,17 @@ static int __init zcore_init(void)
 		rc = -ENOMEM;
 		goto fail_file;
 	}
+	zcore_reipl_file = debugfs_create_file("reipl", S_IRUSR, zcore_dir,
+						NULL, &zcore_reipl_fops);
+	if (!zcore_reipl_file) {
+		rc = -ENOMEM;
+		goto fail_memmap_file;
+	}
 	hsa_available = 1;
 	return 0;
 
+fail_memmap_file:
+	debugfs_remove(zcore_memmap_file);
 fail_file:
 	debugfs_remove(zcore_file);
 fail_dir:
@@ -723,10 +802,15 @@ static void __exit zcore_exit(void)
 {
 	debug_unregister(zcore_dbf);
 	sclp_sdias_exit();
+	free_page((unsigned long) ipl_block);
+	debugfs_remove(zcore_reipl_file);
+	debugfs_remove(zcore_memmap_file);
+	debugfs_remove(zcore_file);
+	debugfs_remove(zcore_dir);
 	diag308(DIAG308_REL_HSA, NULL);
 }
 
-MODULE_AUTHOR("Copyright IBM Corp. 2003,2007");
+MODULE_AUTHOR("Copyright IBM Corp. 2003,2008");
 MODULE_DESCRIPTION("zcore module for zfcpdump support");
 MODULE_LICENSE("GPL");
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
