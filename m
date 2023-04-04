Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418BC761A6
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 16:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjDDQ4Z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjDDQ4S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 12:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B155242
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680627297;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xaJr7dpR/2Qc16NAFTxDDK6uZmYwBJFK5YGMkD3WyVs=;
        b=Jog5E+vrCaOyd0jQ13h8KyZSzlPAHompK+06gQxUjHIyp/K2jY8KiVvTXXHBmIm2qkZ+wp
        kaX4KhQ5DE4aevUXjVqXlzajMAI6oBrwsxUpo2bm2Q3gtOaq/2aAItzgAgFDGoLMdr8vyA
        W72VJ6AVD+6QXckdNddYMkUCo+BgyWk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-ycXhOq6TNsmReQhTAk5pkw-1; Tue, 04 Apr 2023 12:54:56 -0400
X-MC-Unique: ycXhOq6TNsmReQhTAk5pkw-1
Received: by mail-qt1-f198.google.com with SMTP id c14-20020ac87d8e000000b003e38726ec8bso22538801qtd.23
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaJr7dpR/2Qc16NAFTxDDK6uZmYwBJFK5YGMkD3WyVs=;
        b=6a+4ro5RYakKL+R8uP7QKS0pA8Jhhd42anPbDVxgZ/ZVAWmvaoBwQtIzZJ8LVnCXxG
         Dq/Wpgmvk+ZPyB+WDIAQBFbzPrr1dT4OKFsYr4hnDPRIiVBtGYn25B7vn5eIvYR1IIGx
         ZBhZDjfVRr/69CHLU8QNxnbq79iWjAy9Kz7byDdrJxzyJ6HUDh/b74aJRpFmwW5Zu56e
         lDx1K2yQECVlyqrx+G/6Vpg3rYR6nOdWAKvS4cWzLowA93CVh1qV3qY04uUJw943z2X4
         UXQRsytVmRGxYC6G6rmk6RVuD7i+gx8yFUXixfh5vL6auz1P4AvwM9jT5o3gzFXFmAcU
         3Ahw==
X-Gm-Message-State: AAQBX9cgMQ82TMEOxEajBmwj+DaDlKLS/b/J9Wbvcl1gJsqhxDNLkoez
        A1vdzWyvPk2tJJCcqFEa+ZvWzijMC3qvdBBk5IDXUU+y4JbRxe60x1o8vt0yWJzMRDWUODPUVtC
        uZfdJ3dq8AYF7CCAsRtIRIA==
X-Received: by 2002:a05:6214:2427:b0:577:5ffe:e0ce with SMTP id gy7-20020a056214242700b005775ffee0cemr5531594qvb.25.1680627296187;
        Tue, 04 Apr 2023 09:54:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350axcpSEXLH/xqqNVDEazzfBDNocjyNb7PFsNU08BTja8vIes5X5ewmeGPijuUeHeJQRTVwQAA==
X-Received: by 2002:a05:6214:2427:b0:577:5ffe:e0ce with SMTP id gy7-20020a056214242700b005775ffee0cemr5531545qvb.25.1680627295895;
        Tue, 04 Apr 2023 09:54:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d127-20020a37b485000000b007465ad44891sm3743433qkf.102.2023.04.04.09.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:54:54 -0700 (PDT)
Message-ID: <f3af0d81-e8fe-5d25-bb7f-b362dbd62155@redhat.com>
Date:   Tue, 4 Apr 2023 18:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 05/12] vfio/pci: Allow passing zero-length fd array in
 VFIO_DEVICE_PCI_HOT_RESET
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
References: <20230401144429.88673-1-yi.l.liu@intel.com>
 <20230401144429.88673-6-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401144429.88673-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/1/23 16:44, Yi Liu wrote:
