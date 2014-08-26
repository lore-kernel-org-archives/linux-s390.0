From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/15] KVM: s390: add defines for pfault init delivery code
Date: Tue, 26 Aug 2014 10:28:13 +0200
Message-ID: <1409041707-39938-2-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Get rid of open coded values for pfault init.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f4c819b..6c9428e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -26,6 +26,7 @@
 #define IOINT_SSID_MASK 0x00030000
 #define IOINT_CSSID_MASK 0x03fc0000
 #define IOINT_AI_MASK 0x04000000
+#define PFAULT_INIT 0x0600
 
 static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
 
@@ -376,8 +377,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_PFAULT_INIT:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
 						 inti->ext.ext_params2);
-		rc  = put_guest_lc(vcpu, 0x2603, (u16 *) __LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, 0x0600, (u16 *) __LC_EXT_CPU_ADDR);
+		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
+				   (u16 *) __LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, PFAULT_INIT, (u16 *) __LC_EXT_CPU_ADDR);
 		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-- 
1.8.4.2
