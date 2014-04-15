From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 04/47] KVM: s390: allow injecting every kind of interrupt
Date: Tue, 15 Apr 2014 14:00:07 +0200
Message-ID: <1397563250-3089-5-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Add a new data structure and function that allows to inject
all kinds of interrupt as defined in the PoP

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 59 +++++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/interrupt.c        | 25 +++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |  3 ++
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b61ac41..90905ca 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -186,13 +186,58 @@ struct kvm_vcpu_stat {
 	u32 diagnose_9c;
 };
 
-#define PGM_OPERATION            0x01
-#define PGM_PRIVILEGED_OP	 0x02
-#define PGM_EXECUTE              0x03
-#define PGM_PROTECTION           0x04
-#define PGM_ADDRESSING           0x05
-#define PGM_SPECIFICATION        0x06
-#define PGM_DATA                 0x07
+#define PGM_OPERATION			0x01
+#define PGM_PRIVILEGED_OP		0x02
+#define PGM_EXECUTE			0x03
+#define PGM_PROTECTION			0x04
+#define PGM_ADDRESSING			0x05
+#define PGM_SPECIFICATION		0x06
+#define PGM_DATA			0x07
+#define PGM_FIXED_POINT_OVERFLOW	0x08
+#define PGM_FIXED_POINT_DIVIDE		0x09
+#define PGM_DECIMAL_OVERFLOW		0x0a
+#define PGM_DECIMAL_DIVIDE		0x0b
+#define PGM_HFP_EXPONENT_OVERFLOW	0x0c
+#define PGM_HFP_EXPONENT_UNDERFLOW	0x0d
+#define PGM_HFP_SIGNIFICANCE		0x0e
+#define PGM_HFP_DIVIDE			0x0f
+#define PGM_SEGMENT_TRANSLATION		0x10
+#define PGM_PAGE_TRANSLATION		0x11
+#define PGM_TRANSLATION_SPEC		0x12
+#define PGM_SPECIAL_OPERATION		0x13
+#define PGM_OPERAND			0x15
+#define PGM_TRACE_TABEL			0x16
+#define PGM_SPACE_SWITCH		0x1c
+#define PGM_HFP_SQUARE_ROOT		0x1d
+#define PGM_PC_TRANSLATION_SPEC		0x1f
+#define PGM_AFX_TRANSLATION		0x20
+#define PGM_ASX_TRANSLATION		0x21
+#define PGM_LX_TRANSLATION		0x22
+#define PGM_EX_TRANSLATION		0x23
+#define PGM_PRIMARY_AUTHORITY		0x24
+#define PGM_SECONDARY_AUTHORITY		0x25
+#define PGM_LFX_TRANSLATION		0x26
+#define PGM_LSX_TRANSLATION		0x27
+#define PGM_ALET_SPECIFICATION		0x28
+#define PGM_ALEN_TRANSLATION		0x29
+#define PGM_ALE_SEQUENCE		0x2a
+#define PGM_ASTE_VALIDITY		0x2b
+#define PGM_ASTE_SEQUENCE		0x2c
+#define PGM_EXTENDED_AUTHORITY		0x2d
+#define PGM_LSTE_SEQUENCE		0x2e
+#define PGM_ASTE_INSTANCE		0x2f
+#define PGM_STACK_FULL			0x30
+#define PGM_STACK_EMPTY			0x31
+#define PGM_STACK_SPECIFICATION		0x32
+#define PGM_STACK_TYPE			0x33
+#define PGM_STACK_OPERATION		0x34
+#define PGM_ASCE_TYPE			0x38
+#define PGM_REGION_FIRST_TRANS		0x39
+#define PGM_REGION_SECOND_TRANS		0x3a
+#define PGM_REGION_THIRD_TRANS		0x3b
+#define PGM_MONITOR			0x40
+#define PGM_PER				0x80
+#define PGM_CRYPTO_OPERATION		0x119
 
 struct kvm_s390_interrupt_info {
 	struct list_head list;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 200a8f9..a44c689 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -660,6 +660,31 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	return 0;
 }
 
+int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
+			     struct kvm_s390_pgm_info *pgm_info)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_interrupt_info *inti;
+
+	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
+	if (!inti)
+		return -ENOMEM;
+
+	VCPU_EVENT(vcpu, 3, "inject: prog irq %d (from kernel)",
+		   pgm_info->code);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
+				   pgm_info->code, 0, 1);
+
+	inti->type = KVM_S390_PROGRAM_INT;
+	memcpy(&inti->pgm, pgm_info, sizeof(inti->pgm));
+	spin_lock_bh(&li->lock);
+	list_add(&inti->list, &li->list);
+	atomic_set(&li->active, 1);
+	BUG_ON(waitqueue_active(li->wq));
+	spin_unlock_bh(&li->lock);
+	return 0;
+}
+
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid)
 {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 460ccd8..25a8b84 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -165,6 +165,9 @@ bool kvm_s390_cmma_enabled(struct kvm *kvm);
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
+/* implemented in interrupt.c */
+int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
+			     struct kvm_s390_pgm_info *pgm_info);
 
 /* implemented in interrupt.c */
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
-- 
1.8.4.2
