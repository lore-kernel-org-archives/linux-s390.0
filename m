From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 16/18] KVM: s390: do not take mmap_sem on dirty log query
Date: Fri, 12 Feb 2016 14:23:00 +0100
Message-ID: <1455283382-62999-17-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Dirty log query can take a long time for huge guests.
Holding the mmap_sem for very long times  can cause some unwanted
latencies.
Turns out that we do not need to hold the mmap semaphore.
We hold the slots_lock for gfn->hva translation and walk the page
tables with that address, so no need to look at the VMAs. KVM also
holds a reference to the mm, which should prevent other things
going away. During the walk we take the necessary ptl locks.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d0dcf73..d4bcd86 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -274,7 +274,6 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
 	unsigned long address;
 	struct gmap *gmap = kvm->arch.gmap;
 
-	down_read(&gmap->mm->mmap_sem);
 	/* Loop over all guest pages */
 	last_gfn = memslot->base_gfn + memslot->npages;
 	for (cur_gfn = memslot->base_gfn; cur_gfn <= last_gfn; cur_gfn++) {
@@ -283,7 +282,6 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
 		if (gmap_test_and_clear_dirty(address, gmap))
 			mark_page_dirty(kvm, cur_gfn);
 	}
-	up_read(&gmap->mm->mmap_sem);
 }
 
 /* Section: vm related */
-- 
2.3.0
