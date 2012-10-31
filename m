From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 5/5] KVM: s390: Add support for channel I/O instructions.
Date: Wed, 31 Oct 2012 17:24:38 +0100
Message-ID: <1351700678-41969-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add a new capability, KVM_CAP_S390_CSS_SUPPORT, which will pass
intercepts for channel I/O instructions to userspace. Only I/O
instructions interacting with I/O interrupts need to be handled
in-kernel:

- TEST PENDING INTERRUPTION (tpi) dequeues and stores pending
  interrupts entirely in-kernel.
- TEST SUBCHANNEL (tsch) dequeues pending interrupts in-kernel
  and exits via KVM_EXIT_S390_TSCH to userspace for subchannel-
  related processing.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 30 ++++++++++++
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/intercept.c         |  1 +
 arch/s390/kvm/interrupt.c         | 37 +++++++++++++++
 arch/s390/kvm/kvm-s390.c          | 12 +++++
 arch/s390/kvm/kvm-s390.h          |  2 +
 arch/s390/kvm/priv.c              | 96 +++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/trace-s390.h        | 20 ++++++++
 include/linux/kvm.h               | 11 +++++
 include/trace/events/kvm.h        |  2 +-
 10 files changed, 207 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a0408cf..2233081 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2294,6 +2294,22 @@ The possible hypercalls are defined in the Power Architecture Platform
 Requirements (PAPR) document available from www.power.org (free
 developer registration required to access it).
 
+		/* KVM_EXIT_S390_TSCH */
+		struct {
+			__u16 subchannel_id;
+			__u16 subchannel_nr;
+			__u32 io_int_parm;
+			__u32 io_int_word;
+			__u32 ipb;
+			__u8 dequeued;
+		} s390_tsch;
+
+s390 specific. This exit occurs when KVM_CAP_S390_CSS_SUPPORT has been enabled
+and TEST SUBCHANNEL was intercepted. If dequeued is set, a pending I/O
+interrupt for the target subchannel has been dequeued and subchannel_id,
+subchannel_nr, io_int_parm and io_int_word contain the parameters for that
+interrupt. ipb is needed for instruction parameter decoding.
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -2415,3 +2431,17 @@ For mmu types KVM_MMU_FSL_BOOKE_NOHV and KVM_MMU_FSL_BOOKE_HV:
    where "num_sets" is the tlb_sizes[] value divided by the tlb_ways[] value.
  - The tsize field of mas1 shall be set to 4K on TLB0, even though the
    hardware ignores this value for TLB0.
+
+6.4 KVM_CAP_S390_CSS_SUPPORT
+
+Architectures: s390
+Parameters: none
+Returns: 0 on success; -1 on error
+
+This capability enables support for handling of channel I/O instructions.
+
+TEST PENDING INTERRUPTION and the interrupt portion of TEST SUBCHANNEL are
+handled in-kernel, while the other I/O instructions are passed to userspace.
+
+When this capability is enabled, KVM_EXIT_S390_TSCH will occur on TEST
+SUBCHANNEL intercepts.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 773859e..091c581 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -264,6 +264,7 @@ struct kvm_arch{
 	debug_info_t *dbf;
 	struct kvm_s390_float_interrupt float_int;
 	struct gmap *gmap;
+	int css_support;
 };
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 754dc9e..9ab2efd 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -273,6 +273,7 @@ static const intercept_handler_t intercept_funcs[] = {
 	[0x0C >> 2] = handle_instruction_and_prog,
 	[0x10 >> 2] = handle_noop,
 	[0x14 >> 2] = handle_noop,
+	[0x18 >> 2] = handle_noop,
 	[0x1C >> 2] = kvm_s390_handle_wait,
 	[0x20 >> 2] = handle_validity,
 	[0x28 >> 2] = handle_stop,
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6b10267..495a411 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -714,6 +714,43 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	return 0;
 }
 
+struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
+						    u64 cr6, u64 schid)
+{
+	struct kvm_s390_float_interrupt *fi;
+	struct kvm_s390_interrupt_info *inti, *iter;
+
+	if ((!schid && !cr6) || (schid && cr6))
+		return NULL;
+	mutex_lock(&kvm->lock);
+	fi = &kvm->arch.float_int;
+	spin_lock(&fi->lock);
+	inti = NULL;
+	list_for_each_entry(iter, &fi->list, list) {
+		if (!is_ioint(iter->type))
+			continue;
+		if (cr6 && ((cr6 & iter->io.io_int_word) == 0))
+			continue;
+		if (schid) {
+			if (((schid & 0x00000000ffff0000) >> 16) !=
+			    iter->io.subchannel_id)
+				continue;
+			if ((schid & 0x000000000000ffff) !=
+			    iter->io.subchannel_nr)
+				continue;
+		}
+		inti = iter;
+		break;
+	}
+	if (inti)
+		list_del_init(&inti->list);
+	if (list_empty(&fi->list))
+		atomic_set(&fi->active, 0);
+	spin_unlock(&fi->lock);
+	mutex_unlock(&kvm->lock);
+	return inti;
+}
+
 int kvm_s390_inject_vm(struct kvm *kvm,
 		       struct kvm_s390_interrupt *s390int)
 {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c19568b..fcbb711 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -141,6 +141,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_SYNC_REGS:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ENABLE_CAP:
+	case KVM_CAP_S390_CSS_SUPPORT:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -235,6 +236,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
 	}
+
+	kvm->arch.css_support = 0;
+
 	return 0;
 out_nogmap:
 	debug_unregister(kvm->arch.dbf);
@@ -657,6 +661,7 @@ rerun_vcpu:
 	case KVM_EXIT_INTR:
 	case KVM_EXIT_S390_RESET:
 	case KVM_EXIT_S390_UCONTROL:
+	case KVM_EXIT_S390_TSCH:
 		break;
 	default:
 		BUG();
@@ -817,6 +822,13 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	switch (cap->cap) {
+	case KVM_CAP_S390_CSS_SUPPORT:
+		if (!vcpu->kvm->arch.css_support) {
+			vcpu->kvm->arch.css_support = 1;
+			trace_kvm_s390_enable_css(vcpu->kvm);
+		}
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 7f50229..14a417f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -76,6 +76,8 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 		struct kvm_s390_interrupt *s390int);
 int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
+struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
+						    u64 cr6, u64 schid);
 
 /* implemented in priv.c */
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 2aba96b..7473888 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -135,15 +135,103 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int handle_io_inst(struct kvm_vcpu *vcpu)
+static int handle_tpi(struct kvm_vcpu *vcpu)
 {
-	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
-	/* condition code 3 */
+	u32 ipb = vcpu->arch.sie_block->ipb;
+	u64 addr;
+	struct kvm_s390_interrupt_info *inti;
+	int cc;
+
+	addr = ipb >> 28;
+	if (addr > 0)
+		addr = vcpu->run->s.regs.gprs[addr];
+
+	addr += (ipb & 0xfff0000) >> 16;
+
+	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->run->s.regs.crs[6], 0);
+	if (inti) {
+		if (addr) {
+			/*
+			 * Store the two-word I/O interruption code into the
+			 * provided area.
+			 */
+			put_guest_u16(vcpu, addr, inti->io.subchannel_id);
+			put_guest_u16(vcpu, addr + 2, inti->io.subchannel_nr);
+			put_guest_u32(vcpu, addr + 4, inti->io.io_int_parm);
+		} else {
+			/*
+			 * Store the three-word I/O interruption code into
+			 * the appropriate lowcore area.
+			 */
+			put_guest_u16(vcpu, 184, inti->io.subchannel_id);
+			put_guest_u16(vcpu, 186, inti->io.subchannel_nr);
+			put_guest_u32(vcpu, 188, inti->io.io_int_parm);
+			put_guest_u32(vcpu, 192, inti->io.io_int_word);
+		}
+		cc = 1;
+	} else
+		cc = 0;
+	kfree(inti);
+	/* Set condition code and we're done. */
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-	vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
+	vcpu->arch.sie_block->gpsw.mask |= (cc & 3ul) << 44;
 	return 0;
 }
 
