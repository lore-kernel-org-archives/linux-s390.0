From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
Date: Wed, 22 Aug 2018 10:08:57 +0200
Message-ID: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Currently when shadowing the CRYCB on SIE entrance, the validation
tests the following:
- accept only FORMAT1 or FORMAT2
- test if MSAext facility (76) is installed
- accept the CRYCB if no keys are used
- verifies that the CRYCB format1 is inside a page
- verifies that the CRYCB origin is not 0

This is not following the architecture.

On SIE entrance, the CRYCB must be validated before accepting
any of its entries.

Let's do the validation in the right order and also verify
correctly the FORMAT2 CRYCB.

The testing of facility MSAext3 (76) is not useful as it is
already tested by kvm_crypto_init() to set FORMAT1.

The testing of a null CRYCB origin must be done what ever
the format of the guest3 CRYCB is.

The CRYCB must be contained inside a page, but the CRYCB size
depends on the CRYCB format.
Lets test what the guest2 initialized, we can not trust it to have
done things right.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a2b28cd..35c3907 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -158,28 +158,43 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->crycbd = 0;
 	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
-	/* format-1 is supported with message-security-assist extension 3 */
-	if (!test_kvm_facility(vcpu->kvm, 76))
-		return 0;
+	/*
+	 * If APIE is set or it the CRYCB Format is FORMAT1 or FORMAT2 with
+	 * APXA installed, the machine checks the validity of crycb origin.
+	 * KVM kvm_s390_crypto_init() makes sure that FORMAT2 is only used
+	 * if APXA is installed.
+	 * The guest2 hypervizor could have set APIE and Format2 so let's
+	 * test all these points.
+	 * We here have always a CRYCB FORMAT1 or FORMAT2 (FORMAT0 was
+	 * refused in previous test).
+	 */
+	if (!crycb_addr)
+		return set_validity_icpt(scb_s, 0x0039U);
+
+	if ((crycbd_o & 0x03) == CRYCB_FORMAT1)
+		if ((crycb_addr & PAGE_MASK) !=
+		   ((crycb_addr + 128) & PAGE_MASK))
+			return set_validity_icpt(scb_s, 0x003CU);
+
+	if ((crycbd_o & 0x03) == CRYCB_FORMAT2)
+		if ((crycb_addr & PAGE_MASK) !=
+		   ((crycb_addr + 256) & PAGE_MASK))
+			return set_validity_icpt(scb_s, 0x003CU);
+
 	/* we may only allow it if enabled for guest 2 */
 	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
 		     (ECB3_AES | ECB3_DEA);
 	if (!ecb3_flags)
 		return 0;
 
-	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
-		return set_validity_icpt(scb_s, 0x003CU);
-	else if (!crycb_addr)
-		return set_validity_icpt(scb_s, 0x0039U);
-
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72,
 			    vsie_page->crycb.dea_wrapping_key_mask, 56))
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
+	/* Set the shadow CRYCB format to format 2 */
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-- 
2.7.4
