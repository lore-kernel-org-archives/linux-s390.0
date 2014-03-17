From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 1/2] KVM: s390: Removing untriggerable BUG_ONs
Date: Mon, 17 Mar 2014 12:13:59 +0100
Message-ID: <1395054840-52175-2-git-send-email-borntraeger@de.ibm.com>
References: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

The BUG_ON in kvm-s390.c is unreachable, as we get the vcpu per common code,
which itself does this from the private_data field of the file descriptor,
and there is no KVM_UNCREATE_VCPU.

The __{set,unset}_cpu_idle BUG_ONs are not triggerable because the vcpu
creation code already checks against KVM_MAX_VCPUS.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 --
 arch/s390/kvm/kvm-s390.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1d0f9d5..79d2e4f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -114,14 +114,12 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(vcpu->vcpu_id > KVM_MAX_VCPUS - 1);
 	atomic_set_mask(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 	set_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
 }
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(vcpu->vcpu_id > KVM_MAX_VCPUS - 1);
 	atomic_clear_mask(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 	clear_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9136f8d..6268357 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -949,8 +949,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 
-	BUG_ON(kvm_get_vcpu(vcpu->kvm, vcpu->vcpu_id) == NULL);
-
 	switch (kvm_run->exit_reason) {
 	case KVM_EXIT_S390_SIEIC:
 	case KVM_EXIT_UNKNOWN:
-- 
1.8.4.2
