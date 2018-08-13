From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 20/22] KVM: s390: Handling of Cypto control block in VSIE
Date: Mon, 13 Aug 2018 17:48:17 -0400
Message-ID: <1534196899-16987-21-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

Shadowing the crypto control block now supports APCB shadowing.

AP instruction interpretation for guest 3 through ECA.28 is shadowed when
guest 2 ECA.28 is set.

CRYCB is shadowed for APCB and wrapping keys.

CRYCB format 0 is now supported for both guests 2 and 3.

Shadow CRYCB always uses the guest 2 CRYCB format and it
follows that:

* Guest 3 CRYCB format 0 is supported with guest 2 CRYCB format 0,1 or 2
* Guest 3 CRYCB format 1 is supported with guest 2 CRYCB format 1 or 2
* Guest 3 CRYCB format 2 is supported with guest 2 CRYCB format 2

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c |  222 ++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 198 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index aa30b48..e15240e 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,17 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/*
- * Create a shadow copy of the crycb block and setup key wrapping, if
- * requested for guest 3 and enabled for guest 2.
- *
- * We only accept format-1 (no AP in g2), but convert it into format-2
- * There is nothing to do for format-0.
- *
- * Returns: - 0 if shadowed or nothing to do
- *          - > 0 if control has to be given to guest 2
- */
-static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+/* Copy keys into shadow crycb, is only called if MSA3 is available.  */
+static int copy_key_masks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
@@ -155,30 +146,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
 
-	scb_s->crycbd = 0;
-	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
-		return 0;
-	/* format-1 is supported with message-security-assist extension 3 */
-	if (!test_kvm_facility(vcpu->kvm, 76))
-		return 0;
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
 	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
@@ -189,6 +167,202 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/* Copy masks into apcb when g2 and g3 use format 1 */
+static int copy_apcb1(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_crypto_cb *crycb_h = &vcpu->kvm->arch.sie_page2->crycb;
+	struct kvm_s390_crypto_cb *crycb_s = &vsie_page->crycb;
+	unsigned long *apcb_s = (unsigned long *) &crycb_s->apcb1;
+	unsigned long *apcb_h = (unsigned long *) &crycb_h->apcb1;
+	int i;
+	u32 src;
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb1);
+	if (read_guest_real(vcpu, src, apcb_s, sizeof(struct kvm_s390_apcb1)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	for (i = 0; i < sizeof(struct kvm_s390_apcb1); i += sizeof(*apcb_s))
+		*apcb_s &= *apcb_h;
+
+	return 0;
+}
+
+/*
+ * Copy masks into apcb when g2 use format 1 and g3 use format 0
+ * In this case the shadow APCB uses format 1
+ */
+static int copy_apcb01(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_apcb1 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb1;
+	struct kvm_s390_apcb1 *apcb_s = &vsie_page->crycb.apcb1;
+	u32 src;
+
+	memset(apcb_s, 0, sizeof(*apcb_s));
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	apcb_s->apm[0] &= apcb_h->apm[0];
+	apcb_s->aqm[0] &= apcb_h->aqm[0];
+	apcb_s->adm[0] &= apcb_h->adm[0];
+
+	return 0;
+}
+
+/* Copy masks into apcb when g2 and g3 use format 0 */
+static int copy_apcb0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
+	struct kvm_s390_apcb0 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb0;
+	struct kvm_s390_apcb0 *apcb_s = &vsie_page->crycb.apcb0;
+	u32 src;
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
+	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	apcb_s->apm[0] &= apcb_h->apm[0];
+	apcb_s->aqm[0] &= apcb_h->aqm[0];
+	apcb_s->adm[0] &= apcb_h->adm[0];
+
+	return 0;
+}
+
+/* Shadowing APCB depends on G2 and G3 CRYCB format */
+static int copy_apcb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		     int g2_fmt, int g3_fmt)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	int ret = 0;
+
+	switch (g2_fmt) {
+	case CRYCB_FORMAT0:
+		switch (g3_fmt) {
+		case  CRYCB_FORMAT0:
+			ret = copy_apcb0(vcpu, vsie_page);
+			break;
+		default:
+			return set_validity_icpt(scb_s, 0x0020U);
+		}
+		break;
+	case CRYCB_FORMAT1:
+		switch (g3_fmt) {
+		case CRYCB_FORMAT1:
+		case CRYCB_FORMAT0:	/* Fall through to copy APCB */
+			ret = copy_apcb0(vcpu, vsie_page);
+			break;
+		default:
+			return set_validity_icpt(scb_s, 0x0020U);
+		}
+		break;
+	case CRYCB_FORMAT2:
+		switch (g3_fmt) {
+		case CRYCB_FORMAT0:
+		case CRYCB_FORMAT1:
+			ret = copy_apcb01(vcpu, vsie_page);
+			break;
+		case CRYCB_FORMAT2:
+			ret = copy_apcb1(vcpu, vsie_page);
+			break;
+		}
+		break;
+	default:
+	/*
+	 * Guest 2 format is valid or we can not get to here.
+	 */
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Create a shadow copy of the crycb block.
+ * - Setup key wrapping, if requested for guest 3 and enabled for guest 2.
+ * - Shadow APCB if requested by guest 3 and enabled for guest 2 through
+ *   ECA_APIE.
+ *
+ * We only accept format-1 (no AP in g2), but convert it into format-2
+ * There is nothing to do for format-0.
+ *
+ * Returns: - 0 if shadowed or nothing to do
+ *          - > 0 if control has to be given to guest 2
+ *          - < 0 if something went wrong on copy
+ */
+static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
+	int g2_fmt = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
+	int g3_fmt = crycbd_o & CRYCB_FORMAT_MASK;
+	int g2_apie, g2_msa3, g3_apie, g3_msa3;
+	int size, ret;
+
+	/* crycb should not cross a page boundary */
+	size = (g3_fmt == CRYCB_FORMAT2) ? 0x100 : 0x80;
+	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + size) & PAGE_MASK))
+		return set_validity_icpt(scb_s, 0x003CU);
+
+	g2_apie = vcpu->arch.sie_block->eca & ECA_APIE;
+	g3_apie = scb_o->eca & g2_apie;
+
+	g2_msa3 = test_kvm_facility(vcpu->kvm, 76);
+	g3_msa3 = (g3_fmt != CRYCB_FORMAT0) & g2_msa3;
+
+	scb_s->crycbd = 0;
+	/* If no AP instructions and no keys we just set crycbd to 0 */
+	if (!(g3_apie || g3_msa3))
+		return 0;
+
+	if (!crycb_addr)
+		return set_validity_icpt(scb_s, 0x0039U);
+
+	if (g3_apie) {
+		ret = copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
+		if (ret)
+			return ret;
+		scb_s->eca |= g3_apie;
+	}
+
+	if (g3_msa3)
+		ret = copy_key_masks(vcpu, vsie_page);
+
+	if (!ret)
+		scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | g2_fmt;
+
+	return ret;
+}
+
 /* shadow (round up/down) the ibc to avoid validity icpt */
 static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-- 
1.7.1
