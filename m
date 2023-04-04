Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96071C76188
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 22:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjDDWVh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDWVg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 18:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA713A92
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680646848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtedyzqZlxnYrFGj+qXmrLzgKTFLw2c+Vuc4YDvBs9Y=;
        b=UzOHpne7GntJwANdqJiIkMbRE592H7Tkg+YYwnSe8uXju1UBjDmSc0gsAvopDeS6wl2Cu9
        clmyiIvLYmLmpVXNEy91GUCArM3Z+kY0Cerjke0VIXlDnegApQqX4r8t0JQC9IIszcj9F2
        f5J3/c/poom9eqsrT6tLZ01IKyUK05E=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-IsXK4RRoMXSMBTpBY0AcLw-1; Tue, 04 Apr 2023 18:20:47 -0400
X-MC-Unique: IsXK4RRoMXSMBTpBY0AcLw-1
Received: by mail-io1-f72.google.com with SMTP id d204-20020a6bb4d5000000b00758cfdd36c3so20885721iof.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 15:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtedyzqZlxnYrFGj+qXmrLzgKTFLw2c+Vuc4YDvBs9Y=;
        b=4rvch+t2jTcLuQYkVq15wuepW13p0sq61WK8hlTgKo3fyZ0d1u0HoSitRVBxxVfvoz
         vy3JkS1B/y4eVdljiwAPnATA1YOwC2B2xzuPWpIZ5lPE61NrxaRyr/eU6LGSf16EukG2
         86hdbiV0HQbP9sHur1+EVGVKQ/kuhnqKcqmBTd2j2QE7W0gX/B346YY9QjI2DMlUsdOT
         ba0XC7DYobCdW/ecpXj5Sssj/Qv7sCQ5FR1WGh+2oQq3WTT4tISfzYYbesxl6ZdSTbW4
         cGSC3x9JXgUNomlBPiZHEAvZZ8cD3jJY/PfsPAzuhylrjWJd5+Ek3OL6jKfdx/bcM62W
         BxTw==
X-Gm-Message-State: AAQBX9copn7oEqiHcfthJi45chZJ4LKVD1Mkbj1wCYi7gOCPHP3H86p/
        09PNxYkCdj54jc4ejU8ggKx94UK7tYnX9WlqWm4qUaxg66YtX9qTRURAiZpf+QA0AfJUTM0Gk0V
        //WKcP8+z3tTHAw5C7HEsGg==
X-Received: by 2002:a92:d987:0:b0:325:fe9f:b89e with SMTP id r7-20020a92d987000000b00325fe9fb89emr2656628iln.30.1680646846630;
        Tue, 04 Apr 2023 15:20:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bG28gnLkRr7C9UJ/JFxsCc3vxT4/kcNZsJIuMjQPoAsqhmlGTrjKd2rtr7Dssvge/zd/DKMA==
X-Received: by 2002:a92:d987:0:b0:325:fe9f:b89e with SMTP id r7-20020a92d987000000b00325fe9fb89emr2656616iln.30.1680646846274;
        Tue, 04 Apr 2023 15:20:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m17-20020a056638409100b004040f9898ebsm3653932jam.148.2023.04.04.15.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:20:45 -0700 (PDT)
