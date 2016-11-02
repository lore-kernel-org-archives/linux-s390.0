From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 07/11] KVM: Introduce kvm_write_guest_offset_cached
Date: Wed,  2 Nov 2016 05:08:34 -0400
Message-ID: <1478077718-37424-8-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net, konrad.wilk@oracle.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

It allows us to update some status or field of one struct partially.

We can also save one kvm_read_guest_cached if we just update one filed
of the struct regardless of its current value.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01c0b9c..6f00237 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -645,6 +645,8 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
+int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, int offset, unsigned long len);
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2907b7b..95308ee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1972,30 +1972,38 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 }
 EXPORT_SYMBOL_GPL(kvm_gfn_to_hva_cache_init);
 
-int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, unsigned long len)
+int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, int offset, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	int r;
+	gpa_t gpa = ghc->gpa + offset;
 
-	BUG_ON(len > ghc->len);
+	BUG_ON(len + offset > ghc->len);
 
 	if (slots->generation != ghc->generation)
 		kvm_gfn_to_hva_cache_init(kvm, ghc, ghc->gpa, ghc->len);
 
 	if (unlikely(!ghc->memslot))
-		return kvm_write_guest(kvm, ghc->gpa, data, len);
+		return kvm_write_guest(kvm, gpa, data, len);
 
 	if (kvm_is_error_hva(ghc->hva))
 		return -EFAULT;
 
-	r = __copy_to_user((void __user *)ghc->hva, data, len);
+	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, ghc->gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kvm_write_guest_offset_cached);
+
+int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, unsigned long len)
+{
+	return kvm_write_guest_offset_cached(kvm, ghc, data, 0, len);
+}
 EXPORT_SYMBOL_GPL(kvm_write_guest_cached);
 
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-- 
2.4.11
