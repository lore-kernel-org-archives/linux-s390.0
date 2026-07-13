Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B040E8F5;
	Mon, 13 Jul 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947548; cv=none; b=UKLC6ab7G/dc5qCUz4GSrZVNZYN/NaPOwNGNhy2wHniTm92OV5LfpTn7wSZKE+EkyaxlQVCJDesZwtXUN3Y4vklQ0gjLI8KV/PMvT9RXlxBpMmzdXWosHBqO3yBEF9zBe06iK0GNUjqE//iO16argbBEnfxcUOpmwc4CWOHheNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947548; c=relaxed/simple;
	bh=HYG7xsN3we//3CS5YORptORDiWvvKL/5naSd2e0b1jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsht377uKEVZZoKqWxyb5Nio7AlBZr8YfrlVscw8MXIvqwe51Eb62wcb1Ng6+3v9lJrrJZ1wZXY+F2Ok0H600mATkfaXEgNJGyu0Tg7k3FeO73NRyn9p/XH9we4mr5sgXlRw1Dws6JH8XSfIpTAaDwkAmSbf0iGZxGt9L/vdLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jMF9GiWS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jMF9GiWS"
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id D821220B716F; Mon, 13 Jul 2026 05:58:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D821220B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783947535;
	bh=B4xgmHRpxY0w+f4J0WGkQeaIjzFbYhEnWIXDWbYxgao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMF9GiWSlj4YIrS3pAEigfyWM8hLIx0rVLXPc4T0zXSzSZKUAfGQZR01xl1VV52zU
	 bNDjgp2P6o0xlEZW97iP1lkK0wcx0cd5867xcTPWgE561/TAuwO3INAHBpqlBhBwwB
	 WuMAGljFz3336C+4N6dpWc5FS/rv/4ejgrphxdoA=
Date: Mon, 13 Jul 2026 05:58:55 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
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
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/5] vfio: cache KVM VM file references instead of raw
 struct kvm pointers
Message-ID: <alThD6mjBG2SGZzf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525154816.1029642-2-aneesh.kumar@kernel.org>

