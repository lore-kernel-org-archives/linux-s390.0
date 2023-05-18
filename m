Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DCFC77B7D
	for <linux-s390@archiver.kernel.org>; Thu, 18 May 2023 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjERTzP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 May 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjERTzM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 May 2023 15:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF8E44
        for <linux-s390@vger.kernel.org>; Thu, 18 May 2023 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684439669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOnz7FLeWFp9Eq20E/7cfvpQ/psIaNzbdtCx4JAp4z8=;
        b=gipjujcychRb/rzaqmMrCItESmfZMk13Mh8od2uBUgGGZZkselGocANyZPRuRqfT4z2eNe
        dN/VgFpoxTgIsAU72f3pwPnCfW8ZpqHDCTetvBeHzdVJIEzkC+Yyn/dpB/oP/EDo9+Lumt
        E+0vGJ6EBHo0TnChPYEJqDK+pnhFgws=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-nBBDt1vzPLKr9n9aqHomgA-1; Thu, 18 May 2023 15:54:05 -0400
X-MC-Unique: nBBDt1vzPLKr9n9aqHomgA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33859d4a322so23810835ab.1
        for <linux-s390@vger.kernel.org>; Thu, 18 May 2023 12:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439632; x=1687031632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOnz7FLeWFp9Eq20E/7cfvpQ/psIaNzbdtCx4JAp4z8=;
        b=UoTP3A13R5xZ7YVGiCfw7crlpoYkRnTboyXBYICEwgWrZ39myy7QNDBd1Ln9+0CnfJ
         1gBYREQgK8JPpD1UrAC/cxBooz5hr+FNUrLO1ojSaa2aUbqh5xMIn9VdMLUKlOpQQvzV
         524C1PX2mg7t6FUZAWQfMalbe/OZC9GuTuFJqSdAkz6eoOVwDrUqu3V3fBJvnwDjW5bv
         929VuP7Qfky7ESrKkW/YT25m4cyr45cOEEA8u3xnOr6DUUh7k+SNUKhlV6f3CJOsvHld
         bAqfH9P993xVIfQGAWUQmykkP0rs8caoHULD/mwclRJVBaCYbMCChOsuzAXzAk8WxFGA
         ytTg==
X-Gm-Message-State: AC+VfDzzBtJGMJN+95To8KB13a2VC+q8y0m+kKdjYacidfsDFgFq/JOz
        YYfHGgBx+/jR3M8QmkR3rpdeqhI3kHrlVp1i8J8d19VhmWgh3XeFek78EZNv2oPCiQpaAz0JoWX
        nMY2c1awfQO1FAOtbZ1Zbiw==
X-Received: by 2002:a92:c952:0:b0:337:83fc:43c8 with SMTP id i18-20020a92c952000000b0033783fc43c8mr5511182ilq.10.1684439631918;
        Thu, 18 May 2023 12:53:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Mt3onZ7ykj03VNoF8B/a0LVLffzU72IX2ayiTe6tSR9N5/g8PndWcoR1I1HxYqhwrE8Wk5Q==
X-Received: by 2002:a92:c952:0:b0:337:83fc:43c8 with SMTP id i18-20020a92c952000000b0033783fc43c8mr5511169ilq.10.1684439631723;
        Thu, 18 May 2023 12:53:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cp12-20020a056638480c00b004165f64968csm676038jab.103.2023.05.18.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 12:53:51 -0700 (PDT)
Date:   Thu, 18 May 2023 13:53:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: Re: [PATCH v5 09/10] vfio/pci: Extend
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO for vfio device cdev
Message-ID: <20230518135349.5dcf63c1.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB752951FE3826428345A6CF6DC37F9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230513132136.15021-1-yi.l.liu@intel.com>
        <20230513132136.15021-10-yi.l.liu@intel.com>
        <20230517160131.254be76b.alex.williamson@redhat.com>
        <DS0PR11MB75291457BBD647819B855DA0C37F9@DS0PR11MB7529.namprd11.prod.outlook.com>
        <DS0PR11MB752951FE3826428345A6CF6DC37F9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 18 May 2023 13:31:47 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 18, 2023 9:22 PM
> >   
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Thursday, May 18, 2023 6:02 AM
> > >
> > > On Sat, 13 May 2023 06:21:35 -0700
> > > Yi Liu <yi.l.liu@intel.com> wrote:  
> 
> > >
> > > static int vfio_hot_reset_devid(struct vfio_device *vdev,
> > >                                 struct iommufd_ctx *iommufd_ctx)
> > > {
> > >         struct iommu_group *group;
> > >         int devid;
> > >
> > >         if (!vdev)
> > >                 return VFIO_PCI_DEVID_NOT_OWNED;
> > >
> > >         if (vfio_iommufd_physical_ictx(vdev) == iommufd_ctx)
> > >                 return vfio_iommufd_physical_devid(vdev);  
> 
> Do we need to check the return of this helper? It returns -EINVAL
> when iommufd_access and iommufd_device are both null. Though
> not possible in this path. Is a WARN_ON needed or not?

I also came to the conclusion that it wasn't possible while reviewing
the code.  I wouldn't got to extreme measures to introduce paranoia
checks for impossible conditions.  Thanks,

Alex

> > >
> > >         group = iommu_group_get(vdev->dev);
> > >         if (!group)
> > >                 return VFIO_PCI_DEVID_NOT_OWNED;
> > >
> > >         if (iommufd_ctx_has_group(iommufd_ctx, group))
> > >                 devid = VFIO_PCI_DEVID_OWNED;
> > >
> > >         iommu_group_put(group);
> > >
> > >         return devid;
> > > }  

