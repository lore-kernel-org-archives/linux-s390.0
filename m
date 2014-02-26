From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/3] KVM: add kvm_arch_vcpu_runnable() test to kvm_vcpu_on_spin() loop
Date: Wed, 26 Feb 2014 16:14:18 +0100
Message-ID: <1393427659-42501-3-git-send-email-borntraeger@de.ibm.com>
References: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Use the arch specific function kvm_arch_vcpu_runnable() to add a further
criterium to identify a suitable vcpu to yield to during undirected yield
processing.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f5668a4..5fd4cf8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1801,7 +1801,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq))
+			if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
-- 
1.8.4.2
