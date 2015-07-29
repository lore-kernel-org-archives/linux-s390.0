From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/16] KVM: s390: more irq names for trace events
Date: Wed, 29 Jul 2015 11:06:01 +0200
Message-ID: <1438160766-108179-12-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch adds names for missing irq types to the trace events.
In order to identify adapter irqs, the define is moved from
interrupt.c to the other basic irq defines in uapi/linux/kvm.h.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c  |  3 +--
 arch/s390/kvm/trace-s390.h | 22 ++++++++++++++++------
 include/uapi/linux/kvm.h   |  1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6c98fb6..a578140 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -30,7 +30,6 @@
 #define IOINT_SCHID_MASK 0x0000ffff
 #define IOINT_SSID_MASK 0x00030000
 #define IOINT_CSSID_MASK 0x03fc0000
-#define IOINT_AI_MASK 0x04000000
 #define PFAULT_INIT 0x0600
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
@@ -1447,7 +1446,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 		inti->mchk.mcic = s390int->parm64;
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (inti->type & IOINT_AI_MASK)
+		if (inti->type & KVM_S390_INT_IO_AI_MASK)
 			VM_EVENT(kvm, 5, "%s", "inject: I/O (AI)");
 		else
 			VM_EVENT(kvm, 5, "inject: I/O css %x ss %x schid %04x",
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 4f373c5..cc1d6c6 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -105,11 +105,22 @@ TRACE_EVENT(kvm_s390_vcpu_start_stop,
 	{KVM_S390_PROGRAM_INT, "program interrupt"},			\
 	{KVM_S390_SIGP_SET_PREFIX, "sigp set prefix"},			\
 	{KVM_S390_RESTART, "sigp restart"},				\
+	{KVM_S390_INT_PFAULT_INIT, "pfault init"},			\
+	{KVM_S390_INT_PFAULT_DONE, "pfault done"},			\
+	{KVM_S390_MCHK, "machine check"},				\
+	{KVM_S390_INT_CLOCK_COMP, "clock comparator"},			\
+	{KVM_S390_INT_CPU_TIMER, "cpu timer"},				\
 	{KVM_S390_INT_VIRTIO, "virtio interrupt"},			\
 	{KVM_S390_INT_SERVICE, "sclp interrupt"},			\
 	{KVM_S390_INT_EMERGENCY, "sigp emergency"},			\
 	{KVM_S390_INT_EXTERNAL_CALL, "sigp ext call"}
 
+#define get_irq_name(__type) \
+	(__type > KVM_S390_INT_IO_MAX ? \
+	__print_symbolic(__type, kvm_s390_int_type) : \
+		(__type & KVM_S390_INT_IO_AI_MASK ? \
+		 "adapter I/O interrupt" : "subchannel I/O interrupt"))
+
 TRACE_EVENT(kvm_s390_inject_vm,
 	    TP_PROTO(__u64 type, __u32 parm, __u64 parm64, int who),
 	    TP_ARGS(type, parm, parm64, who),
@@ -131,8 +142,7 @@ TRACE_EVENT(kvm_s390_inject_vm,
 	    TP_printk("inject%s: type:%x (%s) parm:%x parm64:%llx",
 		      (__entry->who == 1) ? " (from kernel)" :
 		      (__entry->who == 2) ? " (from user)" : "",
-		      __entry->inttype,
-		      __print_symbolic(__entry->inttype, kvm_s390_int_type),
+		      __entry->inttype, get_irq_name(__entry->inttype),
 		      __entry->parm, __entry->parm64)
 	);
 
@@ -156,8 +166,8 @@ TRACE_EVENT(kvm_s390_inject_vcpu,
 
 	    TP_printk("inject (vcpu %d): type:%x (%s) parm:%x parm64:%llx",
 		      __entry->id, __entry->inttype,
-		      __print_symbolic(__entry->inttype, kvm_s390_int_type),
-		      __entry->parm, __entry->parm64)
+		      get_irq_name(__entry->inttype), __entry->parm,
+		      __entry->parm64)
 	);
 
 /*
@@ -184,8 +194,8 @@ TRACE_EVENT(kvm_s390_deliver_interrupt,
 	    TP_printk("deliver interrupt (vcpu %d): type:%x (%s) "	\
 		      "data:%08llx %016llx",
 		      __entry->id, __entry->inttype,
-		      __print_symbolic(__entry->inttype, kvm_s390_int_type),
-		      __entry->data0, __entry->data1)
+		      get_irq_name(__entry->inttype), __entry->data0,
+		      __entry->data1)
 	);
 
 /*
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9ef19eb..0d831f9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -482,6 +482,7 @@ struct kvm_s390_psw {
 	 ((ai) << 26))
 #define KVM_S390_INT_IO_MIN		0x00000000u
 #define KVM_S390_INT_IO_MAX		0xfffdffffu
+#define KVM_S390_INT_IO_AI_MASK		0x04000000u
 
 
 struct kvm_s390_interrupt {
-- 
2.3.0
