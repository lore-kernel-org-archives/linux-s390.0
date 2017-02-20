From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/4] sparc: convert mdesc_handle.refcnt from atomic_t to refcount_t
Date: Mon, 20 Feb 2017 13:06:20 +0200
Message-ID: <1487588781-15123-4-git-send-email-elena.reshetova@intel.com>
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
 arch/sparc/kernel/mdesc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index c0765bb..ac3fe0d 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -12,6 +12,7 @@
 #include <linux/miscdevice.h>
 #include <linux/bootmem.h>
 #include <linux/export.h>
+#include <linux/refcount.h>
 
 #include <asm/cpudata.h>
 #include <asm/hypervisor.h>
@@ -70,7 +71,7 @@ struct mdesc_handle {
 	struct list_head	list;
 	struct mdesc_mem_ops	*mops;
 	void			*self_base;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	unsigned int		handle_size;
 	struct mdesc_hdr	mdesc;
 };
@@ -84,7 +85,7 @@ static void mdesc_handle_init(struct mdesc_handle *hp,
 	memset(hp, 0, handle_size);
 	INIT_LIST_HEAD(&hp->list);
 	hp->self_base = base;
-	atomic_set(&hp->refcnt, 1);
+	refcount_set(&hp->refcnt, 1);
 	hp->handle_size = handle_size;
 }
 
@@ -114,7 +115,7 @@ static void __init mdesc_memblock_free(struct mdesc_handle *hp)
 	unsigned int alloc_size;
 	unsigned long start;
 
-	BUG_ON(atomic_read(&hp->refcnt) != 0);
+	BUG_ON(refcount_read(&hp->refcnt) != 0);
 	BUG_ON(!list_empty(&hp->list));
 
 	alloc_size = PAGE_ALIGN(hp->handle_size);
@@ -154,7 +155,7 @@ static struct mdesc_handle *mdesc_kmalloc(unsigned int mdesc_size)
 
 static void mdesc_kfree(struct mdesc_handle *hp)
 {
-	BUG_ON(atomic_read(&hp->refcnt) != 0);
+	BUG_ON(refcount_read(&hp->refcnt) != 0);
 	BUG_ON(!list_empty(&hp->list));
 
 	kfree(hp->self_base);
@@ -193,7 +194,7 @@ struct mdesc_handle *mdesc_grab(void)
 	spin_lock_irqsave(&mdesc_lock, flags);
 	hp = cur_mdesc;
 	if (hp)
-		atomic_inc(&hp->refcnt);
+		refcount_inc(&hp->refcnt);
 	spin_unlock_irqrestore(&mdesc_lock, flags);
 
 	return hp;
@@ -205,7 +206,7 @@ void mdesc_release(struct mdesc_handle *hp)
 	unsigned long flags;
 
 	spin_lock_irqsave(&mdesc_lock, flags);
-	if (atomic_dec_and_test(&hp->refcnt)) {
+	if (refcount_dec_and_test(&hp->refcnt)) {
 		list_del_init(&hp->list);
 		hp->mops->free(hp);
 	}
@@ -344,7 +345,7 @@ void mdesc_update(void)
 	if (status != HV_EOK || real_len > len) {
 		printk(KERN_ERR "MD: mdesc reread fails with %lu\n",
 		       status);
-		atomic_dec(&hp->refcnt);
+		refcount_dec(&hp->refcnt);
 		mdesc_free(hp);
 		goto out;
 	}
@@ -357,7 +358,7 @@ void mdesc_update(void)
 	mdesc_notify_clients(orig_hp, hp);
 
 	spin_lock_irqsave(&mdesc_lock, flags);
-	if (atomic_dec_and_test(&orig_hp->refcnt))
+	if (refcount_dec_and_test(&orig_hp->refcnt))
 		mdesc_free(orig_hp);
 	else
 		list_add(&orig_hp->list, &mdesc_zombie_list);
-- 
2.7.4
