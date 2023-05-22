Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E5C7EE2D
	for <linux-s390@archiver.kernel.org>; Mon, 22 May 2023 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEVUZv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 May 2023 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjEVUZ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 May 2023 16:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5F1B7
        for <linux-s390@vger.kernel.org>; Mon, 22 May 2023 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684787081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NENApr2cZp+USCY75WyJ/FbkT9bE21OL+57iVe/1FUo=;
        b=Duj0V6trDCu88lJXrfrxG+pI/NTSpb9n3MNyQbMAzEDdTtonYEyXvkhMM+2E+UC6GeAVQh
        CdEQw8stUOvurn31hkVm/Ag8CHDJumBqrpgV9zIMHNDePo55a5gb+c7MveO1QNeXgjiGFL
        vU+Jtlxut4/yuBm44UpsFEiR/bI9K6g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-jwjHO6P5MyO9BWitTj_EQA-1; Mon, 22 May 2023 16:24:40 -0400
X-MC-Unique: jwjHO6P5MyO9BWitTj_EQA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-333eb36e510so327455ab.1
        for <linux-s390@vger.kernel.org>; Mon, 22 May 2023 13:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787080; x=1687379080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NENApr2cZp+USCY75WyJ/FbkT9bE21OL+57iVe/1FUo=;
        b=NO0WrCism6S+PuaWarm7d7VRjVNc8kW4nQxcC5XH68K8z6/YQL9O1Xq+wz7bBA8MKz
         ysUP6Jz2S9q9sglDhzFCEle8R0yxKgayJK3I6j/2wsbOxo6BjbAxxS9b1WG4SGHPD72L
         f7+BtLMH3LlcpRfc318REELeupA6nBg0STo7AtClEjeFzNZVZ/DN/zZP049sqGIKGPYV
         wDoepuujC8SC2OSuFYYgKqMH78l4qQlI5V1AGQZ00sCqatqHTwgCdQMGeEzgdADAc+eh
         ZBpXJ9J6ul4jLDv+YtMn7MQ4xvS5py1AwfY39fqImtp/yzpL4UYVnvBM++cGTmUYEcQg
         VDOg==
X-Gm-Message-State: AC+VfDzS83cm1gwX6Mlovrc9Qi+i9vBHUEkCzA8C9JPHt3nEBa+pGNDx
        a4nH0XDX+2S507XPUdMa8sJbJIGfsqCvn3yhbjLbHZ1arJkS/aqYKFkvuLZqmxfvAUPdYdIS9AR
        Yw6lwQXb6n9eK/BNCjgH2JQ==
X-Received: by 2002:a92:c64d:0:b0:338:e5a9:e43f with SMTP id 13-20020a92c64d000000b00338e5a9e43fmr4889686ill.17.1684787079755;
        Mon, 22 May 2023 13:24:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ512CeDeZO8hU3xF8vOUYaaUxxB6hwvCnGroyhxR9InVCYt68F99GX0+3UcrYhQidOeA0YXTA==
X-Received: by 2002:a92:c64d:0:b0:338:e5a9:e43f with SMTP id 13-20020a92c64d000000b00338e5a9e43fmr4889656ill.17.1684787079467;
        Mon, 22 May 2023 13:24:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m16-20020a92d710000000b0032e1f94be7bsm1919596iln.33.2023.05.22.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:38 -0700 (PDT)
Date:   Mon, 22 May 2023 14:24:35 -0600
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
Subject: Re: [PATCH v11 10/23] vfio-iommufd: Move noiommu compat probe out
 of vfio_iommufd_bind()
Message-ID: <20230522142435.298ea794.alex.williamson@redhat.com>
In-Reply-To: <20230513132827.39066-11-yi.l.liu@intel.com>
References: <20230513132827.39066-1-yi.l.liu@intel.com>
        <20230513132827.39066-11-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 13 May 2023 06:28:14 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> into vfio_device_group_open(). This is more consistent with what will
> be done in vfio device cdev path.

Same comment regarding flowing commit subject into body on this series.

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/group.c   |  6 ++++++
>  drivers/vfio/iommufd.c | 32 +++++++++++++++++++-------------
>  drivers/vfio/vfio.h    |  9 +++++++++
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index a17584e8be15..cfd0b9254bbc 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,6 +192,12 @@ static int vfio_device_group_open(struct vfio_device_file *df)
>  		vfio_device_group_get_kvm_safe(device);
>  
>  	df->iommufd = device->group->iommufd;
> +	if (df->iommufd && vfio_device_is_noiommu(device) && device->open_count == 0) {
> +		ret = vfio_iommufd_compat_probe_noiommu(device,
> +							df->iommufd);
> +		if (ret)
> +			goto out_put_kvm;
> +	}
>  
>  	ret = vfio_device_open(df);
>  	if (ret) {
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a18e920be164..7a654a1437f0 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -46,6 +46,24 @@ static void vfio_iommufd_noiommu_unbind(struct vfio_device *vdev)
>  	}
>  }
>  
> +int vfio_iommufd_compat_probe_noiommu(struct vfio_device *device,
> +				      struct iommufd_ctx *ictx)
> +{
> +	u32 ioas_id;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	/*
> +	 * Require no compat ioas to be assigned to proceed.  The basic
> +	 * statement is that the user cannot have done something that
> +	 * implies they expected translation to exist
> +	 */
> +	if (!iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id))
> +		return -EPERM;
> +	return 0;
> +}

I think the purpose of this function is to keep the iommufd namespace
out of the group, but we're muddying it as a general grab bag of
noiommu validation.  What if the caller retained the RAWIO test and
comment, and this function simply became a wrapper around the iommufd
function, ex:

bool vfio_iommufd_device_has_compat_ioas(struct vfio_device *device,
					 struct iommufd_ctx *ictx)
{
	u32 ioas_id;

	return !iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id));
}

Thanks,
Alex

> +
>  int vfio_iommufd_bind(struct vfio_device *vdev, struct iommufd_ctx *ictx)
>  {
>  	u32 ioas_id;
> @@ -54,20 +72,8 @@ int vfio_iommufd_bind(struct vfio_device *vdev, struct iommufd_ctx *ictx)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_noiommu(vdev)) {
> -		if (!capable(CAP_SYS_RAWIO))
> -			return -EPERM;
> -
> -		/*
> -		 * Require no compat ioas to be assigned to proceed. The basic
> -		 * statement is that the user cannot have done something that
> -		 * implies they expected translation to exist
> -		 */
> -		if (!iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id))
> -			return -EPERM;
> -
> +	if (vfio_device_is_noiommu(vdev))
>  		return vfio_iommufd_noiommu_bind(vdev, ictx, &device_id);
> -	}
>  
>  	ret = vdev->ops->bind_iommufd(vdev, ictx, &device_id);
>  	if (ret)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 785afc40ece8..8884b557fb26 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -234,9 +234,18 @@ static inline void vfio_container_cleanup(void)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
> +int vfio_iommufd_compat_probe_noiommu(struct vfio_device *device,
> +				      struct iommufd_ctx *ictx);
>  int vfio_iommufd_bind(struct vfio_device *device, struct iommufd_ctx *ictx);
>  void vfio_iommufd_unbind(struct vfio_device *device);
>  #else
> +static inline int
> +vfio_iommufd_compat_probe_noiommu(struct vfio_device *device,
> +				  struct iommufd_ctx *ictx)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int vfio_iommufd_bind(struct vfio_device *device,
>  				    struct iommufd_ctx *ictx)
>  {

