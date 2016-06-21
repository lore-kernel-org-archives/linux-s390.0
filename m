From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 34/51] KVM: s390: vsie: support aes dea wrapping keys
Date: Tue, 21 Jun 2016 15:13:12 +0200
Message-ID: <1466514809-146638-35-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

As soon as message-security-assist extension 3 is enabled for guest 2,
we have to allow key wrapping for guest 3.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index cd4bbfa..6b26b0b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -28,7 +28,8 @@ struct vsie_page {
 	struct kvm_s390_sie_block *scb_o;	/* 0x0200 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap *gmap;			/* 0x0208 */
-	__u8 reserved[0x0800 - 0x0210];		/* 0x0210 */
+	__u8 reserved[0x0700 - 0x0210];		/* 0x0210 */
+	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 } __packed;
 
@@ -111,6 +112,58 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/*
+ * Create a shadow copy of the crycb block and setup key wrapping, if
+ * requested for guest 3 and enabled for guest 2.
+ *
+ * We only accept format-1 (no AP in g2), but convert it into format-2
+ * There is nothing to do for format-0.
+ *
+ * Returns: - 0 if shadowed or nothing to do
+ *          - > 0 if control has to be given to guest 2
+ */
+static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	u32 crycb_addr = scb_o->crycbd & 0x7ffffff8U;
+	unsigned long *b1, *b2;
+	u8 ecb3_flags;
+
+	scb_s->crycbd = 0;
+	if (!(scb_o->crycbd & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
+		return 0;
+	/* format-1 is supported with message-security-assist extension 3 */
+	if (!test_kvm_facility(vcpu->kvm, 76))
+		return 0;
+	/* we may only allow it if enabled for guest 2 */
+	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
+		     (ECB3_AES | ECB3_DEA);
+	if (!ecb3_flags)
+		return 0;
+
+	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
+		return set_validity_icpt(scb_s, 0x003CU);
+	else if (!crycb_addr)
+		return set_validity_icpt(scb_s, 0x0039U);
+
+	/* copy only the wrapping keys */
+	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
+		return set_validity_icpt(scb_s, 0x0035U);
+
+	scb_s->ecb3 |= ecb3_flags;
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
+			CRYCB_FORMAT2;
+
+	/* xor both blocks in one run */
+	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
+	b2 = (unsigned long *)
+			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
+	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
+	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
+	return 0;
+}
+
 /* shadow (round up/down) the ibc to avoid validity icpt */
 static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
@@ -248,6 +301,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->ecb |= scb_o->ecb & 0x02U;
 
 	prepare_ibc(vcpu, vsie_page);
+	rc = shadow_crycb(vcpu, vsie_page);
 out:
 	if (rc)
 		unshadow_scb(vcpu, vsie_page);
-- 
2.5.5
