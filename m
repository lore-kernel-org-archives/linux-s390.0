From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/7] s390/kvm: Add support for machine checks.
Date: Tue,  7 Aug 2012 16:52:14 +0200
Message-ID: <1344351139-1793-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351139-1793-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351139-1793-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add support for injecting machine checks (only repressible
conditions for now).

This is a bit more involved than I/O interrupts, for these reasons:

- Machine checks come in both floating and cpu varieties.
- We don't have a bit for machine checks enabling, but have to use
  a roundabout approach with trapping PSW changing instructions and
  watching for opened machine checks.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   8 +++
 arch/s390/kvm/intercept.c        |   2 +
 arch/s390/kvm/interrupt.c        | 111 ++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |   3 +
 arch/s390/kvm/priv.c             | 133 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/trace-s390.h       |   6 +-
 include/linux/kvm.h              |   1 +
 7 files changed, 261 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e47f697..556774d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -77,8 +77,10 @@ struct kvm_s390_sie_block {
 	__u8	reserved40[4];		/* 0x0040 */
 #define LCTL_CR0	0x8000
 #define LCTL_CR6	0x0200
+#define LCTL_CR14	0x0002
 	__u16   lctl;			/* 0x0044 */
 	__s16	icpua;			/* 0x0046 */
+#define ICTL_LPSW 0x02000000
 	__u32	ictl;			/* 0x0048 */
 	__u32	eca;			/* 0x004c */
 	__u8	icptcode;		/* 0x0050 */
@@ -189,6 +191,11 @@ struct kvm_s390_emerg_info {
 	__u16 code;
 };
 
+struct kvm_s390_mchk_info {
+	__u64 cr14;
+	__u64 mcic;
+};
+
 struct kvm_s390_interrupt_info {
 	struct list_head list;
 	u64	type;
@@ -199,6 +206,7 @@ struct kvm_s390_interrupt_info {
 		struct kvm_s390_emerg_info emerg;
 		struct kvm_s390_extcall_info extcall;
 		struct kvm_s390_prefix_info prefix;
+		struct kvm_s390_mchk_info mchk;
 	};
 };
 
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 22798ec..ec1177f 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -106,10 +106,12 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 
 static intercept_handler_t instruction_handlers[256] = {
 	[0x01] = kvm_s390_handle_01,
+	[0x82] = kvm_s390_handle_lpsw,
 	[0x83] = kvm_s390_handle_diag,
 	[0xae] = kvm_s390_handle_sigp,
 	[0xb2] = kvm_s390_handle_b2,
 	[0xb7] = handle_lctl,
+	[0xb9] = kvm_s390_handle_b9,
 	[0xe5] = kvm_s390_handle_e5,
 	[0xeb] = handle_lctlg,
 };
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1dccfe7..edc065f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -41,6 +41,11 @@ static int psw_ioint_disabled(struct kvm_vcpu *vcpu)
 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_IO);
 }
 
+static int psw_mchk_disabled(struct kvm_vcpu *vcpu)
+{
+	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_MCHECK);
+}
+
 static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 {
 	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER) ||
@@ -82,6 +87,12 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 	case KVM_S390_SIGP_SET_PREFIX:
 	case KVM_S390_RESTART:
 		return 1;
+	case KVM_S390_MCHK:
+		if (psw_mchk_disabled(vcpu))
+			return 0;
+		if (vcpu->arch.sie_block->gcr[14] & inti->mchk.cr14)
+			return 1;
+		return 0;
 	default:
 		if (is_ioint(inti->type)) {
 			if (psw_ioint_disabled(vcpu))
@@ -119,6 +130,7 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 		CPUSTAT_IO_INT | CPUSTAT_EXT_INT | CPUSTAT_STOP_INT,
 		&vcpu->arch.sie_block->cpuflags);
 	vcpu->arch.sie_block->lctl = 0x0000;
+	vcpu->arch.sie_block->ictl &= ~ICTL_LPSW;
 }
 
 static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
@@ -142,6 +154,12 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 	case KVM_S390_SIGP_STOP:
 		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
 		break;
+	case KVM_S390_MCHK:
+		if (psw_mchk_disabled(vcpu))
+			vcpu->arch.sie_block->ictl |= ICTL_LPSW;
+		else
+			vcpu->arch.sie_block->lctl |= LCTL_CR14;
+		break;
 	default:
 		if (is_ioint(inti->type)) {
 			if (psw_ioint_disabled(vcpu))
@@ -330,6 +348,32 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 			exception = 1;
 		break;
 
+	case KVM_S390_MCHK:
+		VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
+			   inti->mchk.mcic);
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+						 inti->mchk.cr14,
+						 inti->mchk.mcic);
+		rc = kvm_s390_vcpu_store_status(vcpu,
+						KVM_S390_STORE_STATUS_PREFIXED);
+		if (rc == -EFAULT)
+			exception = 1;
+
+		rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
+		if (rc == -EFAULT)
+			exception = 1;
+		
+		rc = copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
+				   &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		if (rc == -EFAULT)
+			exception = 1;
+		
+		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				     __LC_MCK_NEW_PSW, sizeof(psw_t));
+		if (rc == -EFAULT)
+			exception = 1;
+		break;
+
 	default:
 		if (is_ioint(inti->type)) {
 			__u32 param0 = ((__u32)inti->io.subchannel_id << 16) |
@@ -595,6 +639,61 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	}
 }
 
