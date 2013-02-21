From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 2/3] KVM: Generalize ioeventfds.
Date: Thu, 21 Feb 2013 14:12:59 +0100
Message-ID: <1361452380-50398-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

Currently, ioeventfds are designed to work on architectures that
can trap I/O memory writes. This won't work for architectures like
s390, however; therefore provide a way for architectures to override
this with an architecture-specific implementation.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |   5 +-
 include/linux/kvm_host.h          |  13 +++
 include/uapi/linux/kvm.h          |   4 +-
 virt/kvm/eventfd.c                | 181 ++++++++++++++++++++++++++------------
 4 files changed, 146 insertions(+), 57 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c2534c3..13c038c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1465,7 +1465,7 @@ struct kvm_ioeventfd {
 	__u32 len;         /* 1, 2, 4, or 8 bytes    */
 	__s32 fd;
 	__u32 flags;
-	__u8  pad[36];
+	__u8  data[36];    /* for architecture-specific data */
 };
 
 The following flags are defined:
@@ -1473,10 +1473,13 @@ The following flags are defined:
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_ARCH      (1 << kvm_ioeventfd_flag_nr_arch)
 
 If datamatch flag is set, the event will be signaled only if the written value
 to the registered address is equal to datamatch in struct kvm_ioeventfd.
 
+If the arch flag is set, the eventfd will use the data field. If the arch flag
+is not set, the data field is not valid.
 
 4.60 KVM_DIRTY_TLB
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 722cae7..d7965fb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -905,8 +905,21 @@ static inline void kvm_free_irq_routing(struct kvm *kvm) {}
 
 #ifdef CONFIG_HAVE_KVM_EVENTFD
 
+struct kvm_arch_ioeventfd;
 void kvm_eventfd_init(struct kvm *kvm);
 int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args);
+struct eventfd_ctx *kvm_ioeventfd_get_eventfd(struct kvm_arch_ioeventfd *arch);
+int kvm_arch_ioeventfd_check(struct kvm_ioeventfd *args);
+void kvm_arch_ioeventfd_init(struct kvm_arch_ioeventfd *arch,
+			     struct kvm_ioeventfd *args);
+int kvm_arch_ioeventfd_activate(struct kvm *kvm,
+				struct kvm_arch_ioeventfd *arch,
+				struct kvm_ioeventfd *args);
+bool kvm_arch_ioeventfd_match(struct kvm_arch_ioeventfd *arch,
+			      struct kvm_arch_ioeventfd *to_match);
+bool kvm_arch_ioeventfd_match_and_release(struct kvm *kvm,
+					  struct kvm_arch_ioeventfd *arch,
+					  struct kvm_ioeventfd *args);
 
 #ifdef CONFIG_HAVE_KVM_IRQCHIP
 int kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9a2db57..dfd444b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -448,12 +448,14 @@ enum {
 	kvm_ioeventfd_flag_nr_datamatch,
 	kvm_ioeventfd_flag_nr_pio,
 	kvm_ioeventfd_flag_nr_deassign,
+	kvm_ioeventfd_flag_nr_arch,
 	kvm_ioeventfd_flag_nr_max,
 };
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_ARCH      (1 << kvm_ioeventfd_flag_nr_arch)
 
 #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
 
@@ -463,7 +465,7 @@ struct kvm_ioeventfd {
 	__u32 len;         /* 1, 2, 4, or 8 bytes    */
 	__s32 fd;
 	__u32 flags;
-	__u8  pad[36];
+	__u8  data[36];    /* for architecture-specific data */
 };
 
 /* for KVM_ENABLE_CAP */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b6eea5c..63fe454 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -568,23 +568,37 @@ module_exit(irqfd_module_exit);
  *
  * userspace can register a PIO/MMIO address with an eventfd for receiving
  * notification when the memory has been touched.
+ *
+ * Architectures that use a notification mechanism different from memory
+ * writes may override this with architecture-specific callbacks.
  * --------------------------------------------------------------------
  */
