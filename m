Return-Path: <SRS0=FZpJ=T4=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 28 May 2019 15:43:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 2/3] vfio: zpci: defining the VFIO headers
Message-ID: <20190528154342.7b0f3946@x1.home>
In-Reply-To: <1558614326-24711-3-git-send-email-pmorel@linux.ibm.com>
References: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
        <1558614326-24711-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 May 2019 14:25:25 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We define a new device region in vfio.h to be able to
> get the ZPCI CLP information by reading this region from
> userland.
> 
> We create a new file, vfio_zdev.h to define the structure
> of the new region we defined in vfio.h
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  include/uapi/linux/vfio.h      |  4 ++++
>  include/uapi/linux/vfio_zdev.h | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 include/uapi/linux/vfio_zdev.h
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8f10748..56595b8 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -306,6 +306,10 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_GFX                    (1)
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>  
> +/* IBM Subtypes */
> +#define VFIO_REGION_TYPE_IBM_ZDEV		(1)

This one defines (but never uses) a conflicting region type to GFX
above.

> +#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(1)

If we're using a PCI vendor type, which the next patch indicates we
are, this is the one you need.  But please also specify it as a PCI
vendor sub-type with the hex PCI vendor ID, and perhaps group it with
the Intel vendor sub-types.

> +
>  /**
>   * struct vfio_region_gfx_edid - EDID region layout.
>   *
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> new file mode 100644
> index 0000000..84b1a82
> --- /dev/null
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Region definition for ZPCI devices
> + *
> + * Copyright IBM Corp. 2019
> + *
> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> + */
> +
> +#ifndef _VFIO_ZDEV_H_
> +#define _VFIO_ZDEV_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct vfio_region_zpci_info - ZPCI information.
> + *
> + */
> +struct vfio_region_zpci_info {
> +	__u64 dasm;
> +	__u64 start_dma;
> +	__u64 end_dma;
> +	__u64 msi_addr;
> +	__u64 flags;
> +	__u16 pchid;
> +	__u16 mui;
> +	__u16 noi;
> +	__u8 gid;
> +	__u8 version;
> +#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
> +	__u8 util_str[CLP_UTIL_STR_LEN];

I don't see where CLP_UTIL_STR_LEN is defined in a uapi consumable
header.  Should this simply be [] where the string length is implied by
the remaining region size?  QEMU hard codes it, that doesn't validate
the vfio uapi.

> +} __packed;
> +
> +#endif
