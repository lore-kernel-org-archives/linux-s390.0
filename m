From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/23] KVM: Remove unnecessary debugfs dentry references
Date: Wed,  2 Dec 2015 12:06:04 +0100
Message-ID: <1449054384-76374-4-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

KVM creates debugfs files to export VM statistics to userland. To be
able to remove them on kvm exit it tracks the files' dentries.

Since their parent directory is also tracked and since each parent
direntry knows its children we can easily remove them by using
debugfs_remove_recursive(kvm_debugfs_dir). Therefore we don't
need the extra tracking in the kvm_stats_debugfs_item anymore.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-By: Sascha Silbe <silbe@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h |  1 -
 virt/kvm/kvm_main.c      | 18 ++++--------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a754fc0..590c46e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1016,7 +1016,6 @@ struct kvm_stats_debugfs_item {
 	const char *name;
 	int offset;
 	enum kvm_stat_kind kind;
-	struct dentry *dentry;
 };
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9649a42..be3cef1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3447,10 +3447,9 @@ static int kvm_init_debug(void)
 		goto out;
 
 	for (p = debugfs_entries; p->name; ++p) {
-		p->dentry = debugfs_create_file(p->name, 0444, kvm_debugfs_dir,
-						(void *)(long)p->offset,
-						stat_fops[p->kind]);
-		if (p->dentry == NULL)
+		if (!debugfs_create_file(p->name, 0444, kvm_debugfs_dir,
+					 (void *)(long)p->offset,
+					 stat_fops[p->kind]))
 			goto out_dir;
 	}
 
@@ -3462,15 +3461,6 @@ out:
 	return r;
 }
 
-static void kvm_exit_debug(void)
-{
-	struct kvm_stats_debugfs_item *p;
-
-	for (p = debugfs_entries; p->name; ++p)
-		debugfs_remove(p->dentry);
-	debugfs_remove(kvm_debugfs_dir);
-}
-
 static int kvm_suspend(void)
 {
 	if (kvm_usage_count)
@@ -3628,7 +3618,7 @@ EXPORT_SYMBOL_GPL(kvm_init);
 
 void kvm_exit(void)
 {
-	kvm_exit_debug();
+	debugfs_remove_recursive(kvm_debugfs_dir);
 	misc_deregister(&kvm_dev);
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_async_pf_deinit();
-- 
2.3.0
