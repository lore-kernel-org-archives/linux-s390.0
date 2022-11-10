Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD156C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 10 Nov 2022 20:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiKJUSL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKJUR4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Nov 2022 15:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8107A43841
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 12:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVnV2DDw0Jhdp1QeqoFk0F1Z/gE4Ln1RaOhIXeyW3wU=;
        b=eb7m06FVuj56TbnRfCdCA0z5gmAE6iMC25Tma95NHHqVm8hmx1Y4+0bC3PDF6YiqXZnPZN
        zkwVDIOLxVYTjcq0WXAH/i4Xtlb00KM2pEAUzQXSo95hbs57JKFPY2K6GxKkFeDaZBv++y
        tZwWb13a7N1cZJ1gFBScv6x4W+dytmE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-n05bB0_-PNGce8aSv2TmNg-1; Thu, 10 Nov 2022 15:16:51 -0500
X-MC-Unique: n05bB0_-PNGce8aSv2TmNg-1
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so1773933ioz.8
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 12:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVnV2DDw0Jhdp1QeqoFk0F1Z/gE4Ln1RaOhIXeyW3wU=;
        b=ynoVh6oXl1s6deH0jGQH+kf0Ztw327cncX6tu1cvt6YwiwBWSB7HqoONIXwsFtW1c2
         4Z5xae17ol7y1v/AHzEsh/AUMr1sKYen148pZFEvzJPgvLF77Ue6mOIcgYwjPKRKpjGn
         GymGjO4uUnTQIgCxpdLO3ho5PdOPRltq1H6EfkF0KzNQYhTlXMR2uXMhLOLKo9kefqHG
         N+2IQ7Tm8cqnbPGZ0gBux731BDKGidSuvTJrpyTxDQOG42Sxt3A+9FPcMmSOOQHE3dJz
         eAbPVv+Pxr6VLjUSXmpuWotXCEEGodLFFnCUKm+I6kij0pNIK11iV2SaZKymhrBo1LNb
         PxHw==
X-Gm-Message-State: ACrzQf0pRCteN2kNitBZ7mttCxj8MeADAk/BR8aKHbZ7Lf7TM1xI/MTA
        QfdAWA7/JCcufWip7JTvG380cq8RdXxPIbuB5OhX6Ki2TYf7EM9CN+wQAeulTdgLpx94y8tvs5z
        1eH9fOBf9UQFVrWK/X/NG+A==
X-Received: by 2002:a92:d70b:0:b0:2f9:516b:25f3 with SMTP id m11-20020a92d70b000000b002f9516b25f3mr3482772iln.156.1668111410912;
        Thu, 10 Nov 2022 12:16:50 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7kmGLkxawxZSF0r3BGM7XEMkdaMXz0cdBNGYH99+jL5O4ssCKnWMKVWwzHqb43uql1tb9xRA==
X-Received: by 2002:a92:d70b:0:b0:2f9:516b:25f3 with SMTP id m11-20020a92d70b000000b002f9516b25f3mr3482749iln.156.1668111410617;
        Thu, 10 Nov 2022 12:16:50 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i7-20020a0566022c8700b006bbea9f45cesm25981iow.38.2022.11.10.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:16:49 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:16:32 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/7] vfio-ccw parent rework
Message-ID: <20221110131632.4e00f87d.alex.williamson@redhat.com>
In-Reply-To: <20221104142007.1314999-1-farman@linux.ibm.com>
References: <20221104142007.1314999-1-farman@linux.ibm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  4 Nov 2022 15:20:00 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Hi Alex,
> 
> Here's the (last?) update to the vfio-ccw lifecycle changes that I've sent
> recently, and were previously discussed at various points [1][2].
> 
> Patches 1-5 rework the behavior of the vfio-ccw driver's private struct.
> In summary, the mdev pieces are split out of vfio_ccw_private and into a
> new vfio_ccw_parent struct that will continue to follow today's lifecycle.
> The remainder (bulk) of the private struct moves to follow the mdev
> probe/remove pair. There's opportunity for further separation of the
> things in the private struct, which would simplify some of the vfio-ccw
> code, but it got too hairy as I started that. Once vfio-ccw is no longer
> considered unique, those cleanups can happen at our leisure. 
> 
> Patch 6 removes the trickery where vfio-ccw uses vfio_init_device instead of
> vfio_alloc_device, and thus removes vfio_init_device from the outside world.
> 
> Patch 7 removes vfio_free_device from vfio-ccw and the other drivers (hello,
> CC list!), letting it be handled by vfio_device_release directly.
> 
> I believe this covers everything in this space; let me know if not!
> 
> Thanks,
> Eric
> 
> [1] https://lore.kernel.org/kvm/0-v3-57c1502c62fd+2190-ccw_mdev_jgg@nvidia.com/
> [2] https://lore.kernel.org/kvm/20220602171948.2790690-1-farman@linux.ibm.com/
> 
> v2->v3:
>  - [MR] Added r-b to remaining patches (Thank you!)
>  - Patch 1:
>    [gfx checkpatch] Whitespace
>    [EF] Remove put_device(&parent->dev)
>    [MR] Fix error exit when alloc of parent fails
>    [MR] Check for !private on sch_probe error path
>  - Patch 3:
>    [EF] Fix error exit when alloc of private fails
>  - Patch 6:
>    [AW] Added ack (Thank you!)
>  - Patch 7:
>    [CH, AK] Added r-b (Thank you!)
>    [AW] Added ack (Thank you!)
> v2: https://lore.kernel.org/kvm/20221102150152.2521475-1-farman@linux.ibm.com/
> v1: https://lore.kernel.org/kvm/20221019162135.798901-1-farman@linux.ibm.com/
> 
> Eric Farman (7):
>   vfio/ccw: create a parent struct
>   vfio/ccw: remove private->sch
>   vfio/ccw: move private initialization to callback
>   vfio/ccw: move private to mdev lifecycle
>   vfio/ccw: remove release completion
>   vfio/ccw: replace vfio_init_device with _alloc_
>   vfio: Remove vfio_free_device
> 
>  drivers/gpu/drm/i915/gvt/kvmgt.c      |   1 -
>  drivers/s390/cio/vfio_ccw_chp.c       |   5 +-
>  drivers/s390/cio/vfio_ccw_drv.c       | 173 +++++++++++---------------
>  drivers/s390/cio/vfio_ccw_fsm.c       |  27 ++--
>  drivers/s390/cio/vfio_ccw_ops.c       | 107 +++++++++++-----
>  drivers/s390/cio/vfio_ccw_private.h   |  37 ++++--
>  drivers/s390/crypto/vfio_ap_ops.c     |   6 -
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c     |   1 -
>  drivers/vfio/pci/vfio_pci_core.c      |   1 -
>  drivers/vfio/platform/vfio_amba.c     |   1 -
>  drivers/vfio/platform/vfio_platform.c |   1 -
>  drivers/vfio/vfio_main.c              |  32 ++---
>  include/linux/vfio.h                  |   3 -
>  samples/vfio-mdev/mbochs.c            |   1 -
>  samples/vfio-mdev/mdpy.c              |   1 -
>  samples/vfio-mdev/mtty.c              |   1 -
>  16 files changed, 196 insertions(+), 202 deletions(-)
> 

Applied to vfio next branch for v6.2.  Thanks,

Alex

