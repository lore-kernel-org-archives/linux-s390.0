From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: some ext irqs have to clear the ext cpu addr
Date: Thu,  4 Dec 2014 17:14:03 +0100
Message-ID: <1417709645-63747-2-git-send-email-borntraeger@de.ibm.com>
References: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The cpu address of a source cpu (responsible for an external irq) is only to
be stored if bit 6 of the ext irq code is set.

If bit 6 is not set, it is to be zeroed out.

The special external irq code used for virtio and pfault uses the cpu addr as a
parameter field. As bit 6 is set, this implementation is correct.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index b3d4409..6c0d14b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -281,6 +281,7 @@ static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_CPU_TIMER,
 			   (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
@@ -299,6 +300,7 @@ static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_CLK_COMP,
 			   (u16 __user *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
@@ -585,6 +587,7 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
 					 inti->ext.ext_params, 0);
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-- 
1.9.3
