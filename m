From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:13 +0000
Subject: [GIT PULL 02/18] KVM: s390: drop obsolete else path
Message-Id: <1550835749-26436-3-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

The explicit else path specified in set_intercept_indicators_io
is not required as the function returns in case the first branch
is taken anyway.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-2-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b0..19d5565 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -345,7 +345,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 {
 	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
 		return;
-	else if (psw_ioint_disabled(vcpu))
+	if (psw_ioint_disabled(vcpu))
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
 	else
 		vcpu->arch.sie_block->lctl |= LCTL_CR6;
-- 
2.7.4
