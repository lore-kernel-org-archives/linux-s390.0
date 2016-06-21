From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 29/51] KVM: s390: vsie: optimize gmap prefix mapping
Date: Tue, 21 Jun 2016 15:13:07 +0200
Message-ID: <1466514809-146638-30-git-send-email-borntraeger@de.ibm.com>
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

In order to not always map the prefix, we have to take care of certain
aspects that implicitly unmap the prefix:
- Changes to the prefix address
- Changes to MSO, because the HVA of the prefix is changed
- Changes of the gmap shadow (e.g. unshadowed, asce or edat changes)

By properly handling these cases, we can stop remapping the prefix when
there is no reason to do so.

This also allows us now to not acquire any gmap shadow locks when
rerunning the vsie and still having a valid gmap shadow.

Please note, to detect changing gmap shadows, we have to keep the reference
of the gmap shadow. The address of a gmap shadow does otherwise not
reliably indicate if the gmap shadow has changed (the memory chunk
could get reused).

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 747d4f9..2839efc 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -62,6 +62,11 @@ static void prefix_mapped(struct vsie_page *vsie_page)
 	atomic_andnot(PROG_REQUEST, &vsie_page->scb_s.prog20);
 }
 
+/* test if the prefix is mapped into the gmap shadow */
+static int prefix_is_mapped(struct vsie_page *vsie_page)
+{
+	return !(atomic_read(&vsie_page->scb_s.prog20) & PROG_REQUEST);
+}
 
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
@@ -152,6 +157,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	unsigned long new_mso;
 	int rc;
 
 	/* make sure we don't have any leftovers when reusing the scb */
@@ -192,9 +198,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 	scb_s->icpua = scb_o->icpua;
 
+	new_mso = scb_o->mso & 0xfffffffffff00000UL;
+	/* if the hva of the prefix changes, we have to remap the prefix */
+	if (scb_s->mso != new_mso || scb_s->prefix != scb_o->prefix)
+		prefix_unmapped(vsie_page);
 	 /* SIE will do mso/msl validity and exception checks for us */
 	scb_s->msl = scb_o->msl & 0xfffffffffff00000UL;
-	scb_s->mso = scb_o->mso & 0xfffffffffff00000UL;
+	scb_s->mso = new_mso;
 	scb_s->prefix = scb_o->prefix;
 
 	/* We have to definetly flush the tlb if this scb never ran */
@@ -262,6 +272,9 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	u64 prefix = scb_s->prefix << GUEST_PREFIX_SHIFT;
 	int rc;
 
+	if (prefix_is_mapped(vsie_page))
+		return 0;
+
 	/* mark it as mapped so we can catch any concurrent unmappers */
 	prefix_mapped(vsie_page);
 
@@ -532,6 +545,7 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	if (vsie_page->gmap)
 		gmap_put(vsie_page->gmap);
 	WRITE_ONCE(vsie_page->gmap, NULL);
+	prefix_unmapped(vsie_page);
 }
 
 static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
@@ -547,6 +561,16 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
 	edat = cr0.edat && test_kvm_facility(vcpu->kvm, 8);
 	edat += edat && test_kvm_facility(vcpu->kvm, 78);
 
+	/*
+	 * ASCE or EDAT could have changed since last icpt, or the gmap
+	 * we're holding has been unshadowed. If the gmap is still valid,
+	 * we can safely reuse it.
+	 */
+	if (vsie_page->gmap && gmap_shadow_valid(vsie_page->gmap, asce, edat))
+		return 0;
+
+	/* release the old shadow - if any, and mark the prefix as unmapped */
+	release_gmap_shadow(vsie_page);
 	gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
 	if (IS_ERR(gmap))
 		return PTR_ERR(gmap);
@@ -578,7 +602,6 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = do_vsie_run(vcpu, vsie_page);
 			gmap_enable(vcpu->arch.gmap);
 		}
-		release_gmap_shadow(vsie_page);
 
 		if (rc == -EAGAIN)
 			rc = 0;
@@ -667,6 +690,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	vsie_page = page_to_virt(page);
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
+	release_gmap_shadow(vsie_page);
 	vsie_page->scb_s.ihcpu = 0xffffU;
 	return vsie_page;
 }
@@ -739,6 +763,7 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
+	struct vsie_page *vsie_page;
 	struct page *page;
 	int i;
 
@@ -746,6 +771,8 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
 		page = kvm->arch.vsie.pages[i];
 		kvm->arch.vsie.pages[i] = NULL;
+		vsie_page = page_to_virt(page);
+		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
 		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
 		__free_page(page);
-- 
2.5.5
