From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/7] KVM: s390/CPACF: Choose crypto control block format
Date: Wed,  4 Feb 2015 10:44:49 +0100
Message-ID: <1423043092-34044-5-git-send-email-borntraeger@de.ibm.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

We need to specify a different format for the crypto control block
depending on whether the APXA facility is installed or not. Let's test
for it by executing the PQAP(QCI) function and use either a format-1 or
a format-2 crypto control block accordingly.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 49 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d1ecc7f..09b6c1f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -163,6 +163,7 @@ struct kvm_s390_sie_block {
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT1 0x00000001
+#define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
@@ -515,6 +516,7 @@ struct kvm_s390_crypto_cb {
 	__u8    reserved00[72];                 /* 0x0000 */
 	__u8    dea_wrapping_key_mask[24];      /* 0x0048 */
 	__u8    aes_wrapping_key_mask[32];      /* 0x0060 */
+	__u8    reserved80[128];                /* 0x0080 */
 };
 
 struct kvm_arch{
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 57f5538..57ba533 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -653,6 +653,52 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
+static int kvm_s390_query_ap_config(u8 *config)
+{
+	u32 fcn_code = 0x04000000UL;
+	u32 cc;
+
+	asm volatile(
+		"lgr 0,%1\n"
+		"lgr 2,%2\n"
+		".long 0xb2af0000\n"		/* PQAP(QCI) */
+		"ipm %0\n"
+		"srl %0,28\n"
+		: "=r" (cc)
+		: "r" (fcn_code), "r" (config)
+		: "cc", "0", "2", "memory"
+	);
+
+	return cc;
+}
+
+static int kvm_s390_apxa_installed(void)
+{
+	u8 config[128];
+	int cc;
+
+	if (test_facility(2) && test_facility(12)) {
+		cc = kvm_s390_query_ap_config(config);
+
+		if (cc)
+			pr_err("PQAP(QCI) failed with cc=%d", cc);
+		else
+			return config[0] & 0x40;
+	}
+
+	return 0;
+}
+
+static void kvm_s390_set_crycb_format(struct kvm *kvm)
+{
+	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
+
+	if (kvm_s390_apxa_installed())
+		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
+	else
+		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
+}
+
 static int kvm_s390_crypto_init(struct kvm *kvm)
 {
 	if (!test_vfacility(76))
@@ -663,8 +709,7 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 	if (!kvm->arch.crypto.crycb)
 		return -ENOMEM;
 
-	kvm->arch.crypto.crycbd = (__u32) (unsigned long) kvm->arch.crypto.crycb |
-				  CRYCB_FORMAT1;
+	kvm_s390_set_crycb_format(kvm);
 
 	/* Disable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 0;
-- 
1.9.3
