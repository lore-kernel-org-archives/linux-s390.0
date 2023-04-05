Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E134C7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 09:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjDEJiN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbjDEJiK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 05:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B75267
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680687395;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNBqhrj+XTm9KfkuETQ/F4AN0Uqhaaw5G/lVJC6MyqE=;
        b=TDahx3M2YO/U9+U5tOpD/F+CWNUs5nEIlYIEVTrkBVNWQ7mKu65bGDwfDI8w/7tNXZt2Po
        pAPFhpxYilvlrc7YWdcp9lR8pF9+05gMkSbj2CZbXFLEwEShXgSPx/VFIJw8TuiBqj+748
        0qeDWGtCnhWfHsKg6+xSOhg64NAJOWU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-3eVaBcqUN7qlahqLVQV7SQ-1; Wed, 05 Apr 2023 05:36:34 -0400
X-MC-Unique: 3eVaBcqUN7qlahqLVQV7SQ-1
Received: by mail-qv1-f70.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so16037336qvb.7
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 02:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNBqhrj+XTm9KfkuETQ/F4AN0Uqhaaw5G/lVJC6MyqE=;
        b=7U0wl9EFEIoFI2pdEZIaDWlMAXLuRJJ3Ubx9aH4hBg3GdOaQW9FKyr+5EOKyV/1UCt
         fphbf37j4mUoFbcZ9TjEbs9mjASAVu6O0+jNvJnDnfqDizZgfk4C2M5tbP4gkDeXMj3q
         yXaKejehfCWLCa01Vl7aPB3XNO29Pcs/lDw5ZZDHzl+M/R5snN49BrzKa3dYJM7bOBxC
         hYuspjhuQ3m6o1akqxlyDF28VcS4VLubh4yAZC5j37SOWJ1WFpqizvjaVAa1hA1j+xzm
         cp0ysKqYhIm5A5ZOz7r/7yjPmi2MJsT93Au3DR6m9CwKHgDRYKIWmVtSf3gy6sdoNzAv
         RKGw==
X-Gm-Message-State: AAQBX9dUrSMdCZnjDDg0d5uv5Ijvp1PR4u+wqSfZUN3GffB4STre76mh
        v1f5NVq5YmBS0IKdE9PaWMQsGLx4OtT6tvP+jTwjDMMIGmDrVSKk4FeDG4xT58grHj3llb/BHpR
        Et4kwd/Y8c3NwRhVZEjzUYg==
X-Received: by 2002:a05:6214:2588:b0:579:5dbc:ab8c with SMTP id fq8-20020a056214258800b005795dbcab8cmr8061822qvb.30.1680687389405;
        Wed, 05 Apr 2023 02:36:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZmW7jHQa6DlupuWctFYcymxjC6ipeuyihMvEZoDZgJpFRcRiiHDYRJnqb2qNZSPOB4Sijfqw==
X-Received: by 2002:a05:6214:2588:b0:579:5dbc:ab8c with SMTP id fq8-20020a056214258800b005795dbcab8cmr8061789qvb.30.1680687388936;
        Wed, 05 Apr 2023 02:36:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id mm17-20020a0562145e9100b005dd8b9345f4sm3996945qvb.140.2023.04.05.02.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:36:26 -0700 (PDT)
Message-ID: <5aaaf93e-f000-7f6c-b315-cf9550a237e8@redhat.com>
Date:   Wed, 5 Apr 2023 11:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 09/12] vfio/pci: Accept device fd in
 VFIO_DEVICE_PCI_HOT_RESET ioctl
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
 <20230401144429.88673-10-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401144429.88673-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 4/1/23 16:44, Yi Liu wrote:
> Now user can also provide an array of device fds as a 3rd method to verify
> the reset ownership. It's not useful at this point when the device fds are
> acquired via group fds. But it's necessary when moving to device cdev which
> allows the user to directly acquire device fds by skipping group. In that
> case this method can be used as a last resort when the preferred iommufd
> verification doesn't work, e.g. in noiommu usages.
>
> Clarify it in uAPI.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 9 +++++----
>  include/uapi/linux/vfio.h        | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index da6325008872..19f5b075d70a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1289,7 +1289,7 @@ vfio_pci_ioctl_pci_hot_reset_files(struct vfio_pci_core_device *vdev,
>  		return -ENOMEM;
>  	}
>  
> -	if (copy_from_user(fds, arg->group_fds,
> +	if (copy_from_user(fds, arg->fds,
>  			   hdr->count * sizeof(*fds))) {
>  		kfree(fds);
>  		kfree(files);
> @@ -1297,8 +1297,8 @@ vfio_pci_ioctl_pci_hot_reset_files(struct vfio_pci_core_device *vdev,
>  	}
>  
>  	/*
> -	 * Get the group file for each fd to ensure the group held across
> -	 * the reset
> +	 * Get the file for each fd to ensure the group/device file
> +	 * is held across the reset
>  	 */
>  	for (file_idx = 0; file_idx < hdr->count; file_idx++) {
>  		struct file *file = fget(fds[file_idx]);
> @@ -2469,7 +2469,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  		 * cannot race being opened by another user simultaneously.
>  		 *
>  		 * Otherwise all opened devices in the dev_set must be
> -		 * contained by the set of groups provided by the user.
> +		 * contained by the set of groups/devices provided by
> +		 * the user.
>  		 *
>  		 * If user provides a zero-length array, then all the
>  		 * opened devices must be bound to a same iommufd_ctx.
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 17aa5d09db41..25432ef213ee 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -681,6 +681,7 @@ struct vfio_pci_hot_reset_info {
>   *
>   * The ownership can be proved by:
>   *   - An array of group fds
> + *   - An array of device fds
>   *   - A zero-length array
>   *
>   * In the last case all affected devices which are opened by this user
> @@ -694,7 +695,7 @@ struct vfio_pci_hot_reset {
>  	__u32	argsz;
>  	__u32	flags;
>  	__u32	count;
> -	__s32	group_fds[];
> +	__s32	fds[];
>  };
>  
>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)

