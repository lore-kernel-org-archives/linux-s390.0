From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/3] KVM: s390: clean up return code handling in irq delivery code
Date: Thu,  4 Dec 2014 17:14:05 +0100
Message-ID: <1417709645-63747-4-git-send-email-borntraeger@de.ibm.com>
References: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Instead of returning a possibly random or'ed together value, let's
always return -EFAULT if rc is set.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 86bc89a..f00f31e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -287,7 +287,7 @@ static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	clear_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
@@ -306,7 +306,7 @@ static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
@@ -334,7 +334,7 @@ static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= put_guest_lc(vcpu, ext.ext_params2, (u64 *) __LC_EXT_PARAMS2);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
@@ -371,7 +371,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
@@ -389,7 +389,7 @@ static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
 	rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	clear_bit(IRQ_PEND_RESTART, &li->pending_irqs);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_stop(struct kvm_vcpu *vcpu)
@@ -450,7 +450,7 @@ static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
@@ -478,7 +478,7 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW, &vcpu->arch.sie_block->gpsw,
 			    sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
@@ -572,7 +572,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_PGM_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
@@ -594,7 +594,7 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= put_guest_lc(vcpu, inti->ext.ext_params,
 			   (u32 *)__LC_EXT_PARAMS);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu,
@@ -614,7 +614,7 @@ static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
 			   (u64 *)__LC_EXT_PARAMS2);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu,
@@ -639,7 +639,7 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu,
 			   (u32 *)__LC_EXT_PARAMS);
 	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
 			   (u64 *)__LC_EXT_PARAMS2);
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
@@ -667,7 +667,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
@@ -692,7 +692,7 @@ static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc;
+	return rc ? -EFAULT : 0;
 }
 
 typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
-- 
1.9.3
