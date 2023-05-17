Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7FC77B7A
	for <linux-s390@archiver.kernel.org>; Wed, 17 May 2023 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQSQK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 May 2023 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEQSQJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 May 2023 14:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF583FA
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684347323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBbkfwSNfUaNRT3WQhfk4a0Uy2VKZgjYjPB926dHc6c=;
        b=KsteX1iAJUyV8IZFrS5jUpDWzvRuHymOO8GNeHw9FYQhKSYsqDhdL6dk6knBUfo9xBz3eA
        +drYz5uXwurhUNEZRIJ0URILPVJIJl9pJcEbCDexetLkzpmL87HU3ar78zoInn1qytF2ng
        qlF8uSMeCbW5bSRJa9PwQ3rTmZKAKuw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-ABLqN3ZENWSTAVlNPMWS_A-1; Wed, 17 May 2023 14:15:22 -0400
X-MC-Unique: ABLqN3ZENWSTAVlNPMWS_A-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3379306f979so7377515ab.2
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 11:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347321; x=1686939321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBbkfwSNfUaNRT3WQhfk4a0Uy2VKZgjYjPB926dHc6c=;
        b=FWl4hNIFYrXJzMlSVZtTi+kfdkZRi3g5W+NJddklkY4oHPnu24YGln4uqXAjD0wElg
         Xq1ctH3lzVRpjIAPxgto1rKMYqMhKyMIF5k+81k6qgAsJo+F/wVW24BohrFOamsiOnJg
         rO7YwAIuubk0JOKpSu4Qtu64PAVG63p/Vp1/hP1qpnUiNgNu1/2ZkWb/JrDoC530Ccyr
         jyMfmjgZlPNMmfeOARHr4isq7RtUz4nUPthdj+p4Fi0e3kXL2u2DuMsD6/zutJ2fKSqq
         GzBiGKoLpc2U9kVv6zfwZcGV4Ldme4O4qjQENucQk1mkgbkszXZA4VQ9QNmYUdMYMzWL
         i4ig==
X-Gm-Message-State: AC+VfDzwaiMqHBgpSuL10R6MpZshCpzPC7VG2hJC081gqlenb1OVRdRS
        AG+xrpFi2IoqWgCpzR+rpxJmSYq+BJET58B2iv3Cx99Wrg9dCjacyu21pyTU0P69jd0fslU9UYs
        n69iknNatkgc4WONwnes0ig==
X-Received: by 2002:a92:280b:0:b0:334:faa5:494 with SMTP id l11-20020a92280b000000b00334faa50494mr2434394ilf.16.1684347321340;
        Wed, 17 May 2023 11:15:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51VpyD99hRmBsrXJMFRpCGeYsUOJ+gL3UPLw/Lj4qOOkLmuTpqYEjHcu6zyABxCd7m198oHA==
X-Received: by 2002:a92:280b:0:b0:334:faa5:494 with SMTP id l11-20020a92280b000000b00334faa50494mr2434329ilf.16.1684347319597;
        Wed, 17 May 2023 11:15:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm8728015jar.108.2023.05.17.11.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:15:19 -0700 (PDT)
Date:   Wed, 17 May 2023 12:15:17 -0600
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
Subject: Re: [PATCH v5 06/10] vfio-iommufd: Add helper to retrieve
 iommufd_ctx and devid for vfio_device
Message-ID: <20230517121517.4b7ceb52.alex.williamson@redhat.com>
In-Reply-To: <20230513132136.15021-7-yi.l.liu@intel.com>
References: <20230513132136.15021-1-yi.l.liu@intel.com>
        <20230513132136.15021-7-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 13 May 2023 06:21:32 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This is needed by the vfio-pci driver to report affected devices in the