+void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
+	struct kvm_s390_interrupt_info  *n, *inti = NULL;
+	int deliver;
+
+	__reset_intercept_indicators(vcpu);
+	if (atomic_read(&li->active)) {
+		do {
+			deliver = 0;
+			spin_lock_bh(&li->lock);
+			list_for_each_entry_safe(inti, n, &li->list, list) {
+				if ((inti->type == KVM_S390_MCHK) &&
+				    __interrupt_is_deliverable(vcpu, inti)) {
+					list_del(&inti->list);
+					deliver = 1;
+					break;
+				}
+				__set_intercept_indicator(vcpu, inti);
+			}
+			if (list_empty(&li->list))
+				atomic_set(&li->active, 0);
+			spin_unlock_bh(&li->lock);
+			if (deliver) {
+				__do_deliver_interrupt(vcpu, inti);
+				kfree(inti);
+			}
+		} while (deliver);
+	}
+
+	if (atomic_read(&fi->active)) {
+		do {
+			deliver = 0;
+			spin_lock(&fi->lock);
+			list_for_each_entry_safe(inti, n, &fi->list, list) {
+				if ((inti->type == KVM_S390_MCHK) &&
+				    __interrupt_is_deliverable(vcpu, inti)) {
+					list_del(&inti->list);
+					deliver = 1;
+					break;
+				}
+				__set_intercept_indicator(vcpu, inti);
+			}
+			if (list_empty(&fi->list))
+				atomic_set(&fi->active, 0);
+			spin_unlock(&fi->lock);
+			if (deliver) {
+				__do_deliver_interrupt(vcpu, inti);
+				kfree(inti);
+			}
+		} while (deliver);
+	}
+}
+
 int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
@@ -648,6 +747,12 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	case KVM_S390_INT_EMERGENCY:
 		kfree(inti);
 		return -EINVAL;
+	case KVM_S390_MCHK:
+		VM_EVENT(kvm, 5, "inject: machine check parm64:%llx",
+			 s390int->parm64);
+		inti->type = s390int->type;
+		inti->mchk.mcic = s390int->parm64;
+		break;
 	default:
 		if (!is_ioint(s390int->type)) {
 			kfree(inti);
@@ -740,6 +845,12 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 		VCPU_EVENT(vcpu, 3, "inject: type %x", s390int->type);
 		inti->type = s390int->type;
 		break;
+	case KVM_S390_MCHK:
+		VCPU_EVENT(vcpu, 5, "inject: machine check parm64:%llx",
+			   s390int->parm64);
+		inti->type = s390int->type;
+		inti->mchk.mcic = s390int->parm64;
+		break;
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
 	default:
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index d75bc5e..b1e1cb6 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -69,6 +69,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
+void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
 int kvm_s390_inject_vm(struct kvm *kvm,
 		struct kvm_s390_interrupt *s390int);
 int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
@@ -80,6 +81,8 @@ int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu);
 
 /* implemented in sigp.c */
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ed256fd..7e7263c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -176,6 +176,101 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void handle_new_psw(struct kvm_vcpu *vcpu)
+{
+	/* Check whether the new psw is enabled for machine checks. */
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_MCHECK)
+		kvm_s390_deliver_pending_machine_checks(vcpu);
+}
+
+int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
+{
+	int base2 = vcpu->arch.sie_block->ipb >> 28;
+	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+	u64 addr;
+	u64 uninitialized_var(new_psw);
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu,
+						   PGM_PRIVILEGED_OPERATION);
+
+	addr = disp2;
+	if (base2)
+		addr += vcpu->run->s.regs.gprs[base2];
+
+	if (addr & 7) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+
+	if (get_guest_u64(vcpu, addr, &new_psw)) {
+		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		goto out;
+	}
+
+	if (!(new_psw & 0x0008000000000000)) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+
+	vcpu->arch.sie_block->gpsw.mask = new_psw & 0xfff7ffff80000000;
+	vcpu->arch.sie_block->gpsw.addr = new_psw & 0x000000007fffffff;
+
+	if ((vcpu->arch.sie_block->gpsw.mask & 0xb80800fe00000000) ||
+	    (!(vcpu->arch.sie_block->gpsw.mask & 0x0000000180000000) &&
+	     (vcpu->arch.sie_block->gpsw.addr & 0x000000007ff00000)) ||
+	    ((vcpu->arch.sie_block->gpsw.mask & 0x0000000110000000) ==
+	     0x0000000100000000)) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+
+	handle_new_psw(vcpu);
+out:
+	return 0;
+}
+
+static int handle_lpswe(struct kvm_vcpu *vcpu)
+{
+	int base2 = vcpu->arch.sie_block->ipb >> 28;
+	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+	u64 addr;
+	u64 new_psw[2];
+
+	addr = disp2;
+	if (base2)
+		addr += vcpu->run->s.regs.gprs[base2];
+	
+	if (addr & 7) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+
+	if (copy_from_guest(vcpu, new_psw, addr, sizeof(*new_psw))) {
+		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		goto out;
+	}
+
+	vcpu->arch.sie_block->gpsw.mask = new_psw[0];
+	vcpu->arch.sie_block->gpsw.addr = new_psw[1];
+
+	if ((vcpu->arch.sie_block->gpsw.mask & 0xb80800fe7fffffff) ||
+	    (((vcpu->arch.sie_block->gpsw.mask & 0x0000000110000000) ==
+	      0x0000000010000000) &&
+	     (vcpu->arch.sie_block->gpsw.addr & 0xffffffff80000000)) ||
+	    (!(vcpu->arch.sie_block->gpsw.mask & 0x0000000180000000) &&
+	     (vcpu->arch.sie_block->gpsw.addr & 0xfffffffffff00000)) ||
+	    ((vcpu->arch.sie_block->gpsw.mask & 0x0000000110000000) ==
+	     0x0000000100000000)) {
+		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out;
+	}
+	
+	handle_new_psw(vcpu);
+out:
+	return 0;
+}
+
 static int handle_stidp(struct kvm_vcpu *vcpu)
 {
 	int base2 = vcpu->arch.sie_block->ipb >> 28;
@@ -309,6 +404,7 @@ static intercept_handler_t priv_handlers[256] = {
 	[0x5f] = handle_chsc,
 	[0x7d] = handle_stsi,
 	[0xb1] = handle_stfl,
+	[0xb2] = handle_lpswe,
 };
 
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
@@ -333,6 +429,43 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 	return -EOPNOTSUPP;
 }
 
