From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 4/4] kvm: convert kvm.users_count from atomic_t to refcount_t
Date: Mon, 20 Feb 2017 13:06:21 +0200
Message-ID: <1487588781-15123-5-git-send-email-elena.reshetova@intel.com>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/kvm_host.h | 3 ++-
 virt/kvm/kvm_main.c      | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cda457b..7fa05a5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -26,6 +26,7 @@
 #include <linux/context_tracking.h>
 #include <linux/irqbypass.h>
 #include <linux/swait.h>
+#include <linux/refcount.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -402,7 +403,7 @@ struct kvm {
 #endif
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
-	atomic_t users_count;
+	refcount_t users_count;
 #ifdef KVM_COALESCED_MMIO_PAGE_OFFSET
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dcd1c12..6ae5775 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -622,7 +622,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mutex_init(&kvm->lock);
 	mutex_init(&kvm->irq_lock);
 	mutex_init(&kvm->slots_lock);
-	atomic_set(&kvm->users_count, 1);
+	refcount_set(&kvm->users_count, 1);
 	INIT_LIST_HEAD(&kvm->devices);
 
 	r = kvm_arch_init_vm(kvm, type);
@@ -745,13 +745,13 @@ static void kvm_destroy_vm(struct kvm *kvm)
 
 void kvm_get_kvm(struct kvm *kvm)
 {
-	atomic_inc(&kvm->users_count);
+	refcount_inc(&kvm->users_count);
 }
 EXPORT_SYMBOL_GPL(kvm_get_kvm);
 
 void kvm_put_kvm(struct kvm *kvm)
 {
-	if (atomic_dec_and_test(&kvm->users_count))
+	if (refcount_dec_and_test(&kvm->users_count))
 		kvm_destroy_vm(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_put_kvm);
@@ -3640,7 +3640,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 	 * To avoid the race between open and the removal of the debugfs
 	 * directory we test against the users count.
 	 */
-	if (!atomic_add_unless(&stat_data->kvm->users_count, 1, 0))
+	if (!refcount_inc_not_zero(&stat_data->kvm->users_count))
 		return -ENOENT;
 
 	if (simple_attr_open(inode, file, get, set, fmt)) {
-- 
2.7.4
