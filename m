From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/4] KVM: s390: use assignment instead of memcpy
Date: Tue, 15 Dec 2015 20:23:43 +0100
Message-ID: <1450207426-17222-2-git-send-email-borntraeger@de.ibm.com>
References: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Replace two memcpy with proper assignment.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6857262..6dec01d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2120,7 +2120,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	 */
 	kvm_check_async_pf_completion(vcpu);
 
-	memcpy(&vcpu->arch.sie_block->gg14, &vcpu->run->s.regs.gprs[14], 16);
+	vcpu->arch.sie_block->gg14 = vcpu->run->s.regs.gprs[14];
+	vcpu->arch.sie_block->gg15 = vcpu->run->s.regs.gprs[15];
 
 	if (need_resched())
 		schedule();
@@ -2185,7 +2186,8 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	if (guestdbg_enabled(vcpu))
 		kvm_s390_restore_guest_per_regs(vcpu);
 
-	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
+	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
+	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
 
 	if (vcpu->arch.sie_block->icptcode > 0) {
 		int rc = kvm_handle_sie_intercept(vcpu);
-- 
2.3.0
