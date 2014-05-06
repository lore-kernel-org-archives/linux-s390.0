From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: Add clock comparator and CPU timer IRQ injection
Date: Tue,  6 May 2014 15:58:28 +0200
Message-ID: <1399384709-21339-3-git-send-email-borntraeger@de.ibm.com>
References: <1399384709-21339-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1399384709-21339-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Add an interface to inject clock comparator and CPU timer interrupts
into the guest. This is needed for handling the external interrupt
interception.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  2 ++
 arch/s390/kvm/interrupt.c         | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 2014ff1..0581f6c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2211,6 +2211,8 @@ KVM_S390_SIGP_STOP (vcpu) - sigp restart
 KVM_S390_PROGRAM_INT (vcpu) - program check; code in parm
 KVM_S390_SIGP_SET_PREFIX (vcpu) - sigp set prefix; prefix address in parm
 KVM_S390_RESTART (vcpu) - restart
+KVM_S390_INT_CLOCK_COMP (vcpu) - clock comparator interrupt
+KVM_S390_INT_CPU_TIMER (vcpu) - CPU timer interrupt
 KVM_S390_INT_VIRTIO (vm) - virtio external interrupt; external interrupt
 			   parameters in parm and parm64
 KVM_S390_INT_SERVICE (vm) - sclp external interrupt; sclp parameter in parm
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d9526bb..75cd321 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -27,6 +27,8 @@
 #define IOINT_CSSID_MASK 0x03fc0000
 #define IOINT_AI_MASK 0x04000000
 
+static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
+
 static int is_ioint(u64 type)
 {
 	return ((type & 0xfffe0000u) != 0xfffe0000u);
@@ -89,6 +91,14 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 		if (vcpu->arch.sie_block->gcr[0] & 0x4000ul)
 			return 1;
 		return 0;
+	case KVM_S390_INT_CLOCK_COMP:
+		return ckc_interrupts_enabled(vcpu);
+	case KVM_S390_INT_CPU_TIMER:
+		if (psw_extint_disabled(vcpu))
+			return 0;
+		if (vcpu->arch.sie_block->gcr[0] & 0x400ul)
+			return 1;
+		return 0;
 	case KVM_S390_INT_SERVICE:
 	case KVM_S390_INT_PFAULT_INIT:
 	case KVM_S390_INT_PFAULT_DONE:
@@ -166,6 +176,8 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_PFAULT_INIT:
 	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
+	case KVM_S390_INT_CLOCK_COMP:
+	case KVM_S390_INT_CPU_TIMER:
 		if (psw_extint_disabled(vcpu))
 			__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 		else
@@ -326,6 +338,24 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				    &vcpu->arch.sie_block->gpsw,
 				    sizeof(psw_t));
 		break;
+	case KVM_S390_INT_CLOCK_COMP:
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+						 inti->ext.ext_params, 0);
+		deliver_ckc_interrupt(vcpu);
+		break;
+	case KVM_S390_INT_CPU_TIMER:
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+						 inti->ext.ext_params, 0);
+		rc  = put_guest_lc(vcpu, EXT_IRQ_CPU_TIMER,
+				   (u16 *)__LC_EXT_INT_CODE);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+				   (u32 *)__LC_EXT_PARAMS);
+		break;
 	case KVM_S390_INT_SERVICE:
 		VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
 			   inti->ext.ext_params);
@@ -984,6 +1014,8 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 		break;
 	case KVM_S390_SIGP_STOP:
 	case KVM_S390_RESTART:
+	case KVM_S390_INT_CLOCK_COMP:
+	case KVM_S390_INT_CPU_TIMER:
 		VCPU_EVENT(vcpu, 3, "inject: type %x", s390int->type);
 		inti->type = s390int->type;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 836e15b..2b83cf3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -416,6 +416,8 @@ struct kvm_s390_psw {
 #define KVM_S390_INT_PFAULT_INIT	0xfffe0004u
 #define KVM_S390_INT_PFAULT_DONE	0xfffe0005u
 #define KVM_S390_MCHK			0xfffe1000u
+#define KVM_S390_INT_CLOCK_COMP		0xffff1004u
+#define KVM_S390_INT_CPU_TIMER		0xffff1005u
 #define KVM_S390_INT_VIRTIO		0xffff2603u
 #define KVM_S390_INT_SERVICE		0xffff2401u
 #define KVM_S390_INT_EMERGENCY		0xffff1201u
-- 
1.8.4.2
