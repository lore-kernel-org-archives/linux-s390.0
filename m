From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 8/8] KVM: s390: Add proper dirty bitmap support to S390 kvm.
Date: Wed,  9 Apr 2014 12:44:58 +0200
Message-ID: <1397040298-59306-9-git-send-email-borntraeger@de.ibm.com>
References: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Jason J. Herne" <jjherne@us.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@us.ibm.com>

Replace the kvm_s390_sync_dirty_log() stub with code to construct the KVM
dirty_bitmap from S390 memory change bits.  Also add code to properly clear
the dirty_bitmap size when clearing the bitmap.

Signed-off-by: Jason J. Herne <jjherne@us.ibm.com>
CC: Dominik Dingel <dingel@linux.vnet.ibm.com>
[Dominik Dingel: use gmap_test_and_clear_dirty, locking fixes]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
 virt/kvm/kvm_main.c      |  2 --
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b767ec9..346a347 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -11,6 +11,7 @@
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  *               Heiko Carstens <heiko.carstens@de.ibm.com>
  *               Christian Ehrhardt <ehrhardt@de.ibm.com>
+ *               Jason J. Herne <jjherne@us.ibm.com>
  */
 
 #include <linux/compiler.h>
@@ -179,6 +180,25 @@ int kvm_dev_ioctl_check_extension(long ext)
 	return r;
 }
 
+static void kvm_s390_sync_dirty_log(struct kvm *kvm,
+					struct kvm_memory_slot *memslot)
+{
+	gfn_t cur_gfn, last_gfn;
+	unsigned long address;
+	struct gmap *gmap = kvm->arch.gmap;
+
+	down_read(&gmap->mm->mmap_sem);
+	/* Loop over all guest pages */
+	last_gfn = memslot->base_gfn + memslot->npages;
+	for (cur_gfn = memslot->base_gfn; cur_gfn <= last_gfn; cur_gfn++) {
+		address = gfn_to_hva_memslot(memslot, cur_gfn);
+
+		if (gmap_test_and_clear_dirty(address, gmap))
+			mark_page_dirty(kvm, cur_gfn);
+	}
+	up_read(&gmap->mm->mmap_sem);
+}
+
 /* Section: vm related */
 /*
  * Get (and clear) the dirty memory log for a memory slot.
@@ -186,7 +206,36 @@ int kvm_dev_ioctl_check_extension(long ext)
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 			       struct kvm_dirty_log *log)
 {
-	return 0;
+	int r;
+	unsigned long n;
+	struct kvm_memory_slot *memslot;
+	int is_dirty = 0;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = -EINVAL;
+	if (log->slot >= KVM_USER_MEM_SLOTS)
+		goto out;
+
+	memslot = id_to_memslot(kvm->memslots, log->slot);
+	r = -ENOENT;
+	if (!memslot->dirty_bitmap)
+		goto out;
+
+	kvm_s390_sync_dirty_log(kvm, memslot);
+	r = kvm_get_dirty_log(kvm, log, &is_dirty);
+	if (r)
+		goto out;
+
+	/* Clear the dirty log */
+	if (is_dirty) {
+		n = kvm_dirty_bitmap_bytes(memslot);
+		memset(memslot->dirty_bitmap, 0, n);
+	}
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
 }
 
 static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 56baae8..7facdb1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -637,14 +637,12 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
  */
 static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
-#ifndef CONFIG_S390
 	unsigned long dirty_bytes = 2 * kvm_dirty_bitmap_bytes(memslot);
 
 	memslot->dirty_bitmap = kvm_kvzalloc(dirty_bytes);
 	if (!memslot->dirty_bitmap)
 		return -ENOMEM;
 
-#endif /* !CONFIG_S390 */
 	return 0;
 }
 
-- 
1.8.4.2
