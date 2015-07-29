From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/16] KVM: s390: add more debug data for the pfault diagnoses
Date: Wed, 29 Jul 2015 11:05:59 +0200
Message-ID: <1438160766-108179-10-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We're not only interested in the address of the control block, but
also in the requested subcommand and for the token subcommand, in the
specified token address and masks.

Suggested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 1871754..5fbfb88 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -88,6 +88,9 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 
 	switch (parm.subcode) {
 	case 0: /* TOKEN */
+		VCPU_EVENT(vcpu, 3, "pageref token addr 0x%llx "
+			   "select mask 0x%llx compare mask 0x%llx",
+			   parm.token_addr, parm.select_mask, parm.compare_mask);
 		if (vcpu->arch.pfault_token != KVM_S390_PFAULT_TOKEN_INVALID) {
 			/*
 			 * If the pagefault handshake is already activated,
@@ -117,6 +120,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 		 * the cancel, therefore to reduce code complexity, we assume
 		 * all outstanding tokens are already pending.
 		 */
+		VCPU_EVENT(vcpu, 3, "pageref cancel addr 0x%llx", parm.token_addr);
 		if (parm.token_addr || parm.select_mask ||
 		    parm.compare_mask || parm.zarch)
 			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-- 
2.3.0
