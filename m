From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 5/6] KVM: s390: SIGP START has to report BUSY while stopping a CPU
Date: Wed, 11 Dec 2013 19:57:48 +0100
Message-ID: <1386788269-20249-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Just like the RESTART order, the START order also has to report BUSY
while a STOP request is pending, to avoid that the START might be
ignored due to a race condition between the STOP and the START order.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/sigp.h |    1 +
 arch/s390/kvm/sigp.c         |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index c002cd5..d091aa1 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -5,6 +5,7 @@
 #define SIGP_SENSE		      1
 #define SIGP_EXTERNAL_CALL	      2
 #define SIGP_EMERGENCY_SIGNAL	      3
+#define SIGP_START		      4
 #define SIGP_STOP		      5
 #define SIGP_RESTART		      6
 #define SIGP_STOP_AND_STORE_STATUS    9
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 509547d..87c2b3a 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -455,6 +455,11 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		rc = __sigp_sense_running(vcpu, cpu_addr,
 					  &vcpu->run->s.regs.gprs[r1]);
 		break;
+	case SIGP_START:
+		rc = sigp_check_callable(vcpu, cpu_addr);
+		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED)
+			rc = -EOPNOTSUPP;    /* Handle START in user space */
+		break;
 	case SIGP_RESTART:
 		vcpu->stat.instruction_sigp_restart++;
 		rc = sigp_check_callable(vcpu, cpu_addr);
-- 
1.7.9.5
