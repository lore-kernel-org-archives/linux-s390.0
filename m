From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 2/5] KVM: s390: vsie: Only accept FORMAT1 CRYCB for guest2
Date: Wed, 22 Aug 2018 18:51:54 +0200
Message-ID: <1534956717-14087-3-git-send-email-pmorel@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

As the comment above the function suggested the shadowing
of the guest2 CRYCB can only accept a format 1 since
AP instructions are not supported in the guest.

Let's modify the check which allowed to accept a format 2 too.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 12b9707..56a9d47 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -156,7 +156,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	u8 ecb3_flags;
 
 	scb_s->crycbd = 0;
-	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
+	if (!(crycbd_o == CRYCB_FORMAT1))
+		return 0;
+	if (!(vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
 	/* format-1 is supported with message-security-assist extension 3 */
 	if (!test_kvm_facility(vcpu->kvm, 76))
-- 
2.7.4
