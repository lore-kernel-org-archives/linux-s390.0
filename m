From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: Create debugfs dir and stat files for each VM
Date: Wed, 18 Nov 2015 14:11:47 +0100
Message-ID: <1447852307-106478-3-git-send-email-borntraeger@de.ibm.com>
References: <1447852307-106478-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447852307-106478-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

KVM statistics for VMs (no. of exits, halts and other special
instructions) are currently only available in a summarized manner for
all VMs. They are exported to userland through files in the kvm
debugfs directory and used for performance monitoring, as well as VM
problem detection with helper tools like kvm_stat. If a VM has
problems and therefore creates a large number of exits, one can not
easily find out which one it is, as there is no VM specific data.

This patch adds a kvm debugfs subdirectory for each VM on
kvm_create_vm(). The subdirectories are named by the VM pid and
contain the same type of exported statistics that are already in the
kvm debugfs directory, but the exported data is now VM specific.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h |   7 ++
 virt/kvm/kvm_main.c      | 188 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 187 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6981bc6..23071bc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -425,6 +425,8 @@ struct kvm {
 #endif
 	long tlbs_dirty;
 	struct list_head devices;
+	struct dentry *debugfs_dentry;
+	struct kvm_stat_data **debugfs_data;
 };
 
 #define kvm_err(fmt, ...) \
@@ -1005,6 +1007,11 @@ enum kvm_stat_kind {
 	KVM_STAT_VCPU,
 };
 
+struct kvm_stat_data {
+	int offset;
+	struct kvm *kvm;
+};
+
 struct kvm_stats_debugfs_item {
 	const char *name;
 	int offset;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 726bb51..1ee2f73 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -63,6 +63,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/kvm.h>
 
+/* Worst case buffer size needed for holding an integer. */
+#define ITOA_MAX_LEN 12
+
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
@@ -100,6 +103,9 @@ static __read_mostly struct preempt_ops kvm_preempt_ops;
 struct dentry *kvm_debugfs_dir;
 EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
 
+static u64 kvm_debugfs_num_entries;
+static const struct file_operations *stat_fops_per_vm[];
+
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -539,6 +545,71 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 	kvfree(slots);
 }
 
