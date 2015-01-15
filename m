From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 17/21] KVM: s390: Take addressing mode into account for MVPG interception
Date: Thu, 15 Jan 2015 14:43:30 +0100
Message-ID: <1421329414-76826-18-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The handler for MVPG partial execution interception does not take
the current CPU addressing mode into account yet, so addresses are
always treated as 64-bit addresses. For correct behaviour, we should
properly handle 24-bit and 31-bit addresses, too.

Since MVPG is defined to work with logical addresses, we can simply
use guest_translate_address() to achieve the required behaviour
(since DAT is disabled here, guest_translate_address() skips the MMU
translation and only translates the address via kvm_s390_logical_to_effective()
and kvm_s390_real_to_abs(), which is exactly what we want here).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 7c868a9..bebd215 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -318,17 +318,19 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
 	/* Make sure that the source is paged-in */
-	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
-	if (kvm_is_error_gpa(vcpu->kvm, srcaddr))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg2],
+				     &srcaddr, 0);
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, srcaddr, 0);
 	if (rc != 0)
 		return rc;
 
 	/* Make sure that the destination is paged-in */
-	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
-	if (kvm_is_error_gpa(vcpu->kvm, dstaddr))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg1],
+				     &dstaddr, 1);
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, dstaddr, 1);
 	if (rc != 0)
 		return rc;
-- 
1.9.3
