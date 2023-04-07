Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E771C77B75
	for <linux-s390@archiver.kernel.org>; Fri,  7 Apr 2023 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbjDGPPK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Apr 2023 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjDGPO4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Apr 2023 11:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED44C01
        for <linux-s390@vger.kernel.org>; Fri,  7 Apr 2023 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680880447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXAPNdBJMnoHbxVht9yPga+A2CeJtiyrlF4HM2aW+j0=;
        b=dDPNHZDfdeyB062/uyMr6aoaGBYNaZqftMM32GwZZzIhO0DJCsmhhoiL+Q2+dwxYjpHz71
        yTQ0qR9V0VvHr+ZckSL368//Xc/To9G07pgdSIyd9BZlM2Tqd8Qqk62QaA4fs7v8r1tw8e
        SAzxv2/Wc1Rz0ZKihpMJhDdc1St/WPQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-EFT2ZwlvO-6KKFOgCfeGBA-1; Fri, 07 Apr 2023 11:14:06 -0400
X-MC-Unique: EFT2ZwlvO-6KKFOgCfeGBA-1
Received: by mail-il1-f200.google.com with SMTP id x5-20020a056e021ca500b00327f726c6c0so4798140ill.9
        for <linux-s390@vger.kernel.org>; Fri, 07 Apr 2023 08:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680880445; x=1683472445;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXAPNdBJMnoHbxVht9yPga+A2CeJtiyrlF4HM2aW+j0=;
        b=NO6CzB/6IqZdTq0fj/zI2Zh8uELuUl9wY1n2IdOrgFtuRHHUfsbJtQt66MgnheWrSm
         tbJV9mn0Gpp205SvxIKkh/XNNNLHbzEas5TnnZmR/g/H69ZyBA+T/6xmgxQdNmfI5Paf
         zUBHlHgfj4fBXBiDPbxQfbqDAeYT5WtLwkMmd1WnMmWBDe84PEbfRIZFkX0DAK+m9Xue
         QcpUEMZBBqREujPBLCPwUwu9/yY90n6Dqi1aK0v49hl4anqhjdv/7HyaXZYGnK/7p4VK
         s8az6ZbF3GkC9w+x/fpKWDoIckNnqQoShqxrYNCWIsilumMKATmjqDg0U6qfSqaaZgvX
         C4ZA==
X-Gm-Message-State: AAQBX9davQtZRNd0+a+7Xb/xg+EfIZAwJAEzqHDMVOL7+wwwXpQDhmpV
        R3mA1ehwSSAn/aVP9uyTJNbXrHYLTOdPJ1DYRGImVxxKMYQiPaEnB9/VOCSJTJ8iUy5gRQZSMHw
        tEiiZ9JtQo6eMH0fS6shBtmcT5faf5g==
X-Received: by 2002:a6b:e611:0:b0:74c:9235:8753 with SMTP id g17-20020a6be611000000b0074c92358753mr2519778ioh.13.1680880445447;
        Fri, 07 Apr 2023 08:14:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YEpVoORZpa6d3nNLDs1r1CtYmaffUAedkEJ1EC3FuUQNNUjaJPIAYHNqBk5PYwGJ72oUes6w==
X-Received: by 2002:a6b:e611:0:b0:74c:9235:8753 with SMTP id g17-20020a6be611000000b0074c92358753mr2519746ioh.13.1680880445186;
        Fri, 07 Apr 2023 08:14:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z20-20020a027a54000000b004061ac1ddd1sm1174890jad.169.2023.04.07.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:14:04 -0700 (PDT)
Date:   Fri, 7 Apr 2023 09:14:01 -0600
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
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230407091401.1c847419.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529C1CA38D7D1035869F358C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230403090151.4cb2158c.alex.williamson@redhat.com>
        <DS0PR11MB75291E6ED702ADD03AAE023BC3969@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230407060335.7babfeb8.alex.williamson@redhat.com>
        <DS0PR11MB7529B0A91FF97C078BEA3783C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230407075155.3ad4c804.alex.williamson@redhat.com>
        <DS0PR11MB7529C1CA38D7D1035869F358C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 7 Apr 2023 14:04:02 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 7, 2023 9:52 PM
