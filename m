From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/10] KVM: s390: kvm_arch_vcpu_runnable already cares about timer interrupts
Date: Tue, 13 Oct 2015 16:06:02 +0200
Message-ID: <1444745168-21479-5-git-send-email-borntraeger@de.ibm.com>
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

We can remove that double check.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4f05520..1260f8c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -839,7 +839,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	vcpu->stat.exit_wait_state++;
 
 	/* fast path */
-	if (kvm_cpu_has_pending_timer(vcpu) || kvm_arch_vcpu_runnable(vcpu))
+	if (kvm_arch_vcpu_runnable(vcpu))
 		return 0;
 
 	if (psw_interrupts_disabled(vcpu)) {
-- 
2.4.3