+static int kvm_destroy_vm_debugfs(struct kvm *kvm)
+{
+	u64 i;
+	struct kvm_stat_data **stat_data = kvm->debugfs_data;
+
+	for (i = 0; i < kvm_debugfs_num_entries; i++)
+		kfree(stat_data[i]);
+
+	kfree(kvm->debugfs_data);
+
+	return 0;
+}
+
+static int kvm_create_vm_debugfs(struct kvm *kvm)
+{
+	int r = 0, i = 0;
+	char dir_name[ITOA_MAX_LEN];
+	struct kvm_stat_data *stat_data;
+	struct kvm_stats_debugfs_item *p;
+
+	if (!kvm)
+		return -EINVAL;
+
+	snprintf(dir_name, sizeof(dir_name), "%d", current->pid);
+	kvm->debugfs_dentry = debugfs_create_dir(dir_name, kvm_debugfs_dir);
+	if (!kvm->debugfs_dentry)
+		goto out_err;
+
+	kvm->debugfs_data = kmalloc(sizeof(*kvm->debugfs_data) *
+				    kvm_debugfs_num_entries, GFP_KERNEL);
+	if (!kvm->debugfs_data)
+		return -ENOMEM;
+
+	for (p = debugfs_entries; p->name; p++, i++) {
+		stat_data = kzalloc(sizeof(*stat_data), GFP_KERNEL);
+		if (!stat_data) {
+			r = -ENOMEM;
+			goto out_err_clean;
+		}
+
+		stat_data->offset = p->offset;
+		stat_data->kvm = kvm;
+		if (!debugfs_create_file(p->name, 0444,
+					 kvm->debugfs_dentry,
+					 stat_data,
+					 stat_fops_per_vm[p->kind])) {
+			r = -EEXIST;
+			goto out_err_clean;
+		}
+		kvm->debugfs_data[i] = stat_data;
+	}
+
+	return r;
+
+out_err_clean:
+	debugfs_remove_recursive(kvm->debugfs_dentry);
+	kfree(stat_data);
+	for (i--; i >= 0; i--)
+		kfree(kvm->debugfs_data[i]);
+
+	kfree(kvm->debugfs_data);
+out_err:
+	return r;
+}
+
 static struct kvm *kvm_create_vm(unsigned long type)
 {
 	int r, i;
@@ -597,6 +668,10 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	list_add(&kvm->vm_list, &vm_list);
 	spin_unlock(&kvm_lock);
 
+	r = kvm_create_vm_debugfs(kvm);
+	if (r)
+		goto out_err;
+
 	preempt_notifier_inc();
 
 	return kvm;
@@ -646,6 +721,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	int i;
 	struct mm_struct *mm = kvm->mm;
 
+	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
 	spin_lock(&kvm_lock);
 	list_del(&kvm->vm_list);
@@ -689,6 +765,7 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 {
 	struct kvm *kvm = filp->private_data;
 
+	debugfs_remove_recursive(kvm->debugfs_dentry);
 	kvm_irqfd_release(kvm);
 
 	kvm_put_kvm(kvm);
@@ -3398,15 +3475,107 @@ static struct notifier_block kvm_cpu_notifier = {
 	.notifier_call = kvm_cpu_hotplug,
 };
 
+static int kvm_debugfs_open(struct inode *inode, struct file *file,
+			   int (*get)(void *, u64 *), int (*set)(void *, u64),
+			   const char *fmt)
+{
+	int err;
+	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
+					  inode->i_private;
+
+	err = simple_attr_open(inode, file, get, set, fmt);
+	if (err)
+		return err;
+
+	kvm_get_kvm(stat_data->kvm);
+
+	return 0;
+}
+
+static int kvm_debugfs_release(struct inode *inode, struct file *file)
+{
+	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
+					  inode->i_private;
+
+	simple_attr_release(inode, file);
+	kvm_put_kvm(stat_data->kvm);
+
+	return 0;
+}
+
+static int vm_stat_get_per_vm(void *data, u64 *val)
+{
+	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
+
+	*val = *(u32 *)((void *)stat_data->kvm + stat_data->offset);
+
+	return 0;
+}
+
+static int vm_stat_get_per_vm_open(struct inode *inode, struct file *file)
+{
+	__simple_attr_check_format("%llu\n", 0ull);
+	return simple_attr_open(inode, file, vm_stat_get_per_vm,
+				 NULL, "%llu\n");
+}
+
+static const struct file_operations vm_stat_get_per_vm_fops = {
+	.owner   = THIS_MODULE,
+	.open    = vm_stat_get_per_vm_open,
+	.release = kvm_debugfs_release,
+	.read    = simple_attr_read,
+	.write   = simple_attr_write,
+	.llseek  = generic_file_llseek,
+};
+
+static int vcpu_stat_get_per_vm(void *data, u64 *val)
+{
+	int i;
+	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
+	struct kvm_vcpu *vcpu;
+
+	*val = 0;
+
+	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
+		*val += *(u32 *)((void *)vcpu + stat_data->offset);
+
+	return 0;
+}
+
+static int vcpu_stat_get_per_vm_open(struct inode *inode, struct file *file)
+{
+	__simple_attr_check_format("%llu\n", 0ull);
+	return kvm_debugfs_open(inode, file, vcpu_stat_get_per_vm,
+				 NULL, "%llu\n");
+}
+
+static const struct file_operations vcpu_stat_get_per_vm_fops = {
+	.owner   = THIS_MODULE,
+	.open    = vcpu_stat_get_per_vm_open,
+	.release = kvm_debugfs_release,
+	.read    = simple_attr_read,
+	.write   = simple_attr_write,
+	.llseek  = generic_file_llseek,
+};
+
+static const struct file_operations *stat_fops_per_vm[] = {
+	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
+	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
+};
+
 static int vm_stat_get(void *_offset, u64 *val)
 {
 	unsigned offset = (long)_offset;
 	struct kvm *kvm;
+	struct kvm_stat_data stat_tmp = {.offset = offset};
+	u64 tmp_val;
 
 	*val = 0;
 	spin_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list)
-		*val += *(u32 *)((void *)kvm + offset);
+		stat_tmp.kvm = kvm;
+		vm_stat_get_per_vm((void *)&stat_tmp, &tmp_val);
+		*val += tmp_val;
 	spin_unlock(&kvm_lock);
 	return 0;
 }
@@ -3417,16 +3586,18 @@ static int vcpu_stat_get(void *_offset, u64 *val)
 {
 	unsigned offset = (long)_offset;
 	struct kvm *kvm;
-	struct kvm_vcpu *vcpu;
-	int i;
+	struct kvm_stat_data stat_tmp = {.offset = offset};
+	u64 tmp_val;
 
 	*val = 0;
 	spin_lock(&kvm_lock);
-	list_for_each_entry(kvm, &vm_list, vm_list)
-		kvm_for_each_vcpu(i, vcpu, kvm)
-			*val += *(u32 *)((void *)vcpu + offset);
-
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		stat_tmp.kvm = kvm;
+		vcpu_stat_get_per_vm((void *)&stat_tmp, &tmp_val);
+		*val += tmp_val;
+	}
 	spin_unlock(&kvm_lock);
+
 	return 0;
 }
 
@@ -3446,7 +3617,8 @@ static int kvm_init_debug(void)
 	if (kvm_debugfs_dir == NULL)
 		goto out;
 
-	for (p = debugfs_entries; p->name; ++p) {
+	kvm_debugfs_num_entries = 0;
+	for (p = debugfs_entries; p->name; ++p, kvm_debugfs_num_entries++) {
 		if (!debugfs_create_file(p->name, 0444, kvm_debugfs_dir,
 					 (void *)(long)p->offset,
 					 stat_fops[p->kind]))
-- 
2.3.0
