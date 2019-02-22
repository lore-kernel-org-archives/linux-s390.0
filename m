From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:17 +0000
Subject: [GIT PULL 06/18] KVM: s390: use pending_irqs_no_gisa() where appropriate
Message-Id: <1550835749-26436-7-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Interruption types that are not represented in GISA shall
use pending_irqs_no_gisa() to test pending interruptions.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-6-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 005dbe7..cb48736 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -353,7 +353,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs(vcpu) & IRQ_PEND_EXT_MASK))
+	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_EXT_MASK))
 		return;
 	if (psw_extint_disabled(vcpu))
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
@@ -363,7 +363,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
+	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_MCHK_MASK))
 		return;
 	if (psw_mchk_disabled(vcpu))
 		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
-- 
2.7.4
