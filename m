From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v10 20/26] KVM: s390: vsie: allow CRYCB FORMAT-0
Date: Wed, 12 Sep 2018 15:43:10 -0400
Message-ID: <1536781396-13601-21-git-send-email-akrowiak@linux.vnet.ibm.com>
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

When the host and the guest both use a FORMAT-0 CRYCB,
we copy the guest's FORMAT-0 APCB to a shadow CRYCB
for use by vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0a26814..67a5536 100644
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
1.7.1
