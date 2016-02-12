From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/18] KVM: s390: allow sync of fp registers via vregs
Date: Fri, 12 Feb 2016 14:22:45 +0100
Message-ID: <1455283382-62999-2-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If we have MACHINE_HAS_VX, the floating point registers are stored
in the vector register format, event if the guest isn't enabled for vector
registers. So we can allow KVM_SYNC_VRS as soon as MACHINE_HAS_VX is
available.

This can in return be used by user space to support floating point
registers via struct kvm_run when the machine has vector registers.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4af21c7..8fcdf98 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1414,7 +1414,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_PFAULT;
 	if (test_kvm_facility(vcpu->kvm, 64))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
-	if (test_kvm_facility(vcpu->kvm, 129))
+	/* fprs can be synchronized via vrs, even if the guest has no vx. With
+	 * MACHINE_HAS_VX, (load|store)_fpu_regs() will work with vrs format.
+	 */
+	if (MACHINE_HAS_VX)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm))
-- 
2.3.0
