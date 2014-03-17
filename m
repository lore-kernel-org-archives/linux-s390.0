From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 2/2] KVM: s390: Optimize ucontrol path
Date: Mon, 17 Mar 2014 12:14:00 +0100
Message-ID: <1395054840-52175-3-git-send-email-borntraeger@de.ibm.com>
References: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1395054840-52175-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since commit 7c470539c95630c1f2a10f109e96f249730b75eb
(s390/kvm: avoid automatic sie reentry) we will run through the C code
of KVM on host interrupts instead of just reentering the guest. This
will result in additional ucontrol exits (at least HZ per second). Let
handle a 0 intercept in the kernel and dont return to userspace,
even if in ucontrol mode.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
CC: stable@vger.kernel.org
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6268357..7337c57 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -896,7 +896,8 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 
 	if (rc == 0) {
 		if (kvm_is_ucontrol(vcpu->kvm))
-			rc = -EOPNOTSUPP;
+			/* Don't exit for host interrupts. */
+			rc = vcpu->arch.sie_block->icptcode ? -EOPNOTSUPP : 0;
 		else
 			rc = kvm_handle_sie_intercept(vcpu);
 	}
-- 
1.8.4.2
