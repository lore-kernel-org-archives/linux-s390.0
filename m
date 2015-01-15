From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 08/21] KVM: s390: new parameter for SIGP STOP irqs
Date: Thu, 15 Jan 2015 14:43:21 +0100
Message-ID: <1421329414-76826-9-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

In order to get rid of the action_flags and to properly migrate pending SIGP
STOP irqs triggered e.g. by SIGP STOP AND STORE STATUS, we need to remember
whether to store the status when stopping.

For this reason, a new parameter (flags) for the SIGP STOP irq is introduced.
These flags further define details of the requested STOP and can be easily
migrated.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  2 +-
 arch/s390/include/asm/kvm_host.h  |  2 ++
 arch/s390/kvm/interrupt.c         | 18 +++++++++++++++++-
 include/uapi/linux/kvm.h          |  6 ++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0007fef..3ca6e0e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2312,7 +2312,7 @@ struct kvm_s390_interrupt {
 
 type can be one of the following:
 
-KVM_S390_SIGP_STOP (vcpu) - sigp restart
+KVM_S390_SIGP_STOP (vcpu) - sigp stop; optional flags in parm
 KVM_S390_PROGRAM_INT (vcpu) - program check; code in parm
 KVM_S390_SIGP_SET_PREFIX (vcpu) - sigp set prefix; prefix address in parm
 KVM_S390_RESTART (vcpu) - restart
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9cba74d5..5eafe84 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -378,6 +378,7 @@ struct kvm_s390_interrupt_info {
 		struct kvm_s390_emerg_info emerg;
 		struct kvm_s390_extcall_info extcall;
 		struct kvm_s390_prefix_info prefix;
+		struct kvm_s390_stop_info stop;
 		struct kvm_s390_mchk_info mchk;
 	};
 };
@@ -393,6 +394,7 @@ struct kvm_s390_irq_payload {
 	struct kvm_s390_emerg_info emerg;
 	struct kvm_s390_extcall_info extcall;
 	struct kvm_s390_prefix_info prefix;
+	struct kvm_s390_stop_info stop;
 	struct kvm_s390_mchk_info mchk;
 };
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7fbbcbc..73bafc3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -394,13 +394,20 @@ static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
 
 static int __must_check __deliver_stop(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_stop_info *stop = &li->irq.stop;
+
+	spin_lock(&li->lock);
+	stop->flags = 0;
+	clear_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
+	spin_unlock(&li->lock);
+
 	VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
 	vcpu->stat.deliver_stop_signal++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_SIGP_STOP,
 					 0, 0);
 
 	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
-	clear_bit(IRQ_PEND_SIGP_STOP, &vcpu->arch.local_int.pending_irqs);
 	return 0;
 }
 
@@ -1031,13 +1038,19 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
+#define KVM_S390_STOP_SUPP_FLAGS 0
 static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_stop_info *stop = &li->irq.stop;
 
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0, 2);
 
+	if (irq->u.stop.flags & ~KVM_S390_STOP_SUPP_FLAGS)
+		return -EINVAL;
+
 	li->action_bits |= ACTION_STOP_ON_STOP;
+	stop->flags = irq->u.stop.flags;
 	set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
 	return 0;
 }
@@ -1306,6 +1319,9 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 	case KVM_S390_SIGP_SET_PREFIX:
 		irq->u.prefix.address = s390int->parm;
 		break;
+	case KVM_S390_SIGP_STOP:
+		irq->u.stop.flags = s390int->parm;
+		break;
 	case KVM_S390_INT_EXTERNAL_CALL:
 		if (irq->u.extcall.code & 0xffff0000)
 			return -EINVAL;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a37fd12..adc24a3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -491,6 +491,11 @@ struct kvm_s390_emerg_info {
 	__u16 code;
 };
 
+#define KVM_S390_STOP_FLAG_STORE_STATUS	0x01
+struct kvm_s390_stop_info {
+	__u32 flags;
+};
+
 struct kvm_s390_mchk_info {
 	__u64 cr14;
 	__u64 mcic;
@@ -509,6 +514,7 @@ struct kvm_s390_irq {
 		struct kvm_s390_emerg_info emerg;
 		struct kvm_s390_extcall_info extcall;
 		struct kvm_s390_prefix_info prefix;
+		struct kvm_s390_stop_info stop;
 		struct kvm_s390_mchk_info mchk;
 		char reserved[64];
 	} u;
-- 
1.9.3
