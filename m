Return-Path: <linux-kernel-owner+w=401wt.eu-S1760859AbYG1R5E@vger.kernel.org>
Message-Id: <20080728175513.443424050@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/15] kmsg: convert setup printk messages to kmsg api.
Content-Disposition: inline; filename=811-kmsg-setup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/setup |  164 ++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c      |   78 ++++++++++++-------
 2 files changed, 213 insertions(+), 29 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -55,6 +55,9 @@
 #include <asm/ebcdic.h>
 #include <asm/compat.h>
 #include <asm/kvm_virtio.h>
+#include <asm/kmsg.h>
+
+#define KMSG_COMPONENT "setup"
 
 long psw_kernel_bits	= (PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY |
 			   PSW_MASK_MCHECK | PSW_DEFAULT_KEY);
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
+			kmsg_info(1, "Execute protection active, "
+				  "mvcos available\n");
+		else
+			kmsg_info(2, "Execute protection active, "
+				  "mvcos not available\n");
 	} else if (switch_amode) {
-		printk("S390 address spaces switched, ");
-		set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY);
+		if (set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY))
+			kmsg_info(3, "Address spaces switched, "
+				  "mvcos available\n");
+		else
+			kmsg_info(4, "Address spaces switched, "
+				  "mvcos not available\n");
 	}
 #ifdef CONFIG_TRACE_IRQFLAGS
 	sysc_restore_trace_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
@@ -572,15 +585,15 @@ setup_memory(void)
 			start = PFN_PHYS(start_pfn) + bmap_size + PAGE_SIZE;
 
 			if (start + INITRD_SIZE > memory_end) {
-				printk("initrd extends beyond end of memory "
-				       "(0x%08lx > 0x%08lx)\n"
-				       "disabling initrd\n",
-				       start + INITRD_SIZE, memory_end);
+				kmsg_err(5, "initrd extends beyond end of "
+					 "memory (0x%08lx > 0x%08lx) "
+					 "disabling initrd\n",
+					 start + INITRD_SIZE, memory_end);
 				INITRD_START = INITRD_SIZE = 0;
 			} else {
-				printk("Moving initrd (0x%08lx -> 0x%08lx, "
-				       "size: %ld)\n",
-				       INITRD_START, start, INITRD_SIZE);
+				kmsg_info(6, "Moving initrd (0x%08lx -> "
+					  "0x%08lx, size: %ld)\n",
+					  INITRD_START, start, INITRD_SIZE);
 				memmove((void *) start, (void *) INITRD_START,
 					INITRD_SIZE);
 				INITRD_START = start;
@@ -642,9 +655,10 @@ setup_memory(void)
 			initrd_start = INITRD_START;
 			initrd_end = initrd_start + INITRD_SIZE;
 		} else {
-			printk("initrd extends beyond end of memory "
-			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			       initrd_start + INITRD_SIZE, memory_end);
+			kmsg_err(5, "initrd extends beyond end of "
+				 "memory (0x%08lx > 0x%08lx)\n"
+				 "disabling initrd\n",
+				 initrd_start + INITRD_SIZE, memory_end);
 			initrd_start = initrd_end = 0;
 		}
 	}
@@ -756,21 +770,27 @@ setup_arch(char **cmdline_p)
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
+		kmsg_info(7, "Linux is running as a z/VM "
+			  "guest operating system in 31-bit mode\n");
+	else
+		kmsg_info(8, "Linux is running natively in 31-bit mode\n");
+	if (MACHINE_HAS_IEEE)
+		kmsg_info(9, "The hardware system has IEEE compatible "
+			  "floating point units\n");
+	else
+		kmsg_info(10, "The hardware system has no IEEE compatible "
+			  "floating point units\n");
 #else /* CONFIG_64BIT */
 	if (MACHINE_IS_VM)
-		printk("We are running under VM (64 bit mode)\n");
+		kmsg_info(11, "Linux is running as a z/VM "
+			  "guest operating system in 64-bit mode\n");
 	else if (MACHINE_IS_KVM) {
-		printk("We are running under KVM (64 bit mode)\n");
+		kmsg_info(13, "Linux is running under KVM in 64-bit mode\n");
 		add_preferred_console("hvc", 0, NULL);
 		s390_virtio_console_init();
 	} else
