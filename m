From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 19 Nov 2018 17:25:29 +0000
Subject: [PATCH v2 05/12] KVM: s390: add metric vcpus_in_sie to struct kvm_arch
Message-Id: <20181119172536.52649-6-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This metric will allow to identify how many vcpus are currently
running for a given kvm in SIE context. Its value is between 0 and
the number of vcpus defined for the kvm guest, but never lager than
the number of cpus available to the KVM host in total.

This metric is required to decide if the GISA IAM has to be restored
from the kvm arch field of the guest. That will be the case when no
vcpu is in SIE context. (vcpus_in_sie == 0)

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 537e5e59f27e..02227457945e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -848,6 +848,7 @@ struct kvm_arch{
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
 	int gib_in_use;
+	atomic_t vcpus_in_sie;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a4ba9fa582fe..3adffce27550 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3458,6 +3458,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 		kvm_s390_patch_guest_per_regs(vcpu);
 	}
 
+	atomic_inc(&vcpu->kvm->arch.vcpus_in_sie);
+
 	vcpu->arch.sie_block->icptcode = 0;
 	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
@@ -3517,6 +3519,8 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
 	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
 
+	atomic_dec(&vcpu->kvm->arch.vcpus_in_sie);
+
 	if (exit_reason == -EINTR) {
 		VCPU_EVENT(vcpu, 3, "%s", "machine check");
 		sie_page = container_of(vcpu->arch.sie_block,
-- 
2.13.4
