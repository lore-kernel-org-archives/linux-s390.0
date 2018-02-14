From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/6] KVM: s390: do not set intervention requests for GISA interrupts
Date: Wed, 14 Feb 2018 15:56:32 +0000
Message-ID: <20180214155636.60405-3-borntraeger@de.ibm.com>
References: <20180214155636.60405-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180214155636.60405-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

If GISA is available, we do not have to kick CPUs out of SIE to deliver
interrupts. The hardware can deliver such interrupts while running.

Cc: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 337a69bc04db..e399495001ca 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -236,10 +236,15 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
+static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.float_int.pending_irqs |
-		vcpu->arch.local_int.pending_irqs |
+		vcpu->arch.local_int.pending_irqs;
+}
+
+static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
+{
+	return pending_irqs_no_gisa(vcpu) |
 		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
 }
 
@@ -337,7 +342,7 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs(vcpu) & IRQ_PEND_IO_MASK))
+	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
 		return;
 	else if (psw_ioint_disabled(vcpu))
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
-- 
2.14.3
