From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 03/26] KVM: s390: refactor crypto initialization
Date: Tue, 25 Sep 2018 19:16:18 -0400
Message-ID: <20180925231641.4954-4-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

This patch refactors the code that initializes and sets up the
crypto configuration for a guest. The following changes are
implemented via this patch:

1. Introduces a flag indicating AP instructions executed on
   the guest shall be interpreted by the firmware. This flag
   is used to set a bit in the guest's state description
   indicating AP instructions are to be interpreted.

2. Replace code implementing AP interfaces with code supplied
   by the AP bus to query the AP configuration.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++
 arch/s390/kvm/kvm-s390.c         | 70 +++++++++++++++-----------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 75d39628f21d..79fa0a3a777f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
 #define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
@@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
 	__u8	reservede4[4];		/* 0x00e4 */
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
+#define CRYCB_FORMAT_MASK 0x00000003
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
@@ -716,6 +718,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 876fbb2b0c04..d62f6d840f8c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -40,6 +40,7 @@
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
 #include <asm/timex.h>
+#include <asm/ap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -1995,49 +1996,37 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
 static int kvm_s390_apxa_installed(void)
 {
-	u8 config[128];
-	int cc;
+	struct ap_config_info info;
 
-	if (test_facility(12)) {
-		cc = kvm_s390_query_ap_config(config);
-
-		if (cc)
-			pr_err("PQAP(QCI) failed with cc=%d", cc);
-		else
-			return config[0] & 0x40;
+	if (ap_instructions_available()) {
+		if (ap_qci(&info) == 0)
+			return info.apxa;
 	}
 
 	return 0;
 }
 
+/*
+ * The format of the crypto control block (CRYCB) is specified in the 3 low
+ * order bits of the CRYCB designation (CRYCBD) field as follows:
+ * Format 0: Neither the message security assist extension 3 (MSAX3) nor the
+ *	     AP extended addressing (APXA) facility are installed.
+ * Format 1: The APXA facility is not installed but the MSAX3 facility is.
+ * Format 2: Both the APXA and MSAX3 facilities are installed
+ */
 static void kvm_s390_set_crycb_format(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
 
+	/* Clear the CRYCB format bits - i.e., set format 0 by default */
+	kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK);
+
+	/* Check whether MSAX3 is installed */
+	if (!test_kvm_facility(kvm, 76))
+		return;
+
 	if (kvm_s390_apxa_installed())
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
 	else
@@ -2055,12 +2044,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
-	if (!test_kvm_facility(kvm, 76))
-		return;
-
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
 
+	if (!test_kvm_facility(kvm, 76))
+		return;
+
 	/* Enable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 1;
 	kvm->arch.crypto.dea_kw = 1;
@@ -2586,17 +2575,24 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
-	if (!test_kvm_facility(vcpu->kvm, 76))
+	/*
+	 * If the AP instructions are not being interpreted and the MSAX3
+	 * facility is not configured for the guest, there is nothing to set up.
+	 */
+	if (!vcpu->kvm->arch.crypto.apie && !test_kvm_facility(vcpu->kvm, 76))
 		return;
 
+	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
 
+	if (vcpu->kvm->arch.crypto.apie)
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
+	/* Set up protected key support */
 	if (vcpu->kvm->arch.crypto.aes_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
 	if (vcpu->kvm->arch.crypto.dea_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
-
-	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 }
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
-- 
2.19.0.221.g150f307
