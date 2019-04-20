Return-Path: <SRS0=agSP=SW=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 6/8] s390: kvm: test CRYCB masks before setting them
Date: Sat, 20 Apr 2019 17:49:38 -0400
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1555796980-27920-7-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There is no sense in blocking all vCPUs to set the masks in the guest's
CRYCB if the mask values will not be changed, so let's verify

Let's verify that mask values will be changed before blocking all vCPUs
in order to set the crypto masks in the guest's CRYCB.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4638303ba6a8..38835717c815 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2217,12 +2217,43 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+static int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
+				      unsigned long *aqm, unsigned long *adm)
+{
+	int ret;
+	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
+		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 256);
+		ret &= bitmap_equal(aqm,
+				    (unsigned long *)crycb->apcb1.aqm, 256);
+		ret &= bitmap_equal(adm,
+				    (unsigned long *)crycb->apcb1.adm, 256);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
+		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb0.apm, 64);
+		ret &= bitmap_equal(aqm, (unsigned long *)crycb->apcb0.aqm, 16);
+		ret &= bitmap_equal(adm, (unsigned long *)crycb->apcb0.adm, 16);
+		break;
+	default:	/* Can not happen */
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
 void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 			       unsigned long *aqm, unsigned long *adm)
 {
 	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
 
 	mutex_lock(&kvm->lock);
+	if (kvm_arch_crypto_test_masks(kvm, apm, aqm, adm)) {
+		mutex_unlock(&kvm->lock);
+		return;
+	}
 	kvm_s390_vcpu_block_all(kvm);
 
 	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
-- 
2.7.4
