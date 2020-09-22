Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgIVLWx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 07:22:53 -0400
Date: Tue, 22 Sep 2020 13:22:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] vfio-pci/zdev: use a device region to retrieve zPCI
 information
Message-ID: <20200922132239.4be1e749.cohuck@redhat.com>
In-Reply-To: <1600529318-8996-5-git-send-email-mjrosato@linux.ibm.com>
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
        <1600529318-8996-5-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 19 Sep 2020 11:28:38 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Define a new configuration entry VFIO_PCI_ZDEV for VFIO/PCI.
> 
> When this s390-only feature is configured we initialize a new device
> region, VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP, to hold information provided
> by the underlying hardware.
> 
> This patch is based on work previously done by Pierre Morel.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig            |  13 ++
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/vfio_pci.c         |   8 ++
>  drivers/vfio/pci/vfio_pci_private.h |  10 ++
>  drivers/vfio/pci/vfio_pci_zdev.c    | 242 ++++++++++++++++++++++++++++++++++++

Maybe you want to add yourself to MAINTAINERS for the zdev-specific
files? You're probably better suited to review changes to the
zpci-specific code :)

>  5 files changed, 274 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c

(...)

> +int vfio_pci_zdev_init(struct vfio_pci_device *vdev)
> +{
> +	struct vfio_region_zpci_info *region;
> +	struct zpci_dev *zdev;
> +	size_t clp_offset;
> +	int size;
> +	int ret;
> +
> +	if (!vdev->pdev->bus)
> +		return -ENODEV;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	/* Calculate size needed for all supported CLP features  */
> +	size = sizeof(*region) +
> +	       sizeof(struct vfio_region_zpci_info_qpci) +
> +	       sizeof(struct vfio_region_zpci_info_qpcifg) +
> +	       (sizeof(struct vfio_region_zpci_info_util) + CLP_UTIL_STR_LEN) +
> +	       (sizeof(struct vfio_region_zpci_info_pfip) +
> +		CLP_PFIP_NR_SEGMENTS);
> +
> +	region = kmalloc(size, GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	/* Fill in header */
> +	region->argsz = size;
> +	clp_offset = region->offset = sizeof(struct vfio_region_zpci_info);
> +
> +	/* Fill the supported CLP features */
> +	clp_offset = vfio_pci_zdev_add_qpci(zdev, region, clp_offset);
> +	clp_offset = vfio_pci_zdev_add_qpcifg(zdev, region, clp_offset);
> +	clp_offset = vfio_pci_zdev_add_util(zdev, region, clp_offset);
> +	clp_offset = vfio_pci_zdev_add_pfip(zdev, region, clp_offset);

So, the regions are populated once. Can any of the values in the
hardware structures be modified by a guest? Or changed from the
hardware side?

> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +		PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +		VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP, &vfio_pci_zdev_regops,
> +		size, VFIO_REGION_INFO_FLAG_READ, region);
> +	if (ret)
> +		kfree(region);
> +
> +	return ret;
> +}
