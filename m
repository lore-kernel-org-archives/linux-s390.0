Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58341C6FD1D
	for <linux-s390@archiver.kernel.org>; Fri,  7 Apr 2023 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjDGMEc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Apr 2023 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjDGMEb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Apr 2023 08:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740C8A52
        for <linux-s390@vger.kernel.org>; Fri,  7 Apr 2023 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680869019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkUUy9iLyVeqXpHFSjwkEYxhFcB9vKBhzKxpfaiYE+o=;
        b=EZrVU8BFU76i+Cr77Hd1dnYto4hC6OWDZrZP+9CrB2D0GQ35/daKGO9LFcHrM+Ph/lfsdy
        ii5ZPUGulBHf4bdOu4XZQYfLMT+BVzotbbqLNR6uDdphoaeBvl3AAIM3IKNqt8GLxipL/p
        Fgy2lyG17huzBuagsoAqxRrPKZEYLgE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-RQnz08tdPWG63EKKemY6vw-1; Fri, 07 Apr 2023 08:03:38 -0400
X-MC-Unique: RQnz08tdPWG63EKKemY6vw-1
Received: by mail-io1-f72.google.com with SMTP id v126-20020a6bac84000000b007587234a54cso25819235ioe.6
        for <linux-s390@vger.kernel.org>; Fri, 07 Apr 2023 05:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680869018; x=1683461018;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkUUy9iLyVeqXpHFSjwkEYxhFcB9vKBhzKxpfaiYE+o=;
        b=Vdb7iZcBvWJ0d/WlMEKPx9Gu2GjbNsveiGJh/iK9K06woVNtRjs24ZPY0dC0jES8Ku
         xCGglqn3AEApjrExMSaHiniRI6Ck5f2NbFwGH9Ig3A7e0gFW/K8B1qi26W6haKHZV5z9
         gd7aH3JBZ5ISFPP3ePZ4tDCFe/s5n20j4+Tc3n0mA7BWC518iHpMvNZHt+Enf/YuHqUM
         cgFTvOQQZC7LH/jXi58WfTU1ayCbpKwfV7Olbfrl+SNMU3yEppm5en3lmrZX6qdq6dTQ
         FJL1xOPrrwH29u3HvOSnBwow6QihFKCMx58KXEDD00onDtIkESTXgBrsrA/ysOXZbXcV
         qF2Q==
X-Gm-Message-State: AAQBX9fgrY7HytucJIJmE3B2acjfyDxjQvdnv+QO3lWi5DGFc2Wr1x/p
        Ujl/EmFHbDbcY44sCNWEoVSh3Weyqph9OanGgy571PRoPtWhNBa06MC3WV4db9bWF/yyo+9piGm
        9yMQfJTWfnXjI9Fr723ZqVg==
X-Received: by 2002:a6b:e809:0:b0:74c:aa8f:a83e with SMTP id f9-20020a6be809000000b0074caa8fa83emr1736929ioh.6.1680869017714;
        Fri, 07 Apr 2023 05:03:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350b47GhoP5h7PpNabOBHlWCa/K0lm8L4p8ItVOpFt9aS9p6DIyF0sceWV4C6aZBR6S4P0IdR1A==
X-Received: by 2002:a6b:e809:0:b0:74c:aa8f:a83e with SMTP id f9-20020a6be809000000b0074caa8fa83emr1736912ioh.6.1680869017415;
        Fri, 07 Apr 2023 05:03:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m42-20020a026d2a000000b003a4419ba0c2sm1027418jac.139.2023.04.07.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:03:36 -0700 (PDT)
Date:   Fri, 7 Apr 2023 06:03:35 -0600
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
Message-ID: <20230407060335.7babfeb8.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75291E6ED702ADD03AAE023BC3969@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230403090151.4cb2158c.alex.williamson@redhat.com>
        <DS0PR11MB75291E6ED702ADD03AAE023BC3969@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 7 Apr 2023 10:09:58 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Monday, April 3, 2023 11:02 PM
> > 
> > On Mon, 3 Apr 2023 09:25:06 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Saturday, April 1, 2023 10:44 PM  
> > >  
> > > > @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev *pdev, void  
> > *data)  
> > > >  	if (!iommu_group)
> > > >  		return -EPERM; /* Cannot reset non-isolated devices */  
> > >
> > > Hi Alex,
> > >
> > > Is disabling iommu a sane way to test vfio noiommu mode?  
> > 
> > Yes
> >   
> > > I added intel_iommu=off to disable intel iommu and bind a device to vfio-pci.
> > > I can see the /dev/vfio/noiommu-0 and /dev/vfio/devices/noiommu-vfio0. Bind
> > > iommufd==-1 can succeed, but failed to get hot reset info due to the above
> > > group check. Reason is that this happens to have some affected devices, and
> > > these devices have no valid iommu_group (because they are not bound to vfio-pci
> > > hence nobody allocates noiommu group for them). So when hot reset info loops
> > > such devices, it failed with -EPERM. Is this expected?  
> > 
> > Hmm, I didn't recall that we put in such a limitation, but given the
> > minimally intrusive approach to no-iommu and the fact that we never
> > defined an invalid group ID to return to the user, it makes sense that
> > we just blocked the ioctl for no-iommu use.  I guess we can do the same
> > for no-iommu cdev.  
> 
> I just realize a further issue related to this limitation. Remember that we
> may finally compile out the vfio group infrastructure in the future. Say I
> want to test noiommu, I may boot such a kernel with iommu disabled. I think
> the _INFO ioctl would fail as there is no iommu_group. Does it mean we will
> not support hot reset for noiommu in future if vfio group infrastructure is
> compiled out?

We're talking about IOMMU groups, IOMMU groups are always present
regardless of whether we expose a vfio group interface to userspace.
Remember, we create IOMMU groups even in the no-iommu case.  Even with
pure cdev, there are underlying IOMMU groups that maintain the DMA
ownership.

> As another thread, we are going to add a new bdf/group capability to
> DEVICE_GET_INFO. If the above kernel is booted, shall we exclude the new
> bdf/group capability or add a flag in the capability to mark the group_id
> is invalid?

As above, there's always an IOMMU group, it's never invalid.  Thanks,

Alex

