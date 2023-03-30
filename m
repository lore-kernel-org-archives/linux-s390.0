Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC716C761A6
	for <linux-s390@archiver.kernel.org>; Thu, 30 Mar 2023 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC3TWu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjC3TWm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Mar 2023 15:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEFCE1A4
        for <linux-s390@vger.kernel.org>; Thu, 30 Mar 2023 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680204110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqnQEZxaWao68chgcCo4orFozBmRoRDCr3XacwFOlaI=;
        b=XIbS3wOVZ67d6OiZdskTHt6GgJAFaErM9YBFoYy4R2AovHqCGorTznOL8cBTFDm9l9KK5T
        OcLMLudyrFyOKIjUhAu+9Jj4FECfESSPYi26yvGq+DiU9vf1k9+O9jdimsse+zS+YCqbQ3
        dIEkEKSiUd1bARK5NjO/jb4N8nJHKvI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-QIlnw_oENrC8OhvA3yvx4g-1; Thu, 30 Mar 2023 15:21:46 -0400
X-MC-Unique: QIlnw_oENrC8OhvA3yvx4g-1
Received: by mail-io1-f70.google.com with SMTP id j4-20020a6b5504000000b00758646159fbso12198591iob.20
        for <linux-s390@vger.kernel.org>; Thu, 30 Mar 2023 12:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqnQEZxaWao68chgcCo4orFozBmRoRDCr3XacwFOlaI=;
        b=wX9GmmuTVJG6VjqavUU2Xm/XJ2smjkPw5QiiLH5ChDJdtBtBZ1l41nyoqXqi1wNLxw
         DbCp39NAIYV0ObE/7+dIXDuG7p5tuYNCV7wOzkXpAX8pkJSjGuAAmjOmNpjdCYTbEWgM
         jCNDOWZKBdkx9dJXUPguptrElGvw1JlSeuOGn8EgIOY/mZ6lKx2EgSgN5G8EsI6vvQP5
         uTv2L8Mr+R8uGuJyhOZmKHpGLX/Pm7jbpNTGDnZNYChnDOooyJd3y88vQtO/u8voTamk
         6tbenzCHleyPmW3zXRYa2IQ0PQquIrf1ml2FNiMN3yYL1tcet01cFK7f/VOEdeTFDDvX
         7cEg==
X-Gm-Message-State: AO0yUKXpe2vShF2u/b85Zo4Jl5e3yuZwzFfUcnwmjOc53akVcwylwPOZ
        R95qgQvUCyBEOSXB9dSPWx6NmZMJ0a1MjVSy2hxCu5jwZTMOnvN/H4g6kXwIuc2/SdlChuyk0dV
        l/KgwMvE+Dt5MIsToITZEeQ==
X-Received: by 2002:a05:6602:20da:b0:74c:aa1d:c1a1 with SMTP id 26-20020a05660220da00b0074caa1dc1a1mr17687523ioz.3.1680204105938;
        Thu, 30 Mar 2023 12:21:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set+mNeudR7e8tOPV/GXrIldwy7od5clU9Br4psJl/Z0Ulm5W6yZvi903JIlNz219vg0XihaniQ==
X-Received: by 2002:a05:6602:20da:b0:74c:aa1d:c1a1 with SMTP id 26-20020a05660220da00b0074caa1dc1a1mr17687509ioz.3.1680204105715;
        Thu, 30 Mar 2023 12:21:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cp7-20020a056638480700b00403089c2a1dsm104349jab.108.2023.03.30.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:21:45 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:21:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v3 0/6] vfio: Make emulated devices prepared for vfio
 device cdev
Message-ID: <20230330132143.0c33f4d3.alex.williamson@redhat.com>
In-Reply-To: <ZCSV2+LbgeWD2bPa@nvidia.com>
References: <20230327093351.44505-1-yi.l.liu@intel.com>
        <ZCSV2+LbgeWD2bPa@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 29 Mar 2023 16:47:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 27, 2023 at 02:33:45AM -0700, Yi Liu wrote:
> > Nicolin Chen (1):
> >   iommufd: Create access in vfio_iommufd_emulated_bind()
> > 
> > Yi Liu (5):
> >   iommu/iommufd: Pass iommufd_ctx pointer in iommufd_get_ioas()
> >   vfio-iommufd: No need to record iommufd_ctx in vfio_device
> >   vfio-iommufd: Make vfio_iommufd_emulated_bind() return iommufd_access
> >     ID
> >   vfio/mdev: Uses the vfio emulated iommufd ops set in the mdev sample
> >     drivers
> >   vfio: Check the presence for iommufd callbacks in
> >     __vfio_register_dev()
> > 
> >  drivers/iommu/iommufd/device.c          | 55 +++++++++++++++----------
> >  drivers/iommu/iommufd/ioas.c            | 14 +++----
> >  drivers/iommu/iommufd/iommufd_private.h |  4 +-
> >  drivers/iommu/iommufd/selftest.c        | 14 ++++---
> >  drivers/iommu/iommufd/vfio_compat.c     |  2 +-
> >  drivers/vfio/iommufd.c                  | 37 ++++++++---------
> >  drivers/vfio/vfio_main.c                |  5 ++-
> >  include/linux/iommufd.h                 |  5 ++-
> >  include/linux/vfio.h                    |  1 -
> >  samples/vfio-mdev/mbochs.c              |  3 ++
> >  samples/vfio-mdev/mdpy.c                |  3 ++
> >  samples/vfio-mdev/mtty.c                |  3 ++
> >  12 files changed, 85 insertions(+), 61 deletions(-)  
> 
> It looks like most of this is iommufd so I will take it - Ok Alex?
> 
> The following cdev patch needs it so I'll stick it on its own branch
> and we can sort it out after the reset series is done

Ok

Acked-by: Alex Williamson <alex.williamson@redhat.com>

