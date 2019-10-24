Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407532AbfJXLlz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:41:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb8UI137705
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vub4qgea3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:41:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:41:51 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 02/37] s390/protvirt: introduce host side setup
Date: Thu, 24 Oct 2019 07:40:24 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

From: Vasily Gorbik <gor@linux.ibm.com>

Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
protected virtual machines hosting support code.

Add "prot_virt" command line option which controls if the kernel
protected VMs support is enabled at runtime.

Extend ultravisor info definitions and expose it via uv_info struct
filled in during startup.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 arch/s390/boot/Makefile                       |  2 +-
 arch/s390/boot/uv.c                           | 20 +++++++-
 arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
 arch/s390/kernel/Makefile                     |  1 +
 arch/s390/kernel/setup.c                      |  4 --
 arch/s390/kernel/uv.c                         | 48 +++++++++++++++++++
 arch/s390/kvm/Kconfig                         |  9 ++++
 8 files changed, 126 insertions(+), 9 deletions(-)
 create mode 100644 arch/s390/kernel/uv.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..aa22e36b3105 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3693,6 +3693,11 @@
 			before loading.
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
+	prot_virt=	[S390] enable hosting protected virtual machines
+			isolated from the hypervisor (if hardware supports
+			that).
+			Format: <bool>
+
 	psi=		[KNL] Enable or disable pressure stall information
 			tracking.
 			Format: <bool>
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index e2c47d3a1c89..82247e71617a 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -37,7 +37,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
 obj-y	+= version.o pgm_check_info.o ctype.o text_dma.o
-obj-$(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)	+= uv.o
+obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST))	+= uv.o
 obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 targets	:= bzImage startup.a section_cmp.boot.data section_cmp.boot.preserved.data $(obj-y)
diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index ed007f4a6444..88cf8825d169 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -3,7 +3,12 @@
 #include <asm/facility.h>
 #include <asm/sections.h>
 
+#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
 int __bootdata_preserved(prot_virt_guest);
+#endif
+#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
+struct uv_info __bootdata_preserved(uv_info);
+#endif
 
 void uv_query_info(void)
 {
@@ -18,7 +23,20 @@ void uv_query_info(void)
 	if (uv_call(0, (uint64_t)&uvcb))
 		return;
 
-	if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
+	if (IS_ENABLED(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST)) {
+		memcpy(uv_info.inst_calls_list, uvcb.inst_calls_list, sizeof(uv_info.inst_calls_list));
+		uv_info.uv_base_stor_len = uvcb.uv_base_stor_len;
+		uv_info.guest_base_stor_len = uvcb.conf_base_phys_stor_len;
+		uv_info.guest_virt_base_stor_len = uvcb.conf_base_virt_stor_len;
+		uv_info.guest_virt_var_stor_len = uvcb.conf_virt_var_stor_len;
+		uv_info.guest_cpu_stor_len = uvcb.cpu_stor_len;
+		uv_info.max_sec_stor_addr = ALIGN(uvcb.max_guest_stor_addr, PAGE_SIZE);
+		uv_info.max_num_sec_conf = uvcb.max_num_sec_conf;
+		uv_info.max_guest_cpus = uvcb.max_guest_cpus;
+	}
+
+	if (IS_ENABLED(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) &&
+	    test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
 	    test_bit_inv(BIT_UVC_CMD_REMOVE_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list))
 		prot_virt_guest = 1;
 }
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index ef3c00b049ab..6db1bc495e67 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -44,7 +44,19 @@ struct uv_cb_qui {
 	struct uv_cb_header header;
 	u64 reserved08;
 	u64 inst_calls_list[4];
-	u64 reserved30[15];
+	u64 reserved30[2];
+	u64 uv_base_stor_len;
+	u64 reserved48;
+	u64 conf_base_phys_stor_len;
+	u64 conf_base_virt_stor_len;
+	u64 conf_virt_var_stor_len;
+	u64 cpu_stor_len;
+	u32 reserved68[3];
+	u32 max_num_sec_conf;
+	u64 max_guest_stor_addr;
+	u8  reserved80[150-128];
+	u16 max_guest_cpus;
+	u64 reserved98;
 } __packed __aligned(8);
 
 struct uv_cb_share {
@@ -69,9 +81,21 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
 	return cc;
 }
 
