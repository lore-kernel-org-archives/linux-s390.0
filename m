From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v10 18/26] KVM: s390: vsie: Allow CRYCB FORMAT-2
Date: Wed, 12 Sep 2018 15:43:08 -0400
Message-ID: <1536781396-13601-19-git-send-email-akrowiak@linux.vnet.ibm.com>
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

When the guest and the host both use CRYCB FORMAT-2,
we copy the guest's FORMAT-1 APCB to a FORMAT-1
shadow APCB.

This patch also cleans up the shadow_crycb() function.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/vsie.c |  114 +++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index e0e6fbf..3a93278 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -136,14 +136,81 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
-/*
+/**
+ * setup_apcb11 - Copy the FORMAT1 APCB from the guest to the shadow CRYCB
+ * @vcpu: pointer to the virtual CPU
+ * @apcb_s: pointer to start of apcb in the shadow crycb
+ * @apcb_o: pointer to start of original guest apcb
+ * @apcb_h: pointer to start of apcb in the host
+ *
+ * Returns 0 and -EFAULT on error reading guest apcb
+ */
+static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
+			unsigned long apcb_o,
+			unsigned long *apcb_h)
+{
+	if (read_guest_real(vcpu, apcb_o, apcb_s,
+			    sizeof(struct kvm_s390_apcb1)))
+		return -EFAULT;
+
+	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb1));
+
+	return 0;
+}
+
+/**
+ * setup_apcb - Create a shadow copy of the apcb.
+ * @vcpu: pointer to the virtual CPU
+ * @crycb_s: pointer to shadow crycb
+ * @crycb_o: pointer to original guest crycb
+ * @crycb_h: pointer to the host crycb
+ * @fmt_o: format of the original guest crycb.
+ * @fmt_h: format of the host crycb.
+ *
+ * Checks the compatibility between the guest and host crycb and calls the
+ * appropriate copy function.
+ *
+ * Return 0 or an error number if the guest and host crycb are incompatible.
+ */
+static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
+	       const u32 crycb_o,
+	       struct kvm_s390_crypto_cb *crycb_h,
+	       int fmt_o, int fmt_h)
+{
+	struct kvm_s390_crypto_cb *crycb;
+
+	crycb = (struct kvm_s390_crypto_cb *) (unsigned long)crycb_o;
+
+	switch (fmt_o) {
+	case CRYCB_FORMAT2:
+		if ((crycb_o & PAGE_MASK) != ((crycb_o + 256) & PAGE_MASK))
+			return -EACCES;
+		if (fmt_h != CRYCB_FORMAT2)
+			return -EINVAL;
+		return setup_apcb11(vcpu, (unsigned long *)&crycb_s->apcb1,
+				    (unsigned long) &crycb->apcb1,
+				    (unsigned long *)&crycb_h->apcb1);
+	}
+	return -EINVAL;
+}
+
+/**
+ * shadow_crycb - Create a shadow copy of the crycb block
+ * @vcpu: a pointer to the virtual CPU
+ * @vsie_page: a pointer to internal date used for the vSIE
+ *
  * Create a shadow copy of the crycb block and setup key wrapping, if
  * requested for guest 3 and enabled for guest 2.
  *
- * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
- * and we convert it into format-2 in the shadow CRYCB.
+ * We accept format-1 or format-2, but we convert format-1 into format-2
+ * in the shadow CRYCB.
+ * Using format-2 enables the firmware to choose the right format when
+ * scheduling the SIE.
  * There is nothing to do for format-0.
  *
+ * This function centralize the issuing of set_validity_icpt() for all
+ * the subfunctions working on the crycb.
+ *
  * Returns: - 0 if shadowed or nothing to do
  *          - > 0 if control has to be given to guest 2
  */
@@ -155,24 +222,42 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
+	int apie_h;
+	int key_msk = test_kvm_facility(vcpu->kvm, 76);
+	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
+	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
+	int ret = 0;
 
 	scb_s->crycbd = 0;
 	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
-	/* format-1 is supported with message-security-assist extension 3 */
-	if (!test_kvm_facility(vcpu->kvm, 76))
+
+	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
+	if (!apie_h && !key_msk)
 		return 0;
 
-	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
-		return set_validity_icpt(scb_s, 0x003CU);
-	else if (!crycb_addr)
+	if (!crycb_addr)
 		return set_validity_icpt(scb_s, 0x0039U);
 
+	if (fmt_o == CRYCB_FORMAT1)
+		if ((crycb_addr & PAGE_MASK) !=
+		    ((crycb_addr + 128) & PAGE_MASK))
+			return set_validity_icpt(scb_s, 0x003CU);
+
+	if (apie_h && (scb_o->eca & ECA_APIE)) {
+		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
+				 vcpu->kvm->arch.crypto.crycb,
+				 fmt_o, fmt_h);
+		if (ret)
+			goto end;
+		scb_s->eca |= scb_o->eca & ECA_APIE;
+	}
+
 	/* we may only allow it if enabled for guest 2 */
 	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
 		     (ECB3_AES | ECB3_DEA);
 	if (!ecb3_flags)
-		return 0;
+		goto end;
 
 	/* copy only the wrapping keys */
 	if (read_guest_real(vcpu, crycb_addr + 72,
@@ -180,7 +265,6 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
@@ -188,6 +272,16 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
 	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
 	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
+end:
+	switch (ret) {
+	case -EINVAL:
+		return set_validity_icpt(scb_s, 0x0020U);
+	case -EFAULT:
+		return set_validity_icpt(scb_s, 0x0035U);
+	case -EACCES:
+		return set_validity_icpt(scb_s, 0x003CU);
+	}
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 	return 0;
 }
 
-- 
1.7.1
