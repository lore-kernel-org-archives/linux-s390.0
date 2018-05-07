From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v5 01/13] KVM: s390: Interface to test whether APXA installed
Date: Mon,  7 May 2018 11:11:40 -0400
Message-ID: <1525705912-12815-2-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Relocates an existing static function that tests whether
the AP extended addressing facility (APXA) is installed on
the linux host. The primary reason for relocating this
function is because a new compilation unit (arch/s390/kvm/kvm-ap.c)
is being created to contain all of the interfaces and logic
for configuring an AP matrix for a KVM guest. Some of its
functions will also need to determine whether APXA is installed,
so, let's go ahead and relocate this static function as a
public interface in kvm-ap.c.

Notes:
----
1. The interface to determine whether APXA is installed on the linux
   host the information returned from the AP Query Configuration
   Information (QCI) function. This function will not be available
   if the AP instructions are not installed on the linux host, so a check
   will be included to verify that.

2. Currently, the AP bus interfaces accessing the AP instructions will
   not be accessible if CONFIG_ZCRYPT=n, so the relevant code will be
   temporarily contained in the new arch/s390/kvm/kvm-ap.c file until
   the patch(es) to statically build the required AP bus interfaces are
   available.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS                    |    1 +
 arch/s390/include/asm/kvm-ap.h |   60 +++++++++++++++++++++++++++++
 arch/s390/kvm/Makefile         |    2 +-
 arch/s390/kvm/kvm-ap.c         |   83 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c       |   42 +-------------------
 5 files changed, 147 insertions(+), 41 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm-ap.h
 create mode 100644 arch/s390/kvm/kvm-ap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eab763f..224e97b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7792,6 +7792,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