On Mon, May 25, 2026 at 09:18:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
> VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
> and the opened vfio_device. Switch VFIO to track the VM's struct file
> instead, so VFIO and iommufd can use normal file references for VM lifetime
> instead of depending on KVM's internal struct kvm refcounting.
> 
> KVM_CREATE_DEVICE binds the KVM VM lifetime to the KVM device fd lifetime.
> For KVM_DEV_TYPE_VFIO, the KVM VFIO device fd also takes references to each
> VFIO file added through KVM_DEV_VFIO_FILE_ADD. The KVM VFIO device fd
> therefore owns both the internal KVM reference and the VFIO file references
> in kvf->file.
> 
> KVM_DEV_VFIO_FILE_ADD further installs the VM file association into the
> VFIO file. VFIO converts the struct kvm pointer to a VM file reference with
> get_file_active(&kvm->_file), because the KVM device fd can keep struct kvm
> alive after the original VM fd is already in final release.
> 
> The association intentionally pins the VM file until KVM_DEV_VFIO_FILE_DEL
> or until the KVM VFIO device fd is released. This gives VFIO/iommufd a
> stable VM file reference source without taking a dependency on KVM's struct
> kvm lifetime. The KVM VFIO device release path clears the VFIO-side
> association before dropping its VFIO file references.
> 
> When a VFIO device is opened or bound, VFIO takes an additional reference
> from the associated VM file and stores it in vfio_device::kvm_file for
> driver and iommufd use. That open-time reference is released from
> vfio_device_put_kvm() when the VFIO device is closed or unbound.
> 
can the "VM file" that VFIO caches be abstracted from "the KVM VM file"
to "a VM file the VMM registered"?
> This gives the ownership model:
> 
>   - KVM device fd pins struct kvm through kvm->users_count
>   - KVM VFIO device fd pins VFIO files through kvf->file
>   - VFIO group/device-file state pins the VM file while associated with KVM
>   - vfio_device::kvm_file pins the VM file during active VFIO device use
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  5 +-
>  drivers/vfio/device_cdev.c        | 10 ++--
>  drivers/vfio/group.c              | 14 +++---
>  drivers/vfio/pci/vfio_pci_zdev.c  |  7 +--
>  drivers/vfio/vfio.h               | 16 ++++--
>  drivers/vfio/vfio_main.c          | 81 ++++++++++++++++---------------
>  include/linux/kvm_host.h          |  3 ++
>  include/linux/vfio.h              | 17 ++++++-
>  virt/kvm/kvm_main.c               |  2 +
>  9 files changed, 91 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44b3a1dcc1b3..05996a8fd860 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2054,11 +2054,12 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev =
>  		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct kvm *kvm = vfio_device_get_kvm(vdev);
>  
> -	if (!vdev->kvm)
> +	if (!kvm)
>  		return -EINVAL;
>  
> -	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
> +	return vfio_ap_mdev_set_kvm(matrix_mdev, kvm);
>  }
>  
>  static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..ca75ab8eb7bd 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>  static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
>  {
>  	spin_lock(&df->kvm_ref_lock);
> -	vfio_device_get_kvm_safe(df->device, df->kvm);
> +	vfio_device_get_kvm_safe(df->device, df->kvm_file);
>  	spin_unlock(&df->kvm_ref_lock);
>  }
>  
> @@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>  	}
>  
>  	/*
> -	 * Before the device open, get the KVM pointer currently
> -	 * associated with the device file (if there is) and obtain
> -	 * a reference.  This reference is held until device closed.
> -	 * Save the pointer in the device for use by drivers.
> +	 * Before the device open, get the VM struct file currently
> +	 * associated with the device file (if there is one) and obtain a
> +	 * reference. This reference is held until the device is closed.
> +	 * Save the file in the device for use by drivers.
>  	 */
>  	vfio_df_get_kvm_safe(df);
>  
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df..8950cfb9405d 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -163,7 +163,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
>  {
>  	spin_lock(&device->group->kvm_ref_lock);
> -	vfio_device_get_kvm_safe(device, device->group->kvm);
> +	vfio_device_get_kvm_safe(device, device->group->kvm_file);
>  	spin_unlock(&device->group->kvm_ref_lock);
>  }
>  
> @@ -181,10 +181,10 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>  	mutex_lock(&device->dev_set->lock);
>  
>  	/*
> -	 * Before the first device open, get the KVM pointer currently
> -	 * associated with the group (if there is one) and obtain a reference
> -	 * now that will be held until the open_count reaches 0 again.  Save
> -	 * the pointer in the device for use by drivers.
> +	 * Before the first device open, get the VM struct file currently
> +	 * associated with the group (if there is one) and obtain a
> +	 * reference now that will be held until the open_count reaches 0
> +	 * again. Save the file in the device for use by drivers.
>  	 */
>  	if (device->open_count == 0)
>  		vfio_device_group_get_kvm_safe(device);
> @@ -862,9 +862,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
>  
>  void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
>  {
> -	spin_lock(&group->kvm_ref_lock);
> -	group->kvm = kvm;
> -	spin_unlock(&group->kvm_ref_lock);
> +	vfio_kvm_file_replace(&group->kvm_file, &group->kvm_ref_lock, kvm);
>  }
>  
>  /**
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..a9d8e6aa3839 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -144,15 +144,16 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	struct kvm *kvm = vfio_device_get_kvm(&vdev->vdev);
>  
>  	if (!zdev)
>  		return -ENODEV;
>  
> -	if (!vdev->vdev.kvm)
> +	if (!kvm)
>  		return 0;
>  
>  	if (zpci_kvm_hook.kvm_register)
> -		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
> +		return zpci_kvm_hook.kvm_register(zdev, kvm);
>  
>  	return -ENOENT;
>  }
> @@ -161,7 +162,7 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>  
> -	if (!zdev || !vdev->vdev.kvm)
> +	if (!zdev || !vfio_device_get_kvm(&vdev->vdev))
>  		return;
>  
>  	if (zpci_kvm_hook.kvm_unregister)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3..41032104eb36 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -22,8 +22,8 @@ struct vfio_device_file {
>  
>  	u8 access_granted;
>  	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> +	struct file *kvm_file;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>  };
>  
> @@ -88,7 +88,7 @@ struct vfio_group {
>  #endif
>  	enum vfio_group_type		type;
>  	struct mutex			group_lock;
> -	struct kvm			*kvm;
> +	struct file			*kvm_file;
>  	struct file			*opened_file;
>  	struct iommufd_ctx		*iommufd;
>  	spinlock_t			kvm_ref_lock;
> @@ -434,11 +434,17 @@ static inline void vfio_virqfd_exit(void)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
> +void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm);
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file);
>  void vfio_device_put_kvm(struct vfio_device *device);
>  #else
> +static inline void vfio_kvm_file_replace(struct file **dst,
> +		spinlock_t *lock, struct kvm *kvm)
> +{
> +}
> +
>  static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
> -					    struct kvm *kvm)
> +					    struct file *kvm_file)
>  {
>  }
>  
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..88c85a7b98c0 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -442,55 +442,61 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
> +void vfio_kvm_file_replace(struct file **dst, spinlock_t *lock, struct kvm *kvm)
>  {
> -	void (*pfn)(struct kvm *kvm);
> -	bool (*fn)(struct kvm *kvm);
> -	bool ret;
> +	struct file *old_kvm_file, *new_kvm_file = NULL;
>  
> -	lockdep_assert_held(&device->dev_set->lock);
> +	/*
> +	 * @kvm can outlive the VM fd and its final __fput(). Only take a
> +	 * new reference if the VM file is still active.
> +	 */
> +	if (kvm)
> +		new_kvm_file = get_file_active(&kvm->_file);
>  
> -	if (!kvm)
> -		return;
> +	spin_lock(lock);
> +	old_kvm_file = *dst;
> +	*dst = new_kvm_file;
> +	spin_unlock(lock);
>  
> -	pfn = symbol_get(kvm_put_kvm);
> -	if (WARN_ON(!pfn))
> -		return;
> +	if (old_kvm_file)
> +		fput(old_kvm_file);
> +}
>  
> -	fn = symbol_get(kvm_get_kvm_safe);
> -	if (WARN_ON(!fn)) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm_file)
> +{
> +	lockdep_assert_held(&device->dev_set->lock);
>  
> -	ret = fn(kvm);
> -	symbol_put(kvm_get_kvm_safe);
> -	if (!ret) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +	/*
> +	 * Take a VM file reference if the KVM fd is still active.
> +	 */
> +	if (kvm_file)
> +		kvm_file = get_file(kvm_file);
>  
> -	device->put_kvm = pfn;
> -	device->kvm = kvm;
> +	device->kvm_file = kvm_file;
>  }
>  
>  void vfio_device_put_kvm(struct vfio_device *device)
>  {
> +	struct file *kvm_file;
> +
>  	lockdep_assert_held(&device->dev_set->lock);
>  
> -	if (!device->kvm)
> +	kvm_file = device->kvm_file;
> +	if (!kvm_file)
>  		return;
>  
> -	if (WARN_ON(!device->put_kvm))
> -		goto clear;
> +	device->kvm_file = NULL;
> +	fput(kvm_file);
> +}
>  
> -	device->put_kvm(device->kvm);
> -	device->put_kvm = NULL;
> -	symbol_put(kvm_put_kvm);
> +struct kvm *vfio_device_get_kvm(struct vfio_device *device)
> +{
> +	if (!device->kvm_file)
> +		return NULL;
>  
> -clear:
> -	device->kvm = NULL;
> +	return device->kvm_file->private_data;
>  }
> +EXPORT_SYMBOL_GPL(vfio_device_get_kvm);
>  #endif
>  
>  /* true if the vfio_device has open_device() called but not close_device() */
> @@ -1518,13 +1524,10 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>  	struct vfio_device_file *df = file->private_data;
>  
>  	/*
> -	 * The kvm is first recorded in the vfio_device_file, and will
> -	 * be propagated to vfio_device::kvm when the file is bound to
> -	 * iommufd successfully in the vfio device cdev path.
> +	 * Cache the VM file reference associated with this VFIO file so it
> +	 * can be pinned into vfio_device while the device is open.
>  	 */
> -	spin_lock(&df->kvm_ref_lock);
> -	df->kvm = kvm;
> -	spin_unlock(&df->kvm_ref_lock);
> +	vfio_kvm_file_replace(&df->kvm_file, &df->kvm_ref_lock, kvm);
>  }
>  
>  /**
> @@ -1532,8 +1535,8 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>   * @file: VFIO group file or VFIO device file
>   * @kvm: KVM to link
>   *
> - * When a VFIO device is first opened the KVM will be available in
> - * device->kvm if one was associated with the file.
> + * When a VFIO device is first opened, VFIO caches a VM file reference if
> + * one was associated with the file.
>   */
>  void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4c14aee1fb06..31afac5fb0ea 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -45,6 +45,8 @@
>  #include <asm/kvm_host.h>
>  #include <linux/kvm_dirty_ring.h>
>  
> +struct file;
> +
>  #ifndef KVM_MAX_VCPU_IDS
>  #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
>  #endif
> @@ -861,6 +863,7 @@ struct kvm {
>  	struct srcu_struct srcu;
>  	struct srcu_struct irq_srcu;
>  	pid_t userspace_pid;
> +	struct file __rcu *_file;
>  	bool override_halt_poll_ns;
>  	unsigned int max_halt_poll_ns;
>  	u32 dirty_ring_size;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 31b826efba00..bca1d00f7845 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -22,8 +22,22 @@ struct kvm;
>  struct iommufd_ctx;
>  struct iommufd_device;
>  struct iommufd_access;
> +struct vfio_device;
>  struct vfio_info_cap;
>  
> +#if IS_ENABLED(CONFIG_KVM)
> +/*
> + * Return the KVM associated with @vdev's kvm_file. The returned pointer
> + * is valid only while VFIO device open holds the kvm_file reference.
> + */
> +struct kvm *vfio_device_get_kvm(struct vfio_device *vdev);
> +#else
> +static inline struct kvm *vfio_device_get_kvm(struct vfio_device *vdev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  /*
>   * VFIO devices can be placed in a set, this allows all devices to share this
>   * structure and the VFIO core will provide a lock that is held around
> @@ -54,7 +68,7 @@ struct vfio_device {
>  	struct list_head dev_set_list;
>  	unsigned int migration_flags;
>  	u8 precopy_info_v2;
> -	struct kvm *kvm;
> +	struct file *kvm_file;
>  
>  	/* Members below here are private, not for driver use */
>  	unsigned int index;
> @@ -66,7 +80,6 @@ struct vfio_device {
>  	unsigned int open_count;
>  	struct completion comp;
>  	struct iommufd_access *iommufd_access;
> -	void (*put_kvm)(struct kvm *kvm);
>  	struct inode *inode;
>  #if IS_ENABLED(CONFIG_IOMMUFD)
>  	struct iommufd_device *iommufd_device;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..011819c5c47c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1351,6 +1351,7 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>  
>  	kvm_irqfd_release(kvm);
>  
> +	RCU_INIT_POINTER(kvm->_file, NULL);
>  	kvm_put_kvm(kvm);
>  	return 0;
>  }
> @@ -5500,6 +5501,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>  		r = PTR_ERR(file);
>  		goto put_kvm;
>  	}
> +	rcu_assign_pointer(kvm->_file, file);
>  
>  	/*
>  	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
> -- 
> 2.43.0
> 