-
-struct _ioeventfd {
-	struct list_head     list;
+#ifndef __KVM_HAVE_ARCH_IOEVENTFD
+struct kvm_arch_ioeventfd {
 	u64                  addr;
 	int                  length;
-	struct eventfd_ctx  *eventfd;
 	u64                  datamatch;
 	struct kvm_io_device dev;
 	bool                 wildcard;
 };
+#endif
+
+struct _ioeventfd {
+	struct list_head     list;
+	struct eventfd_ctx  *eventfd;
+	struct kvm_arch_ioeventfd arch;
+};
 
-static inline struct _ioeventfd *
-to_ioeventfd(struct kvm_io_device *dev)
+static inline struct _ioeventfd *to_ioeventfd(struct kvm_arch_ioeventfd *arch)
 {
-	return container_of(dev, struct _ioeventfd, dev);
+	return container_of(arch, struct _ioeventfd, arch);
+}
+
+struct eventfd_ctx *kvm_ioeventfd_get_eventfd(struct kvm_arch_ioeventfd *arch)
+{
+	struct _ioeventfd *p = to_ioeventfd(arch);
+
+	return p->eventfd;
 }
 
 static void
@@ -595,16 +609,18 @@ ioeventfd_release(struct _ioeventfd *p)
 	kfree(p);
 }
 
+#ifndef __KVM_HAVE_ARCH_IOEVENTFD
 static bool
-ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
+ioeventfd_in_range(struct kvm_arch_ioeventfd *arch, gpa_t addr, int len,
+		   const void *val)
 {
 	u64 _val;
 
-	if (!(addr == p->addr && len == p->length))
+	if (!(addr == arch->addr && len == arch->length))
 		/* address-range must be precise for a hit */
 		return false;
 
-	if (p->wildcard)
+	if (arch->wildcard)
 		/* all else equal, wildcard is always a hit */
 		return true;
 
@@ -629,7 +645,13 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
 		return false;
 	}
 
-	return _val == p->datamatch ? true : false;
+	return _val == arch->datamatch ? true : false;
+}
+
+static inline struct kvm_arch_ioeventfd *
+to_arch_ioeventfd(struct kvm_io_device *dev)
+{
+	return container_of(dev, struct kvm_arch_ioeventfd, dev);
 }
 
 /* MMIO/PIO writes trigger an event if the addr/val match */
@@ -637,12 +659,12 @@ static int
 ioeventfd_write(struct kvm_io_device *this, gpa_t addr, int len,
 		const void *val)
 {
-	struct _ioeventfd *p = to_ioeventfd(this);
+	struct kvm_arch_ioeventfd *arch = to_arch_ioeventfd(this);
 
-	if (!ioeventfd_in_range(p, addr, len, val))
+	if (!ioeventfd_in_range(arch, addr, len, val))
 		return -EOPNOTSUPP;
 
-	eventfd_signal(p->eventfd, 1);
+	eventfd_signal(kvm_ioeventfd_get_eventfd(arch), 1);
 	return 0;
 }
 
