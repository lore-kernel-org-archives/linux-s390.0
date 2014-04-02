From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/5] KVM: s390: Don't enable skeys by default
Date: Wed,  2 Apr 2014 11:24:48 +0200
Message-ID: <1396430688-53629-6-git-send-email-borntraeger@de.ibm.com>
References: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

The first invocation of storage key operations on a given cpu will be intercepted.

On these intercepts we will enable storage keys for the guest and remove the
previously added intercepts.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h    |  3 +++
 arch/s390/include/asm/mmu_context.h |  2 +-
 arch/s390/kvm/kvm-s390.c            |  1 +
 arch/s390/kvm/priv.c                | 14 ++++++++++++++
 arch/s390/kvm/trace.h               | 14 ++++++++++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9f2f45d..33c425e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -89,6 +89,9 @@ struct kvm_s390_sie_block {
 	__u16   lctl;			/* 0x0044 */
 	__s16	icpua;			/* 0x0046 */
 #define ICTL_LPSW 0x00400000
+#define ICTL_ISKE 0x00004000
+#define ICTL_SSKE 0x00002000
+#define ICTL_RRBE 0x00001000
 	__u32	ictl;			/* 0x0048 */
 	__u32	eca;			/* 0x004c */
 	__u8	icptcode;		/* 0x0050 */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c913486..f230e6c 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -22,7 +22,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
 	mm->context.has_pgste = 0;
-	mm->context.use_skey = 1;
+	mm->context.use_skey = 0;
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fcb1c32..2d981b4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -492,6 +492,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->ecb2  = 8;
 	vcpu->arch.sie_block->eca   = 0xC1002001U;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
+	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
 		if (!kvm_s390_vcpu_activate_cmma(vcpu))
 			return -ENOMEM;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 8f5e111..6cba3e0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -148,8 +148,21 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void __skey_check_enable(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)))
+		return;
+
+	s390_enable_skey();
+	trace_kvm_s390_skey_related_inst(vcpu);
+	vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+}
+
+
 static int handle_skey(struct kvm_vcpu *vcpu)
 {
+	__skey_check_enable(vcpu);
+
 	vcpu->stat.instruction_storage_key++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
@@ -662,6 +675,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		}
 
 		if (vcpu->run->s.regs.gprs[reg1] & PFMF_SK) {
+			__skey_check_enable(vcpu);
 			if (set_guest_storage_key(current->mm, useraddr,
 					vcpu->run->s.regs.gprs[reg1] & PFMF_KEY,
 					vcpu->run->s.regs.gprs[reg1] & PFMF_NQ))
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index e8e7213..a4bf7d7 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -30,6 +30,20 @@
 	TP_printk("%02d[%016lx-%016lx]: " p_str, __entry->id,		\
 		  __entry->pswmask, __entry->pswaddr, p_args)
 
+TRACE_EVENT(kvm_s390_skey_related_inst,
+	    TP_PROTO(VCPU_PROTO_COMMON),
+	    TP_ARGS(VCPU_ARGS_COMMON),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    ),
+	    VCPU_TP_PRINTK("%s", "first instruction related to skeys on vcpu")
+	);
+
 TRACE_EVENT(kvm_s390_major_guest_pfault,
 	    TP_PROTO(VCPU_PROTO_COMMON),
 	    TP_ARGS(VCPU_ARGS_COMMON),
-- 
1.8.4.2
