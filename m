From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:49 +0000
Subject: [GIT PULL 22/28] KVM: s390: vsie: allow guest FORMAT-1 CRYCB on host FORMAT-2
Message-Id: <20181002070655.224110-23-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest schedules a SIE with a CRYCB FORMAT-1 CRYCB,
we are able to schedule it in the host with a FORMAT-2 CRYCB
if the host uses FORMAT-2.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-23-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 90ae31072991..ca6466304731 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -135,6 +135,22 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
 }
+/* Copy to APCB FORMAT1 from APCB FORMAT0 */
+static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
+			unsigned long apcb_o, struct kvm_s390_apcb1 *apcb_h)
+{
+	struct kvm_s390_apcb0 tmp;
+
+	if (read_guest_real(vcpu, apcb_o, &tmp, sizeof(struct kvm_s390_apcb0)))
+		return -EFAULT;
+
+	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
+	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
+	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
+
+	return 0;
+
+}
 
 /**
  * setup_apcb00 - Copy to APCB FORMAT0 from APCB FORMAT0
@@ -212,11 +228,18 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 				    (unsigned long) &crycb->apcb1,
 				    (unsigned long *)&crycb_h->apcb1);
 	case CRYCB_FORMAT1:
-		if (fmt_h != CRYCB_FORMAT1)
-			return -EINVAL;
-		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
-				    (unsigned long) &crycb->apcb0,
-				    (unsigned long *) &crycb_h->apcb0);
+		switch (fmt_h) {
+		case CRYCB_FORMAT2:
+			return setup_apcb10(vcpu, &crycb_s->apcb1,
+					    (unsigned long) &crycb->apcb0,
+					    &crycb_h->apcb1);
+		case CRYCB_FORMAT1:
+			return setup_apcb00(vcpu,
+					    (unsigned long *) &crycb_s->apcb0,
+					    (unsigned long) &crycb->apcb0,
+					    (unsigned long *) &crycb_h->apcb0);
+		}
+		break;
 	case CRYCB_FORMAT0:
 		if ((crycb_o & PAGE_MASK) != ((crycb_o + 32) & PAGE_MASK))
 			return -EACCES;
-- 
2.17.0
