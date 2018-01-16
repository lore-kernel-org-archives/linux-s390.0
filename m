From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 06/12] KVM: s390: exploit GISA and AIV for emulated interrupts
Date: Tue, 16 Jan 2018 21:02:11 +0100
Message-ID: <20180116200217.211897-7-borntraeger@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The adapter interruption virtualization (AIV) facility is an
optional facility that comes with functionality expected to increase
the performance of adapter interrupt handling for both emulated and
passed-through adapter interrupts. With AIV, adapter interrupts can be
delivered to the guest without exiting SIE.

This patch provides some preparations for using AIV for emulated adapter
interrupts (inclusive virtio) if it's available. When using AIV, the
interrupts are delivered at the so called GISA by setting the bit
corresponding to its Interruption Subclass (ISC) in the Interruption
Pending Mask (IPM) instead of inserting a node into the floating interrupt
list.

To keep the change reasonably small, the handling of this new state is
deferred in get_all_floating_irqs and handle_tpi. This patch concentrates
on the code handling enqueuement of emulated adapter interrupts, and their
delivery to the guest.

Note that care is still required for adapter interrupts using AIV,
because there is no guarantee that AIV is going to deliver the adapter
interrupts pending at the GISA (consider all vcpus idle). When delivering
GISA adapter interrupts by the host (usual mechanism) special attention
is required to honor interrupt priorities.

Empirical results show that the time window between making an interrupt
pending at the GISA and doing kvm_s390_deliver_pending_interrupts is
sufficient for a guest with at least moderate cpu activity to get adapter
interrupts delivered within the SIE, and potentially save some SIE exits
(if not other deliverable interrupts).

The code will be activated with a follow-up patch.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 104 +++++++++++++++++++++++++++++++++++++---------
 arch/s390/kvm/kvm-s390.c  |   8 ++++
 arch/s390/kvm/kvm-s390.h  |   3 ++
 3 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index dfdecff302d2..6c34133f3842 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -206,7 +206,8 @@ static inline u8 int_word_to_isc(u32 int_word)
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.float_int.pending_irqs |
-	       vcpu->arch.local_int.pending_irqs;
+		vcpu->arch.local_int.pending_irqs |
+		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -896,18 +897,42 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 	return rc ? -EFAULT : 0;
 }
 
+static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
+{
+	int rc;
+
+	rc  = put_guest_lc(vcpu, io->subchannel_id,
+			   (u16 *)__LC_SUBCHANNEL_ID);
+	rc |= put_guest_lc(vcpu, io->subchannel_nr,
+			   (u16 *)__LC_SUBCHANNEL_NR);
+	rc |= put_guest_lc(vcpu, io->io_int_parm,
+			   (u32 *)__LC_IO_INT_PARM);
+	rc |= put_guest_lc(vcpu, io->io_int_word,
+			   (u32 *)__LC_IO_INT_WORD);
+	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw,
+			     sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw,
+			    sizeof(psw_t));
+	return rc;
+}
+
 static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 				     unsigned long irq_type)
 {
 	struct list_head *isc_list;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_interrupt_info *inti = NULL;
+	struct kvm_s390_io_info io;
+	u32 isc;
 	int rc = 0;
 
 	fi = &vcpu->kvm->arch.float_int;
 
 	spin_lock(&fi->lock);
-	isc_list = &fi->lists[irq_type_to_isc(irq_type)];
+	isc = irq_type_to_isc(irq_type);
+	isc_list = &fi->lists[isc];
 	inti = list_first_entry_or_null(isc_list,
 					struct kvm_s390_interrupt_info,
 					list);
@@ -935,23 +960,27 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	spin_unlock(&fi->lock);
 
 	if (inti) {
-		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
-				(u16 *)__LC_SUBCHANNEL_ID);
-		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
-				(u16 *)__LC_SUBCHANNEL_NR);
-		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
-				(u32 *)__LC_IO_INT_PARM);
-		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
-				(u32 *)__LC_IO_INT_WORD);
-		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
-				&vcpu->arch.sie_block->gpsw,
-				sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
-				&vcpu->arch.sie_block->gpsw,
-				sizeof(psw_t));
+		rc = __do_deliver_io(vcpu, &(inti->io));
 		kfree(inti);
