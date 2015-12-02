From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/23] KVM: s390: Introduce switching code
Date: Wed,  2 Dec 2015 12:06:12 +0100
Message-ID: <1449054384-76374-12-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

This patch adds code that performs transparent switch to Extended
SCA on addition of 65th VCPU in a VM. Disposal of ESCA is added too.
The entier ESCA functionality, however, is still not enabled.
The enablement will be provided in a separate patch.

This patch also uses read/write lock protection of SCA and its subfields for
possible disposal at the BSCA-to-ESCA transition. While only Basic SCA needs such
a protection (for the swap), any SCA access is now guarded.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/gaccess.c          | 30 ++++++++++++----
 arch/s390/kvm/interrupt.c        |  6 ++++
 arch/s390/kvm/kvm-s390.c         | 75 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 25fdbf8..86c3386 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -622,6 +622,7 @@ struct kvm_s390_crypto_cb {
 struct kvm_arch{
 	void *sca;
 	int use_esca;
+	rwlock_t sca_lock;
 	debug_info_t *dbf;
 	struct kvm_s390_float_interrupt float_int;
 	struct kvm_device *flic;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 06f7edb..d30db40 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -259,10 +259,14 @@ struct aste {
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
-	union ipte_control *ic = kvm_s390_get_ipte_control(vcpu->kvm);
+	if (vcpu->arch.sie_block->eca & 1) {
+		int rc;
 
-	if (vcpu->arch.sie_block->eca & 1)
-		return ic->kh != 0;
+		read_lock(&vcpu->kvm->arch.sca_lock);
+		rc = kvm_s390_get_ipte_control(vcpu->kvm)->kh != 0;
+		read_unlock(&vcpu->kvm->arch.sca_lock);
+		return rc;
+	}
 	return vcpu->kvm->arch.ipte_lock_count != 0;
 }
 
@@ -274,16 +278,20 @@ static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.ipte_lock_count++;
 	if (vcpu->kvm->arch.ipte_lock_count > 1)
 		goto out;
+retry:
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
-		while (old.k) {
+		if (old.k) {
+			read_unlock(&vcpu->kvm->arch.sca_lock);
 			cond_resched();
-			old = READ_ONCE(*ic);
+			goto retry;
 		}
 		new = old;
 		new.k = 1;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 out:
 	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
 }
@@ -296,12 +304,14 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.ipte_lock_count--;
 	if (vcpu->kvm->arch.ipte_lock_count)
 		goto out;
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
 		new = old;
 		new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 	wake_up(&vcpu->kvm->arch.ipte_wq);
 out:
 	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
@@ -311,23 +321,28 @@ static void ipte_lock_siif(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
+retry:
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
-		while (old.kg) {
+		if (old.kg) {
+			read_unlock(&vcpu->kvm->arch.sca_lock);
 			cond_resched();
-			old = READ_ONCE(*ic);
+			goto retry;
 		}
 		new = old;
 		new.k = 1;
 		new.kh++;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 }
 
 static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
@@ -336,6 +351,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 		if (!new.kh)
 			new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 	if (!new.kh)
 		wake_up(&vcpu->kvm->arch.ipte_wq);
 }
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 60b36b0..831c9ac 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -39,6 +39,7 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
 	int c, scn;
 
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl sigp_ctrl =
@@ -54,6 +55,7 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 		c = sigp_ctrl.c;
 		scn = sigp_ctrl.scn;
 	}
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 
 	if (src_id)
 		*src_id = scn;
@@ -66,6 +68,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 {
 	int expect, rc;
 
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl *sigp_ctrl =
@@ -91,6 +94,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		expect = old_val.value;
 		rc = cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
 	}
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 
 	if (rc != expect) {
 		/* another external call is pending */
@@ -106,6 +110,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	int rc, expect;
 
 	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl *sigp_ctrl =
@@ -123,6 +128,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 		expect = old.value;
 		rc = cmpxchg(&sigp_ctrl->value, old.value, 0);
 	}
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 	WARN_ON(rc != expect); /* cannot clear? */
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 41b3fed..5e884aa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1080,7 +1080,7 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 static void sca_dispose(struct kvm *kvm)
 {
 	if (kvm->arch.use_esca)
-		BUG(); /* not implemented yet */
+		free_pages_exact(kvm->arch.sca, sizeof(struct esca_block));
 	else
 		free_page((unsigned long)(kvm->arch.sca));
 	kvm->arch.sca = NULL;
@@ -1110,6 +1110,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	rc = -ENOMEM;
 
 	kvm->arch.use_esca = 0; /* start with basic SCA */
+	rwlock_init(&kvm->arch.sca_lock);
 	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(GFP_KERNEL);
 	if (!kvm->arch.sca)
 		goto out_err;
@@ -1259,6 +1260,7 @@ static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 
 static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
+	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 
@@ -1272,11 +1274,13 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 		if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
 			sca->cpu[vcpu->vcpu_id].sda = 0;
 	}
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 }
 
 static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 			unsigned int id)
 {
+	read_lock(&kvm->arch.sca_lock);
 	if (kvm->arch.use_esca) {
 		struct esca_block *sca = kvm->arch.sca;
 
@@ -1294,11 +1298,78 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
 		set_bit_inv(id, (unsigned long *) &sca->mcn);
 	}
+	read_unlock(&kvm->arch.sca_lock);
+}
+
+/* Basic SCA to Extended SCA data copy routines */
+static inline void sca_copy_entry(struct esca_entry *d, struct bsca_entry *s)
+{
+	d->sda = s->sda;
+	d->sigp_ctrl.c = s->sigp_ctrl.c;
+	d->sigp_ctrl.scn = s->sigp_ctrl.scn;
+}
+
+static void sca_copy_b_to_e(struct esca_block *d, struct bsca_block *s)
+{
+	int i;
+
+	d->ipte_control = s->ipte_control;
+	d->mcn[0] = s->mcn;
+	for (i = 0; i < KVM_S390_BSCA_CPU_SLOTS; i++)
+		sca_copy_entry(&d->cpu[i], &s->cpu[i]);
+}
+
+static int sca_switch_to_extended(struct kvm *kvm)
+{
+	struct bsca_block *old_sca = kvm->arch.sca;
+	struct esca_block *new_sca;
+	struct kvm_vcpu *vcpu;
+	unsigned int vcpu_idx;
+	u32 scaol, scaoh;
+
+	new_sca = alloc_pages_exact(sizeof(*new_sca), GFP_KERNEL|__GFP_ZERO);
+	if (!new_sca)
+		return -ENOMEM;
+
+	scaoh = (u32)((u64)(new_sca) >> 32);
+	scaol = (u32)(u64)(new_sca) & ~0x3fU;
+
+	kvm_s390_vcpu_block_all(kvm);
+	write_lock(&kvm->arch.sca_lock);
+
+	sca_copy_b_to_e(new_sca, old_sca);
+
+	kvm_for_each_vcpu(vcpu_idx, vcpu, kvm) {
+		vcpu->arch.sie_block->scaoh = scaoh;
+		vcpu->arch.sie_block->scaol = scaol;
+		vcpu->arch.sie_block->ecb2 |= 0x04U;
+	}
+	kvm->arch.sca = new_sca;
+	kvm->arch.use_esca = 1;
+
+	write_unlock(&kvm->arch.sca_lock);
+	kvm_s390_vcpu_unblock_all(kvm);
+
+	free_page((unsigned long)old_sca);
+
+	VM_EVENT(kvm, 2, "Switched to ESCA (%p -> %p)", old_sca, kvm->arch.sca);
+	return 0;
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
 {
-	return id < KVM_MAX_VCPUS;
+	int rc;
+
+	if (id < KVM_S390_BSCA_CPU_SLOTS)
+		return true;
+	if (!sclp.has_esca)
+		return false;
+
+	mutex_lock(&kvm->lock);
+	rc = kvm->arch.use_esca ? 0 : sca_switch_to_extended(kvm);
+	mutex_unlock(&kvm->lock);
+
+	return rc == 0 && id < KVM_S390_ESCA_CPU_SLOTS;
 }
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
-- 
2.3.0
