Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A7405E7;
	Mon, 25 May 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724128; cv=none; b=MQxfp5aUPC5aMBZrQ8yRPFFZPElqnrQdks0f1pDCJ8/N6Ub/edGS2eaDjDCwhu7Ht9UqddNrPX2nSRCnuaoY+VyOcR942ZoRc1KHQzEtKlxB+wq9WWDMGg1b512QBN5AKFOwByBMLDsptupj2TKI3b8hh6PQhIlcWoE8ongNo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724128; c=relaxed/simple;
	bh=eaYGETD6+vwB+6kC2hrC9r8tlw18tleJhUAEDIs8Ta0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwAJIYEMui9grgC69hCRrD/crFO3t5l1h3QXtv+oYwNfAFk8hU/F97Iv3haJerDJecPHowwVQvy+GK5cD76nBcEls5l+3VLGpZTVChtRNu3pWKRNT8w25VOlLMDpHbCtlC6DFYqMF2EjHC3JhAO4Rr7yMr9lYFfp0WvtdRtrrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PESnMb+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PESnMb+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010701F000E9;
	Mon, 25 May 2026 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724126;
	bh=zUcJo14pjI06xfQoir2Y8G0tRMrIpQj5eccfds7tvhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PESnMb+xxun7O2ay30P4QRqLYJR9xP+ku46JvZmlusVQNHI3S4pd8xF9jBXgE3pYb
	 R/3oHZcM+6H1Af2e/5xNHNVK/bkgZmqvizbWPLpBkawwyQu9VE+5tUn53hAwTmq52x
	 CZdwfCnLAOhl1/MFBpnTXwLkzxhARJV8ewHWrNANxidHxLwYaV34zkibATvYKPNqji
	 Y0rJ1lLeNjrqWIV4GX96repCUy07aNd+Q9orVIW1ytBEYgLTfxFMftRYUmeImtJmQg
	 IGsoA/EoJQEnZUB8ASY+lwhc0/nrcfqyRimKmPQDERG/JiiLPNVQeOJpB0L1A6ffQy
	 me904uDjABJfg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 1/5] vfio: cache KVM VM file references instead of raw struct kvm pointers
Date: Mon, 25 May 2026 21:18:12 +0530
Message-ID: <20260525154816.1029642-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
and the opened vfio_device. Switch VFIO to track the VM's struct file
instead, so VFIO and iommufd can use normal file references for VM lifetime
instead of depending on KVM's internal struct kvm refcounting.

KVM_CREATE_DEVICE binds the KVM VM lifetime to the KVM device fd lifetime.
For KVM_DEV_TYPE_VFIO, the KVM VFIO device fd also takes references to each
VFIO file added through KVM_DEV_VFIO_FILE_ADD. The KVM VFIO device fd
therefore owns both the internal KVM reference and the VFIO file references
in kvf->file.

KVM_DEV_VFIO_FILE_ADD further installs the VM file association into the
VFIO file. VFIO converts the struct kvm pointer to a VM file reference with
get_file_active(&kvm->_file), because the KVM device fd can keep struct kvm
alive after the original VM fd is already in final release.

The association intentionally pins the VM file until KVM_DEV_VFIO_FILE_DEL
or until the KVM VFIO device fd is released. This gives VFIO/iommufd a
stable VM file reference source without taking a dependency on KVM's struct
kvm lifetime. The KVM VFIO device release path clears the VFIO-side
association before dropping its VFIO file references.

When a VFIO device is opened or bound, VFIO takes an additional reference
from the associated VM file and stores it in vfio_device::kvm_file for
driver and iommufd use. That open-time reference is released from
vfio_device_put_kvm() when the VFIO device is closed or unbound.

This gives the ownership model:

  - KVM device fd pins struct kvm through kvm->users_count
  - KVM VFIO device fd pins VFIO files through kvf->file
  - VFIO group/device-file state pins the VM file while associated with KVM
  - vfio_device::kvm_file pins the VM file during active VFIO device use

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c |  5 +-
 drivers/vfio/device_cdev.c        | 10 ++--
 drivers/vfio/group.c              | 14 +++---
 drivers/vfio/pci/vfio_pci_zdev.c  |  7 +--
 drivers/vfio/vfio.h               | 16 ++++--
 drivers/vfio/vfio_main.c          | 81 ++++++++++++++++---------------
 include/linux/kvm_host.h          |  3 ++
 include/linux/vfio.h              | 17 ++++++-
 virt/kvm/kvm_main.c               |  2 +
 9 files changed, 91 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..05996a8fd860 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2054,11 +2054,12 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
 		container_of(vdev, struct ap_matrix_mdev, vdev);
