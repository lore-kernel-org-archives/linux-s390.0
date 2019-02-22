From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 22 Feb 2019 16:29:54 +0100
Message-ID: <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We prepare the interception of the PQAP/AQIC instruction for
the case the AQIC facility is enabled in the guest.

We add a callback inside the KVM arch structure for s390 for
a VFIO driver to handle a specific response to the PQAP
instruction with the AQIC command.

We inject the correct exceptions from inside KVM for the case the
callback is not initialized, which happens when the vfio_ap driver
is not loaded.

If the callback has been setup we call it.
If not we setup an answer considering that no queue is available
for the guest when no callback has been setup.

We do consider the responsability of the driver to always initialize
the PQAP callback if it defines queues by initializing the CRYCB for
a guest.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/priv.c             | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c5f5156..49cc8b0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -719,6 +719,7 @@ struct kvm_s390_cpu_model {
 
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
+	int (*pqap_hook)(struct kvm_vcpu *vcpu);
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 8679bd7..3448abd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/ptrace.h>
 #include <asm/sclp.h>
+#include <asm/ap.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
 #include "trace.h"
@@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * handle_pqap: Handling pqap interception
+ * @vcpu: the vcpu having issue the pqap instruction
+ *
+ * We now support PQAP/AQIC instructions and we need to correctly
+ * answer the guest even if no dedicated driver's hook is available.
+ *
+ * The intercepting code calls a dedicated callback for this instruction
+ * if a driver did register one in the CRYPTO satellite of the
+ * SIE block.
+ *
+ * For PQAP/AQIC instructions only, verify privilege and specifications.
+ *
+ * If no callback available, the queues are not available, return this to
+ * the caller.
+ * Else return the value returned by the callback.
+ */
+static int handle_pqap(struct kvm_vcpu *vcpu)
+{
+	uint8_t fc;
+	struct ap_queue_status status = {};
+
+	/* Verify that the AP instruction are available */
+	if (!ap_instructions_available())
+		return -EOPNOTSUPP;
+	/* Verify that the guest is allowed to use AP instructions */
+	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
+		return -EOPNOTSUPP;
+	/* Verify that the function code is AQIC */
+	fc = vcpu->run->s.regs.gprs[0] >> 24;
+	if (fc != 0x03)
+		return -EOPNOTSUPP;
+
+	/* PQAP instructions are allowed for guest kernel only */
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+	/* AQIC instruction is allowed only if facility 65 is available */
+	if (!test_kvm_facility(vcpu->kvm, 65))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	/* Verify that the hook callback is registered and call it */
+	if (vcpu->kvm->arch.crypto.pqap_hook)
+		return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
+
+	/* PQAP/AQIC instructions are authorized but there is no queue */
+	status.response_code = 0x01;
+	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
+	return 0;
+}
+
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
 	int rc;
@@ -878,6 +928,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 		return handle_sthyi(vcpu);
 	case 0x7d:
 		return handle_stsi(vcpu);
+	case 0xaf:
+		return handle_pqap(vcpu);
 	case 0xb1:
 		return handle_stfl(vcpu);
 	case 0xb2:
-- 
2.7.4
