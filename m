From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:46 +0000
Subject: [GIT PULL 19/28] KVM: s390: vsie: allow CRYCB FORMAT-1
Message-Id: <20181002070655.224110-20-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the host and guest both use a FORMAT-1 CRYCB, we copy
the guest's FORMAT-0 APCB to a shadow CRYCB for use by
vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-20-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3a932781e0b0..0a26814c6efe 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,6 +136,19 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/* Copy to APCB FORMAT0 from APCB FORMAT0 */
+static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
+			unsigned long apcb_o, unsigned long *apcb_h)
+{
+	if (read_guest_real(vcpu, apcb_o, apcb_s,
+			    sizeof(struct kvm_s390_apcb0)))
+		return -EFAULT;
+
+	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb0));
+
+	return 0;
+}
+
 /**
  * setup_apcb11 - Copy the FORMAT1 APCB from the guest to the shadow CRYCB
  * @vcpu: pointer to the virtual CPU
@@ -190,6 +203,12 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 		return setup_apcb11(vcpu, (unsigned long *)&crycb_s->apcb1,
 				    (unsigned long) &crycb->apcb1,
 				    (unsigned long *)&crycb_h->apcb1);
+	case CRYCB_FORMAT1:
+		if (fmt_h != CRYCB_FORMAT1)
+			return -EINVAL;
+		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
+				    (unsigned long) &crycb->apcb0,
+				    (unsigned long *) &crycb_h->apcb0);
 	}
 	return -EINVAL;
 }
-- 
2.17.0
