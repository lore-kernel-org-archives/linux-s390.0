Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDCC74A5B
	for <linux-s390@archiver.kernel.org>; Wed, 29 Mar 2023 22:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjC2W6y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC2W6x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Mar 2023 18:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39E46AA
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680130686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqSb614bpnGODSpdBacflTpi7ojJu/N3KB6ydJf7CJc=;
        b=WhlCBCVVHYoD4G1Nb89faKhZ1AnGgYtBYkoeZcljOhXct/xTK5k8xkgvJ0RXEPy+iYfe64
        NpPAlnpOhVQsvTrLyi8AXchq0m2FXLWk/Csd3MatQ5aZ3q/y9kcCnGJ5duG8wx/J0RU2Ry
        vUtaJL0kFXyRa/we2/5JzH2f2zPvPEQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-TOzDecYeMQW1D8vinkiLJA-1; Wed, 29 Mar 2023 18:58:05 -0400
X-MC-Unique: TOzDecYeMQW1D8vinkiLJA-1
Received: by mail-il1-f200.google.com with SMTP id z8-20020a92cd08000000b00317b27a795aso11018021iln.0
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 15:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqSb614bpnGODSpdBacflTpi7ojJu/N3KB6ydJf7CJc=;
        b=OArDYcS+YWSO7u3APTuGcXbzxEAnbedtBCmmlIvJw2HtnsJt62qoPfVgK85Byb/JUN
         j0nxUT38QQIWGAUOg/xYmMZ8mH0voCpAePjxNz57X2pZddtFkRzm9u+CfMBRCd1y14Vx
         iwZSJ9j+LiCyTPz/aLesl4Ozb5ar8DLfB99Fp5TT7ppvMga8/f0jzQ1b4LrOUOupNOX+
         TSBHd4DNxq0Lsoc+urnpr8Pglkb0xvkWJoKSZdIwtXXtRm9SaNiA1CNyf/EO+TYZ/yeY
         JGvUkjEKn45+ou/aU/R1+bJgmcvVnXdzhoNMiPDvmlKjdfIG1v8KWOajZH3CZvhYqG9j
         tYJQ==
X-Gm-Message-State: AAQBX9c30lYkE2TcCN/wuYFJvIwQ25tWCgalqlmhFsoBi7OpjSikju+H
        6XDzr6jrKGw5slP9yZNujb+Q1ggzuCpWRWXaG679xVyIN5bWZ5DWSW+1+xOPus2HyvxKa5eB1hl
        znk0DR4DZ/5fYpyfLDExWvA==
X-Received: by 2002:a92:c688:0:b0:315:537e:4b18 with SMTP id o8-20020a92c688000000b00315537e4b18mr13545901ilg.32.1680130679692;
        Wed, 29 Mar 2023 15:57:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZjB6g4MnZXnp6LQWyrzpWRTxnEwfNS5Oun74wPc/2VqhYS17fcaEn6qOIbdj9/uz/LN80VSA==
X-Received: by 2002:a92:c688:0:b0:315:537e:4b18 with SMTP id o8-20020a92c688000000b00315537e4b18mr13545882ilg.32.1680130679216;
        Wed, 29 Mar 2023 15:57:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x10-20020a92300a000000b0030c0dce44b1sm9466042ile.15.2023.03.29.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:57:56 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:57:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v8 24/24] docs: vfio: Add vfio device cdev description
