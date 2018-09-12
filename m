From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v10 16/26] KVM: s390: vsie: Do the CRYCB validation first
Date: Wed, 12 Sep 2018 15:43:06 -0400
Message-ID: <1536781396-13601-17-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

We need to handle the validity checks for the crycb, no matter what the
settings for the keywrappings are. So lets move the keywrapping checks
after we have done the validy checks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 12b9707..38ea5da 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -161,17 +161,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* format-1 is supported with message-security-assist extension 3 */
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return 0;
-	/* we may only allow it if enabled for guest 2 */
-	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
-		     (ECB3_AES | ECB3_DEA);
-	if (!ecb3_flags)
-		return 0;
 
 	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
 		return set_validity_icpt(scb_s, 0x003CU);
 	else if (!crycb_addr)
 		return set_validity_icpt(scb_s, 0x0039U);
 
+	/* we may only allow it if enabled for guest 2 */
+	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
+		     (ECB3_AES | ECB3_DEA);
+	if (!ecb3_flags)
+		return 0;
+
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72,
 			    vsie_page->crycb.dea_wrapping_key_mask, 56))
-- 
1.7.1
