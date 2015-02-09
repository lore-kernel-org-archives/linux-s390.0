From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/7] KVM: Disable compat ioctl for s390
Date: Mon,  9 Feb 2015 13:33:47 +0100
Message-ID: <1423485227-51721-8-git-send-email-borntraeger@de.ibm.com>
References: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We never had a 31bit QEMU/kuli running. We would need to review several
ioctls to check if this creates holes, bugs or whatever to make it work.
Lets just disable compat support for KVM on s390.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/Kconfig    |  4 ++++
 virt/kvm/kvm_main.c | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 50d1106..e2c876d 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -43,3 +43,7 @@ config HAVE_KVM_ARCH_TLB_FLUSH_ALL
 
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
+
+config KVM_COMPAT
+       def_bool y
+       depends on COMPAT && !S390
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 32449e0..8579f18 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -92,7 +92,7 @@ struct dentry *kvm_debugfs_dir;
 
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 static long kvm_vcpu_compat_ioctl(struct file *file, unsigned int ioctl,
 				  unsigned long arg);
 #endif
@@ -2052,7 +2052,7 @@ static int kvm_vcpu_release(struct inode *inode, struct file *filp)
 static struct file_operations kvm_vcpu_fops = {
 	.release        = kvm_vcpu_release,
 	.unlocked_ioctl = kvm_vcpu_ioctl,
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 	.compat_ioctl   = kvm_vcpu_compat_ioctl,
 #endif
 	.mmap           = kvm_vcpu_mmap,
@@ -2342,7 +2342,7 @@ out:
 	return r;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 static long kvm_vcpu_compat_ioctl(struct file *filp,
 				  unsigned int ioctl, unsigned long arg)
 {
@@ -2434,7 +2434,7 @@ static int kvm_device_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations kvm_device_fops = {
 	.unlocked_ioctl = kvm_device_ioctl,
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 	.compat_ioctl = kvm_device_ioctl,
 #endif
 	.release = kvm_device_release,
@@ -2721,7 +2721,7 @@ out:
 	return r;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 struct compat_kvm_dirty_log {
 	__u32 slot;
 	__u32 padding1;
@@ -2768,7 +2768,7 @@ out:
 static struct file_operations kvm_vm_fops = {
 	.release        = kvm_vm_release,
 	.unlocked_ioctl = kvm_vm_ioctl,
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_KVM_COMPAT
 	.compat_ioctl   = kvm_vm_compat_ioctl,
 #endif
 	.llseek		= noop_llseek,
-- 
1.9.3
