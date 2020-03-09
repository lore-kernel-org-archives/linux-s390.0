Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbgCIA6G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Mar 2020 20:58:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0290t8lV047136
        for <linux-s390@vger.kernel.org>; Sun, 8 Mar 2020 20:58:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ym647uc78-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 08 Mar 2020 20:58:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 9 Mar 2020 00:58:03 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3] ima: add a new CONFIG for loading arch-specific policies
Date: Sun,  8 Mar 2020 20:57:51 -0400
Message-Id: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>

From: Nayna Jain <nayna@linux.vnet.ibm.com>

Every time a new architecture defines the IMA architecture specific
functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
include file needs to be updated. To avoid this "noise", this patch
defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
the different architectures to select it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
v3:
* Removes CONFIG_IMA dependency. Thanks Ard.
* Updated the patch with improvements suggested by Michael. It now uses
"imply" instead of "select". Thanks Michael.
* Replaced the CONFIG_IMA in x86 and s390 with new config, else it was
resulting in redefinition when the IMA_SECURE_AND_OR_TRUSTED_BOOT
is not enabled. Thanks to Mimi for identifying the problem.
* Removed "#ifdef EFI" check in the arch/x86/Makefile for compiling
ima_arch.c file.
* Ard, Thanks for your Acked-by. I have changed the arch/x86/Makefile in
this version. Can you please review again and confirm ?
* Rudo, Thanks for your review. I have changed arch/s390/Makefile as well.
Can you also please review again ?

v2:
* Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and Michael for
discussing the fix.

 arch/powerpc/Kconfig           | 1 +
 arch/s390/Kconfig              | 1 +
 arch/s390/kernel/Makefile      | 2 +-
 arch/x86/Kconfig               | 1 +
 arch/x86/kernel/Makefile       | 4 +---
 include/linux/ima.h            | 3 +--
 security/integrity/ima/Kconfig | 7 +++++++
 7 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..5b9f1cba2a44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
 	bool
 	depends on PPC_POWERNV
 	depends on IMA_ARCH_POLICY
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	help
 	  Systems with firmware secure boot enabled need to define security
 	  policies to extend secure boot to the OS. This config allows a user
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8abe77536d9d..59c216af6264 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -195,6 +195,7 @@ config S390
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select SWIOTLB
 	select GENERIC_ALLOCATOR
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 
 
 config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 2b1203cf7be6..578a6fa82ea4 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 
-obj-$(CONFIG_IMA)		+= ima_arch.o
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf_common.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..dcf5b1729f7c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c13809a..cfef37a27def 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -154,6 +154,4 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-y				+= vsmp_64.o
 endif
 
-ifdef CONFIG_EFI
-obj-$(CONFIG_IMA)			+= ima_arch.o
-endif
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1659217e9b60..aefe758f4466 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
-	|| defined(CONFIG_PPC_SECURE_BOOT)
+#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 3f3ee4e2eb0d..edde88dbe576 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -327,3 +327,10 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
 	depends on IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on SYSTEM_TRUSTED_KEYRING
 	default y
+
+config IMA_SECURE_AND_OR_TRUSTED_BOOT
+       bool
+       depends on IMA_ARCH_POLICY
+       help
+          This option is selected by architectures to enable secure and/or
+          trusted boot based on IMA runtime policies.
-- 
2.17.1
