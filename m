Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D1C38A2D
	for <linux-s390@archiver.kernel.org>; Wed, 26 Oct 2022 21:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJZVbn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJZVbm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Oct 2022 17:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A24143A43
        for <linux-s390@vger.kernel.org>; Wed, 26 Oct 2022 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666819899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuFaUTxM7jN8IIcowYyyBSnYENOQWRsD3k/T0JWO9mA=;
        b=BWfRrFw2zW7YjHCvZeTsXQlcDpdrwQhbzB8f1rogR2TNc7kOtMtEyCc13cQn4ruA3iRbiv
        DJV/0FAHgK7aQvZXRh7lQ7s+/5NQgXioKjv9kLiyuNEeIfWhc/35Y7biaPJ86bxIKmION6
        5UhnyJAUHD4y/xxOTxmq3bdoi4n6jN4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100--0dRh9hHMbCDVSmWQMTTcw-1; Wed, 26 Oct 2022 17:31:38 -0400
X-MC-Unique: -0dRh9hHMbCDVSmWQMTTcw-1
Received: by mail-il1-f197.google.com with SMTP id b7-20020a92c567000000b002fb9207838bso14743875ilj.23
        for <linux-s390@vger.kernel.org>; Wed, 26 Oct 2022 14:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuFaUTxM7jN8IIcowYyyBSnYENOQWRsD3k/T0JWO9mA=;
        b=pcu5ENmstmeWDpWQ9ETdahfUFDmYX/Wn6kxbslo8ALxZZDyodFnhRrTzvVTuMk8XrO
         BV6qoLhgbwVhBFUnQ/ngDcMQTFucdbJUyAW+qqM8YKvJULxy/v9odl5vdwdFeRJSy4LD
         8Aon0tqsFPRU1jv5JaU3ZXTjl0mYOUxLJT8G/4DSy0oMndHrTilgIQ1mHZWaGS+VTEka
         gyKDy+ngatqNdj0iZ5qRAZjHRtet8x332x7wlyUKDOtsuxKgE9R22itLvFxBBVEjWZlY
         HQfzyNz7/opamrKiGjvNDBUh0rCBSlU1Jv02h5z0UezjapxoJLgA+Bk4bcL78pu1xqve
         Onog==
X-Gm-Message-State: ACrzQf2DdbvUitYNTYt93/Yj5NWrsnQ4hsYE0X8Tvkt3xesWUDFEQ5e4
        v581m2u3skpsTJN+7DU2cd/nKgJTIX8ODiTgJT+2VVDNYHprylXN5Fe8pBfAS7+D70aU1w0GRqF
        g+myXpk5+6Y7F8jRpXvBrLw==
X-Received: by 2002:a05:6602:341c:b0:6bc:1c3d:836e with SMTP id n28-20020a056602341c00b006bc1c3d836emr25364736ioz.24.1666819897609;
        Wed, 26 Oct 2022 14:31:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7g0EslrnnS032hMCGhtH/3H9PcP3RsMN5qxVX8v5zeaewsUE7rw9P/VUiao60P3aqERhjABw==
X-Received: by 2002:a05:6602:341c:b0:6bc:1c3d:836e with SMTP id n28-20020a056602341c00b006bc1c3d836emr25364701ioz.24.1666819897311;
        Wed, 26 Oct 2022 14:31:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n31-20020a056602341f00b006bc3bf6e5b5sm2759668ioz.55.2022.10.26.14.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:31:36 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:31:33 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@gmail.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 10/10] iommufd: Allow iommufd to supply /dev/vfio/vfio
Message-ID: <20221026153133.44dc05c8.alex.williamson@redhat.com>
In-Reply-To: <10-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
References: <0-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
        <10-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 25 Oct 2022 15:50:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> If the VFIO container is compiled out, give a kconfig option for iommufd
> to provide the miscdev node with the same name and permissions as vfio
> uses.
> 
> The compatibility node supports the same ioctls as VFIO and automatically
> enables the VFIO compatible pinned page accounting mode.

