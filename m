From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 45/51] KVM: s390: vsie: try to refault after a reported fault to g2
Date: Tue, 21 Jun 2016 15:13:23 +0200
Message-ID: <1466514809-146638-46-git-send-email-borntraeger@de.ibm.com>
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

We can avoid one unneeded SIE entry after we reported a fault to g2.
Theoretically, g2 resolves the fault and we can create the shadow mapping
directly, instead of failing again when entering the SIE.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 3ececbb..7482488 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -28,7 +28,9 @@ struct vsie_page {
 	struct kvm_s390_sie_block *scb_o;	/* 0x0200 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap *gmap;			/* 0x0208 */
-	__u8 reserved[0x0700 - 0x0210];		/* 0x0210 */
+	/* address of the last reported fault to guest2 */
+	unsigned long fault_addr;		/* 0x0210 */
+	__u8 reserved[0x0700 - 0x0218];		/* 0x0218 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 } __packed;
@@ -676,10 +678,27 @@ static int handle_fault(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		rc = inject_fault(vcpu, rc,
 				  current->thread.gmap_addr,
 				  current->thread.gmap_write_flag);
+		if (rc >= 0)
+			vsie_page->fault_addr = current->thread.gmap_addr;
 	}
 	return rc;
 }
 
+/*
+ * Retry the previous fault that required guest 2 intervention. This avoids
+ * one superfluous SIE re-entry and direct exit.
+ *
+ * Will ignore any errors. The next SIE fault will do proper fault handling.
+ */
+static void handle_last_fault(struct kvm_vcpu *vcpu,
+			      struct vsie_page *vsie_page)
+{
+	if (vsie_page->fault_addr)
+		kvm_s390_shadow_fault(vcpu, vsie_page->gmap,
+				      vsie_page->fault_addr);
+	vsie_page->fault_addr = 0;
+}
+
 static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
 {
 	vsie_page->scb_s.icptcode = 0;
@@ -737,6 +756,8 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	int rc;
 
+	handle_last_fault(vcpu, vsie_page);
+
 	if (need_resched())
 		schedule();
 	if (test_cpu_flag(CIF_MCCK_PENDING))
@@ -928,6 +949,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	vsie_page = page_to_virt(page);
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
 	release_gmap_shadow(vsie_page);
+	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;
 	return vsie_page;
 }
-- 
2.5.5
