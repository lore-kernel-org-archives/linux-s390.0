Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F3C7EE29
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jun 2023 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjFHVlo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFHVln (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Jun 2023 17:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCA2D76
        for <linux-s390@vger.kernel.org>; Thu,  8 Jun 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686260455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=th2bvhX62hzxRrLB1ybsAs0POe7Ojvtoj9i9GhxJpv4=;
        b=CLpg52IGLXeOnG798Egwxx/hDRnb7DP4KTJ+Zz8kWW95lsIB3OKp4rqNwQMXJEYXONViU0
        QtI64pGrVECHz6xq/HKviJneVoa0ZHPZY51TDPEP4fH7WvLhn/FlD/2WLqAtNOEen1jryb
        r/wK+fEuVhFV/MiCmzq0H/2UpMGfqog=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-DkDgvCoeMIKQFutfU3n-sg-1; Thu, 08 Jun 2023 17:40:54 -0400
X-MC-Unique: DkDgvCoeMIKQFutfU3n-sg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77ac14e9bc5so95956339f.2
        for <linux-s390@vger.kernel.org>; Thu, 08 Jun 2023 14:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686260454; x=1688852454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=th2bvhX62hzxRrLB1ybsAs0POe7Ojvtoj9i9GhxJpv4=;
        b=Db2sn/I0VELJC3ycly9h20nu5HNhQECnjvQ0iT6dqxEeTum5OOZBbnE1zA0TKvHP2q
         k8zhXnMe9PjcxS7GQSusIRGZrHazQgeFLhwvBh3hBEgqLIaFLfOcoDExk4wPp6XzpKpK
         hWNL7tINUMHAq8U1AsN/RS515x7QFATpAAq4jyT5u+xrL1KxMZBHAHoLPhGBlpjGH8Tc
         DmeolrUIG2gwlX4ppT3r2zBuhA1nBS24OkstRA08yJ+2/H59i9DJEkuMO1cD1ZuJoHPG
         Thxqk/TfcUZ/3gkmM3oFXC4DbAH/P4FlhVP77uwMrGmFBjsd2KjiBjOmsjVLEaTbXIXp
         8BRA==
X-Gm-Message-State: AC+VfDyYTfGduJo3f64epMixOPsxrnOqz1E9UJwkdvXVOt94EGfjj+fL
        Q2/FtdY68LSc7DHKIZxf18BLK56u01GuJfVUZV3lr0npG6hqEELGXFImXeMFeGMB9zn+Db/tEcU
        LxL1pNIYJlfeugCZQg80S4w==
X-Received: by 2002:a5e:8345:0:b0:777:ab8e:7039 with SMTP id y5-20020a5e8345000000b00777ab8e7039mr7756605iom.15.1686260454066;
        Thu, 08 Jun 2023 14:40:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UUVLC5rbROJu7mWqoujxWOhqO8BOzy7CP85v3updJvqBKZ/ov8Q2c1LG3o15l/VOOm831qQ==
X-Received: by 2002:a5e:8345:0:b0:777:ab8e:7039 with SMTP id y5-20020a5e8345000000b00777ab8e7039mr7756585iom.15.1686260453798;
        Thu, 08 Jun 2023 14:40:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h2-20020a02cd22000000b00420cda3fd2esm510972jaq.155.2023.06.08.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:40:53 -0700 (PDT)
Date:   Thu, 8 Jun 2023 15:40:51 -0600
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
Subject: Re: [PATCH v7 4/9] iommufd: Add iommufd_ctx_has_group()
Message-ID: <20230608154051.0f0e4449.alex.williamson@redhat.com>
In-Reply-To: <20230602121515.79374-5-yi.l.liu@intel.com>
References: <20230602121515.79374-1-yi.l.liu@intel.com>
        <20230602121515.79374-5-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  2 Jun 2023 05:15:10 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This adds the helper to check if any device within the given iommu_group
> has been bound with the iommufd_ctx. This is helpful for the checking on
> device ownership for the devices which have not been bound but cannot be
> bound to any other iommufd_ctx as the iommu_group has been bound.
> 
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/iommufd.h        |  8 ++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 4f9b2142274c..4571344c8508 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -98,6 +98,36 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
>  
> +/**
> + * iommufd_ctx_has_group - True if any device within the group is bound
> + *                         to the ictx
> + * @ictx: iommufd file descriptor
> + * @group: Pointer to a physical iommu_group struct
> + *
> + * True if any device within the group has been bound to this ictx, ex. via
> + * iommufd_device_bind(), therefore implying ictx ownership of the group.
> + */
> +bool iommufd_ctx_has_group(struct iommufd_ctx *ictx, struct iommu_group *group)
> +{
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +
> +	if (!ictx || !group)
> +		return false;
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type == IOMMUFD_OBJ_DEVICE &&
> +		    container_of(obj, struct iommufd_device, obj)->group == group) {
> +			xa_unlock(&ictx->objects);
> +			return true;
> +		}
> +	}
> +	xa_unlock(&ictx->objects);
> +	return false;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> +
>  /**
>   * iommufd_device_unbind - Undo iommufd_device_bind()
>   * @idev: Device returned by iommufd_device_bind()
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 1129a36a74c4..33fe57e95e42 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -16,6 +16,7 @@ struct page;
>  struct iommufd_ctx;
>  struct iommufd_access;
>  struct file;
> +struct iommu_group;
>  
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  					   struct device *dev, u32 *id);
> @@ -50,6 +51,7 @@ void iommufd_ctx_get(struct iommufd_ctx *ictx);
>  #if IS_ENABLED(CONFIG_IOMMUFD)
>  struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
>  void iommufd_ctx_put(struct iommufd_ctx *ictx);
> +bool iommufd_ctx_has_group(struct iommufd_ctx *ictx, struct iommu_group *group);
>  
>  int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
>  			     unsigned long length, struct page **out_pages,
> @@ -71,6 +73,12 @@ static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
>  {
>  }
>  
> +static inline bool iommufd_ctx_has_group(struct iommufd_ctx *ictx,
> +					 struct iommu_group *group)
> +{
> +	return false;
> +}
> +
>  static inline int iommufd_access_pin_pages(struct iommufd_access *access,
>  					   unsigned long iova,
>  					   unsigned long length,

It looks like the v12 cdev series no longer requires this stub?  We
haven't used this function except from iommufd specific code since v5.
Thanks,

Alex

