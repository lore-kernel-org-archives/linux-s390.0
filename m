From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/16] KVM: s390: clean up cmma_enable check
Date: Wed, 29 Jul 2015 11:05:53 +0200
Message-ID: <1438160766-108179-4-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

As we already only enable CMMA when userspace requests it, we can
safely move the additional checks to the request handler and avoid
doing them multiple times. This also tells userspace if CMMA is
available.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 21 +++++++--------------
 arch/s390/kvm/kvm-s390.h |  2 --
 arch/s390/kvm/priv.c     |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b77dcfe..641639b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -330,6 +330,11 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	unsigned int idx;
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_ENABLE_CMMA:
+		/* enable CMMA only for z10 and later (EDAT_1) */
+		ret = -EINVAL;
+		if (!MACHINE_IS_LPAR || !MACHINE_HAS_EDAT1)
+			break;
+
 		ret = -EBUSY;
 		mutex_lock(&kvm->lock);
 		if (atomic_read(&kvm->online_vcpus) == 0) {
@@ -1133,7 +1138,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_free(vcpu->arch.gmap);
 
-	if (kvm_s390_cmma_enabled(vcpu->kvm))
+	if (vcpu->kvm->arch.use_cmma)
 		kvm_s390_vcpu_unsetup_cmma(vcpu);
 	free_page((unsigned long)(vcpu->arch.sie_block));
 
@@ -1344,7 +1349,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	}
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
-	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
+	if (vcpu->kvm->arch.use_cmma) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
 		if (rc)
 			return rc;
@@ -1725,18 +1730,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-bool kvm_s390_cmma_enabled(struct kvm *kvm)
-{
-	if (!MACHINE_IS_LPAR)
-		return false;
-	/* only enable for z10 and later */
-	if (!MACHINE_HAS_EDAT1)
-		return false;
-	if (!kvm->arch.use_cmma)
-		return false;
-	return true;
-}
-
 static bool ibs_enabled(struct kvm_vcpu *vcpu)
 {
 	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_IBS;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c570478..81de2af 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -217,8 +217,6 @@ void exit_sie(struct kvm_vcpu *vcpu);
 void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
-/* is cmma enabled */
-bool kvm_s390_cmma_enabled(struct kvm *kvm);
 unsigned long kvm_s390_fac_list_mask_size(void);
 extern unsigned long kvm_s390_fac_list_mask[];
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ad42422..1b95d29 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -761,7 +761,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 5, "cmma release %d pages", entries);
 	gmap = vcpu->arch.gmap;
 	vcpu->stat.instruction_essa++;
-	if (!kvm_s390_cmma_enabled(vcpu->kvm))
+	if (!vcpu->kvm->arch.use_cmma)
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-- 
2.3.0