> > 
> > On Fri, 7 Apr 2023 13:24:25 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Friday, April 7, 2023 8:04 PM
> > > >  
> > > > > > > > @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev *pdev,  
> > void  
> > > > > > *data)  
> > > > > > > >  	if (!iommu_group)
> > > > > > > >  		return -EPERM; /* Cannot reset non-isolated devices */  
> > >
> > > [1]
> > >  
> > > > > > >
> > > > > > > Hi Alex,
> > > > > > >
> > > > > > > Is disabling iommu a sane way to test vfio noiommu mode?  
> > > > > >
> > > > > > Yes
> > > > > >  
> > > > > > > I added intel_iommu=off to disable intel iommu and bind a device to vfio-pci.
> > > > > > > I can see the /dev/vfio/noiommu-0 and /dev/vfio/devices/noiommu-vfio0.  
> > Bind  
> > > > > > > iommufd==-1 can succeed, but failed to get hot reset info due to the above
> > > > > > > group check. Reason is that this happens to have some affected devices, and
> > > > > > > these devices have no valid iommu_group (because they are not bound to  
> > vfio-  
> > > > pci  
> > > > > > > hence nobody allocates noiommu group for them). So when hot reset info  
> > loops  
> > > > > > > such devices, it failed with -EPERM. Is this expected?  
> > > > > >
> > > > > > Hmm, I didn't recall that we put in such a limitation, but given the
> > > > > > minimally intrusive approach to no-iommu and the fact that we never
> > > > > > defined an invalid group ID to return to the user, it makes sense that
> > > > > > we just blocked the ioctl for no-iommu use.  I guess we can do the same
> > > > > > for no-iommu cdev.  
> > > > >
> > > > > I just realize a further issue related to this limitation. Remember that we
> > > > > may finally compile out the vfio group infrastructure in the future. Say I
> > > > > want to test noiommu, I may boot such a kernel with iommu disabled. I think
> > > > > the _INFO ioctl would fail as there is no iommu_group. Does it mean we will
> > > > > not support hot reset for noiommu in future if vfio group infrastructure is
> > > > > compiled out?  
> > > >
> > > > We're talking about IOMMU groups, IOMMU groups are always present
> > > > regardless of whether we expose a vfio group interface to userspace.
> > > > Remember, we create IOMMU groups even in the no-iommu case.  Even with
> > > > pure cdev, there are underlying IOMMU groups that maintain the DMA
> > > > ownership.  
> > >
> > > hmmm. As [1], when iommu is disabled, there will be no iommu_group for a
> > > given device unless it is registered to VFIO, which a fake group is created.
> > > That's why I hit the limitation [1]. When vfio_group is compiled out, then
> > > even fake group goes away.  
> > 
> > In the vfio group case, [1] can be hit with no-iommu only when there
> > are affected devices which are not bound to vfio.  
> 
> yes. because vfio would allocate fake group when device is registered to
> it.
> 
> > Why are we not
> > allocating an IOMMU group to no-iommu devices when vfio group is
> > disabled?  Thanks,  
> 
> hmmm. when the vfio group code is configured out. The
> vfio_device_set_group() just returns 0 after below patch is
> applied and CONFIG_VFIO_GROUP=n. So when there is no
> vfio group, the fake group also goes away.
> 
> https://lore.kernel.org/kvm/20230401151833.124749-25-yi.l.liu@intel.com/

Is this a fundamental issue or just a problem with the current
implementation proposal?  It seems like the latter.  FWIW, I also don't
see a taint happening in the cdev path for no-iommu use.  Thanks,

Alex

