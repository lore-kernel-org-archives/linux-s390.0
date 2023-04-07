Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F33C76196
	for <linux-s390@archiver.kernel.org>; Fri,  7 Apr 2023 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDGVIP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGVIO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Apr 2023 17:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6EE44
        for <linux-s390@vger.kernel.org>; Fri,  7 Apr 2023 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680901646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5KpsOJOZ4YA+v0e7h56AcRCS0K0kPfTOJnEBGf/OGY=;
        b=e/9OWk4B6rANY5ksdruUWDlhMhqCZ5v7QlX3vYLmZYUD3rPRO4S27HBfk39r0gdbeIjqEC
        aIyLUEQMFGfcQ6Q9e/bkc94OHpmkO9YxQrLCMBHbCEgiN8CY9wcnkJ1FQqOm7aQReGNwIS
        sFpVsYKE/DG2C7kSsscwU+nUl0EkPMU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-WyPmw1OEPxCsDbpBWekDEw-1; Fri, 07 Apr 2023 17:07:25 -0400
X-MC-Unique: WyPmw1OEPxCsDbpBWekDEw-1
Received: by mail-io1-f72.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so26014881iog.7
        for <linux-s390@vger.kernel.org>; Fri, 07 Apr 2023 14:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680901645; x=1683493645;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5KpsOJOZ4YA+v0e7h56AcRCS0K0kPfTOJnEBGf/OGY=;
        b=d0GKpr5GS7q5oSJV+Iyy4+AVP6jJuxFwYw+wVljlFUg2gEtfodN0cRHl1Gppe3dKy5
         NmRGrisWHtsm2xfGQEsr66CNuHZwd+F2fJVbUwwI3Ak3tt0fKAdFliRY4djdNlNpJaTj
         /8xdInaKZtSclMuti/o3tsWfa/3XVIRDelccLEtwYpW1bngpnjIMGKesecLXcezLKHoQ
         T9I+cUymdPgoWVtT6u9J2ogPOKcPgSg8kVCjoIiXiIkR6DISh3n2ngZbPphmfU8oW6NA
         gHO3quy00bnUQUXL7+G4Jd/Qo9CcLzE4OZ1WxJh6SJfWSK6weMcesg6Zd2c8gL9yveqQ
         Ecvg==
X-Gm-Message-State: AAQBX9cmX9o8tKhDJFNcToO3E2pUITIP9GpuGGU/q7tBUaTIMg+cglWr
        S34QUFP+WRKqHzTGL6+0N0gvZ+TEkHXMwKKQOhYhqIC9DAmuC8uhwHFY5nRtbUTVwebgtlZSFmm
        FkQhlzL4L1efD08bOP85x1A==
X-Received: by 2002:a92:c842:0:b0:310:c6f7:c1e9 with SMTP id b2-20020a92c842000000b00310c6f7c1e9mr46531ilq.5.1680901644901;
        Fri, 07 Apr 2023 14:07:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350blmaCJLT4o9hbUAuzSGLAYyai8t8DDOomZycals9fmQUkixA3uNQMnu5k2ngdyGVebYrNjzQ==
X-Received: by 2002:a92:c842:0:b0:310:c6f7:c1e9 with SMTP id b2-20020a92c842000000b00310c6f7c1e9mr46508ilq.5.1680901644577;
        Fri, 07 Apr 2023 14:07:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y17-20020a027311000000b0040b1f6db720sm1389567jab.29.2023.04.07.14.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:07:23 -0700 (PDT)
Date:   Fri, 7 Apr 2023 15:07:21 -0600
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
Message-ID: <20230407150721.395eabc4.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529A9D103F88381F84CF390C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230403090151.4cb2158c.alex.williamson@redhat.com>
        <DS0PR11MB75291E6ED702ADD03AAE023BC3969@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230407060335.7babfeb8.alex.williamson@redhat.com>
        <DS0PR11MB7529B0A91FF97C078BEA3783C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230407075155.3ad4c804.alex.williamson@redhat.com>
        <DS0PR11MB7529C1CA38D7D1035869F358C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230407091401.1c847419.alex.williamson@redhat.com>
        <DS0PR11MB7529A9D103F88381F84CF390C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 7 Apr 2023 15:47:10 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 7, 2023 11:14 PM