+static int handle_epsw(struct kvm_vcpu *vcpu)
+{
+	int reg1, reg2;
+
+	reg1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 24;
+	reg2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	vcpu->run->s.regs.gprs[reg1] &= 0xffffffff00000000;
+	vcpu->run->s.regs.gprs[reg1] |= vcpu->arch.sie_block->gpsw.mask >> 32;
+	if (reg2) {
+		vcpu->run->s.regs.gprs[reg2] &= 0xffffffff00000000;
+		vcpu->run->s.regs.gprs[reg2] |=
+			vcpu->arch.sie_block->gpsw.mask & 0x00000000ffffffff;
+	}
+	return 0;
+}
+
+static intercept_handler_t b9_handlers[256] = {
+	[0x8d] = handle_epsw,
+};
+
+int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
+{
+	intercept_handler_t handler;
+
+	/* This is handled just as for the B2 instructions. */
+	handler = b9_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
+	if (handler) {
+		if ((handler != handle_epsw) &&
+		    (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE))
+			return kvm_s390_inject_program_int(vcpu,
+						   PGM_PRIVILEGED_OPERATION);
+		else
+			return handler(vcpu);
+	}
+	return -EOPNOTSUPP;
+}
+
 static int handle_tprot(struct kvm_vcpu *vcpu)
 {
 	int base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 90fdf85..95fbc1a 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -141,13 +141,13 @@ TRACE_EVENT(kvm_s390_inject_vcpu,
  * Trace point for the actual delivery of interrupts.
  */
 TRACE_EVENT(kvm_s390_deliver_interrupt,
-	    TP_PROTO(unsigned int id, __u64 type, __u32 data0, __u64 data1),
+	    TP_PROTO(unsigned int id, __u64 type, __u64 data0, __u64 data1),
 	    TP_ARGS(id, type, data0, data1),
 
 	    TP_STRUCT__entry(
 		    __field(int, id)
 		    __field(__u32, inttype)
-		    __field(__u32, data0)
+		    __field(__u64, data0)
 		    __field(__u64, data1)
 		    ),
 
@@ -159,7 +159,7 @@ TRACE_EVENT(kvm_s390_deliver_interrupt,
 		    ),
 
 	    TP_printk("deliver interrupt (vcpu %d): type:%x (%s) "	\
-		      "data:%08x %016llx",
+		      "data:%08llx %016llx",
 		      __entry->id, __entry->inttype,
 		      __print_symbolic(__entry->inttype, kvm_s390_int_type),
 		      __entry->data0, __entry->data1)
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 31f52c6..e0c3d87 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -388,6 +388,7 @@ struct kvm_s390_psw {
 #define KVM_S390_PROGRAM_INT		0xfffe0001u
 #define KVM_S390_SIGP_SET_PREFIX	0xfffe0002u
 #define KVM_S390_RESTART		0xfffe0003u
+#define KVM_S390_MCHK			0xfffe1000u
 #define KVM_S390_INT_VIRTIO		0xffff2603u
 #define KVM_S390_INT_SERVICE		0xffff2401u
 #define KVM_S390_INT_EMERGENCY		0xffff1201u
-- 
1.7.11.4