I think I'd like to see some sort of breadcrumb when /dev/vfio/vfio is
provided by something other than the vfio container code.  If we intend
to include this before P2P is resolved, that breadcrumb (dmesg I'm
guessing) might also list any known limitations of the compatibility to
save time with debugging.  Thanks,

Alex

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/Kconfig | 12 ++++++++++++
>  drivers/iommu/iommufd/main.c  | 35 ++++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index f0a2012234fa09..afc83b7575cce6 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -14,6 +14,18 @@ config IOMMUFD
>  	  If you don't know what to do here, say N.
>  
>  if IOMMUFD
> +config IOMMUFD_VFIO_CONTAINER
> +	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
> +	depends on VFIO && !VFIO_CONTAINER
> +	default VFIO && !VFIO_CONTAINER
> +	help
> +	  IOMMUFD will provide /dev/vfio/vfio instead of VFIO. This relies on
> +	  IOMMUFD providing compatibility emulation to give the same ioctls.
> +	  It provides an option to build a kernel with legacy VFIO components
> +	  removed.
> +
> +	  Unless testing IOMMUFD say N here.
> +
>  config IOMMUFD_TEST
>  	bool "IOMMU Userspace API Test support"
>  	depends on RUNTIME_TESTING_MENU
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8a31c1a14cdd53..19db81fbf7f08f 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -24,6 +24,7 @@
>  #include <uapi/linux/iommufd.h>
>  #include <linux/iommufd.h>
>  
> +#include "io_pagetable.h"
>  #include "iommufd_private.h"
>  #include "iommufd_test.h"
>  
> @@ -31,6 +32,7 @@ struct iommufd_object_ops {
>  	void (*destroy)(struct iommufd_object *obj);
>  };
>  static struct iommufd_object_ops iommufd_object_ops[];
> +static struct miscdevice vfio_misc_dev;
>  
>  struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>  					     size_t size,
> @@ -167,6 +169,13 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>  	if (!ictx)
>  		return -ENOMEM;
>  
> +	/*
> +	 * For compatibility with VFIO when /dev/vfio/vfio is opened we default
> +	 * to the same rlimit accounting as vfio uses.
> +	 */
> +	if (filp->private_data == &vfio_misc_dev)
> +		ictx->account_mode = IOPT_PAGES_ACCOUNT_MM;
> +
>  	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>  	ictx->file = filp;
>  	filp->private_data = ictx;
> @@ -392,26 +401,46 @@ static struct miscdevice iommu_misc_dev = {
>  	.mode = 0660,
>  };
>  
> +
> +static struct miscdevice vfio_misc_dev = {
> +	.minor = VFIO_MINOR,
> +	.name = "vfio",
> +	.fops = &iommufd_fops,
> +	.nodename = "vfio/vfio",
> +	.mode = 0666,
> +};
> +
>  static int __init iommufd_init(void)
>  {
>  	int ret;
>  
>  	ret = misc_register(&iommu_misc_dev);
> -	if (ret) {
> -		pr_err("Failed to register misc device\n");
> +	if (ret)
>  		return ret;
> -	}
>  
> +	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)) {
> +		ret = misc_register(&vfio_misc_dev);
> +		if (ret)
> +			goto err_misc;
> +	}
>  	return 0;
> +err_misc:
> +	misc_deregister(&iommu_misc_dev);
> +	return ret;
>  }
>  
>  static void __exit iommufd_exit(void)
>  {
> +	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
> +		misc_deregister(&vfio_misc_dev);
>  	misc_deregister(&iommu_misc_dev);
>  }
>  
>  module_init(iommufd_init);
>  module_exit(iommufd_exit);
>  
> +#if IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)
> +MODULE_ALIAS_MISCDEV(VFIO_MINOR);
> +#endif
>  MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
>  MODULE_LICENSE("GPL");