> > 
> > On Fri, 7 Apr 2023 14:04:02 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Friday, April 7, 2023 9:52 PM
> > > >
> > > > On Fri, 7 Apr 2023 13:24:25 +0000
> > > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > > >  
> > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Sent: Friday, April 7, 2023 8:04 PM
> > > > > >  
> > > > > > > > > > @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev  
> > *pdev,  
> > > > void  
> > > > > > > > *data)  
> > > > > > > > > >  	if (!iommu_group)
> > > > > > > > > >  		return -EPERM; /* Cannot reset non-isolated devices */  
> > > > >
> > > > > [1]
> > > > >  
> > > > > > > > >
> > > > > > > > > Hi Alex,
> > > > > > > > >
> > > > > > > > > Is disabling iommu a sane way to test vfio noiommu mode?  
> > > > > > > >
> > > > > > > > Yes
> > > > > > > >  
> > > > > > > > > I added intel_iommu=off to disable intel iommu and bind a device to vfio-  
> > pci.  
> > > > > > > > > I can see the /dev/vfio/noiommu-0 and /dev/vfio/devices/noiommu-vfio0.  
> > > > Bind  
> > > > > > > > > iommufd==-1 can succeed, but failed to get hot reset info due to the  
> > above  
> > > > > > > > > group check. Reason is that this happens to have some affected devices,  
> > and  
> > > > > > > > > these devices have no valid iommu_group (because they are not bound to  
> > > > vfio-  
> > > > > > pci  
> > > > > > > > > hence nobody allocates noiommu group for them). So when hot reset info  
> > > > loops  
> > > > > > > > > such devices, it failed with -EPERM. Is this expected?  
> > > > > > > >
> > > > > > > > Hmm, I didn't recall that we put in such a limitation, but given the
> > > > > > > > minimally intrusive approach to no-iommu and the fact that we never
> > > > > > > > defined an invalid group ID to return to the user, it makes sense that
> > > > > > > > we just blocked the ioctl for no-iommu use.  I guess we can do the same
> > > > > > > > for no-iommu cdev.  
> > > > > > >
> > > > > > > I just realize a further issue related to this limitation. Remember that we
> > > > > > > may finally compile out the vfio group infrastructure in the future. Say I
> > > > > > > want to test noiommu, I may boot such a kernel with iommu disabled. I think
> > > > > > > the _INFO ioctl would fail as there is no iommu_group. Does it mean we will
> > > > > > > not support hot reset for noiommu in future if vfio group infrastructure is
> > > > > > > compiled out?  
> > > > > >
> > > > > > We're talking about IOMMU groups, IOMMU groups are always present
> > > > > > regardless of whether we expose a vfio group interface to userspace.
> > > > > > Remember, we create IOMMU groups even in the no-iommu case.  Even with
> > > > > > pure cdev, there are underlying IOMMU groups that maintain the DMA
> > > > > > ownership.  
> > > > >
> > > > > hmmm. As [1], when iommu is disabled, there will be no iommu_group for a
> > > > > given device unless it is registered to VFIO, which a fake group is created.
> > > > > That's why I hit the limitation [1]. When vfio_group is compiled out, then
> > > > > even fake group goes away.  
> > > >
> > > > In the vfio group case, [1] can be hit with no-iommu only when there
> > > > are affected devices which are not bound to vfio.  
> > >
> > > yes. because vfio would allocate fake group when device is registered to
> > > it.
> > >  
> > > > Why are we not
> > > > allocating an IOMMU group to no-iommu devices when vfio group is
> > > > disabled?  Thanks,  
> > >
> > > hmmm. when the vfio group code is configured out. The
> > > vfio_device_set_group() just returns 0 after below patch is
> > > applied and CONFIG_VFIO_GROUP=n. So when there is no
> > > vfio group, the fake group also goes away.
> > >
> > > https://lore.kernel.org/kvm/20230401151833.124749-25-yi.l.liu@intel.com/  
> > 
> > Is this a fundamental issue or just a problem with the current
> > implementation proposal?  It seems like the latter.  FWIW, I also don't
> > see a taint happening in the cdev path for no-iommu use.  Thanks,  
> 
> yes. the latter case. The reason I raised it here is to confirm the
> policy on the new group/bdf capability in the DEVICE_GET_INFO. If
> there is no iommu group, perhaps I only need to exclude the new
> group/bdf capability from the cap chain of DEVICE_GET_INFO. is it?

I think we need to revisit the question of why allocating an IOMMU
group for a no-iommu device is exclusive to the vfio group support.
We've already been down the path of trying to report a field that only
exists for devices with certain properties with dev-id.  It doesn't
work well.  I think we've said all along that while the cdev interface
is device based, there are still going to be underlying IOMMU groups
for the user to be aware of, they're just not as much a fundamental
part of the interface.  There should not be a case where a device
doesn't have a group to report.  Thanks,

Alex

