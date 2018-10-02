From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:47 +0000
Subject: [GIT PULL 20/28] KVM: s390: vsie: allow CRYCB FORMAT-0
Message-Id: <20181002070655.224110-21-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the host and the guest both use a FORMAT-0 CRYCB,
we copy the guest's FORMAT-0 APCB to a shadow CRYCB
for use by vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-21-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0a26814c6efe..67a5536637bb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,7 +136,15 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/* Copy to APCB FORMAT0 from APCB FORMAT0 */
+/**
+ * setup_apcb00 - Copy to APCB FORMAT0 from APCB FORMAT0
+ * @vcpu: pointer to the virtual CPU
+ * @apcb_s: pointer to start of apcb in the shadow crycb
+ * @apcb_o: pointer to start of original apcb in the guest2
+ * @apcb_h: pointer to start of apcb in the guest1
+ *
+ * Returns 0 and -EFAULT on error reading guest apcb
+ */
 static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			unsigned long apcb_o, unsigned long *apcb_h)
 {
@@ -209,6 +217,14 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
 				    (unsigned long) &crycb->apcb0,
 				    (unsigned long *) &crycb_h->apcb0);
+	case CRYCB_FORMAT0:
+		if ((crycb_o & PAGE_MASK) != ((crycb_o + 32) & PAGE_MASK))
+			return -EACCES;
+		if (fmt_h != CRYCB_FORMAT0)
+			return -EINVAL;
+		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
+				    (unsigned long) &crycb->apcb0,
+				    (unsigned long *) &crycb_h->apcb0);
 	}
 	return -EINVAL;
 }
@@ -248,8 +264,6 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	int ret = 0;
 
 	scb_s->crycbd = 0;
-	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
-		return 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
 	if (!apie_h && !key_msk)
-- 
2.17.0
