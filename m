From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/11] KVM: s390: add defines for virtio and pfault interrupt code
Date: Fri, 28 Nov 2014 14:25:35 +0100
Message-ID: <1417181139-25623-8-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Get rid of open coded value for virtio and pfault completion interrupts.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bccda76..481f136 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -27,6 +27,8 @@
 #define IOINT_CSSID_MASK 0x03fc0000
 #define IOINT_AI_MASK 0x04000000
 #define PFAULT_INIT 0x0600
+#define PFAULT_DONE 0x0680
+#define VIRTIO_PARAM 0x0d00
 
 static int __must_check deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
 
@@ -391,7 +393,7 @@ static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
 						 inti->ext.ext_params2);
 		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, 0x0680, (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= put_guest_lc(vcpu, PFAULT_DONE, (u16 *)__LC_EXT_CPU_ADDR);
 		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 				     &vcpu->arch.sie_block->gpsw,
 				     sizeof(psw_t));
@@ -408,7 +410,7 @@ static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 						 inti->ext.ext_params,
 						 inti->ext.ext_params2);
 		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, 0x0d00, (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= put_guest_lc(vcpu, VIRTIO_PARAM, (u16 *)__LC_EXT_CPU_ADDR);
 		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 				     &vcpu->arch.sie_block->gpsw,
 				     sizeof(psw_t));
-- 
1.9.3
