From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/3] KVM: s390: Fix external interrupt interception
Date: Tue,  6 May 2014 15:58:29 +0200
Message-ID: <1399384709-21339-4-git-send-email-borntraeger@de.ibm.com>
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

The external interrupt interception can only occur in rare cases, e.g.
when the PSW of the interrupt handler has a bad value. The old handler
for this interception simply ignored these events (except for increasing
the exit_external_interrupt counter), but for proper operation we either
have to inject the interrupts manually or we should drop to userspace in
case of errors.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 +++-
 arch/s390/kvm/intercept.c        | 49 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f0a1dc5..96b8a67 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -132,7 +132,10 @@ struct kvm_s390_sie_block {
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
-	__u8	reservedb0[28];		/* 0x00b0 */
+	__u8	reservedb0[20];		/* 0x00b0 */
+	__u16	extcpuaddr;		/* 0x00c4 */
+	__u16	eic;			/* 0x00c6 */
+	__u32	reservedc8;		/* 0x00c8 */
 	__u16	pgmilc;			/* 0x00cc */
 	__u16	iprcc;			/* 0x00ce */
 	__u32	dxc;			/* 0x00d0 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 99e4b76..bd607cf 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -17,6 +17,7 @@
 
 #include <asm/kvm_host.h>
 #include <asm/asm-offsets.h>
+#include <asm/irq.h>
 
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -46,9 +47,6 @@ static int handle_noop(struct kvm_vcpu *vcpu)
 	case 0x10:
 		vcpu->stat.exit_external_request++;
 		break;
-	case 0x14:
-		vcpu->stat.exit_external_interrupt++;
-		break;
 	default:
 		break; /* nothing */
 	}
@@ -234,6 +232,49 @@ static int handle_instruction_and_prog(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * handle_external_interrupt - used for external interruption interceptions
+ *
+ * This interception only occurs if the CPUSTAT_EXT_INT bit was set, or if
+ * the new PSW does not have external interrupts disabled. In the first case,
+ * we've got to deliver the interrupt manually, and in the second case, we
+ * drop to userspace to handle the situation there.
+ */
+static int handle_external_interrupt(struct kvm_vcpu *vcpu)
+{
+	u16 eic = vcpu->arch.sie_block->eic;
+	struct kvm_s390_interrupt irq;
+	psw_t newpsw;
+	int rc;
+
+	vcpu->stat.exit_external_interrupt++;
+
+	rc = read_guest_lc(vcpu, __LC_EXT_NEW_PSW, &newpsw, sizeof(psw_t));
+	if (rc)
+		return rc;
+	/* We can not handle clock comparator or timer interrupt with bad PSW */
+	if ((eic == EXT_IRQ_CLK_COMP || eic == EXT_IRQ_CPU_TIMER) &&
+	    (newpsw.mask & PSW_MASK_EXT))
+		return -EOPNOTSUPP;
+
+	switch (eic) {
+	case EXT_IRQ_CLK_COMP:
+		irq.type = KVM_S390_INT_CLOCK_COMP;
+		break;
+	case EXT_IRQ_CPU_TIMER:
+		irq.type = KVM_S390_INT_CPU_TIMER;
+		break;
+	case EXT_IRQ_EXTERNAL_CALL:
+		irq.type = KVM_S390_INT_EXTERNAL_CALL;
+		irq.parm = vcpu->arch.sie_block->extcpuaddr;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return kvm_s390_inject_vcpu(vcpu, &irq);
+}
+
+/**
  * Handle MOVE PAGE partial execution interception.
  *
  * This interception can only happen for guests with DAT disabled and
@@ -291,7 +332,7 @@ static const intercept_handler_t intercept_funcs[] = {
 	[0x08 >> 2] = handle_prog,
 	[0x0C >> 2] = handle_instruction_and_prog,
 	[0x10 >> 2] = handle_noop,
-	[0x14 >> 2] = handle_noop,
+	[0x14 >> 2] = handle_external_interrupt,
 	[0x18 >> 2] = handle_noop,
 	[0x1C >> 2] = kvm_s390_handle_wait,
 	[0x20 >> 2] = handle_validity,
-- 
1.8.4.2
