From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 3/3] KVM: s390: Hook up ioeventfds.
Date: Thu, 21 Feb 2013 14:13:00 +0100
Message-ID: <1361452380-50398-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

As s390 doesn't use memory writes for virtio notifcations, create
a special kind of ioeventfd instead that hooks up into diagnose
0x500 (kvm hypercall) with function code 3 (virtio-ccw notification).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  23 ++++++
 arch/s390/kvm/Kconfig            |   1 +
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/diag.c             |  23 ++++++
 arch/s390/kvm/kvm-s390.c         | 165 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |   3 +
 6 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 16bd5d1..8dad9dc 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_host.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
+#include <asm/schid.h>
 
 #define KVM_MAX_VCPUS 64
 #define KVM_USER_MEM_SLOTS 32
@@ -262,8 +263,30 @@ struct kvm_arch{
 	debug_info_t *dbf;
 	struct kvm_s390_float_interrupt float_int;
 	struct gmap *gmap;
+	struct list_head sch_fds;
+	struct rw_semaphore sch_fds_sem;
 	int css_support;
 };
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
+#define __KVM_HAVE_ARCH_IOEVENTFD
+
+#define KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY 1
+
+struct kvm_s390_ioeventfd_data {
+	__u8 type;
+	union {
+		/* VIRTIO_CCW_NOTIFY */
+		struct {
+			__u64 vq;
+			struct subchannel_id schid;
+		} virtio_ccw_vq;
+		char padding[35];
+	};
+} __packed;
+
+struct kvm_arch_ioeventfd {
+	struct list_head entry;
+	struct kvm_s390_ioeventfd_data data;
+};
 #endif
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index b58dd86..3c43e30 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select HAVE_KVM_EVENTFD
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 2441ffd..dbd8cc9 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -6,7 +6,7 @@
 # it under the terms of the GNU General Public License (version 2 only)
 # as published by the Free Software Foundation.
 
-common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
+common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o eventfd.o)
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index a390687..51ea66f 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -104,6 +104,27 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 	return -EREMOTE;
 }
 
+static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_ioeventfd_data data;
+	u32 tmp;
+
+	/* No channel I/O? Get out quickly. */
+	if (!vcpu->kvm->arch.css_support ||
+	    (vcpu->run->s.regs.gprs[1] != 3))
+		return -EOPNOTSUPP;
+
+	/* subchannel id is in gpr 2, queue in gpr 3 */
+	tmp = vcpu->run->s.regs.gprs[2] & 0xffffffff;
+	memcpy(&data.virtio_ccw_vq.schid, &tmp,
+	       sizeof(data.virtio_ccw_vq.schid));
+	data.virtio_ccw_vq.vq = vcpu->run->s.regs.gprs[3];
+	data.type = KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY;
+
+	/* If signalling via eventfd fails, we want to drop to userspace. */
+	return kvm_s390_ioeventfd_signal(vcpu->kvm, &data) ? -EOPNOTSUPP : 0;
+}
+
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
 	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
@@ -118,6 +139,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 		return __diag_time_slice_end_directed(vcpu);
 	case 0x308:
 		return __diag_ipl_functions(vcpu);
+	case 0x500:
+		return __diag_virtio_hypercall(vcpu);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 58a5f03..cd9eb0e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/err.h>
+#include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
@@ -143,6 +144,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_S390_CSS_SUPPORT:
+	case KVM_CAP_IOEVENTFD:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -237,6 +239,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
 	}
+	INIT_LIST_HEAD(&kvm->arch.sch_fds);
+	init_rwsem(&kvm->arch.sch_fds_sem);
 
 	kvm->arch.css_support = 0;
 
@@ -1028,3 +1032,164 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
 }