-#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
+struct uv_info {
+	unsigned long inst_calls_list[4];
+	unsigned long uv_base_stor_len;
+	unsigned long guest_base_stor_len;
+	unsigned long guest_virt_base_stor_len;
+	unsigned long guest_virt_var_stor_len;
+	unsigned long guest_cpu_stor_len;
+	unsigned long max_sec_stor_addr;
+	unsigned int max_num_sec_conf;
+	unsigned short max_guest_cpus;
+};
+extern struct uv_info uv_info;
 extern int prot_virt_guest;
 
+#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
 static inline int is_prot_virt_guest(void)
 {
 	return prot_virt_guest;
@@ -121,11 +145,27 @@ static inline int uv_remove_shared(unsigned long addr)
 	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
 }
 
-void uv_query_info(void);
 #else
 #define is_prot_virt_guest() 0
 static inline int uv_set_shared(unsigned long addr) { return 0; }
 static inline int uv_remove_shared(unsigned long addr) { return 0; }
+#endif
+
+#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
+extern int prot_virt_host;
+
+static inline int is_prot_virt_host(void)
+{
+	return prot_virt_host;
+}
+#else
+#define is_prot_virt_host() 0
+#endif
+
+#if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
+	defined(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST)
+void uv_query_info(void);
+#else
 static inline void uv_query_info(void) {}
 #endif
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 7edbbcd8228a..fe4fe475f526 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf_events.o perf_regs.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf_diag.o
 
 obj-$(CONFIG_TRACEPOINTS)	+= trace.o
+obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST))	+= uv.o
 
 # vdso
 obj-y				+= vdso64/
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 3ff291bc63b7..f36370f8af38 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -92,10 +92,6 @@ char elf_platform[ELF_PLATFORM_SIZE];
 
 unsigned long int_hwcap = 0;
 
-#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
-int __bootdata_preserved(prot_virt_guest);
-#endif
-
 int __bootdata(noexec_disabled);
 int __bootdata(memory_end_set);
 unsigned long __bootdata(memory_end);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
new file mode 100644
index 000000000000..35ce89695509
--- /dev/null
+++ b/arch/s390/kernel/uv.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Ultravisor functions and initialization
+ *
+ * Copyright IBM Corp. 2019
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/bitmap.h>
+#include <linux/memblock.h>
+#include <asm/facility.h>
+#include <asm/sections.h>
+#include <asm/uv.h>
+
+#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
+int __bootdata_preserved(prot_virt_guest);
+#endif
+
+#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
+int prot_virt_host;
+EXPORT_SYMBOL(prot_virt_host);
+struct uv_info __bootdata_preserved(uv_info);
+EXPORT_SYMBOL(uv_info);
+
+static int __init prot_virt_setup(char *val)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(val, &enabled);
+	if (!rc && enabled)
+		prot_virt_host = 1;
+
+	if (is_prot_virt_guest() && prot_virt_host) {
+		prot_virt_host = 0;
+		pr_info("Running as protected virtualization guest.");
+	}
+
+	if (prot_virt_host && !test_facility(158)) {
+		prot_virt_host = 0;
+		pr_info("The ultravisor call facility is not available.");
+	}
+
+	return rc;
+}
+early_param("prot_virt", prot_virt_setup);
+#endif
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index d3db3d7ed077..652b36f0efca 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -55,6 +55,15 @@ config KVM_S390_UCONTROL
 
 	  If unsure, say N.
 
+config KVM_S390_PROTECTED_VIRTUALIZATION_HOST
+	bool "Protected guests execution support"
+	depends on KVM
+	---help---
+	  Support hosting protected virtual machines isolated from the
+	  hypervisor.
+
+	  If unsure, say Y.
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source "drivers/vhost/Kconfig"
-- 
2.20.1
