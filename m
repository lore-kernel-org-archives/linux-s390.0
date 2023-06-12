Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14042C7EE2F
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jun 2023 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbjFLWnn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjFLWnd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Jun 2023 18:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53211B
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686609768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F75ik3Gqkzq0N+7Vu1ovwO7gqAH3ydx4ZbmNUzc5hkM=;
        b=SYQj07NuEsDqt8dE8cjnRg4d5aL5Ev7uk58U+aCN9hGX9ib7T3rR5X4f6EtO7LW4VFaqln
        rMqZUIUvncxmNXyjOmdTyJ85FnIV3uR9sAToTCrdIFLOb6zI/3xQsNzX0sndkruoeoX6sH
        QF/oD7BFCYYR53bJ4nwxN/bbAeHaerU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-pcdwVDXrNTqE4kA43ooihA-1; Mon, 12 Jun 2023 18:42:30 -0400
X-MC-Unique: pcdwVDXrNTqE4kA43ooihA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77ac14e9bc5so589174239f.2
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 15:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609750; x=1689201750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F75ik3Gqkzq0N+7Vu1ovwO7gqAH3ydx4ZbmNUzc5hkM=;
        b=i6dxoU5ArR/bBGmwMqb4H9pb6IoCJS1MKh2oj2QisGBttrzd0H0+eRp+eO4pV9TMA0
         wPw4PVskZMfGLnrVcKEEOkz4OVkIboh2/4c5IxZweFM6pjkFjlgTVdKtS9UAMrTKFmkY
         eLmp8hD6ZEFwOJblFen8AaL5zsob5qwmfmRtjokkl4V5fHwl1Ud8a3FjCCT4edIFkmyl
         f1UkuuCMZWg6kaYbuWVPmIUFbb5bfPcDf1lX4T/GONuqefs3a4FxOmv/wlfm29im+9P0
         +zT9aDAHKeZPELG8KMdUoubevrtsDgeJrhyOxp5nw4d0Z0expyWPjanXcP57owvx4YZ/
         vcfw==
X-Gm-Message-State: AC+VfDyRNC6Ml6SDCkTChEuD32QcbXj9vslUjvED9ygZ65o3Nbt+nMLP
        9MnB7H2ahVq9gwUWwI9qUuIRqBGu7M++D4tDJ+HK09ZtaY7jOiG5OPueqqinbpRBsoy4a8H0kwK
        fh1LRjPK8LfY71FXeVu+z6w==
X-Received: by 2002:a6b:7b45:0:b0:77a:ec0c:5907 with SMTP id m5-20020a6b7b45000000b0077aec0c5907mr7030168iop.13.1686609750030;
        Mon, 12 Jun 2023 15:42:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ659aPve/JGIQqnJc4um0EzETnEkwaU4sAoCUXmtup2XV1i32AN8041DFRUd8E22BOJmpf8JA==
X-Received: by 2002:a6b:7b45:0:b0:77a:ec0c:5907 with SMTP id m5-20020a6b7b45000000b0077aec0c5907mr7030155iop.13.1686609749769;
        Mon, 12 Jun 2023 15:42:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h19-20020a02c4d3000000b0041f52ea3514sm2963153jaj.158.2023.06.12.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:42:29 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:42:28 -0600
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
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: Re: [PATCH v12 21/24] vfio: Determine noiommu device in
 __vfio_register_dev()
Message-ID: <20230612164228.65b500e0.alex.williamson@redhat.com>
In-Reply-To: <20230602121653.80017-22-yi.l.liu@intel.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-22-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  2 Jun 2023 05:16:50 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This moves the noiommu device determination and noiommu taint out of
> vfio_group_find_or_alloc(). noiommu device is determined in
> __vfio_register_dev() and result is stored in flag vfio_device->noiommu,
> the noiommu taint is added in the end of __vfio_register_dev().
> 
> This is also a preparation for compiling out vfio_group infrastructure
> as it makes the noiommu detection and taint common between the cdev path
> and group path though cdev path does not support noiommu.

Does this really still make sense?  The motivation for the change is
really not clear without cdev support for noiommu.  Thanks,

Alex
 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/group.c     | 15 ---------------
>  drivers/vfio/vfio_main.c | 31 ++++++++++++++++++++++++++++++-
>  include/linux/vfio.h     |  1 +
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 653b62f93474..64cdd0ea8825 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -668,21 +668,6 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  	struct vfio_group *group;
>  
>  	iommu_group = iommu_group_get(dev);
> -	if (!iommu_group && vfio_noiommu) {
> -		/*
> -		 * With noiommu enabled, create an IOMMU group for devices that
> -		 * don't already have one, implying no IOMMU hardware/driver
> -		 * exists.  Taint the kernel because we're about to give a DMA
> -		 * capable device to a user without IOMMU protection.
> -		 */
> -		group = vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);
> -		if (!IS_ERR(group)) {
> -			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> -			dev_warn(dev, "Adding kernel taint for vfio-noiommu group on device\n");
> -		}
> -		return group;
> -	}
> -
>  	if (!iommu_group)
>  		return ERR_PTR(-EINVAL);
>  
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6d8f9b0f3637..00a699b9f76b 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -265,6 +265,18 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>  	return ret;
>  }
>  
> +static int vfio_device_set_noiommu(struct vfio_device *device)
> +{
> +	struct iommu_group *iommu_group = iommu_group_get(device->dev);
> +
> +	if (!iommu_group && !vfio_noiommu)
> +		return -EINVAL;
> +
> +	device->noiommu = !iommu_group;
> +	iommu_group_put(iommu_group); /* Accepts NULL */
> +	return 0;
> +}
> +
>  static int __vfio_register_dev(struct vfio_device *device,
>  			       enum vfio_group_type type)
>  {
> @@ -277,6 +289,13 @@ static int __vfio_register_dev(struct vfio_device *device,
>  		     !device->ops->detach_ioas)))
>  		return -EINVAL;
>  
> +	/* Only physical devices can be noiommu device */
> +	if (type == VFIO_IOMMU) {
> +		ret = vfio_device_set_noiommu(device);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * If the driver doesn't specify a set then the device is added to a
>  	 * singleton set just for itself.
> @@ -288,7 +307,8 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (ret)
>  		return ret;
>  
> -	ret = vfio_device_set_group(device, type);
> +	ret = vfio_device_set_group(device,
> +				    device->noiommu ? VFIO_NO_IOMMU : type);
>  	if (ret)
>  		return ret;
>  
> @@ -301,6 +321,15 @@ static int __vfio_register_dev(struct vfio_device *device,
>  
>  	vfio_device_group_register(device);
>  
> +	if (device->noiommu) {
> +		/*
> +		 * noiommu deivces have no IOMMU hardware/driver.  Taint the
> +		 * kernel because we're about to give a DMA capable device to
> +		 * a user without IOMMU protection.
> +		 */
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev, "Adding kernel taint for vfio-noiommu on device\n");
> +	}
>  	return 0;
>  err_out:
>  	vfio_device_remove_group(device);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e80a8ac86e46..183e620009e7 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -67,6 +67,7 @@ struct vfio_device {
>  	bool iommufd_attached;
>  #endif
>  	bool cdev_opened:1;
> +	bool noiommu:1;
>  };
>  
>  /**