Date:   Tue, 4 Apr 2023 16:20:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230404162044.25fb0f93.alex.williamson@redhat.com>
In-Reply-To: <20230401144429.88673-13-yi.l.liu@intel.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat,  1 Apr 2023 07:44:29 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> for the users that accept device fds passed from management stacks to be
> able to figure out the host reset affected devices among the devices
> opened by the user. This is needed as such users do not have BDF (bus,
> devfn) knowledge about the devices it has opened, hence unable to use
> the information reported by existing VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
> to figure out the affected devices.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 58 ++++++++++++++++++++++++++++----
>  include/uapi/linux/vfio.h        | 24 ++++++++++++-
>  2 files changed, 74 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 19f5b075d70a..a5a7e148dce1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -30,6 +30,7 @@
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> +#include <uapi/linux/iommufd.h>
>  
>  #include "vfio_pci_priv.h"
>  
> @@ -767,6 +768,20 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>  	return 0;
>  }
>  
> +static struct vfio_device *
> +vfio_pci_find_device_in_devset(struct vfio_device_set *dev_set,
> +			       struct pci_dev *pdev)
> +{
> +	struct vfio_device *cur;
> +
> +	lockdep_assert_held(&dev_set->lock);
> +
> +	list_for_each_entry(cur, &dev_set->device_list, dev_set_list)
> +		if (cur->dev == &pdev->dev)
> +			return cur;
> +	return NULL;
> +}
> +
>  static int vfio_pci_count_devs(struct pci_dev *pdev, void *data)
>  {
>  	(*(int *)data)++;
> @@ -776,13 +791,20 @@ static int vfio_pci_count_devs(struct pci_dev *pdev, void *data)
>  struct vfio_pci_fill_info {
>  	int max;
>  	int cur;
> +	bool require_devid;
> +	struct iommufd_ctx *iommufd;
> +	struct vfio_device_set *dev_set;
>  	struct vfio_pci_dependent_device *devices;

Poor structure packing, move the bool to the end.

Nit, maybe just name it @devid.

>  };
>  
>  static int vfio_pci_fill_devs(struct pci_dev *pdev, void *data)
>  {
>  	struct vfio_pci_fill_info *fill = data;
> +	struct vfio_device_set *dev_set = fill->dev_set;
>  	struct iommu_group *iommu_group;
> +	struct vfio_device *vdev;
> +
> +	lockdep_assert_held(&dev_set->lock);
>  
>  	if (fill->cur == fill->max)
>  		return -EAGAIN; /* Something changed, try again */
> @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev *pdev, void *data)
>  	if (!iommu_group)
>  		return -EPERM; /* Cannot reset non-isolated devices */
>  
> -	fill->devices[fill->cur].group_id = iommu_group_id(iommu_group);
> +	if (fill->require_devid) {

Nit, @vdev could be scoped here.

> +		/*
> +		 * Report dev_id of the devices that are opened as cdev
> +		 * and have the same iommufd with the fill->iommufd.
> +		 * Otherwise, just fill IOMMUFD_INVALID_ID.
> +		 */
> +		vdev = vfio_pci_find_device_in_devset(dev_set, pdev);

I wish I had a better solution to this, but I don't.

> +		if (vdev && vfio_device_cdev_opened(vdev) &&
> +		    fill->iommufd == vfio_iommufd_physical_ictx(vdev))
> +			vfio_iommufd_physical_devid(vdev, &fill->devices[fill->cur].dev_id);

Long line, maybe a pointer to &fill->devices[fill->cur] would help.

> +		else
> +			fill->devices[fill->cur].dev_id = IOMMUFD_INVALID_ID;
> +	} else {
> +		fill->devices[fill->cur].group_id = iommu_group_id(iommu_group);
> +	}
>  	fill->devices[fill->cur].segment = pci_domain_nr(pdev->bus);
>  	fill->devices[fill->cur].bus = pdev->bus->number;
>  	fill->devices[fill->cur].devfn = pdev->devfn;
> @@ -1230,17 +1266,27 @@ static int vfio_pci_ioctl_get_pci_hot_reset_info(
>  		return -ENOMEM;
>  
>  	fill.devices = devices;
> +	fill.dev_set = vdev->vdev.dev_set;
>  
> +	mutex_lock(&vdev->vdev.dev_set->lock);
> +	if (vfio_device_cdev_opened(&vdev->vdev)) {
> +		fill.require_devid = true;
> +		fill.iommufd = vfio_iommufd_physical_ictx(&vdev->vdev);
> +	}

We can do this unconditionally:

	fill.devid = vfio_device_cdev_opened(&vdev->vdev);
	fill.iommufd = vfio_iommufd_physical_ictx(&vdev->vdev);

Thanks,
Alex

>  	ret = vfio_pci_for_each_slot_or_bus(vdev->pdev, vfio_pci_fill_devs,
>  					    &fill, slot);
> +	mutex_unlock(&vdev->vdev.dev_set->lock);
>  
>  	/*
>  	 * If a device was removed between counting and filling, we may come up
>  	 * short of fill.max.  If a device was added, we'll have a return of
>  	 * -EAGAIN above.
>  	 */
> -	if (!ret)
> +	if (!ret) {
>  		hdr.count = fill.cur;
> +		if (fill.require_devid)
> +			hdr.flags = VFIO_PCI_HOT_RESET_FLAG_IOMMUFD_DEV_ID;
> +	}
>  
>  reset_info_exit:
>  	if (copy_to_user(arg, &hdr, minsz))
> @@ -2346,12 +2392,10 @@ static bool vfio_dev_in_files(struct vfio_pci_core_device *vdev,
>  static int vfio_pci_is_device_in_set(struct pci_dev *pdev, void *data)
>  {
>  	struct vfio_device_set *dev_set = data;
> -	struct vfio_device *cur;
>  
> -	list_for_each_entry(cur, &dev_set->device_list, dev_set_list)
> -		if (cur->dev == &pdev->dev)
> -			return 0;
> -	return -EBUSY;
> +	lockdep_assert_held(&dev_set->lock);
> +
> +	return vfio_pci_find_device_in_devset(dev_set, pdev) ? 0 : -EBUSY;
>  }
>  
>  /*
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 25432ef213ee..5a34364e3b94 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -650,11 +650,32 @@ enum {
>   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)
>   *
> + * This command is used to query the affected devices in the hot reset for
> + * a given device.  User could use the information reported by this command
> + * to figure out the affected devices among the devices it has opened.
> + * This command always reports the segment, bus and devfn information for
> + * each affected device, and selectively report the group_id or the dev_id
> + * per the way how the device being queried is opened.
> + *	- If the device is opened via the traditional group/container manner,
> + *	  this command reports the group_id for each affected device.
> + *
> + *	- If the device is opened as a cdev, this command needs to report
> + *	  dev_id for each affected device and set the
> + *	  VFIO_PCI_HOT_RESET_FLAG_IOMMUFD_DEV_ID flag.  For the affected
> + *	  devices that are not opened as cdev or bound to different iommufds
> + *	  with the device that is queried, report an invalid dev_id to avoid
> + *	  potential dev_id conflict as dev_id is local to iommufd.  For such
> + *	  affected devices, user shall fall back to use the segment, bus and
> + *	  devfn info to map it to opened device.
> + *
>   * Return: 0 on success, -errno on failure:
>   *	-enospc = insufficient buffer, -enodev = unsupported for device.
>   */
>  struct vfio_pci_dependent_device {
> -	__u32	group_id;
> +	union {
> +		__u32   group_id;
> +		__u32	dev_id;
> +	};
>  	__u16	segment;
>  	__u8	bus;
>  	__u8	devfn; /* Use PCI_SLOT/PCI_FUNC */
> @@ -663,6 +684,7 @@ struct vfio_pci_dependent_device {
>  struct vfio_pci_hot_reset_info {
>  	__u32	argsz;
>  	__u32	flags;
> +#define VFIO_PCI_HOT_RESET_FLAG_IOMMUFD_DEV_ID	(1 << 0)
>  	__u32	count;
>  	struct vfio_pci_dependent_device	devices[];
>  };

