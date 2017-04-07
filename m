From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/9] KVM: s390: Use defines for intercept code
Date: Fri,  7 Apr 2017 12:47:57 +0200
Message-ID: <1491562082-6392-5-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Farhan Ali <alifm@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Let's use #define values for better readability.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 +++
 arch/s390/kvm/intercept.c        | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 18e9c9d..54e36e7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -175,7 +175,10 @@ struct kvm_s390_sie_block {
 #define ICPT_INST	0x04
 #define ICPT_PROGI	0x08
 #define ICPT_INSTPROGI	0x0C
+#define ICPT_EXTREQ	0x10
 #define ICPT_EXTINT	0x14
+#define ICPT_IOREQ	0x18
+#define ICPT_WAIT	0x1c
 #define ICPT_VALIDITY	0x20
 #define ICPT_STOP	0x28
 #define ICPT_OPEREXC	0x2C
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 0a17646..e831f4b 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -403,26 +403,26 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 
 	switch (vcpu->arch.sie_block->icptcode) {
-	case 0x10:
-	case 0x18:
+	case ICPT_EXTREQ:
+	case ICPT_IOREQ:
 		return handle_noop(vcpu);
-	case 0x04:
+	case ICPT_INST:
 		rc = handle_instruction(vcpu);
 		break;
-	case 0x08:
+	case ICPT_PROGI:
 		return handle_prog(vcpu);
-	case 0x14:
+	case ICPT_EXTINT:
 		return handle_external_interrupt(vcpu);
-	case 0x1c:
+	case ICPT_WAIT:
 		return kvm_s390_handle_wait(vcpu);
-	case 0x20:
+	case ICPT_VALIDITY:
 		return handle_validity(vcpu);
-	case 0x28:
+	case ICPT_STOP:
 		return handle_stop(vcpu);
-	case 0x2c:
+	case ICPT_OPEREXC:
 		rc = handle_operexc(vcpu);
 		break;
-	case 0x38:
+	case ICPT_PARTEXEC:
 		rc = handle_partial_execution(vcpu);
 		break;
 	default:
-- 
2.7.4
