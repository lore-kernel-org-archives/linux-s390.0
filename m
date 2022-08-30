Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B1ECAAD1
	for <linux-s390@archiver.kernel.org>; Tue, 30 Aug 2022 15:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiH3PKR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiH3PKQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Aug 2022 11:10:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976DB3D581
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 08:10:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id n4so6320810qvt.7
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CBamQzSNNxE6SjxTKzzEO+qM/bRDvj9E4TwCaLJXBMk=;
        b=fXNdwdpK40/W9ZV/jtDtFanBo50pdD9Zqq2j76SqDodQNMcH/S/9ZORqwpujvM/1o7
         Y6ijjlraOllJTnfE8hkllQZkWTkVYG+l9AgDUUsf4ThP+1u3Lezl0Ah/HcTMhGdPhepr
         6oaOHPhbuuQXVL7zA8adj2Q6F6wDptOrEHfHvWpbBkt1JOkwh5bMK0Ps71apRT8m0wKL
         AOMSw1qxFu5ZtF1ie2DWVMI+XNlOgLhGsqhKFseVmGJOBV0nuysZvPAUoIJ8ecRUEdf7
         8NQ34drZxPG72BJMShFI1bT2VX5a+waMVxy4LYhuSx5L0ejfGHWsTQ/GqJcHZt7AT8AA
         7NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CBamQzSNNxE6SjxTKzzEO+qM/bRDvj9E4TwCaLJXBMk=;
        b=0oWb6zocUN2OdH+oGVY4BFalIHlUUrfuPengXPk0fLCi5tA28CMmfH9VUyjX9YCG/l
         0heRWqTcJDHZRVMWi9okIgvG9tgbF6FTD3yPnNd+yAOzqiTFFY1XCYGnal7UE+dil4Xx
         dGRQ8Ur1ji9qgl6C05uMiXDPrzQhiFYarP7aidAdfzK+dET0J6nlLop/sz5T6ydXD8sk
         Bsl2COWln/myQN3/sIwb8mHXhqcPWkIpt772Mh3GbB+25c2IcBK3Bb31IlKRiA0ig+w6
         BTSPPGI674X5fFLquP1mYjUGBw7tGCiIfkUwxiIsOlca9+IzGhakqSvXSyRZMeyAiIPR
         gzOQ==
X-Gm-Message-State: ACgBeo26HYNiNeF9/i1IoAOKKy0JFFURx12zPCRC9niZebWusdgx9og5
        lIXRInxZP6GVW3fnnXY/8nDtWQ==
X-Google-Smtp-Source: AA6agR6UUGFhrYHDf4KVE6IxiHBU+9Pg/pWLmRZ4Y2KqjrWUkINgLEKIUkRA9mAuIBzucBWjgrkfbQ==
X-Received: by 2002:a0c:f1c7:0:b0:474:725e:753e with SMTP id u7-20020a0cf1c7000000b00474725e753emr15301629qvl.49.1661872210775;
        Tue, 30 Aug 2022 08:10:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bl8-20020a05620a1a8800b006bbdcb3fff7sm7634727qkb.69.2022.08.30.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:10:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oT2sS-003kUN-QX;
        Tue, 30 Aug 2022 12:10:08 -0300
Date:   Tue, 30 Aug 2022 12:10:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Anthony Krowiak <akrowiak@linux.ibm.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 01/15] vfio: Add helpers for unifying vfio_device life
 cycle
Message-ID: <Yw4oUL33TbJK6inc@ziepe.ca>
References: <20220827171037.30297-1-kevin.tian@intel.com>
 <20220827171037.30297-2-kevin.tian@intel.com>
 <907c54c6-7f5b-77f3-c284-45604c60c12e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907c54c6-7f5b-77f3-c284-45604c60c12e@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 30, 2022 at 09:42:42AM -0400, Anthony Krowiak wrote:

> > +/*
> > + * Alloc and initialize vfio_device so it can be registered to vfio
> > + * core.
> > + *
> > + * Drivers should use the wrapper vfio_alloc_device() for allocation.
> > + * @size is the size of the structure to be allocated, including any
> > + * private data used by the driver.
> 
> 
> It seems the purpose of the wrapper is to ensure that the object being
> allocated has as its first field a struct vfio_device object and to return
> its container. Why not just make that a requirement for this function -
> which I would rename vfio_alloc_device - and document it in the prologue?
> The caller can then cast the return pointer or use container_of.

There are three fairly common patterns for this kind of thing

1) The caller open codes everything:

   driver_struct = kzalloc()
   core_init(&driver_struct->core)

2) Some 'get priv' / 'get data' is used instead of container_of():

   core_struct = core_alloc(sizeof(*driver_struct))
   driver_struct = core_get_priv(core_struct)

3) The allocations and initialization are consolidated in the core,
   but we continue to use container_of()

   driver_struct = core_alloc(typeof(*driver_struct))

#1 has a general drawback that people routinely mess up the lifecycle
model and get really confused about when to do kfree() vs put(),
creating bugs.

#2 has a general drawback of not using container_of() at all, and being
a bit confusing in some cases

#3 has the general drawback of being a bit magical, but solves 1 and
2's problems.

I would not fix the struct layout without the BUILD_BUG_ON because
someone will accidently change the order and that becomes a subtle
runtime error - so at a minimum the wrapper macro has to exist to
check that.

If you want to allow a dynamic struct layout and avoid the pitfall of
exposing the user to kalloc/kfree, then you still need the macro, and
it does some more complicated offset stuff.

Having the wrapper macro be entirely type safe is appealing and
reduces code in the drivers, IMHO. Tell it what type you are initing
and get back init'd memory for that type that you always, always free
with a put operation.

Jason
