From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:43 +0000
Subject: [GIT PULL 16/28] KVM: s390: vsie: Do the CRYCB validation first
Message-Id: <20181002070655.224110-17-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

We need to handle the validity checks for the crycb, no matter what the
settings for the keywrappings are. So lets move the keywrapping checks
after we have done the validy checks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180925231641.4954-17-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 12b970701c26..38ea5da4e642 100644
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
2.17.0