+static void kvm_s390_ioeventfd_add(struct kvm *kvm,
+				   struct kvm_arch_ioeventfd *arch)
+{
+	switch (arch->data.type) {
+	case KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY:
+		down_write(&kvm->arch.sch_fds_sem);
+		list_add_tail(&arch->entry, &kvm->arch.sch_fds);
+		up_write(&kvm->arch.sch_fds_sem);
+		break;
+	default:
+		pr_warn("Trying to add ioeventfd type %x\n", arch->data.type);
+	}
+}
+
+static void kvm_s390_ioeventfd_remove(struct kvm *kvm,
+				      struct kvm_arch_ioeventfd *arch)
+{
+	switch (arch->data.type) {
+	case KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY:
+		down_write(&kvm->arch.sch_fds_sem);
+		list_del(&arch->entry);
+		up_write(&kvm->arch.sch_fds_sem);
+		break;
+	default:
+		pr_warn("Trying to remove ioeventfd type %x\n",
+			arch->data.type);
+	}
+}
+
+int kvm_s390_ioeventfd_signal(struct kvm *kvm,
+			      struct kvm_s390_ioeventfd_data *data)
+{
+	struct kvm_arch_ioeventfd *arch, match;
+	int ret;
+
+	if (data->type != KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY)
+		return -ENOENT;
+	down_read(&kvm->arch.sch_fds_sem);
+	if (list_empty(&kvm->arch.sch_fds)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+	memcpy(&match.data, data, sizeof(match.data));
+	list_for_each_entry(arch, &kvm->arch.sch_fds, entry) {
+		if (!kvm_arch_ioeventfd_match(arch, &match))
+			continue;
+		ret = eventfd_signal(kvm_ioeventfd_get_eventfd(arch), 1);
+		goto out_unlock;
+	}
+	ret = -ENOENT;
+out_unlock:
+	if (ret > 0)
+		ret = 0;
+	up_read(&kvm->arch.sch_fds_sem);
+	return ret;
+}
+
+int kvm_arch_ioeventfd_check(struct kvm_ioeventfd *args)
+{
+	struct kvm_s390_ioeventfd_data *data;
+
+	if (!(args->flags & KVM_IOEVENTFD_FLAG_ARCH))
+		return -EINVAL;
+	if (args->flags & (KVM_IOEVENTFD_FLAG_DATAMATCH |
+			   KVM_IOEVENTFD_FLAG_PIO))
+		return -EINVAL;
+
+	data = (struct kvm_s390_ioeventfd_data *) args->data;
+	if (data->type != KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY)
+		return -EINVAL;
+	if (((data->virtio_ccw_vq.schid.m == 1) &&
+	     (data->virtio_ccw_vq.schid.cssid != 0xfe)) ||
+	    ((data->virtio_ccw_vq.schid.m == 0) &&
+	     (data->virtio_ccw_vq.schid.cssid != 0)))
+		return -EINVAL;
+	if (data->virtio_ccw_vq.schid.one != 1)
+		return -EINVAL;
+	if (data->virtio_ccw_vq.vq > 128)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_arch_ioeventfd_check);
+
+void kvm_arch_ioeventfd_init(struct kvm_arch_ioeventfd *arch,
+			     struct kvm_ioeventfd *args)
+{
+	INIT_LIST_HEAD(&arch->entry);
+	memcpy(&arch->data, &args->data, sizeof(arch->data));
+}
+EXPORT_SYMBOL_GPL(kvm_arch_ioeventfd_init);
+
+int kvm_arch_ioeventfd_activate(struct kvm *kvm,
+				struct kvm_arch_ioeventfd *arch,
+				struct kvm_ioeventfd *args)
+{
+	int ret;
+
+	switch (arch->data.type) {
+	case KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY:
+		/* Fail if channel subsystem support is not active. */
+		if (!kvm->arch.css_support)
+			ret = -EINVAL;
+		else {
+			kvm_s390_ioeventfd_add(kvm, arch);
+			ret = 0;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_arch_ioeventfd_activate);
+
+bool kvm_arch_ioeventfd_match(struct kvm_arch_ioeventfd *arch,
+			      struct kvm_arch_ioeventfd *to_match)
+{
+	if (arch->data.type != to_match->data.type)
+		return false;
+
+	switch (arch->data.type) {
+	case KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY:
+		if (memcmp(&arch->data.virtio_ccw_vq.schid,
+			   &to_match->data.virtio_ccw_vq.schid,
+			   sizeof(arch->data.virtio_ccw_vq.schid)))
+			return false;
+		if (arch->data.virtio_ccw_vq.vq !=
+		    to_match->data.virtio_ccw_vq.vq)
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_arch_ioeventfd_match);
+
+bool kvm_arch_ioeventfd_match_and_release(struct kvm *kvm,
+					  struct kvm_arch_ioeventfd *arch,
+					  struct kvm_ioeventfd *args)
+{
+	struct kvm_s390_ioeventfd_data *data;
+
+	data = (struct kvm_s390_ioeventfd_data *)args->data;
+	if (arch->data.type != data->type)
+		return false;
+
+	switch (arch->data.type) {
+	case KVM_S390_IOEVENTFD_VIRTIO_CCW_NOTIFY:
+		if (memcmp(&arch->data.virtio_ccw_vq.schid,
+			   &data->virtio_ccw_vq.schid,
+			   sizeof(arch->data.virtio_ccw_vq.schid)))
+			return false;
+		if (arch->data.virtio_ccw_vq.vq != data->virtio_ccw_vq.vq)
+			return false;
+		kvm_s390_ioeventfd_remove(kvm, arch);
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_arch_ioeventfd_match_and_release);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 4d89d64..9794906 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -136,4 +136,7 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu,
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
+int kvm_s390_ioeventfd_signal(struct kvm *kvm,
+			      struct kvm_s390_ioeventfd_data *data);
+
 #endif
-- 
1.7.12.4