+R:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
new file mode 100644
index 0000000..6af1ff8
--- /dev/null
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Adjunct Processor (AP) configuration management for KVM guests
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
+ */
+
+#ifndef _ASM_KVM_AP
+#define _ASM_KVM_AP
+
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+#include <asm/ap.h>
+
+/**
+ * kvm_ap_apxa_installed
+ *
+ * Returns 1 if the AP extended addressing facility (APXA) is installed on the
+ * linux host; otherwise, returns 0.
+ */
+int kvm_ap_apxa_installed(void);
+
+/**
+ * kvm_ap_query_configuration
+ *
+ * @info: stores the AP configuration information
+ *
+ * Executes the AP Query Configuration Information (QCI) function and stores
+ * the configuration information in @info.
+ *
+ * Returns 0 if the operation succeeds; otherwise returns an error. If the
+ * QCI facility is not installed, returns -EOPNOTSUPP.
+ *
+ * TODO:
+ * This interface is temporary until the ap_query_configuration() interface
+ * implemented in the AP bus becomes statically available. Currently, the
+ * bus interface will not be available if CONFIG_ZCRYPT or CONFIG_ZCRYPT_MODULE
+ * is not selected. Calls to this function should be replaced by a call to
+ * the AP bus ap_query_configuration() interface at that time.
+ */
+int kvm_ap_query_configuration(struct ap_config_info *info);
+
+/**
+ * kvm_ap_instructions_available
+ *
+ * Returns 1 if the AP instructions are installed on the linux host; otherwise,
+ * returns 0.
+ *
+ * TODO:
+ * This interface is temporary until the ap_instructions_available() interface
+ * implemented in the AP bus becomes statically available. Currently, the
+ * bus interface will not be available if CONFIG_ZCRYPT or CONFIG_ZCRYPT_MODULE
+ * is not selected. Calls to this function should be replaced by a call to
+ * the AP bus ap_instructions_available() interface at that time.
+ */
+bool kvm_ap_instructions_available(void);
+
+#endif /* _ASM_KVM_AP */
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 05ee90a..1876bfe 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -9,6 +9,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o guestdbg.o vsie.o
+kvm-objs += diag.o gaccess.o guestdbg.o vsie.o kvm-ap.o
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
new file mode 100644
index 0000000..00bcfb0
--- /dev/null
+++ b/arch/s390/kvm/kvm-ap.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Adjunct Processor (AP) configuration management for KVM guests
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
+ */
+#include <linux/kernel.h>
+#include <asm/kvm-ap.h>
+
+#include "kvm-s390.h"
+
+static int kvm_ap_qci(struct ap_config_info *info)
+{
+	register unsigned long reg0 asm ("0") = 0x04000000UL;
+	register unsigned long reg1 asm ("1") = -EINVAL;
+	register void *reg2 asm ("2") = (void *) info;
+
+	asm volatile(
+		".long 0xb2af0000\n"		/* PQAP(QCI) */
+		"0: la    %1,0\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+d" (reg0), "+d" (reg1), "+d" (reg2)
+		:
+		: "cc", "memory");
+
+	return reg1;
+}
+
+
+/**
+ * TODO:
+ * This interface is temporary until the ap_query_configuration() interface
+ * implemented in the AP bus becomes statically available. Currently, the
+ * bus interface will not be available if CONFIG_ZCRYPT or CONFIG_ZCRYPT_MODULE
+ * is not selected. Calls to this function should be replaced by a call to
+ * the AP bus ap_instructions_available() interface at that time.
+ */
+bool kvm_ap_instructions_available(void)
+{
+	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
+	register unsigned long reg1 asm ("1") = -ENODEV;
+	register unsigned long reg2 asm ("2") = 0UL;
+
+	asm volatile(
+		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
+		"0: la    %1,0\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "+d" (reg0), "+d" (reg1), "+d" (reg2) : : "cc");
+	return reg1 == 0;
+}
+EXPORT_SYMBOL(kvm_ap_instructions_available);
+
+/**
+ * TODO:
+ * This interface is temporary until the ap_query_configuration() interface
+ * implemented in the AP bus becomes statically available. Currently, the AP
+ * bus interface will not be available if CONFIG_ZCRYPT or CONFIG_ZCRYPT_MODULE
+ * is not selected. Calls to this function should be replaced by a call to
+ * the AP bus ap_query_configuration() interface at that time.
+ */
+int kvm_ap_query_configuration(struct ap_config_info *info)
+{
+	if (kvm_ap_instructions_available() && test_facility(12))
+		return kvm_ap_qci(info);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(kvm_ap_query_configuration);
+
+int kvm_ap_apxa_installed(void)
+{
+	struct ap_config_info info;
+
+	if (kvm_ap_query_configuration(&info) == 0)
+		return (info.apxa == 1);
+
+	return 0;
+}
+EXPORT_SYMBOL(kvm_ap_apxa_installed);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 64c9862..1f50de7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -40,6 +40,7 @@
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
 #include <asm/timex.h>
+#include <asm/kvm-ap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -1874,50 +1875,11 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
-static int kvm_s390_query_ap_config(u8 *config)
-{
-	u32 fcn_code = 0x04000000UL;
-	u32 cc = 0;
-
-	memset(config, 0, 128);
-	asm volatile(
-		"lgr 0,%1\n"
-		"lgr 2,%2\n"
-		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"0: ipm %0\n"
-		"srl %0,28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: "+r" (cc)
-		: "r" (fcn_code), "r" (config)
-		: "cc", "0", "2", "memory"
-	);
-
-	return cc;
-}
-
-static int kvm_s390_apxa_installed(void)
-{
-	u8 config[128];
-	int cc;
-
-	if (test_facility(12)) {
-		cc = kvm_s390_query_ap_config(config);
-
-		if (cc)
-			pr_err("PQAP(QCI) failed with cc=%d", cc);
-		else
-			return config[0] & 0x40;
-	}
-
-	return 0;
-}
-
 static void kvm_s390_set_crycb_format(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
 
-	if (kvm_s390_apxa_installed())
+	if (kvm_ap_apxa_installed())
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
 	else
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
-- 
1.7.1
