From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 21/26] KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-1
Date: Tue, 25 Sep 2018 19:16:36 -0400
Message-ID: <20180925231641.4954-22-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest schedules a SIE with a FORMAT-0 CRYCB,
we are able to schedule it in the host with a FORMAT-1
CRYCB if the host uses FORMAT-1 or FORMAT-0.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
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
2.19.0.221.g150f307
