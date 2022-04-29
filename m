Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F16C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 29 Apr 2022 22:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiD2WZf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiD2WZe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Apr 2022 18:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F44DDC9B6
        for <linux-s390@vger.kernel.org>; Fri, 29 Apr 2022 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651270934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATKyFNAAAkRRTMtWxAFMAqDXlfz2eEkoQ0lWbdsfdDE=;
        b=DwQYV3FePSX6Qla3J0/FYZ0+WO4dSHSXBBgbvv3/W1yHxG0vZIy/YkqtffXonsZPk/C9fa
        pMuSk47iMnFODYdCvFj73U35C+Ub6BIS4xwPHeuOz6ay6hEMisrpNi4ndRq1xR1gMwpOID
        L329yMBQR2hpQEgZRjlJJ0FCD4KVO2A=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-mA8vY3ADPnGmqIwSSmwoZA-1; Fri, 29 Apr 2022 18:22:13 -0400
X-MC-Unique: mA8vY3ADPnGmqIwSSmwoZA-1
Received: by mail-io1-f71.google.com with SMTP id 204-20020a6b01d5000000b00657bb7a0f33so5464303iob.4
        for <linux-s390@vger.kernel.org>; Fri, 29 Apr 2022 15:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATKyFNAAAkRRTMtWxAFMAqDXlfz2eEkoQ0lWbdsfdDE=;
        b=zGqreBd11svjU6MpDFJNC4lRZJxY/USn4p44SXlopSTmJIsKbgYoM/oRg8vY/ewCKF
         AWjLdF/R0Dhc+iz2QEFjxfa2F7TZZ7wZGZAsmGRA0bR2f9UGvqS4CHU7VKsjMioSoY+7
         oSE0aw4ghrBOQgvnLKD4mzlrMJP5D3hOjfOUJ6VCfNxyJ0Aod7HXypue6Tjpq8J60zTW
         hBDRCzC9wqToem6+vb9AaRNkgoV8b1UdTdO6g2uDtdexsgwBKGt8FDiuMHcMkGe/6iNh
         vA1MVfPORlHWdASTB61ZUNsXX/jdLg2eSAOEH9fLFM5YxH2CMYG+wHgBy+shEJOlIlbP
         wYHw==
X-Gm-Message-State: AOAM530Rrc+KMp0OOjX3xKH+mY/l5vIwCh4o+NEmxafd3mKlR7UTXxbA
        kTFlJQ72Xw0S4AWOSw0sWqgxMJHmrTv41u8Ba4yzxYyAX3rOGaDAio8uoUYShHh11+TDY+QJOHe
        SuPXgExFd/HSVt/oKGfaIOQ==
X-Received: by 2002:a05:6638:4604:b0:32b:4eab:7394 with SMTP id bw4-20020a056638460400b0032b4eab7394mr636153jab.18.1651270932501;
        Fri, 29 Apr 2022 15:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPQNrRSGnW48FBq1t2/hjh8q51j2JzUcOvWsug9aMrqr32bPZVspTaleHuRHvQdSR9CF/bGw==
X-Received: by 2002:a05:6638:4604:b0:32b:4eab:7394 with SMTP id bw4-20020a056638460400b0032b4eab7394mr636115jab.18.1651270932123;
        Fri, 29 Apr 2022 15:22:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e71-20020a02864d000000b0032b3a78176bsm897885jai.47.2022.04.29.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:22:11 -0700 (PDT)
Date:   Fri, 29 Apr 2022 16:22:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/7] Make the rest of the VFIO driver interface use
 vfio_device
Message-ID: <20220429162209.2ec03e4f.alex.williamson@redhat.com>
In-Reply-To: <20220429173149.GA167483@nvidia.com>
References: <0-v2-6011bde8e0a1+5f-vfio_mdev_no_group_jgg@nvidia.com>
        <20220429173149.GA167483@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 29 Apr 2022 14:31:49 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 21, 2022 at 01:28:31PM -0300, Jason Gunthorpe wrote:
> > Prior series have transformed other parts of VFIO from working on struct
> > device or struct vfio_group into working directly on struct
> > vfio_device. Based on that work we now have vfio_device's readily
> > available in all the drivers.
> > 
> > Update the rest of the driver facing API to use vfio_device as an input.
> > 
> > The following are switched from struct device to struct vfio_device:
> >   vfio_register_notifier()
> >   vfio_unregister_notifier()
> >   vfio_pin_pages()
> >   vfio_unpin_pages()
> >   vfio_dma_rw()
> > 
> > The following group APIs are obsoleted and removed by just using struct
> > vfio_device with the above:
> >   vfio_group_pin_pages()
> >   vfio_group_unpin_pages()
> >   vfio_group_iommu_domain()
> >   vfio_group_get_external_user_from_dev()
> > 
> > To retain the performance of the new device APIs relative to their group
> > versions optimize how vfio_group_add_container_user() is used to avoid
> > calling it when the driver must already guarantee the device is open and
> > the container_users incrd.
> > 
> > The remaining exported VFIO group interfaces are only used by kvm, and are
> > addressed by a parallel series.
> > 
> > This series is based on Christoph's gvt rework here:
> > 
> >  https://lore.kernel.org/all/5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com/
> > 
> > and so will need the PR merged first.  
> 
> Hi Alex,
> 
> Since all the shared branch PRs are ready, do you have any remarks on
> this series and the others before I rebase and repost them?

Only the nit in the commit log:
https://lore.kernel.org/all/20220429142820.6afe7bbe.alex.williamson@redhat.com/ 

> This one has a few changes to the commit messages outstanding, but v2
> didn't have any code changes.
> 
> Also, what order would like the different series in - they conflict
> with each other a little bit. I suggest this:
> 
> - mdev group removal (this one)
> - Remove vfio_device_get_from_dev()
>   https://lore.kernel.org/r/0-v1-7f2292e6b2ba+44839-vfio_get_from_dev_jgg@nvidia.com
> - Remove group from kvm
>   https://lore.kernel.org/r/0-v1-33906a626da1+16b0-vfio_kvm_no_group_jgg@nvidia.com

I think you mean (v2):

https://lore.kernel.org/all/0-v2-6a528653a750+1578a-vfio_kvm_no_group_jgg@nvidia.com/

Otherwise, thanks for sorting these out for me.

> All of them seem to have got enough reviews now.
>
> I have one more series on this group topic and a few little patches still
> 
> It would be great if you could merge the gvt and iommu series together
> into your tree toward linux-next so I can post patches against a
> stable commit ID so the build-bots can test them.

Please check my vfio next branch and see if this matches what you're
looking for:

https://github.com/awilliam/linux-vfio/commits/next

I'll look for any fallout from Stephen and build bots on Monday's
linux-next compilation.  Thanks,

Alex

