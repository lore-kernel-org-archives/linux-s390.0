From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/10] KVM: s390: cleanup cpuid handling
Date: Mon,  9 May 2016 11:20:16 +0200
Message-ID: <1462785621-12600-6-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We only have one cpuid for all VCPUs, so let's directly use the one in the
cpu model. Also always store it directly as u64, no need for struct cpuid.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  6 +-----
 arch/s390/kvm/kvm-s390.c         | 17 +++++++++--------
 arch/s390/kvm/priv.c             |  2 +-
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6da41fa..9282ccf 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -544,10 +544,6 @@ struct kvm_vcpu_arch {
 	struct kvm_s390_local_interrupt local_int;
 	struct hrtimer    ckc_timer;
 	struct kvm_s390_pgm_info pgm;
-	union  {
-		struct cpuid	cpu_id;
-		u64		stidp_data;
-	};
 	struct gmap *gmap;
 	struct kvm_guestdbg_info_arch guestdbg;
 	unsigned long pfault_token;
@@ -605,7 +601,7 @@ struct kvm_s390_cpu_model {
 	__u64 fac_mask[S390_ARCH_FAC_LIST_SIZE_U64];
 	/* facility list requested by guest (in dma page) */
 	__u64 *fac_list;
-	struct cpuid cpu_id;
+	u64 cpuid;
 	unsigned short ibc;
 };
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e1e375c..0d2f242 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -652,8 +652,7 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 	}
 	if (!copy_from_user(proc, (void __user *)attr->addr,
 			    sizeof(*proc))) {
-		memcpy(&kvm->arch.model.cpu_id, &proc->cpuid,
-		       sizeof(struct cpuid));
+		kvm->arch.model.cpuid = proc->cpuid;
 		kvm->arch.model.ibc = proc->ibc;
 		memcpy(kvm->arch.model.fac_list, proc->fac_list,
 		       S390_ARCH_FAC_LIST_SIZE_BYTE);
@@ -687,7 +686,7 @@ static int kvm_s390_get_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 		ret = -ENOMEM;
 		goto out;
 	}
-	memcpy(&proc->cpuid, &kvm->arch.model.cpu_id, sizeof(struct cpuid));
+	proc->cpuid = kvm->arch.model.cpuid;
 	proc->ibc = kvm->arch.model.ibc;
 	memcpy(&proc->fac_list, kvm->arch.model.fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
@@ -1081,10 +1080,13 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
-static void kvm_s390_get_cpu_id(struct cpuid *cpu_id)
+static u64 kvm_s390_get_initial_cpuid(void)
 {
-	get_cpu_id(cpu_id);
-	cpu_id->version = 0xff;
+	struct cpuid cpuid;
+
+	get_cpu_id(&cpuid);
+	cpuid.version = 0xff;
+	return *((u64 *) &cpuid);
 }
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
@@ -1175,7 +1177,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
-	kvm_s390_get_cpu_id(&kvm->arch.model.cpu_id);
+	kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
 	kvm->arch.model.ibc = sclp.ibc & 0x0fff;
 
 	kvm_s390_crypto_init(kvm);
@@ -1624,7 +1626,6 @@ static void kvm_s390_vcpu_setup_model(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_cpu_model *model = &vcpu->kvm->arch.model;
 
-	vcpu->arch.cpu_id = model->cpu_id;
 	vcpu->arch.sie_block->ibc = model->ibc;
 	if (test_kvm_facility(vcpu->kvm, 7))
 		vcpu->arch.sie_block->fac = (u32)(u64) model->fac_list;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 3137479..95916fa 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -439,7 +439,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 
 static int handle_stidp(struct kvm_vcpu *vcpu)
 {
-	u64 stidp_data = vcpu->arch.stidp_data;
+	u64 stidp_data = vcpu->kvm->arch.model.cpuid;
 	u64 operand2;
 	int rc;
 	ar_t ar;
-- 
2.5.5