@@ -653,7 +675,7 @@ ioeventfd_write(struct kvm_io_device *this, gpa_t addr, int len,
 static void
 ioeventfd_destructor(struct kvm_io_device *this)
 {
-	struct _ioeventfd *p = to_ioeventfd(this);
+	struct _ioeventfd *p = to_ioeventfd(to_arch_ioeventfd(this));
 
 	ioeventfd_release(p);
 }
@@ -663,6 +685,87 @@ static const struct kvm_io_device_ops ioeventfd_ops = {
 	.destructor = ioeventfd_destructor,
 };
 
+int kvm_arch_ioeventfd_check(struct kvm_ioeventfd *args)
+{
+	if (args->flags & KVM_IOEVENTFD_FLAG_ARCH)
+		return -EINVAL;
+
+	/* must be natural-word sized */
+	switch (args->len) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	return 0;
+}
+
+void kvm_arch_ioeventfd_init(struct kvm_arch_ioeventfd *arch,
+			     struct kvm_ioeventfd *args)
+{
+	arch->addr    = args->addr;
+	arch->length  = args->len;
+
+	/* The datamatch feature is optional, otherwise this is a wildcard */
+	if (args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH)
+		arch->datamatch = args->datamatch;
+	else
+		arch->wildcard = true;
+}
+
+int kvm_arch_ioeventfd_activate(struct kvm *kvm,
+				struct kvm_arch_ioeventfd *arch,
+				struct kvm_ioeventfd *args)
+{
+	int pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
+	enum kvm_bus bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
+
+	kvm_iodevice_init(&arch->dev, &ioeventfd_ops);
+
+	return kvm_io_bus_register_dev(kvm, bus_idx, arch->addr, arch->length,
+				       &arch->dev);
+}
+
+bool kvm_arch_ioeventfd_match(struct kvm_arch_ioeventfd *arch,
+			      struct kvm_arch_ioeventfd *to_match)
+{
+	if (to_match->addr == arch->addr &&
+	    to_match->length == arch->length &&
+	    (to_match->wildcard || arch->wildcard ||
+	     to_match->datamatch == arch->datamatch))
+			return true;
+	return false;
+}
+
+bool kvm_arch_ioeventfd_match_and_release(struct kvm *kvm,
+					  struct kvm_arch_ioeventfd *arch,
+					  struct kvm_ioeventfd *args)
+{
+	int pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
+	enum kvm_bus bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
+	bool wildcard = !(args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH);
+
+	if (arch->addr != args->addr  ||
+	    arch->length != args->len ||
+	    arch->wildcard != wildcard)
+		return false;
+
+	if (!arch->wildcard && arch->datamatch != args->datamatch)
+		return false;
+
+	kvm_io_bus_unregister_dev(kvm, bus_idx, &arch->dev);
+	return true;
+}
+#endif
+
 /* assumes kvm->slots_lock held */
 static bool
 ioeventfd_check_collision(struct kvm *kvm, struct _ioeventfd *p)
@@ -670,9 +773,7 @@ ioeventfd_check_collision(struct kvm *kvm, struct _ioeventfd *p)
 	struct _ioeventfd *_p;
 
 	list_for_each_entry(_p, &kvm->ioeventfds, list)
-		if (_p->addr == p->addr && _p->length == p->length &&
-		    (_p->wildcard || p->wildcard ||
-		     _p->datamatch == p->datamatch))
+		if (kvm_arch_ioeventfd_match(&p->arch, &_p->arch))
 			return true;
 
 	return false;
@@ -681,26 +782,13 @@ ioeventfd_check_collision(struct kvm *kvm, struct _ioeventfd *p)
 static int
 kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
-	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
-	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
 	struct _ioeventfd        *p;
 	struct eventfd_ctx       *eventfd;
 	int                       ret;
 
-	/* must be natural-word sized */
-	switch (args->len) {
-	case 1:
-	case 2:
-	case 4:
-	case 8:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* check for range overflow */
-	if (args->addr + args->len < args->addr)
-		return -EINVAL;
+	ret = kvm_arch_ioeventfd_check(args);
+	if (ret)
+		return ret;
 
 	/* check for extra flags that we don't understand */
 	if (args->flags & ~KVM_IOEVENTFD_VALID_FLAG_MASK)
@@ -717,15 +805,9 @@ kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 	}
 
 	INIT_LIST_HEAD(&p->list);
-	p->addr    = args->addr;
-	p->length  = args->len;
 	p->eventfd = eventfd;
 
-	/* The datamatch feature is optional, otherwise this is a wildcard */
-	if (args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH)
-		p->datamatch = args->datamatch;
-	else
-		p->wildcard = true;
+	kvm_arch_ioeventfd_init(&p->arch, args);
 
 	mutex_lock(&kvm->slots_lock);
 
@@ -735,10 +817,7 @@ kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 		goto unlock_fail;
 	}
 
-	kvm_iodevice_init(&p->dev, &ioeventfd_ops);
-
-	ret = kvm_io_bus_register_dev(kvm, bus_idx, p->addr, p->length,
-				      &p->dev);
+	ret = kvm_arch_ioeventfd_activate(kvm, &p->arch, args);
 	if (ret < 0)
 		goto unlock_fail;
 
@@ -761,8 +840,6 @@ fail:
 static int
 kvm_deassign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
-	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
-	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
 	struct _ioeventfd        *p, *tmp;
 	struct eventfd_ctx       *eventfd;
 	int                       ret = -ENOENT;
@@ -774,18 +851,12 @@ kvm_deassign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 	mutex_lock(&kvm->slots_lock);
 
 	list_for_each_entry_safe(p, tmp, &kvm->ioeventfds, list) {
-		bool wildcard = !(args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH);
-
-		if (p->eventfd != eventfd  ||
-		    p->addr != args->addr  ||
-		    p->length != args->len ||
-		    p->wildcard != wildcard)
+		if (p->eventfd != eventfd)
 			continue;
 
-		if (!p->wildcard && p->datamatch != args->datamatch)
+		if (!kvm_arch_ioeventfd_match_and_release(kvm, &p->arch, args))
 			continue;
 
-		kvm_io_bus_unregister_dev(kvm, bus_idx, &p->dev);
 		ioeventfd_release(p);
 		ret = 0;
 		break;
-- 
1.7.12.4