+	struct kvm *kvm = vfio_device_get_kvm(vdev);
 
-	if (!vdev->kvm)
+	if (!kvm)
 		return -EINVAL;
 
-	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
+	return vfio_ap_mdev_set_kvm(matrix_mdev, kvm);
 }
 
 static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..ca75ab8eb7bd 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-	vfio_device_get_kvm_safe(df->device, df->kvm);
+	vfio_device_get_kvm_safe(df->device, df->kvm_file);
 	spin_unlock(&df->kvm_ref_lock);
 }
 
@@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 	}
 
 	/*
-	 * Before the device open, get the KVM pointer currently
-	 * associated with the device file (if there is) and obtain
-	 * a reference.  This reference is held until device closed.
-	 * Save the pointer in the device for use by drivers.
+	 * Before the device open, get the VM struct file currently
+	 * associated with the device file (if there is one) and obtain a
+	 * reference. This reference is held until the device is closed.
+	 * Save the file in the device for use by drivers.
 	 */
 	vfio_df_get_kvm_safe(df);
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..8950cfb9405d 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -163,7 +163,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm_safe(device, device->group->kvm_file);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
@@ -181,10 +181,10 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 	mutex_lock(&device->dev_set->lock);
 
 	/*
-	 * Before the first device open, get the KVM pointer currently
-	 * associated with the group (if there is one) and obtain a reference
-	 * now that will be held until the open_count reaches 0 again.  Save
-	 * the pointer in the device for use by drivers.
+	 * Before the first device open, get the VM struct file currently
+	 * associated with the group (if there is one) and obtain a
+	 * reference now that will be held until the open_count reaches 0
+	 * again. Save the file in the device for use by drivers.
 	 */
 	if (device->open_count == 0)
 		vfio_device_group_get_kvm_safe(device);
@@ -862,9 +862,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 
 void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
 {
-	spin_lock(&group->kvm_ref_lock);
-	group->kvm = kvm;
-	spin_unlock(&group->kvm_ref_lock);
+	vfio_kvm_file_replace(&group->kvm_file, &group->kvm_ref_lock, kvm);
 }
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..a9d8e6aa3839 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -144,15 +144,16 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	struct kvm *kvm = vfio_device_get_kvm(&vdev->vdev);
 
 	if (!zdev)
 		return -ENODEV;
 
-	if (!vdev->vdev.kvm)
+	if (!kvm)
 		return 0;
 
 	if (zpci_kvm_hook.kvm_register)
-		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+		return zpci_kvm_hook.kvm_register(zdev, kvm);
 
 	return -ENOENT;
 }
@@ -161,7 +162,7 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
 
-	if (!zdev || !vdev->vdev.kvm)
+	if (!zdev || !vfio_device_get_kvm(&vdev->vdev))
 		return;
 
 	if (zpci_kvm_hook.kvm_unregister)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..41032104eb36 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -22,8 +22,8 @@ struct vfio_device_file {
 
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	spinlock_t kvm_ref_lock; /* protect kvm_file */
+	struct file *kvm_file;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm_file;
 	struct file			*opened_file;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
@@ -434,11 +434,17 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
+static inline void vfio_kvm_file_replace(struct file **dst,
+		spinlock_t *lock, struct kvm *kvm)
+{
+}
+
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct file *kvm_file)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..88c85a7b98c0 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -442,55 +442,61 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
-	bool ret;
+	struct file *old_kvm_file, *new_kvm_file = NULL;
 
-	lockdep_assert_held(&device->dev_set->lock);
+	/*
+	 * @kvm can outlive the VM fd and its final __fput(). Only take a
+	 * new reference if the VM file is still active.
+	 */
+	if (kvm)
+		new_kvm_file = get_file_active(&kvm->_file);
 