Message-ID: <20230329165755.71b7beab.alex.williamson@redhat.com>
In-Reply-To: <20230329164749.2778aa04.alex.williamson@redhat.com>
References: <20230327094047.47215-1-yi.l.liu@intel.com>
        <20230327094047.47215-25-yi.l.liu@intel.com>
        <20230329164749.2778aa04.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 29 Mar 2023 16:47:49 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 27 Mar 2023 02:40:47 -0700
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
> > This gives notes for userspace applications on device cdev usage.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  Documentation/driver-api/vfio.rst | 127 ++++++++++++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> > index 363e12c90b87..77408788b98d 100644
> > --- a/Documentation/driver-api/vfio.rst
> > +++ b/Documentation/driver-api/vfio.rst
> > @@ -239,6 +239,125 @@ group and can access them as follows::
> >  	/* Gratuitous device reset and go... */
> >  	ioctl(device, VFIO_DEVICE_RESET);
> >  
> > +IOMMUFD and vfio_iommu_type1
> > +----------------------------
> > +
> > +IOMMUFD is the new user API to manage I/O page tables from userspace.
> > +It intends to be the portal of delivering advanced userspace DMA
> > +features (nested translation [5], PASID [6], etc.) while being backward
> > +compatible with the vfio_iommu_type1 driver.  Eventually vfio_iommu_type1
> > +will be deprecated.  
> 
> "... while also providing a backwards compatibility interface for
> existing VFIO_TYPE1v2_IOMMU use cases.  Eventually the vfio_iommu_type1
> driver, as well as the legacy vfio container and group model is
> intended to be deprecated."
> 
> > +
> > +With the backward compatibility, no change is required for legacy
> > VFIO +drivers or applications to connect a VFIO device to IOMMUFD.
> > +
> > +	When CONFIG_IOMMUFD_VFIO_CONTAINER=n, VFIO container still provides
> > +	/dev/vfio/vfio which connects to vfio_iommu_type1.  To disable VFIO
> > +	container and vfio_iommu_type1, the administrator could symbol link
> > +	/dev/vfio/vfio to /dev/iommu to enable VFIO container emulation
> > +	in IOMMUFD.
> > +
> > +	When CONFIG_IOMMUFD_VFIO_CONTAINER=y, IOMMUFD directly provides
> > +	/dev/vfio/vfio while the VFIO container and vfio_iommu_type1 are
> > +	explicitly disabled.
> > +  
> 
> "The IOMMUFD backwards compatibility interface can be enabled two ways.
> In the first method, the kernel can be configured with
> CONFIG_IOMMUFD_VFIO_CONTAINER, in which case the IOMMUFD subsystem
> transparently provides the entire infrastructure for the the VFIO
> container and IOMMU backend interfaces.  The compatibility mode can
> also be accessed if the VFIO container interface, ie. /dev/vfio/vfio is
> simply symlink'd to /dev/iommu.  Note that at the time of writing, the
> compatibility mode is not entirely feature complete relative to
> VFIO_TYPE1v2_IOMMU (ex. DMA mapping MMIO) and does not attempt to
> provide compatibility to the VFIO_SPAPR_TCE_IOMMU interface.  Therefore
> it is not generally advisable at this time to switch from native VFIO
> implementations to the IOMMUFD compatibility interfaces.
> 
> Long term, VFIO users should migrate to device access through the cdev
> interface described below, and native access through the IOMMUFD
> provided interfaces."
> 
> Thanks,
> Alex
> 
> > +VFIO Device cdev
> > +----------------
> > +
> > +Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> > +in a VFIO group.
> > +
> > +With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
> > +by directly opening a character device /dev/vfio/devices/vfioX where
> > +"X" is the number allocated uniquely by VFIO for registered devices.
> > +For noiommu devices, the character device would be named with
> > "noiommu-" +prefix. e.g. /dev/vfio/devices/noiommu-vfioX.
> > +
> > +The cdev only works with IOMMUFD.  Both VFIO drivers and applications
> > +must adapt to the new cdev security model which requires using
> > +VFIO_DEVICE_BIND_IOMMUFD to claim DMA ownership before starting to
> > +actually use the device.  Once BIND succeeds then a VFIO device can
> > +be fully accessed by the user.
> > +
> > +VFIO device cdev doesn't rely on VFIO group/container/iommu drivers.
> > +Hence those modules can be fully compiled out in an environment
> > +where no legacy VFIO application exists.
> > +
> > +So far SPAPR does not support IOMMUFD yet.  So it cannot support
> > device +cdev neither.
> > +
> > +Device cdev Example
> > +-------------------
> > +
> > +Assume user wants to access PCI device 0000:6a:01.0::
> > +
> > +	$ ls /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/
> > +	vfio0
> > +
> > +This device is therefore represented as vfio0.  The user can verify
> > +its existence::
> > +
> > +	$ ls -l /dev/vfio/devices/vfio0
> > +	crw------- 1 root root 511, 0 Feb 16 01:22
> > /dev/vfio/devices/vfio0
> > +	$ cat /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/vfio0/dev
> > +	511:0
> > +	$ ls -l /dev/char/511\:0
> > +	lrwxrwxrwx 1 root root 21 Feb 16 01:22 /dev/char/511:0 ->
> > ../vfio/devices/vfio0 +
> > +Then provide the user with access to the device if unprivileged
> > +operation is desired::
> > +
> > +	$ chown user:user /dev/vfio/devices/vfio0
> > +
> > +Finally the user could get cdev fd by::
> > +
> > +	cdev_fd = open("/dev/vfio/devices/vfio0", O_RDWR);
> > +
> > +An opened cdev_fd doesn't give the user any permission of accessing
> > +the device except binding the cdev_fd to an iommufd.  After that
> > point +then the device is fully accessible including attaching it to
> > an +IOMMUFD IOAS/HWPT to enable userspace DMA::
> > +
> > +	struct vfio_device_bind_iommufd bind = {
> > +		.argsz = sizeof(bind),
> > +		.flags = 0,
> > +	};
> > +	struct iommu_ioas_alloc alloc_data  = {
> > +		.size = sizeof(alloc_data),
> > +		.flags = 0,
> > +	};
> > +	struct vfio_device_attach_iommufd_pt attach_data = {
> > +		.argsz = sizeof(attach_data),
> > +		.flags = 0,
> > +	};
> > +	struct iommu_ioas_map map = {
> > +		.size = sizeof(map),
> > +		.flags = IOMMU_IOAS_MAP_READABLE |
> > +			 IOMMU_IOAS_MAP_WRITEABLE |
> > +			 IOMMU_IOAS_MAP_FIXED_IOVA,
> > +		.__reserved = 0,
> > +	};
> > +
> > +	iommufd = open("/dev/iommu", O_RDWR);
> > +
> > +	bind.iommufd = iommufd; // negative value means vfio-noiommu
> > mode
> > +	ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);