+		goto out;
 	}
 
+	if (vcpu->kvm->arch.gisa) {
+		if (kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+			VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
+			memset(&io, 0, sizeof(io));
+			io.io_int_word = (isc << 27) | 0x80000000;
+			vcpu->stat.deliver_io_int++;
+			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+				KVM_S390_INT_IO(1, 0, 0, 0),
+				((__u32)io.subchannel_id << 16) |
+				io.subchannel_nr,
+				((__u64)io.io_int_parm << 32) |
+				io.io_int_word);
+			rc = __do_deliver_io(vcpu, &io);
+		}
+	}
+out:
 	return rc ? -EFAULT : 0;
 }
 
@@ -1515,12 +1544,23 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	struct kvm_s390_float_interrupt *fi;
 	struct list_head *list;
 	int isc;
+	int rc = 0;
+
+	isc = int_word_to_isc(inti->io.io_int_word);
+
+	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
+		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
+		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		kfree(inti);
+		goto out;
+	}
 
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
 		spin_unlock(&fi->lock);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto out;
 	}
 	fi->counters[FIRQ_CNTR_IO] += 1;
 
@@ -1531,12 +1571,12 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 			inti->io.subchannel_id >> 8,
 			inti->io.subchannel_id >> 1 & 0x3,
 			inti->io.subchannel_nr);
-	isc = int_word_to_isc(inti->io.io_int_word);
 	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
 	list_add_tail(&inti->list, list);
 	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
 	spin_unlock(&fi->lock);
-	return 0;
+out:
+	return rc;
 }
 
 /*
@@ -2705,3 +2745,29 @@ int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
+void kvm_s390_gisa_clear(struct kvm *kvm)
+{
+	if (kvm->arch.gisa) {
+		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
+		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
+	}
+}
+
+void kvm_s390_gisa_init(struct kvm *kvm)
+{
+	if (1 || !css_general_characteristics.aiv)
+		kvm->arch.gisa = NULL;
+	else {
+		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
+		kvm_s390_gisa_clear(kvm);
+	}
+}
+
+void kvm_s390_gisa_destroy(struct kvm *kvm)
+{
+	if (!kvm->arch.gisa)
+		return;
+	kvm->arch.gisa = NULL;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 48f0099188df..68d7eef44a98 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1986,6 +1986,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
+	kvm_s390_gisa_init(kvm);
 	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
 
 	return 0;
@@ -2048,6 +2049,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_free_vcpus(kvm);
 	sca_dispose(kvm);
 	debug_unregister(kvm->arch.dbf);
+	kvm_s390_gisa_destroy(kvm);
 	free_page((unsigned long)kvm->arch.sie_page2);
 	if (!kvm_is_ucontrol(kvm))
 		gmap_remove(kvm->arch.gmap);
@@ -2458,6 +2460,11 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 139))
 		vcpu->arch.sie_block->ecd |= ECD_MEF;
 
+	if (vcpu->arch.sie_block->gd) {
+		vcpu->arch.sie_block->eca |= ECA_AIV;
+		VCPU_EVENT(vcpu, 3, "AIV gisa format-%u enabled for cpu %03u",
+			   vcpu->arch.sie_block->gd & 0x3, vcpu->vcpu_id);
+	}
 	vcpu->arch.sie_block->sdnxo = ((unsigned long) &vcpu->run->s.regs.sdnx)
 					| SDNXC;
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
@@ -2510,6 +2517,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
+	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b17e4dea7ea5..04a3e915cd67 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -371,6 +371,9 @@ void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
 u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa);
 void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
 int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc);
+void kvm_s390_gisa_init(struct kvm *kvm);
+void kvm_s390_gisa_clear(struct kvm *kvm);
+void kvm_s390_gisa_destroy(struct kvm *kvm);
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
-- 
2.13.4