-	if (!kvm)
-		return;
+	spin_lock(lock);
+	old_kvm_file = *dst;
+	*dst = new_kvm_file;
+	spin_unlock(lock);
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
+	if (old_kvm_file)
+		fput(old_kvm_file);
+}
 
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file)
+{
+	lockdep_assert_held(&device->dev_set->lock);
 
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	/*
+	 * Take a VM file reference if the KVM fd is still active.
+	 */
+	if (kvm_file)
+		kvm_file = get_file(kvm_file);
 
-	device->put_kvm = pfn;
-	device->kvm = kvm;
+	device->kvm_file = kvm_file;
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
 {
+	struct file *kvm_file;
+
 	lockdep_assert_held(&device->dev_set->lock);
 
-	if (!device->kvm)
+	kvm_file = device->kvm_file;
+	if (!kvm_file)
 		return;
 
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
+	device->kvm_file = NULL;
+	fput(kvm_file);
+}
 
-	device->put_kvm(device->kvm);
-	device->put_kvm = NULL;
-	symbol_put(kvm_put_kvm);
+struct kvm *vfio_device_get_kvm(struct vfio_device *device)
+{
+	if (!device->kvm_file)
+		return NULL;
 
-clear:
-	device->kvm = NULL;
+	return device->kvm_file->private_data;
 }
+EXPORT_SYMBOL_GPL(vfio_device_get_kvm);
 #endif
 
 /* true if the vfio_device has open_device() called but not close_device() */
@@ -1518,13 +1524,10 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	struct vfio_device_file *df = file->private_data;
 
 	/*
-	 * The kvm is first recorded in the vfio_device_file, and will
-	 * be propagated to vfio_device::kvm when the file is bound to
-	 * iommufd successfully in the vfio device cdev path.
+	 * Cache the VM file reference associated with this VFIO file so it
+	 * can be pinned into vfio_device while the device is open.
 	 */
-	spin_lock(&df->kvm_ref_lock);
-	df->kvm = kvm;
-	spin_unlock(&df->kvm_ref_lock);
+	vfio_kvm_file_replace(&df->kvm_file, &df->kvm_ref_lock, kvm);
 }
 
 /**
@@ -1532,8 +1535,8 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
  * @file: VFIO group file or VFIO device file
  * @kvm: KVM to link
  *
- * When a VFIO device is first opened the KVM will be available in
- * device->kvm if one was associated with the file.
+ * When a VFIO device is first opened, VFIO caches a VM file reference if
+ * one was associated with the file.
  */
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..31afac5fb0ea 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,6 +45,8 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
+struct file;
+
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
 #endif
@@ -861,6 +863,7 @@ struct kvm {
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
 	pid_t userspace_pid;
+	struct file __rcu *_file;
 	bool override_halt_poll_ns;
 	unsigned int max_halt_poll_ns;
 	u32 dirty_ring_size;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..bca1d00f7845 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -22,8 +22,22 @@ struct kvm;
 struct iommufd_ctx;
 struct iommufd_device;
 struct iommufd_access;
+struct vfio_device;
 struct vfio_info_cap;
 
+#if IS_ENABLED(CONFIG_KVM)
+/*
+ * Return the KVM associated with @vdev's kvm_file. The returned pointer
+ * is valid only while VFIO device open holds the kvm_file reference.
+ */
+struct kvm *vfio_device_get_kvm(struct vfio_device *vdev);
+#else
+static inline struct kvm *vfio_device_get_kvm(struct vfio_device *vdev)
+{
+	return NULL;
+}
+#endif
+
 /*
  * VFIO devices can be placed in a set, this allows all devices to share this
  * structure and the VFIO core will provide a lock that is held around
@@ -54,7 +68,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
-	struct kvm *kvm;
+	struct file *kvm_file;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -66,7 +80,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..011819c5c47c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1351,6 +1351,7 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 
 	kvm_irqfd_release(kvm);
 
+	RCU_INIT_POINTER(kvm->_file, NULL);
 	kvm_put_kvm(kvm);
 	return 0;
 }
@@ -5500,6 +5501,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 		r = PTR_ERR(file);
 		goto put_kvm;
 	}
+	rcu_assign_pointer(kvm->_file, file);
 
 	/*
 	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
-- 
2.43.0

