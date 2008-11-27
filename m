Return-Path: <linux-kernel-owner+w=401wt.eu-S1757123AbYK0Kpt@vger.kernel.org>
Message-Id: <20081127103140.111751673@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 44/60] convert setup printks to pr_xxx macros.
Content-Disposition: inline; filename=159-kmsg-setup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |   72 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -14,6 +14,9 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
+#define KMSG_COMPONENT "setup"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -291,8 +294,8 @@ unsigned int switch_amode = 0;
 #endif
 EXPORT_SYMBOL_GPL(switch_amode);
 
-static void set_amode_and_uaccess(unsigned long user_amode,
-				  unsigned long user32_amode)
+static int set_amode_and_uaccess(unsigned long user_amode,
+				 unsigned long user32_amode)
 {
 	psw_user_bits = PSW_BASE_BITS | PSW_MASK_DAT | user_amode |
 			PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK |
@@ -309,11 +312,11 @@ static void set_amode_and_uaccess(unsign
 			  PSW_MASK_MCHECK | PSW_DEFAULT_KEY;
 
 	if (MACHINE_HAS_MVCOS) {
-		printk("mvcos available.\n");
 		memcpy(&uaccess, &uaccess_mvcos_switch, sizeof(uaccess));
+		return 1;
 	} else {
-		printk("mvcos not available.\n");
 		memcpy(&uaccess, &uaccess_pt, sizeof(uaccess));
+		return 0;
 	}
 }
 
@@ -328,9 +331,10 @@ static int __init early_parse_switch_amo
 early_param("switch_amode", early_parse_switch_amode);
 
 #else /* CONFIG_S390_SWITCH_AMODE */
-static inline void set_amode_and_uaccess(unsigned long user_amode,
-					 unsigned long user32_amode)
+static inline int set_amode_and_uaccess(unsigned long user_amode,
+					unsigned long user32_amode)
 {
+	return 0;
 }
 #endif /* CONFIG_S390_SWITCH_AMODE */
 
@@ -355,11 +359,20 @@ early_param("noexec", early_parse_noexec
 static void setup_addressing_mode(void)
 {
 	if (s390_noexec) {
-		printk("S390 execute protection active, ");
-		set_amode_and_uaccess(PSW_ASC_SECONDARY, PSW32_ASC_SECONDARY);
+		if (set_amode_and_uaccess(PSW_ASC_SECONDARY,
+					  PSW32_ASC_SECONDARY))
+			pr_info("Execute protection active, "
+				"mvcos available\n");
+		else
+			pr_info("Execute protection active, "
+				"mvcos not available\n");
 	} else if (switch_amode) {
-		printk("S390 address spaces switched, ");
-		set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY);
+		if (set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY))
+			pr_info("Address spaces switched, "
+				"mvcos available\n");
+		else
+			pr_info("Address spaces switched, "
+				"mvcos not available\n");
 	}
 #ifdef CONFIG_TRACE_IRQFLAGS
 	sysc_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
@@ -572,15 +585,15 @@ setup_memory(void)
 			start = PFN_PHYS(start_pfn) + bmap_size + PAGE_SIZE;
 
 			if (start + INITRD_SIZE > memory_end) {
-				printk("initrd extends beyond end of memory "
-				       "(0x%08lx > 0x%08lx)\n"
+				pr_err("initrd extends beyond end of "
+				       "memory (0x%08lx > 0x%08lx) "
 				       "disabling initrd\n",
 				       start + INITRD_SIZE, memory_end);
 				INITRD_START = INITRD_SIZE = 0;
 			} else {
-				printk("Moving initrd (0x%08lx -> 0x%08lx, "
-				       "size: %ld)\n",
-				       INITRD_START, start, INITRD_SIZE);
+				pr_info("Moving initrd (0x%08lx -> "
+					"0x%08lx, size: %ld)\n",
+					INITRD_START, start, INITRD_SIZE);
 				memmove((void *) start, (void *) INITRD_START,
 					INITRD_SIZE);
 				INITRD_START = start;
@@ -642,8 +655,9 @@ setup_memory(void)
 			initrd_start = INITRD_START;
 			initrd_end = initrd_start + INITRD_SIZE;
 		} else {
-			printk("initrd extends beyond end of memory "
-			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			pr_err("initrd extends beyond end of "
+			       "memory (0x%08lx > 0x%08lx) "
+			       "disabling initrd\n",
 			       initrd_start + INITRD_SIZE, memory_end);
 			initrd_start = initrd_end = 0;
 		}
@@ -744,21 +758,27 @@ setup_arch(char **cmdline_p)
          * print what head.S has found out about the machine
          */
 #ifndef CONFIG_64BIT
-	printk((MACHINE_IS_VM) ?
-	       "We are running under VM (31 bit mode)\n" :
-	       "We are running native (31 bit mode)\n");
-	printk((MACHINE_HAS_IEEE) ?
-	       "This machine has an IEEE fpu\n" :
-	       "This machine has no IEEE fpu\n");
+	if (MACHINE_IS_VM)
+		pr_info("Linux is running as a z/VM "
+			"guest operating system in 31-bit mode\n");
+	else
+		pr_info("Linux is running natively in 31-bit mode\n");
+	if (MACHINE_HAS_IEEE)
+		pr_info("The hardware system has IEEE compatible "
+			"floating point units\n");
+	else
+		pr_info("The hardware system has no IEEE compatible "
+			"floating point units\n");
 #else /* CONFIG_64BIT */
 	if (MACHINE_IS_VM)
-		printk("We are running under VM (64 bit mode)\n");
+		pr_info("Linux is running as a z/VM "
+			"guest operating system in 64-bit mode\n");
 	else if (MACHINE_IS_KVM) {
-		printk("We are running under KVM (64 bit mode)\n");
+		pr_info("Linux is running under KVM in 64-bit mode\n");
 		add_preferred_console("hvc", 0, NULL);
 		s390_virtio_console_init();
 	} else
-		printk("We are running native (64 bit mode)\n");
+		pr_info("Linux is running natively in 64-bit mode\n");
 #endif /* CONFIG_64BIT */
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
