From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/10] KVM: s390: disabled wait cares about machine checks, not PER
Date: Tue, 13 Oct 2015 16:06:00 +0200
Message-ID: <1444745168-21479-3-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We don't care about program event recording irqs (synchronous
program irqs) but asynchronous irqs when checking for disabled
wait. Machine checks were missing.

Let's directly switch to the functions we have for that purpose
instead of testing once again for magic bits.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ab9f525..1058240 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -51,11 +51,9 @@ static int psw_mchk_disabled(struct kvm_vcpu *vcpu)
 
 static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 {
-	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER) ||
-	    (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_IO) ||
-	    (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT))
-		return 0;
-	return 1;
+	return psw_extint_disabled(vcpu) &&
+	       psw_ioint_disabled(vcpu) &&
+	       psw_mchk_disabled(vcpu);
 }
 
 static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
-- 
2.4.3
