From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:02 +0000
Subject: [GIT PULL 16/19] KVM: s390: Beautify skey enable check
Message-Id: <20180731084405.28953-17-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's introduce an explicit check if skeys have already been enabled
for the vcpu, so we don't have to check the mm context if we don't have
the storage key facility.

This lets us check for enablement without having to take the mm
semaphore and thus speedup skey emulation.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/priv.c             | 10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1a7b6834797e..29c940bf8506 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -656,6 +656,7 @@ struct kvm_vcpu_arch {
 	seqcount_t cputm_seqcount;
 	__u64 cputm_start;
 	bool gs_enabled;
+	bool skey_enabled;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c623b6f1dd4e..63285b14ff31 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -205,13 +205,10 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 {
 	int rc;
-	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
 
 	trace_kvm_s390_skey_related_inst(vcpu);
 	/* Already enabled? */
-	if (vcpu->kvm->arch.use_skf &&
-	    !(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
-	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
+	if (vcpu->arch.skey_enabled)
 		return 0;
 
 	rc = s390_enable_skey();
@@ -222,9 +219,10 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 	if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
 		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
 	if (!vcpu->kvm->arch.use_skf)
-		sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+		vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 	else
-		sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+		vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+	vcpu->arch.skey_enabled = true;
 	return 0;
 }
 
-- 
2.17.0