> as an alternative method for ownership check when iommufd is used. In
I don't understand the 1st sentence.
> this case all opened devices in the affected dev_set are verified to
> be bound to a same valid iommufd value to allow reset. It's simpler
> and faster as user does not need to pass a set of fds and kernel no
kernel does not need to search
> need to search the device within the given fds.
>
> a device in noiommu mode doesn't have a valid iommufd, so this method
> should not be used in a dev_set which contains multiple devices and one
> of them is in noiommu. The only allowed noiommu scenario is that the
> calling device is noiommu and it's in a singleton dev_set.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 42 +++++++++++++++++++++++++++-----
>  include/uapi/linux/vfio.h        |  9 ++++++-
>  2 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3696b8e58445..b68fcba67a4b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -180,7 +180,8 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  struct vfio_pci_group_info;
>  static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
>  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> -				      struct vfio_pci_group_info *groups);
> +				      struct vfio_pci_group_info *groups,
> +				      struct iommufd_ctx *iommufd_ctx);
>  
>  /*
>   * INTx masking requires the ability to disable INTx signaling via PCI_COMMAND
> @@ -1277,7 +1278,7 @@ vfio_pci_ioctl_pci_hot_reset_groups(struct vfio_pci_core_device *vdev,
>  		return ret;
>  
>  	/* Somewhere between 1 and count is OK */
> -	if (!hdr->count || hdr->count > count)
> +	if (hdr->count > count)
then I would simply remove the above comment since !count check is done
by the caller.
>  		return -EINVAL;
>  
>  	group_fds = kcalloc(hdr->count, sizeof(*group_fds), GFP_KERNEL);
> @@ -1326,7 +1327,7 @@ vfio_pci_ioctl_pci_hot_reset_groups(struct vfio_pci_core_device *vdev,
>  	info.count = hdr->count;
>  	info.files = files;
>  
> -	ret = vfio_pci_dev_set_hot_reset(vdev->vdev.dev_set, &info);
> +	ret = vfio_pci_dev_set_hot_reset(vdev->vdev.dev_set, &info, NULL);
>  
>  hot_reset_release:
>  	for (file_idx--; file_idx >= 0; file_idx--)
> @@ -1341,6 +1342,7 @@ static int vfio_pci_ioctl_pci_hot_reset(struct vfio_pci_core_device *vdev,
>  {
>  	unsigned long minsz = offsetofend(struct vfio_pci_hot_reset, count);
>  	struct vfio_pci_hot_reset hdr;
> +	struct iommufd_ctx *iommufd;
>  	bool slot = false;
>  
>  	if (copy_from_user(&hdr, arg, minsz))
> @@ -1355,7 +1357,12 @@ static int vfio_pci_ioctl_pci_hot_reset(struct vfio_pci_core_device *vdev,
>  	else if (pci_probe_reset_bus(vdev->pdev->bus))
>  		return -ENODEV;
>  
> -	return vfio_pci_ioctl_pci_hot_reset_groups(vdev, &hdr, slot, arg);
> +	if (hdr.count)
> +		return vfio_pci_ioctl_pci_hot_reset_groups(vdev, &hdr, slot, arg);
> +
> +	iommufd = vfio_iommufd_physical_ictx(&vdev->vdev);
> +
> +	return vfio_pci_dev_set_hot_reset(vdev->vdev.dev_set, NULL, iommufd);
>  }
>  
>  static int vfio_pci_ioctl_ioeventfd(struct vfio_pci_core_device *vdev,
> @@ -2327,6 +2334,9 @@ static bool vfio_dev_in_groups(struct vfio_pci_core_device *vdev,
>  {
>  	unsigned int i;
>  
> +	if (!groups)
> +		return false;
> +
>  	for (i = 0; i < groups->count; i++)
>  		if (vfio_file_has_dev(groups->files[i], &vdev->vdev))
>  			return true;
> @@ -2402,13 +2412,25 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
>  	return ret;
>  }
>  
> +static bool vfio_dev_in_iommufd_ctx(struct vfio_pci_core_device *vdev,
> +				    struct iommufd_ctx *iommufd_ctx)
> +{
> +	struct iommufd_ctx *iommufd = vfio_iommufd_physical_ictx(&vdev->vdev);
> +
> +	if (!iommufd)
> +		return false;
> +
> +	return iommufd == iommufd_ctx;
> +}
> +
>  /*
>   * We need to get memory_lock for each device, but devices can share mmap_lock,
>   * therefore we need to zap and hold the vma_lock for each device, and only then
>   * get each memory_lock.
>   */
>  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> -				      struct vfio_pci_group_info *groups)
> +				      struct vfio_pci_group_info *groups,
> +				      struct iommufd_ctx *iommufd_ctx)
>  {
>  	struct vfio_pci_core_device *cur_mem;
>  	struct vfio_pci_core_device *cur_vma;
> @@ -2448,9 +2470,17 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  		 *
>  		 * Otherwise all opened devices in the dev_set must be
>  		 * contained by the set of groups provided by the user.
> +		 *
> +		 * If user provides a zero-length array, then all the
> +		 * opened devices must be bound to a same iommufd_ctx.
> +		 *
> +		 * If all above checks are failed, reset is allowed only if
> +		 * the calling device is in a singleton dev_set.
>  		 */
>  		if (cur_vma->vdev.open_count &&
> -		    !vfio_dev_in_groups(cur_vma, groups)) {
> +		    !vfio_dev_in_groups(cur_vma, groups) &&
> +		    !vfio_dev_in_iommufd_ctx(cur_vma, iommufd_ctx) &&
> +		    (dev_set->device_count > 1)) {
>  			ret = -EINVAL;
>  			goto err_undo;
>  		}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index f96e5689cffc..17aa5d09db41 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -679,7 +679,14 @@ struct vfio_pci_hot_reset_info {
>   * the calling user must ensure all affected devices, if opened, are
>   * owned by itself.
>   *
> - * The ownership is proved by an array of group fds.
> + * The ownership can be proved by:
> + *   - An array of group fds
> + *   - A zero-length array

I would suggest something alike
in case a non void group fd array is passed, the devices affected by the
reset must belong to those opened VFIO groups.
in case a zero length array is passed, the other devices affected by the
reset, if any, must be bound to the same iommufd as this VFIO device
Either of the 2 methods is applied to check the feasibility of the reset
> + *
> + * In the last case all affected devices which are opened by this user
> + * must have been bound to a same iommufd. If the calling device is in
> + * noiommu mode (no valid iommufd) then it can be reset only if the reset
> + * doesn't affect other devices.
and keep that too
>   *
>   * Return: 0 on success, -errno on failure.
>   */
Thanks

Eric

