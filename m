From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 9/9] KVM: s390: drop handling of interception code 12
Date: Mon, 11 May 2015 10:44:37 +0200
Message-ID: <1431333877-28700-10-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Our implementation will never trigger interception code 12 as the
responsible setting is never enabled - and never will be.
The handler is dead code. Let's get rid of it.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 9e3779e..7365e8a 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -241,21 +241,6 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 }
 
-static int handle_instruction_and_prog(struct kvm_vcpu *vcpu)
-{
-	int rc, rc2;
-
-	vcpu->stat.exit_instr_and_program++;
-	rc = handle_instruction(vcpu);
-	rc2 = handle_prog(vcpu);
-
-	if (rc == -EOPNOTSUPP)
-		vcpu->arch.sie_block->icptcode = 0x04;
-	if (rc)
-		return rc;
-	return rc2;
-}
-
 /**
  * handle_external_interrupt - used for external interruption interceptions
  *
@@ -355,7 +340,6 @@ static const intercept_handler_t intercept_funcs[] = {
 	[0x00 >> 2] = handle_noop,
 	[0x04 >> 2] = handle_instruction,
 	[0x08 >> 2] = handle_prog,
-	[0x0C >> 2] = handle_instruction_and_prog,
 	[0x10 >> 2] = handle_noop,
 	[0x14 >> 2] = handle_external_interrupt,
 	[0x18 >> 2] = handle_noop,
-- 
2.3.0
