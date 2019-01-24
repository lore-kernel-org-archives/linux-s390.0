From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v6 07/13] KVM: s390: introduce struct kvm_s390_gisa_interrupt
Date: Thu, 24 Jan 2019 13:59:33 +0100
Message-ID: <20190124125939.130763-8-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use this struct analog to the kvm interruption structs
for kvm emulated floating and local interruptions.
Further fields will be added with this series as
required.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  6 ++++-
 arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
 arch/s390/kvm/kvm-s390.c         |  2 +-
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c259a67c4298..0941571d34eb 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -803,6 +803,10 @@ struct kvm_s390_vsie {
 	struct page *pages[KVM_MAX_VCPUS];
 };
 
+struct kvm_s390_gisa_interrupt {
+	struct kvm_s390_gisa *origin;
+};
+
 struct kvm_arch{
 	void *sca;
 	int use_esca;
@@ -836,8 +840,8 @@ struct kvm_arch{
 	atomic64_t cmma_dirty_pages;
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
-	struct kvm_s390_gisa *gisa;
 	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
+	struct kvm_s390_gisa_interrupt gisa_int;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 942cc7d33766..ee91d1de0036 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return pending_irqs_no_gisa(vcpu) |
-		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
+		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
+			IRQ_PEND_IO_ISC_7;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -956,6 +957,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 {
 	struct list_head *isc_list;
 	struct kvm_s390_float_interrupt *fi;
+	struct kvm_s390_gisa_interrupt *gi = &vcpu->kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti = NULL;
 	struct kvm_s390_io_info io;
 	u32 isc;
@@ -998,8 +1000,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 		goto out;
 	}
 
-	if (vcpu->kvm->arch.gisa &&
-	    gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	if (gi->origin && gisa_tac_ipm_gisc(gi->origin, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1533,18 +1534,19 @@ static struct kvm_s390_interrupt_info *get_top_io_int(struct kvm *kvm,
 
 static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	unsigned long active_mask;
 	int isc;
 
 	if (schid)
 		goto out;
-	if (!kvm->arch.gisa)
+	if (!gi->origin)
 		goto out;
 
-	active_mask = (isc_mask & gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & gisa_get_ipm(gi->origin) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (gisa_tac_ipm_gisc(gi->origin, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1567,6 +1569,7 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 isc_mask, u32 schid)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti, *tmp_inti;
 	int isc;
 
@@ -1584,7 +1587,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 		goto out;
 	}
 gisa_out:
@@ -1596,7 +1599,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 out:
 	return inti;
 }
@@ -1685,6 +1688,7 @@ static int __inject_float_mchk(struct kvm *kvm,
 
 static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_float_interrupt *fi;
 	struct list_head *list;
 	int isc;
@@ -1692,9 +1696,9 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	kvm->stat.inject_io++;
 	isc = int_word_to_isc(inti->io.io_int_word);
 
-	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
+	if (gi->origin && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -1752,7 +1756,8 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (!(type & KVM_S390_INT_IO_AI_MASK && kvm->arch.gisa))
+		if (!(type & KVM_S390_INT_IO_AI_MASK &&
+		      kvm->arch.gisa_int.origin))
 			kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
 		break;
 	default:
@@ -2002,6 +2007,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 
 static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_irq *buf;
@@ -2025,14 +2031,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
-	if (kvm->arch.gisa && gisa_get_ipm(kvm->arch.gisa)) {
+	if (gi->origin && gisa_get_ipm(gi->origin)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (gisa_tac_ipm_gisc(gi->origin, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
@@ -2884,25 +2890,27 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
-	if (!kvm->arch.gisa)
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
+	if (!gi->origin)
 		return;
-	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
-	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
+	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
+	gi->origin->next_alert = (u32)(u64)gi->origin;
+	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
 }
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
 	if (!css_general_characteristics.aiv)
 		return;
-	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	gi->origin = &kvm->arch.sie_page2->gisa;
 	kvm_s390_gisa_clear(kvm);
-	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
+	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
 {
-	if (!kvm->arch.gisa)
-		return;
-	kvm->arch.gisa = NULL;
+	kvm->arch.gisa_int.origin = NULL;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7f4bc58a53b9..4c855cb67699 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2812,7 +2812,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
-	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
+	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa_int.origin;
 	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
 		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
-- 
2.13.4
