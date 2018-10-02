From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:50 +0000
Subject: [GIT PULL 23/28] KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-2
Message-Id: <20181002070655.224110-24-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest schedules a SIE with a FORMAT-0 CRYCB,
we are able to schedule it in the host with a FORMAT-2
CRYCB if the host uses FORMAT-2

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-24-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ca6466304731..9117891651c6 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -246,7 +246,9 @@ static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
 
 		switch (fmt_h) {
 		case CRYCB_FORMAT2:
-			return -EINVAL;
+			return setup_apcb10(vcpu, &crycb_s->apcb1,
+					    (unsigned long) &crycb->apcb0,
+					    &crycb_h->apcb1);
 		case CRYCB_FORMAT1:
 		case CRYCB_FORMAT0:
 			return setup_apcb00(vcpu,
-- 
2.17.0
