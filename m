From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 05/15] KVM: s390: use pending_irqs_no_gisa() where appropriate
Date: Thu, 31 Jan 2019 09:52:36 +0100
Message-ID: <20190131085247.13826-6-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Interruption types that are not represented in GISA shall
use pending_irqs_no_gisa() to test pending interruptions.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 005dbe7252e7..cb48736867ed 100644
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
2.13.4
