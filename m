From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] KVM: s390: vsie: use common code functions for pinning
Date: Wed,  8 Nov 2017 09:41:41 +0100
Message-ID: <20171108084143.78654-4-borntraeger@de.ibm.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

We will not see -ENOMEM (gfn_to_hva() will return KVM_ERR_PTR_BAD_PAGE
for all errors). So we can also get rid of special handling in the
callers of pin_guest_page() and always assume that it is a g2 error.

As also kvm_s390_inject_program_int() should never fail, we can
simplify pin_scb(), too.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170901151143.22714-1-david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c     | 50 +++++++++++++++++-------------------------------
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      |  4 ++--
 3 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index b18b565..a311938 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -443,22 +443,14 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  *
  * Returns: - 0 on success
  *          - -EINVAL if the gpa is not valid guest storage
- *          - -ENOMEM if out of memory
  */
 static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
 {
 	struct page *page;
-	hva_t hva;
-	int rc;
 
-	hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
-	if (kvm_is_error_hva(hva))
+	page = gfn_to_page(kvm, gpa_to_gfn(gpa));
+	if (is_error_page(page))
 		return -EINVAL;
-	rc = get_user_pages_fast(hva, 1, 1, &page);
-	if (rc < 0)
-		return rc;
-	else if (rc != 1)
-		return -ENOMEM;
 	*hpa = (hpa_t) page_to_virt(page) + (gpa & ~PAGE_MASK);
 	return 0;
 }
@@ -466,11 +458,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
 /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
 static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 {
-	struct page *page;
-
-	page = virt_to_page(hpa);
-	set_page_dirty_lock(page);
-	put_page(page);
+	kvm_release_pfn_dirty(hpa >> PAGE_SHIFT);
 	/* mark the page always as dirty for migration */
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }
@@ -557,7 +545,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x003bU);
 		if (!rc) {
 			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-			if (rc == -EINVAL)
+			if (rc)
 				rc = set_validity_icpt(scb_s, 0x0034U);
 		}
 		if (rc)
@@ -574,10 +562,10 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		}
 		/* 256 bytes cannot cross page boundaries */
 		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc == -EINVAL)
+		if (rc) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
-		if (rc)
 			goto unpin;
+		}
 		scb_s->itdba = hpa;
 	}
 
@@ -592,10 +580,10 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 * if this block gets bigger, we have to shadow it.
 		 */
 		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc == -EINVAL)
+		if (rc) {
 			rc = set_validity_icpt(scb_s, 0x1310U);
-		if (rc)
 			goto unpin;
+		}
 		scb_s->gvrd = hpa;
 	}
 
@@ -607,11 +595,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		}
 		/* 64 bytes cannot cross page boundaries */
 		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc == -EINVAL)
+		if (rc) {
 			rc = set_validity_icpt(scb_s, 0x0043U);
-		/* Validity 0x0044 will be checked by SIE */
-		if (rc)
 			goto unpin;
+		}
+		/* Validity 0x0044 will be checked by SIE */
 		scb_s->riccbd = hpa;
 	}
 	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
@@ -635,10 +623,10 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 * cross page boundaries
 		 */
 		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc == -EINVAL)
+		if (rc) {
 			rc = set_validity_icpt(scb_s, 0x10b0U);
-		if (rc)
 			goto unpin;
+		}
 		scb_s->sdnxo = hpa | sdnxc;
 	}
 	return 0;
@@ -663,7 +651,6 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
  *
  * Returns: - 0 if the scb was pinned.
  *          - > 0 if control has to be given to guest 2
- *          - -ENOMEM if out of memory
  */
 static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		   gpa_t gpa)
@@ -672,14 +659,13 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	int rc;
 
 	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-	if (rc == -EINVAL) {
+	if (rc) {
 		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		if (!rc)
-			rc = 1;
+		WARN_ON_ONCE(rc);
+		return 1;
 	}
-	if (!rc)
-		vsie_page->scb_o = (struct kvm_s390_sie_block *) hpa;
-	return rc;
+	vsie_page->scb_o = (struct kvm_s390_sie_block *) hpa;
+	return 0;
 }
 
 /*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538..2e754b7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -667,6 +667,7 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
 			       bool *writable);
 
 void kvm_release_pfn_clean(kvm_pfn_t pfn);
+void kvm_release_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_accessed(kvm_pfn_t pfn);
 void kvm_get_pfn(kvm_pfn_t pfn);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a2..37731f6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -122,7 +122,6 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-static void kvm_release_pfn_dirty(kvm_pfn_t pfn);
 static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
 
 __visible bool kvm_rebooting;
@@ -1679,11 +1678,12 @@ void kvm_release_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL_GPL(kvm_release_page_dirty);
 
-static void kvm_release_pfn_dirty(kvm_pfn_t pfn)
+void kvm_release_pfn_dirty(kvm_pfn_t pfn)
 {
 	kvm_set_pfn_dirty(pfn);
 	kvm_release_pfn_clean(pfn);
 }
+EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
 
 void kvm_set_pfn_dirty(kvm_pfn_t pfn)
 {
-- 
2.9.4
