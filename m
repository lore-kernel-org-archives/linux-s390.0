From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 02/21] KVM: s390: make local function static
Date: Thu, 15 Jan 2015 14:43:15 +0100
Message-ID: <1421329414-76826-3-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

sparse rightfully complains about
warning: symbol '__inject_extcall' was not declared. Should it be static?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f00f31e..a845e35 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -984,7 +984,7 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_extcall_info *extcall = &li->irq.extcall;
-- 
1.9.3
