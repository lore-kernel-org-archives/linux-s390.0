From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 14/47] KVM: s390: make use of ipte lock
Date: Tue, 15 Apr 2014 14:00:17 +0200
Message-ID: <1397563250-3089-15-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  12 ++++-
 arch/s390/kvm/gaccess.c          | 109 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h          |   2 +
 arch/s390/kvm/kvm-s390.c         |   2 +
 arch/s390/kvm/priv.c             |  18 +++++++
 5 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c290d44..f1ed7bd 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -39,9 +39,17 @@ struct sca_entry {
 	__u64	reserved2[2];
 } __attribute__((packed));
 
+union ipte_control {
+	unsigned long val;
+	struct {
+		unsigned long k  : 1;
+		unsigned long kh : 31;
+		unsigned long kg : 32;
+	};
+};
 
 struct sca_block {
-	__u64	ipte_control;
+	union ipte_control ipte_control;
 	__u64	reserved[5];
 	__u64	mcn;
 	__u64	reserved2;
@@ -167,6 +175,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_stpx;
 	u32 instruction_stap;
 	u32 instruction_storage_key;
+	u32 instruction_ipte_interlock;
 	u32 instruction_stsch;
 	u32 instruction_chsc;
 	u32 instruction_stsi;
@@ -336,6 +345,7 @@ struct kvm_arch{
 	int use_irqchip;
 	int use_cmma;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
+	wait_queue_head_t ipte_wq;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 916e1ee..691fdb7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -207,6 +207,107 @@ union raddress {
 	unsigned long pfra : 52; /* Page-Frame Real Address */
 };
 
+static int ipte_lock_count;
+static DEFINE_MUTEX(ipte_mutex);
+
+int ipte_lock_held(struct kvm_vcpu *vcpu)
+{
+	union ipte_control *ic = &vcpu->kvm->arch.sca->ipte_control;
+
+	if (vcpu->arch.sie_block->eca & 1)
+		return ic->kh != 0;
+	return ipte_lock_count != 0;
+}
+
+static void ipte_lock_simple(struct kvm_vcpu *vcpu)
+{
+	union ipte_control old, new, *ic;
+
+	mutex_lock(&ipte_mutex);
+	ipte_lock_count++;
+	if (ipte_lock_count > 1)
+		goto out;
+	ic = &vcpu->kvm->arch.sca->ipte_control;
+	do {
+		old = ACCESS_ONCE(*ic);
+		while (old.k) {
+			cond_resched();
+			old = ACCESS_ONCE(*ic);
+		}
+		new = old;
+		new.k = 1;
+	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+out:
+	mutex_unlock(&ipte_mutex);
+}
+
+static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
+{
+	union ipte_control old, new, *ic;
+
+	mutex_lock(&ipte_mutex);
+	ipte_lock_count--;
+	if (ipte_lock_count)
+		goto out;
+	ic = &vcpu->kvm->arch.sca->ipte_control;
+	do {
+		new = old = ACCESS_ONCE(*ic);
+		new.k = 0;
+	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	if (!ipte_lock_count)
+		wake_up(&vcpu->kvm->arch.ipte_wq);
+out:
+	mutex_unlock(&ipte_mutex);
+}
+
+static void ipte_lock_siif(struct kvm_vcpu *vcpu)
+{
+	union ipte_control old, new, *ic;
+
+	ic = &vcpu->kvm->arch.sca->ipte_control;
+	do {
+		old = ACCESS_ONCE(*ic);
+		while (old.kg) {
+			cond_resched();
+			old = ACCESS_ONCE(*ic);
+		}
+		new = old;
+		new.k = 1;
+		new.kh++;
+	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+}
+
+static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
+{
+	union ipte_control old, new, *ic;
+
+	ic = &vcpu->kvm->arch.sca->ipte_control;
+	do {
+		new = old = ACCESS_ONCE(*ic);
+		new.kh--;
+		if (!new.kh)
+			new.k = 0;
+	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
+	if (!new.kh)
+		wake_up(&vcpu->kvm->arch.ipte_wq);
+}
+
+static void ipte_lock(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sie_block->eca & 1)
+		ipte_lock_siif(vcpu);
+	else
+		ipte_lock_simple(vcpu);
+}
+
+static void ipte_unlock(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sie_block->eca & 1)
+		ipte_unlock_siif(vcpu);
+	else
+		ipte_unlock_simple(vcpu);
+}
+
 static unsigned long get_vcpu_asce(struct kvm_vcpu *vcpu)
 {
 	switch (psw_bits(vcpu->arch.sie_block->gpsw).as) {
@@ -485,6 +586,8 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
 	unsigned long _len, nr_pages, gpa, idx;
 	unsigned long pages_array[2];
 	unsigned long *pages;
+	int need_ipte_lock;
+	union asce asce;
 	int rc;
 
 	if (!len)
@@ -498,6 +601,10 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
 		pages = vmalloc(nr_pages * sizeof(unsigned long));
 	if (!pages)
 		return -ENOMEM;
+	asce.val = get_vcpu_asce(vcpu);
+	need_ipte_lock = psw_bits(*psw).t && !asce.r;
+	if (need_ipte_lock)
+		ipte_lock(vcpu);
 	rc = guest_page_range(vcpu, ga, pages, nr_pages, write);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
 		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
@@ -510,6 +617,8 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
 		ga += _len;
 		data += _len;
 	}
+	if (need_ipte_lock)
+		ipte_unlock(vcpu);
 	if (nr_pages > ARRAY_SIZE(pages_array))
 		vfree(pages);
 	return rc;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 21ee62c..f46e764 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -397,4 +397,6 @@ int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 	return access_guest_real(vcpu, gra, data, len, 0);
 }
 
+int ipte_lock_held(struct kvm_vcpu *vcpu);
+
 #endif /* __KVM_S390_GACCESS_H */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 927ba73..e1dfe24 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -67,6 +67,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_stpx", VCPU_STAT(instruction_stpx) },
 	{ "instruction_stap", VCPU_STAT(instruction_stap) },
 	{ "instruction_storage_key", VCPU_STAT(instruction_storage_key) },
+	{ "instruction_ipte_interlock", VCPU_STAT(instruction_ipte_interlock) },
 	{ "instruction_stsch", VCPU_STAT(instruction_stsch) },
 	{ "instruction_chsc", VCPU_STAT(instruction_chsc) },
 	{ "instruction_essa", VCPU_STAT(instruction_essa) },
@@ -437,6 +438,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	spin_lock_init(&kvm->arch.float_int.lock);
 	INIT_LIST_HEAD(&kvm->arch.float_int.list);
+	init_waitqueue_head(&kvm->arch.ipte_wq);
 
 	debug_register_view(kvm->arch.dbf, &debug_sprintf_view);
 	VM_EVENT(kvm, 3, "%s", "vm created");
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9a04d74..4792f1d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -173,6 +173,19 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_ipte_interlock(struct kvm_vcpu *vcpu)
+{
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+
+	vcpu->stat.instruction_ipte_interlock++;
+	if (psw_bits(*psw).p)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+	wait_event(vcpu->kvm->arch.ipte_wq, !ipte_lock_held(vcpu));
+	psw->addr = __rewind_psw(*psw, 4);
+	VCPU_EVENT(vcpu, 4, "%s", "retrying ipte interlock operation");
+	return 0;
+}
+
 static int handle_test_block(struct kvm_vcpu *vcpu)
 {
 	unsigned long hva;
@@ -509,6 +522,7 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x10] = handle_set_prefix,
 	[0x11] = handle_store_prefix,
 	[0x12] = handle_store_cpu_address,
+	[0x21] = handle_ipte_interlock,
 	[0x29] = handle_skey,
 	[0x2a] = handle_skey,
 	[0x2b] = handle_skey,
@@ -526,6 +540,7 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x3a] = handle_io_inst,
 	[0x3b] = handle_io_inst,
 	[0x3c] = handle_io_inst,
+	[0x50] = handle_ipte_interlock,
 	[0x5f] = handle_io_inst,
 	[0x74] = handle_io_inst,
 	[0x76] = handle_io_inst,
@@ -686,7 +701,10 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 }
 
 static const intercept_handler_t b9_handlers[256] = {
+	[0x8a] = handle_ipte_interlock,
 	[0x8d] = handle_epsw,
+	[0x8e] = handle_ipte_interlock,
+	[0x8f] = handle_ipte_interlock,
 	[0xab] = handle_essa,
 	[0xaf] = handle_pfmf,
 };
-- 
1.8.4.2
