From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/5] KVM: s390: Support for I/O interrupts.
Date: Wed, 31 Oct 2012 17:24:34 +0100
Message-ID: <1351700678-41969-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add support for handling I/O interrupts (standard, subchannel-related
ones and rudimentary adapter interrupts).

The subchannel-identifying parameters are encoded into the interrupt
type.

I/O interrupts are floating, so they can't be injected on a specific
vcpu.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |   4 ++
 arch/s390/include/asm/kvm_host.h  |   2 +
 arch/s390/kvm/interrupt.c         | 115 ++++++++++++++++++++++++++++++++++++--
 include/linux/kvm.h               |   6 ++
 4 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4258180..b660a6e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2068,6 +2068,10 @@ KVM_S390_INT_VIRTIO (vm) - virtio external interrupt; external interrupt
 KVM_S390_INT_SERVICE (vm) - sclp external interrupt; sclp parameter in parm
 KVM_S390_INT_EMERGENCY (vcpu) - sigp emergency; source cpu in parm
 KVM_S390_INT_EXTERNAL_CALL (vcpu) - sigp external call; source cpu in parm
+KVM_S390_INT_IO(ai,cssid,ssid,schid) (vm) - compound value to indicate an
+    I/O interrupt (ai - adapter interrupt; cssid,ssid,schid - subchannel);
+    I/O interruption parameters in parm (subchannel) and parm64 (intparm,
+    interruption subclass)
 
 Note that the vcpu ioctl is asynchronous to vcpu execution.
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b784154..e47f697 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -76,6 +76,7 @@ struct kvm_s390_sie_block {
 	__u64	epoch;			/* 0x0038 */
 	__u8	reserved40[4];		/* 0x0040 */
 #define LCTL_CR0	0x8000
+#define LCTL_CR6	0x0200
 	__u16   lctl;			/* 0x0044 */
 	__s16	icpua;			/* 0x0046 */
 	__u32	ictl;			/* 0x0048 */
@@ -127,6 +128,7 @@ struct kvm_vcpu_stat {
 	u32 deliver_prefix_signal;
 	u32 deliver_restart_signal;
 	u32 deliver_program_int;
+	u32 deliver_io_int;
 	u32 exit_wait_state;
 	u32 instruction_stidp;
 	u32 instruction_spx;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c30615e..070ba22 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -21,11 +21,26 @@
 #include "gaccess.h"
 #include "trace-s390.h"
 
+#define IOINT_SCHID_MASK 0x0000ffff
+#define IOINT_SSID_MASK 0x00030000
+#define IOINT_CSSID_MASK 0x03fc0000
+#define IOINT_AI_MASK 0x04000000
+
+static int is_ioint(u64 type)
+{
+	return ((type & 0xfffe0000u) != 0xfffe0000u);
+}
+
 static int psw_extint_disabled(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
 }
 
+static int psw_ioint_disabled(struct kvm_vcpu *vcpu)
+{
+	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_IO);
+}
+
 static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 {
 	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER) ||
@@ -68,7 +83,18 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 	case KVM_S390_RESTART:
 		return 1;
 	default:
-		BUG();
+		if (is_ioint(inti->type)) {
+			if (psw_ioint_disabled(vcpu))
+				return 0;
+			if (vcpu->arch.sie_block->gcr[6] &
+			    inti->io.io_int_word)
+				return 1;
+			return 0;
+		} else {
+			printk(KERN_WARNING "illegal interrupt type %llx\n",
+			       inti->type);
+			BUG();
+		}
 	}
 	return 0;
 }
@@ -117,6 +143,13 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
 		break;
 	default:
+		if (is_ioint(inti->type)) {
+			if (psw_ioint_disabled(vcpu))
+				__set_cpuflag(vcpu, CPUSTAT_IO_INT);
+			else
+				vcpu->arch.sie_block->lctl |= LCTL_CR6;
+			break;
+		}
 		BUG();
 	}
 }
@@ -298,7 +331,49 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		break;
 
 	default:
