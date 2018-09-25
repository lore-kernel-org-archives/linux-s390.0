From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v11 19/26] KVM: s390: vsie: allow CRYCB FORMAT-1
Date: Tue, 25 Sep 2018 19:16:34 -0400
Message-ID: <20180925231641.4954-20-akrowiak@linux.vnet.ibm.com>
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

When the host and guest both use a FORMAT-1 CRYCB, we copy
the guest's FORMAT-0 APCB to a shadow CRYCB for use by
vSIE.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
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
2.19.0.221.g150f307
