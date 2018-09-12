From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v10 23/26] KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-2
Date: Wed, 12 Sep 2018 15:43:13 -0400
Message-ID: <1536781396-13601-24-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest schedules a SIE with a FORMAT-0 CRYCB,
we are able to schedule it in the host with a FORMAT-2
CRYCB if the host uses FORMAT-2

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ca64663..9117891 100644
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
1.7.1
