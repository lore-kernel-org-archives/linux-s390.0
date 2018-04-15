From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
Date: Sun, 15 Apr 2018 17:22:13 -0400
Message-ID: <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch refactors the code that initializes the crypto
configuration for a guest. The crypto configuration is contained in
a crypto control block (CRYCB) which is a satellite control block to
our main hardware virtualization control block. The CRYCB is
attached to the main virtualization control block via a CRYCB
designation (CRYCBD) designation field containing the address of
the CRYCB as well as its format.

Prior to the introduction of AP device virtualization, there was
no need to provide access to or specify the format of the CRYCB for
a guest unless the MSA extension 3 (MSAX3) facility was installed
on the host system. With the introduction of AP device virtualization,
the CRYCB and its format must be made accessible to the guest
regardless of the presence of the MSAX3 facility.

The crypto initialization code is restructured as follows:

* A new compilation unit is introduced to contain all interfaces
  and data structures related to configuring a guest's CRYCB for
  both the refactoring of crypto initialization as well as all
  subsequent patches introducing AP virtualization support.

* Currently, the asm code for querying the AP configuration is
  duplicated in the AP bus as well as in KVM. Since the KVM
  code was introduced, the AP bus has externalized the interface
  for querying the AP configuration. The KVM interface will be
  replaced with a call to the AP bus interface. Of course, this
  will be moved to the new compilation unit mentioned above.

* An interface to format the CRYCBD field will be provided via
  the new compilation unit and called from the KVM vm
  initialization.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h   |   15 +++++++++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-ap.c           |   39 ++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |   60 ++++----------------------------------
 4 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 84412a9..736e93e 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -10,6 +10,9 @@
 #ifndef _ASM_KVM_AP
 #define _ASM_KVM_AP
 
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+
 /**
  * kvm_ap_instructions_installed()
  *
@@ -20,4 +23,16 @@
  */
 int kvm_ap_instructions_installed(void);
 
+/**
+ * kvm_ap_build_crycbd
+ *
+ * The crypto control block designation (CRYCBD) is a 32-bit field that
+ * designates both the host real address and format of the CRYCB. This function
+ * builds the CRYCBD field for use by the KVM guest.
+ *
+ * @kvm:	the KVM guest
+ * @crycbd:	reference to the CRYCBD
+ */
+void kvm_ap_build_crycbd(struct kvm *kvm);
+
 #endif /* _ASM_KVM_AP */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 81cdb6b..c990a1d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
+#define CRYCB_FORMAT_MASK 0x00000003
 	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index 1267588..991bae4 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -10,6 +10,8 @@
 #include <asm/kvm-ap.h>
 #include <asm/ap.h>
 
+#include "kvm-s390.h"
+
 int kvm_ap_instructions_installed(void)
 {
 #ifdef CONFIG_ZCRYPT
@@ -19,3 +21,40 @@ int kvm_ap_instructions_installed(void)
 #endif
 }
 EXPORT_SYMBOL(kvm_ap_instructions_installed);
+
+static inline int kvm_ap_query_config(struct ap_config_info *config)
+{
+	memset(config, 0, sizeof(*config));
+
+#ifdef CONFIG_ZCRYPT
+	if (kvm_ap_instructions_installed())
+		return ap_query_configuration(config);
+#endif
+
+	return -EOPNOTSUPP;
+}
+
+static int kvm_ap_apxa_installed(void)
+{
+	struct ap_config_info config;
+
+	if (kvm_ap_query_config(&config) == 0)
+		return (config.apxa == 1);
+
+	return 0;
+}
+
+void kvm_ap_build_crycbd(struct kvm *kvm)
+{
+	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
+	kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK);
+
+	/* check whether MSAX3 is installed */
+	if (kvm_ap_instructions_installed() && test_kvm_facility(kvm, 76)) {
+		if (kvm_ap_apxa_installed())
+			kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
+		else
+			kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
+	}
+}
+EXPORT_SYMBOL(kvm_ap_build_crycbd);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d0c3518..b47ff11 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -40,6 +40,7 @@
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
 #include <asm/timex.h>
+#include <asm/kvm-ap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -1881,55 +1882,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
-static void kvm_s390_set_crycb_format(struct kvm *kvm)
-{
-	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
-
-	if (kvm_s390_apxa_installed())
-		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
-	else
-		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
-}
-
 static u64 kvm_s390_get_initial_cpuid(void)
 {
 	struct cpuid cpuid;
@@ -1941,12 +1893,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
+	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
+	kvm_ap_build_crycbd(kvm);
+
 	if (!test_kvm_facility(kvm, 76))
 		return;
 
-	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
-	kvm_s390_set_crycb_format(kvm);
-
 	/* Enable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 1;
 	kvm->arch.crypto.dea_kw = 1;
@@ -2475,6 +2427,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
@@ -2484,8 +2438,6 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
 	if (vcpu->kvm->arch.crypto.dea_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
-
-	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 }
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
-- 
1.7.1