-		BUG();
+		if (is_ioint(inti->type)) {
+			__u32 param0 = ((__u32)inti->io.subchannel_id << 16) |
+				inti->io.subchannel_nr;
+			__u64 param1 = ((__u64)inti->io.io_int_parm << 32) |
+				inti->io.io_int_word;
+			VCPU_EVENT(vcpu, 4,
+				   "interrupt: I/O %llx", inti->type);
+			vcpu->stat.deliver_io_int++;
+			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+							 param0, param1);
+			rc = put_guest_u16(vcpu, __LC_SUBCHANNEL_ID,
+					   inti->io.subchannel_id);
+			if (rc == -EFAULT)
+				exception = 1;
+
+			rc = put_guest_u16(vcpu, __LC_SUBCHANNEL_NR,
+					   inti->io.subchannel_nr);
+			if (rc == -EFAULT)
+				exception = 1;
+
+			rc = put_guest_u32(vcpu, __LC_IO_INT_PARM,
+					   inti->io.io_int_parm);
+			if (rc == -EFAULT)
+				exception = 1;
+
+			rc = put_guest_u32(vcpu, __LC_IO_INT_WORD,
+					   inti->io.io_int_word);
+			if (rc == -EFAULT)
+				exception = 1;
+
+			rc = copy_to_guest(vcpu, __LC_IO_OLD_PSW,
+					   &vcpu->arch.sie_block->gpsw,
+					   sizeof(psw_t));
+			if (rc == -EFAULT)
+				exception = 1;
+
+			rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+					     __LC_IO_NEW_PSW, sizeof(psw_t));
+			if (rc == -EFAULT)
+				exception = 1;
+			break;
+		} else
+			BUG();
 	}
 	if (exception) {
 		printk("kvm: The guest lowcore is not mapped during interrupt "
@@ -545,7 +620,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 {
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_float_interrupt *fi;
-	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt_info *inti, *iter;
 	int sigcpu;
 
 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
@@ -569,9 +644,26 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	case KVM_S390_SIGP_STOP:
 	case KVM_S390_INT_EXTERNAL_CALL:
 	case KVM_S390_INT_EMERGENCY:
-	default:
 		kfree(inti);
 		return -EINVAL;
+	default:
+		if (!is_ioint(s390int->type)) {
+			kfree(inti);
+			return -EINVAL;
+		}
+		if (s390int->type & IOINT_AI_MASK)
+			VM_EVENT(kvm, 5, "%s", "inject: I/O (AI)");
+		else
+			VM_EVENT(kvm, 5, "inject: I/O css %x ss %x schid %04x",
+				 s390int->type & IOINT_CSSID_MASK,
+				 s390int->type & IOINT_SSID_MASK,
+				 s390int->type & IOINT_SCHID_MASK);
+		inti->type = s390int->type;
+		inti->io.subchannel_id = s390int->parm >> 16;
+		inti->io.subchannel_nr = s390int->parm & 0x0000ffffu;
+		inti->io.io_int_parm = s390int->parm64 >> 32;
+		inti->io.io_int_word = s390int->parm64 & 0x00000000ffffffffull;
+		break;
 	}
 	trace_kvm_s390_inject_vm(s390int->type, s390int->parm, s390int->parm64,
 				 2);
@@ -579,7 +671,19 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
-	list_add_tail(&inti->list, &fi->list);
+	if (!is_ioint(inti->type))
+		list_add_tail(&inti->list, &fi->list);
+	else {
+		/* Keep I/O interrupts sorted in isc order. */
+		list_for_each_entry(iter, &fi->list, list) {
+			if (!is_ioint(iter->type))
+				continue;
+			if (iter->io.io_int_word <= inti->io.io_int_word)
+				continue;
+			break;
+		}
+		list_add_tail(&inti->list, &iter->list);
+	}
 	atomic_set(&fi->active, 1);
 	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
 	if (sigcpu == KVM_MAX_VCPUS) {
@@ -654,6 +758,7 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
 	default:
+		/* also includes IOINT */
 		kfree(inti);
 		return -EINVAL;
 	}
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 494a84c..e676940 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -401,6 +401,12 @@ struct kvm_s390_psw {
 #define KVM_S390_INT_SERVICE		0xffff2401u
 #define KVM_S390_INT_EMERGENCY		0xffff1201u
 #define KVM_S390_INT_EXTERNAL_CALL	0xffff1202u
+#define KVM_S390_INT_IO(ai,cssid,ssid,schid)   \
+	(((schid)) |			       \
+	 ((ssid) << 16) |		       \
+	 ((cssid) << 18) |		       \
+	 ((ai) << 26))
+
 
 struct kvm_s390_interrupt {
 	__u32 type;
-- 
1.7.12.4
