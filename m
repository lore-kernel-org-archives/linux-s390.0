From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC v2 02/12] vfio: linux-headers update for vfio-ccw
Date: Tue, 17 Jan 2017 14:51:42 -0700
Message-ID: <20170117145142.4954666f@t450s.home>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
        <20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 12 Jan 2017 08:25:03 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> This is a placeholder for a linux-headers update.
> 
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> ---
>  include/standard-headers/asm-s390/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
>  linux-headers/linux/vfio.h                   | 17 +++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h
> 
> diff --git a/include/standard-headers/asm-s390/vfio_ccw.h b/include/standard-headers/asm-s390/vfio_ccw.h
> new file mode 100644
> index 0000000..cddc09b
> --- /dev/null
> +++ b/include/standard-headers/asm-s390/vfio_ccw.h
> @@ -0,0 +1,28 @@
> +/*
> + * Interfaces for vfio-ccw
> + *
> + * Copyright IBM Corp. 2017
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License (version 2 only)
> + * as published by the Free Software Foundation.
> + *
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _VFIO_CCW_H_
> +#define _VFIO_CCW_H_
> +
> +#include "standard-headers/linux/types.h"
> +
> +struct ccw_io_region {
> +#define ORB_AREA_SIZE 12
> +	uint8_t  orb_area[ORB_AREA_SIZE];
> +#define SCSW_AREA_SIZE 12
> +	uint8_t  scsw_area[SCSW_AREA_SIZE];
> +#define IRB_AREA_SIZE 96
> +	uint8_t  irb_area[IRB_AREA_SIZE];
> +	uint32_t ret_code;
> +} QEMU_PACKED;
> +
> +#endif

This is really part of the uapi for the vfio-ccw mdev device, isn't it?
Should it really be buried in asm-s390 in the kernel?

> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 759b850..b09d247 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -198,6 +198,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> +#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)	/* vfio-ccw device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -436,6 +437,22 @@ enum {
>  	VFIO_PCI_NUM_IRQS
>  };
>  
> +/*
> + * The VFIO-CCW bus driver makes use of the following fixed region and
> + * IRQ index mapping.  Unimplemented regions return a size of zero.
> + * Unimplemented IRQ types return a count of zero.
> + */
> +
> +enum {
> +        VFIO_CCW_CONFIG_REGION_INDEX,
> +        VFIO_CCW_NUM_REGIONS
> +};
> +
> +enum {
> +        VFIO_CCW_IO_IRQ_INDEX,
> +        VFIO_CCW_NUM_IRQS
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)