+static int handle_tsch(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_interrupt_info *inti;
+
+	inti = kvm_s390_get_io_int(vcpu->kvm, 0,
+				   vcpu->run->s.regs.gprs[1]);
+
+	/*
+	 * Prepare exit to userspace.
+	 * We indicate whether we dequeued a pending I/O interrupt
+	 * so that userspace can re-inject it if the instruction gets
+	 * a program check. While this may re-order the pending I/O
+	 * interrupts, this is no problem since the priority is kept
+	 * intact.
+	 */
+	vcpu->run->exit_reason = KVM_EXIT_S390_TSCH;
+	vcpu->run->s390_tsch.dequeued = !!inti;
+	if (inti) {
+		vcpu->run->s390_tsch.subchannel_id = inti->io.subchannel_id;
+		vcpu->run->s390_tsch.subchannel_nr = inti->io.subchannel_nr;
+		vcpu->run->s390_tsch.io_int_parm = inti->io.io_int_parm;
+		vcpu->run->s390_tsch.io_int_word = inti->io.io_int_word;
+	}
+	vcpu->run->s390_tsch.ipb = vcpu->arch.sie_block->ipb;
+	kfree(inti);
+	return -EREMOTE;
+}
+
+static int handle_io_inst(struct kvm_vcpu *vcpu)
+{
+	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
+
+	if (vcpu->kvm->arch.css_support) {
+		/*
+		 * Most I/O instructions will be handled by userspace.
+		 * Exceptions are tpi and the interrupt portion of tsch.
+		 */
+		if (vcpu->arch.sie_block->ipa == 0xb236)
+			return handle_tpi(vcpu);
+		if (vcpu->arch.sie_block->ipa == 0xb235)
+			return handle_tsch(vcpu);
+		/* Handle in userspace. */
+		return -EOPNOTSUPP;
+	} else {
+		/*
+		 * Set condition code 3 to stop the guest from issueing channel
+		 * I/O instructions.
+		 */
+		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
+		vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
+		return 0;
+	}
+}
+
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
 	unsigned int facility_list;
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 95fbc1a..13f30f5 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -204,6 +204,26 @@ TRACE_EVENT(kvm_s390_stop_request,
 	);
 
 
+/*
+ * Trace point for enabling channel I/O instruction support.
+ */
+TRACE_EVENT(kvm_s390_enable_css,
+	    TP_PROTO(void *kvm),
+	    TP_ARGS(kvm),
+
+	    TP_STRUCT__entry(
+		    __field(void *, kvm)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->kvm = kvm;
+		    ),
+
+	    TP_printk("enabling channel I/O support (kvm @ %p)\n",
+		      __entry->kvm)
+	);
+
+
 #endif /* _TRACE_KVMS390_H */
 
 /* This part must be outside protection */
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 22859dc..72aa4a3 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -168,6 +168,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
 #define KVM_EXIT_WATCHDOG         21
+#define KVM_EXIT_S390_TSCH        22
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -285,6 +286,15 @@ struct kvm_run {
 			__u64 ret;
 			__u64 args[9];
 		} papr_hcall;
+		/* KVM_EXIT_S390_TSCH */
+		struct {
+			__u16 subchannel_id;
+			__u16 subchannel_nr;
+			__u32 io_int_parm;
+			__u32 io_int_word;
+			__u32 ipb;
+			__u8 dequeued;
+		} s390_tsch;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -641,6 +651,7 @@ struct kvm_ppc_smmu_info {
 #endif
 #define KVM_CAP_IRQFD_RESAMPLE 82
 #define KVM_CAP_PPC_BOOKE_WATCHDOG 83
+#define KVM_CAP_S390_CSS_SUPPORT 84
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 7ef9e75..a23f47c 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -14,7 +14,7 @@
 	ERSN(SHUTDOWN), ERSN(FAIL_ENTRY), ERSN(INTR), ERSN(SET_TPR),	\
 	ERSN(TPR_ACCESS), ERSN(S390_SIEIC), ERSN(S390_RESET), ERSN(DCR),\
 	ERSN(NMI), ERSN(INTERNAL_ERROR), ERSN(OSI), ERSN(PAPR_HCALL),	\
-	ERSN(S390_UCONTROL)
+	ERSN(S390_UCONTROL), ERSN(S390_TSCH)
 
 TRACE_EVENT(kvm_userspace_exit,
 	    TP_PROTO(__u32 reason, int errno),
-- 
1.7.12.4
