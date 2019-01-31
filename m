From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 01/15] KVM: s390: drop obsolete else path
Date: Thu, 31 Jan 2019 09:52:32 +0100
Message-ID: <20190131085247.13826-2-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The explicit else path specified in set_intercept_indicators_io
is not required as the function returns in case the first branch
is taken anyway.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b02990e..19d556512452 100644
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
2.13.4
