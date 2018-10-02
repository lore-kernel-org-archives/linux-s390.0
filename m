From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:48 +0000
Subject: [GIT PULL 21/28] KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-1
Message-Id: <20181002070655.224110-22-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest schedules a SIE with a FORMAT-0 CRYCB,
we are able to schedule it in the host with a FORMAT-1
CRYCB if the host uses FORMAT-1 or FORMAT-0.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-22-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 67a5536637bb..90ae31072991 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -220,11 +220,17 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 	case CRYCB_FORMAT0:
 		if ((crycb_o & PAGE_MASK) != ((crycb_o + 32) & PAGE_MASK))
 			return -EACCES;
-		if (fmt_h != CRYCB_FORMAT0)
+
+		switch (fmt_h) {
+		case CRYCB_FORMAT2:
 			return -EINVAL;
-		return setup_apcb00(vcpu, (unsigned long *) &crycb_s->apcb0,
-				    (unsigned long) &crycb->apcb0,
-				    (unsigned long *) &crycb_h->apcb0);
+		case CRYCB_FORMAT1:
+		case CRYCB_FORMAT0:
+			return setup_apcb00(vcpu,
+					    (unsigned long *) &crycb_s->apcb0,
+					    (unsigned long) &crycb->apcb0,
+					    (unsigned long *) &crycb_h->apcb0);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.17.0
