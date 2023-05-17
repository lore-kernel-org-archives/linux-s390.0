Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBEC7EE23
	for <linux-s390@archiver.kernel.org>; Wed, 17 May 2023 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEQTla (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 May 2023 15:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQTl3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 May 2023 15:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C289109
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684352441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaMnAGXuqZ++k7whsMY2S/rOWuBgmGh59N8DJRQDhTs=;
        b=atQRCci8c4fakLYoWeq6igNv8f0Cwh7JsO3DAZ3VPctN+wKwD9rUSotm2RyUd02YN3xVkr
        brEy7pN7lJVWf4c0JE6bMpztxrBkWfufhdFZGlcY7kOZVf6VfUqCw+KeWmWrIfdX5vWuTZ
        P38rgtTp76H9HoEjwlkH3FGWc7C3Dqw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-RHbVMxv0NYiib4yaxOCPUw-1; Wed, 17 May 2023 15:40:32 -0400
X-MC-Unique: RHbVMxv0NYiib4yaxOCPUw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331632be774so79233055ab.0
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352432; x=1686944432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaMnAGXuqZ++k7whsMY2S/rOWuBgmGh59N8DJRQDhTs=;
        b=ACrS2Oz9dbWa0PTeIDxPkw0JIfNBTGhEk0IM+ionzkkGdrlZdLfnBqJS39WtgK9O9g
         Ib/QQDOICjUVESeHu3A/3HbjWJs2J1sxax7UKx1Ngg8vPhH4fDO4NygicYQEMUPAwSeQ
         j2qQWNF+MqqnYYc2GAgOIUkYEQtlj7YWB5/sH6Z81fiDoP+YoypbTjjiKnb8tJiurpnN
         KYw8wGS2NOgDW/fFKhjKgZtcb7/U9gR9vvm1k9+bFINLZ8QV0JO4NC/f9B9fIhWCoqtH
         R71vGPXAOwAkRiALXyCQE5TvCCdSMgL/yuqXAapE/kUz0nXliA/Xrji1cDWCwEDScUwP
         i4gg==
X-Gm-Message-State: AC+VfDybOOcYKBp7qGjsnju5kCIgrQuC2i+KGyjgvCevR7edOaL0Bg9S
        H782pIajws5ssRRlLcRUK5KVgH8E8ZRDf3UYkEi4yeLwr28Tkw34XK4sEsPDNpfHQ1HHNMIJpgb
        kR1NrR0ytYXCuZiyeyAcG8g==
X-Received: by 2002:a92:d98d:0:b0:335:4c33:dd2b with SMTP id r13-20020a92d98d000000b003354c33dd2bmr2248061iln.9.1684352431886;
        Wed, 17 May 2023 12:40:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zPWqyJ1aUUbKlOSg6odEXbgecsB1Z4PYEWsEoMYwkf7RUxzAQTmSNvl+uiWj/tj7xsU7DXg==
X-Received: by 2002:a92:d98d:0:b0:335:4c33:dd2b with SMTP id r13-20020a92d98d000000b003354c33dd2bmr2248043iln.9.1684352431641;
        Wed, 17 May 2023 12:40:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h15-20020a92d84f000000b00328ab01a23fsm3413863ilq.14.2023.05.17.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:40:31 -0700 (PDT)
Date:   Wed, 17 May 2023 13:40:29 -0600
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
Subject: Re: [PATCH v5 08/10] iommufd: Add iommufd_ctx_has_group()
Message-ID: <20230517134029.7e3da6c6.alex.williamson@redhat.com>
In-Reply-To: <20230513132136.15021-9-yi.l.liu@intel.com>
References: <20230513132136.15021-1-yi.l.liu@intel.com>
        <20230513132136.15021-9-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 13 May 2023 06:21:34 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> to check if any device within the given iommu_group has been bound with

Nit, I find these commit logs where the subject line is intended to
flow into the commit log to form a complete sentence difficult to read.
I expect complete thoughts within the commit log itself and the subject
should be a separate summary of the log.  Repeating the subject within
the commit log is ok.

> the iommufd_ctx. This helpful for the checking on device ownership for

s/This/This is/

> the devices which have been bound but cannot be bound to any other iommufd

s/have been/have not been/?

> as the iommu_group has been bound.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 29 +++++++++++++++++++++++++++++
>  include/linux/iommufd.h        |  8 ++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 81466b97023f..5e5f7912807b 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -98,6 +98,35 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
>  
> +/**
> + * iommufd_ctx_has_group - True if the struct device is bound to this ictx

What struct device?  Isn't this "True if any device within the group is
bound to the ictx"?

> + * @ictx: iommufd file descriptor
> + * @group: Pointer to a physical iommu_group struct
> + *
> + * True if a iommufd_device_bind() is present for any device within the
> + * group.

How can a function be present for a device?  Maybe "True if any device
within the group has been bound to this ictx, ex. via
iommufd_device_bind(), therefore implying ictx ownership of the group."  Thanks,

Alex

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
> index 68cd65274e28..e49c16cd6831 100644
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
> @@ -56,6 +57,7 @@ void iommufd_ctx_get(struct iommufd_ctx *ictx);
>  #if IS_ENABLED(CONFIG_IOMMUFD)
>  struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
>  void iommufd_ctx_put(struct iommufd_ctx *ictx);
> +bool iommufd_ctx_has_group(struct iommufd_ctx *ictx, struct iommu_group *group);
>  
>  int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
>  			     unsigned long length, struct page **out_pages,
> @@ -77,6 +79,12 @@ static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
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