Even here the dev_cookie is nowhere to be found!  Thanks,

Alex

> > +
> > +	ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> > +	attach_data.pt_id = alloc_data.out_ioas_id;
> > +	ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> > +
> > +	/* Allocate some space and setup a DMA mapping */
> > +	map.user_va = (int64_t)mmap(0, 1024 * 1024, PROT_READ |
> > PROT_WRITE,
> > +				    MAP_PRIVATE | MAP_ANONYMOUS, 0,
> > 0);
> > +	map.iova = 0; /* 1MB starting at 0x0 from device view */
> > +	map.length = 1024 * 1024;
> > +	map.ioas_id = alloc_data.out_ioas_id;;
> > +
> > +	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
> > +
> > +	/* Other device operations as stated in "VFIO Usage Example"
> > */ +
> >  VFIO User API
> >  -------------------------------------------------------------------------------
> >  
> > @@ -566,3 +685,11 @@ This implementation has some specifics:
> >  				\-0d.1
> >  
> >  	00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev
> > 90) +
> > +.. [5] Nested translation is an IOMMU feature which supports two
> > stage
> > +   address translations.  This improves the address translation
> > efficiency
> > +   in IOMMU virtualization.
> > +
> > +.. [6] PASID stands for Process Address Space ID, introduced by PCI
> > +   Express.  It is a prerequisite for Shared Virtual Addressing (SVA)
> > +   and Scalable I/O Virtualization (Scalable IOV).  
> 

