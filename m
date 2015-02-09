From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/7] KVM: s390: floating irqs: fix user triggerable endless loop
Date: Mon,  9 Feb 2015 13:33:41 +0100
Message-ID: <1423485227-51721-2-git-send-email-borntraeger@de.ibm.com>
References: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.15+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If a vm with no VCPUs is created, the injection of a floating irq
leads to an endless loop in the kernel.

Let's skip the search for a destination VCPU for a floating irq if no
VCPUs were created.

Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c34e1d9..073b5f3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1244,6 +1244,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 		list_add_tail(&inti->list, &iter->list);
 	}
 	atomic_set(&fi->active, 1);
+	if (atomic_read(&kvm->online_vcpus) == 0)
+		goto unlock_fi;
 	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
 	if (sigcpu == KVM_MAX_VCPUS) {
 		do {
-- 
1.9.3
