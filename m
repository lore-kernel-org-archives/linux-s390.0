Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3692ECAAD3
	for <linux-s390@archiver.kernel.org>; Wed, 31 Aug 2022 17:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiHaRQR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHaRQP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 Aug 2022 13:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F402B25A
        for <linux-s390@vger.kernel.org>; Wed, 31 Aug 2022 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661966118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wNDRJb+y9GkEb33I7HiMe0aeP3rl6XFj5xgf5bJFgc=;
        b=JuEyyDfArxgK7om6uUP5KdYZ3WrhRtI9o3thBXVljJ3RtMe6AS3cc8T+8RBQ7HMHn0OEAt
        AtU3mnhRNaYoKgDyV3mlyh0x0e/RyviAgucMY8qN7RQ+8rouCaRaxcgvK0WAHh7xZF3ZVc
        RCzA6z9ZybEovIs17bz+MC51/71k0TY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-GYDuP_3RN1WZNyeiu90NGA-1; Wed, 31 Aug 2022 13:15:17 -0400
X-MC-Unique: GYDuP_3RN1WZNyeiu90NGA-1
Received: by mail-il1-f200.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so10863729ilo.19
        for <linux-s390@vger.kernel.org>; Wed, 31 Aug 2022 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=3wNDRJb+y9GkEb33I7HiMe0aeP3rl6XFj5xgf5bJFgc=;
        b=1ICEB13H0TEBj3w4K7ZeJaNiHk4eC5s9aWzWzceOf1sJeL6kZOmO/Lg7duTUVICvJM
         56qZ5gMnTr1mD/qIbYa/Fy5fbTp/NvpF5mT+McvEYwAk9VipFQGzLc4DnBBfkNcAU62D
         0ci4oavKUBTnYogXGaZorWHDL48ojxmamhO+Tq6bfrfR7RpEcsdPPu8/tX3H7/oNleNd
         LLqMyzN2C6jegh2DpozWLhqHbW9kMbi78G+gP+xvVWJULjptv19faXnlf5C5WdZfTHgw
         SAPop9juDKF9ettsT/sEkhD27ZuimPNloKEBf1mInYr54lstMYJbeP5l1lvJoCw4dFfc
         hGkg==
X-Gm-Message-State: ACgBeo3v1tiPJfcf4F7RaKq+ZXT5uKcKfopwsHLOdbL/AvVbRNUlab8y
        16v3DcHuU5p1eOdUCiSVh3yN/FsMhy5t1WFamgJj1k/YMaLCLNG7BZKO05X6gJaPg7vuYtrxoo2
        WU/rNShxfPc7luY5C6YQXeA==
X-Received: by 2002:a05:6638:dd4:b0:349:ebfd:e705 with SMTP id m20-20020a0566380dd400b00349ebfde705mr15532662jaj.4.1661966114833;
        Wed, 31 Aug 2022 10:15:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7UqftyvxL/mEDNedrHFErMBY8p1pSeatls/DmKqtUta1ABwUYFXwUlUJQ1689Lfg3tEQsWAQ==
X-Received: by 2002:a05:6638:dd4:b0:349:ebfd:e705 with SMTP id m20-20020a0566380dd400b00349ebfde705mr15532650jaj.4.1661966114600;
        Wed, 31 Aug 2022 10:15:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u190-20020a0223c7000000b00343617e8368sm7084182jau.99.2022.08.31.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:15:14 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:15:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        "Cornelia Huck" <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220831111512.4924e152.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276BF3B8D65B66DB292CAE58C789@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220827171037.30297-1-kevin.tian@intel.com>
        <20220827171037.30297-16-kevin.tian@intel.com>
        <20220830161838.4aa47045.alex.williamson@redhat.com>
        <Yw6i7btDKcUDPADP@ziepe.ca>
        <BN9PR11MB5276BF3B8D65B66DB292CAE58C789@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 31 Aug 2022 06:10:51 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, August 31, 2022 7:53 AM
> > 
> > On Tue, Aug 30, 2022 at 04:18:38PM -0600, Alex Williamson wrote:  
> > > On Sun, 28 Aug 2022 01:10:37 +0800
> > > Kevin Tian <kevin.tian@intel.com> wrote:
> > >  
> > > > From: Yi Liu <yi.l.liu@intel.com>
> > > >
> > > > and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> > > > sysfs path of the parent, indicating the device is bound to a vfio
> > > > driver, e.g.:
> > > >
> > > > /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> > > >
> > > > It is also a preparatory step toward adding cdev for supporting future
> > > > device-oriented uAPI.  
> > >
> > > Shall we start Documentation/ABI/testing/vfio-dev now?  Thanks.  
> > 
> > I always thought that was something to use when adding new custom
> > sysfs attributes?
> > 
> > Here we are just creating a standard struct device with its standard
> > sysfs?
> >   
> 
> There is nothing special for vfio-dev/vfioX. But from pci device p.o.v
> this does introduce a custom node in the directory, which is probably
> what Alex referred to?

Yup, but not just for pci, we're adding a node into the device
directory for any device bound to vfio.

> Anyway if required following can be introduced:
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-vfio-dev b/Documentation/ABI/testing/sysfs-devices-vfio-dev
> new file mode 100644
> index 000000000000..dfe8baaf1ccb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-vfio-dev
> @@ -0,0 +1,8 @@
> +What:		 /sys/.../<device>/vfio-dev/vfioX/
> +Date:		 September 2022
> +Contact:	 Yi Liu <yi.l.liu@intel.com>
> +Description:
> +		 This directory is created when the device is bound to a
> +		 vfio driver. The layout under this directory matches what
> +		 exists for a standard 'struct device'. 'X' is a random
> +		 number marking this device in vfio.

It's not really random, it's a unique index.  Seems like a good
starting point.

> 
> At the start I thought it might make more sense to add it into an
> existing vfio ABI file. But looks it doesn't exist.
> 
> Curious why nobody asked for ABI doc for /dev/vfio/vfio, /sys/class/vfio, etc...

Oversight, there should probably be a sysfs-class-vfio file.  Thanks,

Alex