-		printk("We are running native (64 bit mode)\n");
+		kmsg_info(12, "Linux is running natively in 64-bit mode\n");
 #endif /* CONFIG_64BIT */
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */
Index: quilt-2.6/Documentation/s390/kmsg/setup
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/setup
@@ -0,0 +1,164 @@
+/*?
+ * Tag: setup.1
+ * Text: "Execute protection active, mvcos available"
+ * Severity: Informational
+ * Description:
+ * The kernel parameter 'noexec' has been specified. The kernel will
+ * honor the execute bit of mappings and will use the mvcos instruction
+ * to copy between the user and kernel address space.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.2
+ * Text: "Execute protection active, mvcos not available"
+ * Severity: Informational
+ * Description:
+ * The kernel parameter 'noexec' has been specified. The kernel will
+ * honor the execute bit of mappings. The mvcos instruction is not
+ * available and the kernel will use the slower page table walk method
+ * to copy between the user and kernel address space.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.3
+ * Text: "Address spaces switched, mvcos available"
+ * Severity: Informational
+ * Description:
+ * The kernel parameter 'switch_amode' has been specified. The kernel
+ * will use the primary address space for user space processes and the
+ * home address space for the kernel. The mvcos instruction is used to
+ * copy between the user and kernel address space.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.4
+ * Text: "Address spaces switched, mvcos not available"
+ * Severity: Informational
+ * Description:
+ * The kernel parameter 'switch_amode' has been specified. The kernel
+ * will use the primary address space for user space processes and the
+ * home address space for the kernel. The mvcos instruction is not
+ * available and the kernel will use the slower page table walk method
+ * to copy between the user and kernel address space.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.5
+ * Text: "initrd extends beyond end of memory (0x%08lx > 0x%08lx) disabling initrd"
+ * Severity: Error
+ * Parameter:
+ *   @1: start address of the initial RAM disk
+ *   @2: memory end address
+ * Description:
+ * The load address and the size of the initial RAM disk result in an end
+ * address of the initial RAM disk that is beyond the end of the system
+ * memory.
+ * User action:
+ * Lower the load address of the initial RAM disk, reduce the size of the
+ * initial RAM disk, or increase the size if the system memory to make the
+ * initial RAM disk fit into the memory.
+ */
+
+/*?
+ * Tag: setup.6
+ * Text: "Moving initrd (0x%08lx -> 0x%08lx, size: %ld)"
+ * Severity: Informational
+ * Parameter:
+ *   @1: old start address of the initial RAM disk
+ *   @2: new start address of the initial RAM disk
+ *   @3: size of the initial RAM disk
+ * Description:
+ * The location of the initial RAM disk conflicted with the boot memory bitmap.
+ * To resolve the conflict the initial RAM disk has been moved to a new
+ * location.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.7
+ * Text: "Linux is running as a z/VM guest operating system in 31-bit mode"
+ * Severity: Informational
+ * Description:
+ * The 31-bit Linux kernel detected that it is running as a guest operating
+ * system of the z/VM hypervisor.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.8
+ * Text: "Linux is running natively in 31-bit mode"
+ * Severity: Informational
+ * Description:
+ * The 31-bit Linux kernel detected that it is running on an IBM mainframe,
+ * either as the sole operating system in an LPAR or as the sole operating
+ * system on the entire mainframe. The Linux kernel is not running as a
+ * guest operating system of the z/VM hypervisor.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.9
+ * Text: "The hardware system has IEEE compatible floating point units"
+ * Severity: Informational
+ * Description:
+ * The Linux kernel detected that it is running on a hardware system with
+ * CPUs that have IEEE compatible floating point units.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.10
+ * Text: "The hardware system has no IEEE compatible floating point units"
+ * Severity: Informational
+ * Description:
+ * The Linux kernel detected that it is running on a hardware system with
+ * CPUs that do not have IEEE compatible floating point units.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.11
+ * Text: "Linux is running as a z/VM guest operating system in 64-bit mode"
+ * Severity: Informational
+ * Description:
+ * The 64-bit Linux kernel detected that it is running as a guest operating
+ * system of the z/VM hypervisor.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.12
+ * Text: "Linux is running natively in 64-bit mode"
+ * Severity: Informational
+ * Description:
+ * The 64-bit Linux kernel detected that it is running on an IBM mainframe,
+ * either as the sole operating system in an LPAR or as the sole operating
+ * system on the entire mainframe. The Linux kernel is not running as a
+ * guest operating system of the z/VM hypervisor.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: setup.13
+ * Text: "Linux is running under KVM in 64-bit mode"
+ * Severity: Informational
+ * Description:
+ * The 64-bit kernel detected that it is running under the KVM hypervisor.
+ * User action:
+ * None.
+ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
