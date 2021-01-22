Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jan 2021 16:48:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: Introduce the zPCI I/O vfio region
Message-ID: <20210122164843.269f806c@omen.home.shazbot.org>
In-Reply-To: <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
References: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
        <1611086550-32765-5-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: cohuck@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 15:02:30 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Some s390 PCI devices (e.g. ISM) perform I/O operations that have very
> specific requirements in terms of alignment as well as the patterns in
> which the data is read/written. Allowing these to proceed through the
> typical vfio_pci_bar_rw path will cause them to be broken in up in such a
> way that these requirements can't be guaranteed. In addition, ISM devices
> do not support the MIO codepaths that might be triggered on vfio I/O coming
> from userspace; we must be able to ensure that these devices use the
> non-MIO instructions.  To facilitate this, provide a new vfio region by
> which non-MIO instructions can be passed directly to the host kernel s390
> PCI layer, to be reliably issued as non-MIO instructions.
> 
> This patch introduces the new vfio VFIO_REGION_SUBTYPE_IBM_ZPCI_IO region
> and implements the ability to pass PCISTB and PCILG instructions over it,
> as these are what is required for ISM devices.

There have been various discussions about splitting vfio-pci to allow
more device specific drivers rather adding duct tape and bailing wire
for various device specific features to extend vfio-pci.  The latest
iteration is here[1].  Is it possible that such a solution could simply
provide the standard BAR region indexes, but with an implementation that
works on s390, rather than creating new device specific regions to
perform the same task?  Thanks,

Alex

[1]https://lore.kernel.org/lkml/20210117181534.65724-1-mgurtovoy@nvidia.com/

> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |   8 ++
>  drivers/vfio/pci/vfio_pci_private.h |   6 ++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 158 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_zdev.h      |  33 ++++++++
>  5 files changed, 209 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 706de3e..e1c156e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -407,6 +407,14 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV)) {
> +		ret = vfio_pci_zdev_io_init(vdev);
> +		if (ret && ret != -ENODEV) {
> +			pci_warn(pdev, "Failed to setup zPCI I/O region\n");
> +			return ret;
> +		}
> +	}
> +
>  	vfio_pci_probe_mmaps(vdev);
>  
>  	return 0;
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 5c90e56..bc49980 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -217,12 +217,18 @@ static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
>  				       struct vfio_info_cap *caps);
> +extern int vfio_pci_zdev_io_init(struct vfio_pci_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int vfio_pci_zdev_io_init(struct vfio_pci_device *vdev)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* VFIO_PCI_PRIVATE_H */
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 57e19ff..a962043 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -18,6 +18,7 @@
>  #include <linux/vfio_zdev.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_io.h>
> +#include <asm/pci_insn.h>
>  
>  #include "vfio_pci_private.h"
>  
> @@ -143,3 +144,160 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
>  
>  	return ret;
>  }
> +
> +static size_t vfio_pci_zdev_io_rw(struct vfio_pci_device *vdev,
> +				  char __user *buf, size_t count,
> +				  loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	struct vfio_region_zpci_io *region = vdev->region[i].data;
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	void *base = region;
> +	struct page *gpage;
> +	void *gaddr;
> +	u64 *data;
> +	int ret;
> +	u64 req;
> +
> +	if ((!vdev->pdev->bus) || (!zdev))
> +		return -ENODEV;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	if (!iswrite) {
> +		/* Only allow reads to the _hdr area */
> +		if (pos + count > offsetof(struct vfio_region_zpci_io, req))
> +			return -EFAULT;
> +		if (copy_to_user(buf, base + pos, count))
> +			return -EFAULT;
> +		return count;
> +	}
> +
> +	/* Only allow writes to the _req area */
> +	if (pos < offsetof(struct vfio_region_zpci_io, req))
> +		return -EFAULT;
> +	if (copy_from_user(base + pos, buf, count))
> +		return -EFAULT;
> +
> +	/*
> +	 * Read operations are limited to 8B
> +	 */
> +	if ((region->req.flags & VFIO_ZPCI_IO_FLAG_READ) &&
> +		(region->req.len > 8)) {
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Block write operations are limited to hardware-reported max
> +	 */
> +	if ((region->req.flags & VFIO_ZPCI_IO_FLAG_BLOCKW) &&
> +		(region->req.len > zdev->maxstbl)) {
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * While some devices may allow relaxed alignment for the PCISTB
> +	 * instruction, the VFIO region requires the input buffer to be on a
> +	 * DWORD boundary for all operations for simplicity.
> +	 */
> +	if (!IS_ALIGNED(region->req.gaddr, sizeof(uint64_t)))
> +		return -EIO;
> +
> +	/*
> +	 * For now, the largest allowed block I/O is advertised as PAGE_SIZE,
> +	 * and cannot exceed a page boundary - so a single page is enough.  The
> +	 * guest should have validated this but let's double-check that the
> +	 * request will not cross a page boundary.
> +	 */
> +	if (((region->req.gaddr & ~PAGE_MASK)
> +			+ region->req.len - 1) & PAGE_MASK) {
> +		return -EIO;
> +	}
> +
> +	mutex_lock(&zdev->lock);
> +
> +	ret = get_user_pages_fast(region->req.gaddr & PAGE_MASK, 1, 0, &gpage);
> +	if (ret <= 0) {
> +		count = -EIO;
> +		goto out;
> +	}
> +	gaddr = page_address(gpage);
> +	gaddr += (region->req.gaddr & ~PAGE_MASK);
> +	data = (u64 *)gaddr;
> +
> +	req = ZPCI_CREATE_REQ(zdev->fh, region->req.pcias, region->req.len);
> +
> +	/* Perform the requested I/O operation */
> +	if (region->req.flags & VFIO_ZPCI_IO_FLAG_READ) {
> +		/* PCILG */
> +		ret = __zpci_load(data, req,
> +				region->req.offset);
> +	} else if (region->req.flags & VFIO_ZPCI_IO_FLAG_BLOCKW) {
> +		/* PCISTB */
> +		ret = __zpci_store_block(data, req,
> +					region->req.offset);
> +	} else {
> +		/* Undefined Operation or none provided */
> +		count = -EIO;
> +	}
> +	if (ret < 0)
> +		count = -EIO;
> +
> +	put_page(gpage);
> +
> +out:
> +	mutex_unlock(&zdev->lock);
> +	return count;
> +}
> +
> +static void vfio_pci_zdev_io_release(struct vfio_pci_device *vdev,
> +				     struct vfio_pci_region *region)
> +{
> +	kfree(region->data);
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_zdev_io_regops = {
> +	.rw		= vfio_pci_zdev_io_rw,
> +	.release	= vfio_pci_zdev_io_release,
> +};
> +
> +int vfio_pci_zdev_io_init(struct vfio_pci_device *vdev)
> +{
> +	struct vfio_region_zpci_io *region;
> +	struct zpci_dev *zdev;
> +	int ret;
> +
> +	if (!vdev->pdev->bus)
> +		return -ENODEV;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	region = kmalloc(sizeof(struct vfio_region_zpci_io), GFP_KERNEL);
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +		PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +		VFIO_REGION_SUBTYPE_IBM_ZPCI_IO,
> +		&vfio_pci_zdev_io_regops,
> +		sizeof(struct vfio_region_zpci_io),
> +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> +		region);
> +
> +	if (ret) {
> +		kfree(region);
> +		return ret;
> +	}
> +
> +	/* Setup the initial header information */
> +	region->hdr.flags = 0;
> +	region->hdr.max = zdev->maxstbl;
> +	region->hdr.reserved = 0;
> +	region->hdr.reserved2 = 0;
> +
> +	return ret;
> +}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index d181277..5547f9b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -338,6 +338,10 @@ struct vfio_region_info_cap_type {
>   * to do TLB invalidation on a GPU.
>   */
>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> +/*
> + * IBM zPCI I/O region
> + */
> +#define VFIO_REGION_SUBTYPE_IBM_ZPCI_IO		(2)
>  
>  /* sub-types for VFIO_REGION_TYPE_GFX */
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index b0b6596..830acca4 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -76,4 +76,37 @@ struct vfio_device_info_cap_zpci_pfip {
>  	__u8 pfip[];
>  };
>  
> +/**
> + * VFIO_REGION_SUBTYPE_IBM_ZPCI_IO - VFIO zPCI PCI Direct I/O Region
> + *
> + * This region is used to transfer I/O operations from the guest directly
> + * to the host zPCI I/O layer.  The same instruction requested by the guest
> + * (e.g. PCISTB) will always be used, even if the MIO variant is available.
> + *
> + * The _hdr area is user-readable and is used to provide setup information.
> + * The _req area is user-writable and is used to provide the I/O operation.
> + */
> +struct vfio_zpci_io_hdr {
> +	__u64 flags;
> +	__u16 max;		/* Max block operation size allowed */
> +	__u16 reserved;
> +	__u32 reserved2;
> +};
> +
> +struct vfio_zpci_io_req {
> +	__u64 flags;
> +#define VFIO_ZPCI_IO_FLAG_READ (1 << 0) /* Read Operation Specified */
> +#define VFIO_ZPCI_IO_FLAG_BLOCKW (1 << 1) /* Block Write Operation Specified */
> +	__u64 gaddr;		/* Address of guest data */
> +	__u64 offset;		/* Offset into target PCI Address Space */
> +	__u32 reserved;
> +	__u16 len;		/* Length of guest operation */
> +	__u8 pcias;		/* Target PCI Address Space */
> +	__u8 reserved2;
> +};
> +
> +struct vfio_region_zpci_io {
> +	struct vfio_zpci_io_hdr hdr;
> +	struct vfio_zpci_io_req req;
> +};
>  #endif