> hot reset for a given device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 24 ++++++++++++++++++++++++
>  drivers/vfio/iommufd.c         | 20 ++++++++++++++++++++
>  include/linux/iommufd.h        |  6 ++++++
>  include/linux/vfio.h           | 14 ++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 4f9b2142274c..81466b97023f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -116,6 +116,18 @@ void iommufd_device_unbind(struct iommufd_device *idev)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
>  
> +struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev)
> +{
> +	return idev->ictx;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_to_ictx, IOMMUFD);
> +
> +u32 iommufd_device_to_id(struct iommufd_device *idev)
> +{
> +	return idev->obj.id;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
> +
>  static int iommufd_device_setup_msi(struct iommufd_device *idev,
>  				    struct iommufd_hw_pagetable *hwpt,
>  				    phys_addr_t sw_msi_start)
> @@ -463,6 +475,18 @@ void iommufd_access_destroy(struct iommufd_access *access)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
>  
> +struct iommufd_ctx *iommufd_access_to_ictx(struct iommufd_access *access)
> +{
> +	return access->ictx;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_to_ictx, IOMMUFD);
> +
> +u32 iommufd_access_to_id(struct iommufd_access *access)
> +{
> +	return access->obj.id;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_to_id, IOMMUFD);
> +
>  int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
>  {
>  	struct iommufd_ioas *new_ioas;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c1379e826052..a18e920be164 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -105,6 +105,26 @@ void vfio_iommufd_unbind(struct vfio_device *vdev)
>  		vdev->ops->unbind_iommufd(vdev);
>  }
>  
> +struct iommufd_ctx *vfio_iommufd_physical_ictx(struct vfio_device *vdev)
> +{
> +	if (vdev->iommufd_device)
> +		return iommufd_device_to_ictx(vdev->iommufd_device);
> +	if (vdev->noiommu_access)
> +		return iommufd_access_to_ictx(vdev->noiommu_access);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommufd_physical_ictx);
> +
> +int vfio_iommufd_physical_devid(struct vfio_device *vdev)
> +{
> +	if (vdev->iommufd_device)
> +		return iommufd_device_to_id(vdev->iommufd_device);
> +	if (vdev->noiommu_access)
> +		return iommufd_access_to_id(vdev->noiommu_access);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommufd_physical_devid);

I think these exemplify that it would be better if both emulated and
noiommu use the same iommufd_access pointer.  Thanks,

Alex

> +
>  /*
>   * The physical standard ops mean that the iommufd_device is bound to the
>   * physical device vdev->dev that was provided to vfio_init_group_dev(). Drivers
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 1129a36a74c4..68cd65274e28 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -24,6 +24,9 @@ void iommufd_device_unbind(struct iommufd_device *idev);
>  int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
>  void iommufd_device_detach(struct iommufd_device *idev);
>  
> +struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
> +u32 iommufd_device_to_id(struct iommufd_device *idev);
> +
>  struct iommufd_access_ops {
>  	u8 needs_pin_pages : 1;
>  	void (*unmap)(void *data, unsigned long iova, unsigned long length);
> @@ -45,6 +48,9 @@ iommufd_access_create(struct iommufd_ctx *ictx,
>  void iommufd_access_destroy(struct iommufd_access *access);
>  int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id);
>  
> +struct iommufd_ctx *iommufd_access_to_ictx(struct iommufd_access *access);
> +u32 iommufd_access_to_id(struct iommufd_access *access);
> +
>  void iommufd_ctx_get(struct iommufd_ctx *ictx);
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index a61130bc06a2..fcbe084b18c8 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -115,6 +115,8 @@ struct vfio_device_ops {
>  };
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
> +struct iommufd_ctx *vfio_iommufd_physical_ictx(struct vfio_device *vdev);
> +int vfio_iommufd_physical_devid(struct vfio_device *vdev);
>  int vfio_iommufd_physical_bind(struct vfio_device *vdev,
>  			       struct iommufd_ctx *ictx, u32 *out_device_id);
>  void vfio_iommufd_physical_unbind(struct vfio_device *vdev);
> @@ -124,6 +126,18 @@ int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
>  void vfio_iommufd_emulated_unbind(struct vfio_device *vdev);
>  int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id);
>  #else
> +static inline struct iommufd_ctx *
> +vfio_iommufd_physical_ictx(struct vfio_device *vdev)
> +{
> +	return NULL;
> +}
> +
> +static inline int
> +vfio_iommufd_physical_devid(struct vfio_device *vdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #define vfio_iommufd_physical_bind                                      \
>  	((int (*)(struct vfio_device *vdev, struct iommufd_ctx *ictx,   \
>  		  u32 *out_device_id)) NULL)

