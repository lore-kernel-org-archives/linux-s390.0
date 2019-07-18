Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Wanpeng Li <kernellwp@gmail.com>
Subject: [PATCH v2 2/2] KVM:390: Use kvm_vcpu_wake_up in kvm_s390_vcpu_wakeup
Date: Thu, 18 Jul 2019 19:39:07 +0800
Message-Id: <1563449947-7749-2-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1563449947-7749-1-git-send-email-wanpengli@tencent.com>
References: <1563449947-7749-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Wanpeng Li <wanpengli@tencent.com>

Use kvm_vcpu_wake_up() in kvm_s390_vcpu_wakeup().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/s390/kvm/interrupt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 26f8bf4..881cc5a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1229,21 +1229,8 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 	 * in kvm_vcpu_block without having the waitqueue set (polling)
 	 */
 	vcpu->valid_wakeup = true;
-	/*
-	 * This is mostly to document, that the read in swait_active could
-	 * be moved before other stores, leading to subtle races.
-	 * All current users do not store or use an atomic like update
-	 */
-	smp_mb__after_atomic();
-	if (swait_active(&vcpu->wq)) {
-		/*
-		 * The vcpu gave up the cpu voluntarily, mark it as a good
-		 * yield-candidate.
-		 */
+	if (kvm_vcpu_wake_up(vcpu))
 		vcpu->ready = true;
-		swake_up_one(&vcpu->wq);
-		vcpu->stat.halt_wakeup++;
-	}
 	/*
 	 * The VCPU might not be sleeping but is executing the VSIE. Let's
 	 * kick it, so it leaves the SIE to process the request.
-- 
2.7.4
