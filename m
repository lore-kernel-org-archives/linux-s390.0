Return-Path: <linux-kernel-owner+w=401wt.eu-S1760766AbZBYP0F@vger.kernel.org>
Message-Id: <20090225150831.798921881@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 17/46] Fix hypervisor detection for KVM
Content-Disposition: inline; filename=116-kvm-detection.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Currently we use the cpuid (via STIDP instruction) to recognize LPAR,
z/VM and KVM.
The architecture states, that bit 0-7 of STIDP returns all zero, and
if STIDP is executed in a virtual machine, the VM operating system
will replace bits 0-7 with FF.

KVM should not use FE to distinguish z/VM from KVM for interested
guests. The proper way to detect the hypervisor is the STSI (Store
System Information) instruction, which return information about the
hypervisors via function code 3, selector1=2, selector2=2.

This patch changes the detection routine of Linux to use STSI instead
of STIDP. This detection is earlier than bootmem, we have to use a
static buffer. Since STSI expects a 4kb block (4kb aligned) this
patch also changes the init.data alignment for s390. As this section
will be freed during boot, this should be no problem.

Patch is tested with LPAR, z/VM, KVM on LPAR, and KVM under z/VM.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/sysinfo.h |    1 +
 arch/s390/kernel/early.c        |   22 +++++++++++++---------
 arch/s390/kernel/vmlinux.lds.S  |    2 ++
 arch/s390/kvm/kvm-s390.c        |    2 +-
 4 files changed, 17 insertions(+), 10 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/sysinfo.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sysinfo.h
+++ quilt-2.6/arch/s390/include/asm/sysinfo.h
@@ -100,6 +100,7 @@ struct sysinfo_3_2_2 {
 		char reserved_1[24];
 
 	} vm[8];
+	char reserved_544[3552];
 };
 
 static inline int stsi(void *sysinfo, int fc, int sel1, int sel2)
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -6,6 +6,7 @@
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -20,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/sysinfo.h>
 #include <asm/cpcmd.h>
 #include <asm/sclp.h>
 #include "entry.h"
@@ -173,19 +175,21 @@ static noinline __init void init_kernel_
 		page_set_storage_key(init_pfn << PAGE_SHIFT, PAGE_DEFAULT_KEY);
 }
 
+static __initdata struct sysinfo_3_2_2 vmms __aligned(PAGE_SIZE);
+
 static noinline __init void detect_machine_type(void)
 {
-	struct cpuinfo_S390 *cpuinfo = &S390_lowcore.cpu_data;
-
-	get_cpu_id(&S390_lowcore.cpu_data.cpu_id);
-
-	/* Running under z/VM ? */
-	if (cpuinfo->cpu_id.version == 0xff)
-		machine_flags |= MACHINE_FLAG_VM;
+	/* No VM information? Looks like LPAR */
+	if (stsi(&vmms, 3, 2, 2) == -ENOSYS)
+		return;
+	if (!vmms.count)
+		return;
 
-	/* Running under KVM ? */
-	if (cpuinfo->cpu_id.version == 0xfe)
+	/* Running under KVM? If not we assume z/VM */
+	if (!memcmp(vmms.vm[0].cpi, "\xd2\xe5\xd4", 3))
 		machine_flags |= MACHINE_FLAG_KVM;
+	else
+		machine_flags |= MACHINE_FLAG_VM;
 }
 
 static __init void early_pgm_check_handler(void)
Index: quilt-2.6/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vmlinux.lds.S
+++ quilt-2.6/arch/s390/kernel/vmlinux.lds.S
@@ -108,6 +108,8 @@ SECTIONS
 		EXIT_TEXT
 	}
 
+	/* early.c uses stsi, which requires page aligned data. */
+	. = ALIGN(PAGE_SIZE);
 	.init.data : {
 		INIT_DATA
 	}
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c
@@ -286,7 +286,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu 
 	setup_timer(&vcpu->arch.ckc_timer, kvm_s390_idle_wakeup,
 		 (unsigned long) vcpu);
 	get_cpu_id(&vcpu->arch.cpu_id);
-	vcpu->arch.cpu_id.version = 0xfe;
+	vcpu->arch.cpu_id.version = 0xff;
 	return 0;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
