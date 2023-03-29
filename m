Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA9C74A5B
	for <linux-s390@archiver.kernel.org>; Wed, 29 Mar 2023 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjC2Wsm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2Wsl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Mar 2023 18:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B423AB8
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680130076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAFNXL8OuvVCp+ZsG3YYv2EZft385+WcsO116CuPnRc=;
        b=i7Zbv+YbqOOn+vCs1J1xhLWYszoFwqg4u9GX9sMdsNvqdKMu1myO/kX1iwzi8CL6jZdhJZ
        Pr5cZZTv/bxoyDyZmHEem0x+yCc4ZX8hgIRuQwAwgLhAunOhVfgwppQaNbii9q43sbdCl5
        ev1do/k5GARP4QZ/PK4iiRnnyaYCJeE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-eqd6S9KyMkCDbtu6XXL2dw-1; Wed, 29 Mar 2023 18:47:53 -0400
X-MC-Unique: eqd6S9KyMkCDbtu6XXL2dw-1
Received: by mail-io1-f69.google.com with SMTP id z65-20020a6bc944000000b007584beb0e28so10333886iof.21
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 15:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAFNXL8OuvVCp+ZsG3YYv2EZft385+WcsO116CuPnRc=;
        b=5coS5dcgPuUE/0TJAzDK0WatukXqg1fdexbmubh6RjhwqxUR9pD3i9ndt358o1H7DT
         hYiIkCEeqHccDGeiwbKf8f65PHaGYfOdXV6I9679XZoh0gXTkyxa97bdVGkPZqJONfwC
         zwvAoObciCbwtFX52/VR69mYjro+9YVSUfQNAOpxtIK2m6jMMOLspJWj7p/QKLZbu/5k
         y9ssVBdkAkqEf1mq24C8nMPZHVqZWqZv6nygVIksFhC8Eq1OtrZg9B08wPmVTT+kH0GF
         aI1ssjbssZTHHa993WmKtHQ0JI8dYY+gbLJmDVh4Zeddifcp8wXC/X8HkeLzN7GNjmAh
         aBUA==
X-Gm-Message-State: AO0yUKWQGMXyU8siIK0eBNO82YmEXWjH7rCVxyHOBD0GOmhr8Ct//QL8
        PIhJO+mJ1IMuKKYUi7Pgz8URnr78cVi5kbrdEHSl/0NNs3q4XLvnLRf9kju0C27GzjcdAyVo1FV
        KoG/npjCxgOmtiIt9pQ7p1Q==
X-Received: by 2002:a5e:8344:0:b0:753:7cef:6383 with SMTP id y4-20020a5e8344000000b007537cef6383mr15654862iom.8.1680130072210;
        Wed, 29 Mar 2023 15:47:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Oqs+6kFDxn2w3FS9AhA0ZvLLKl4b6L1jIAXFQAIPVYEF2juJ8F1iY+ayWQ8fgbwnI9kAVIQ==
X-Received: by 2002:a5e:8344:0:b0:753:7cef:6383 with SMTP id y4-20020a5e8344000000b007537cef6383mr15654839iom.8.1680130071903;
        Wed, 29 Mar 2023 15:47:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n13-20020a5e8c0d000000b0074555814e73sm4853842ioj.32.2023.03.29.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:47:51 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:47:49 -0600
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
Message-ID: <20230329164749.2778aa04.alex.williamson@redhat.com>
In-Reply-To: <20230327094047.47215-25-yi.l.liu@intel.com>
References: <20230327094047.47215-1-yi.l.liu@intel.com>
        <20230327094047.47215-25-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 27 Mar 2023 02:40:47 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This gives notes for userspace applications on device cdev usage.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  Documentation/driver-api/vfio.rst | 127 ++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 363e12c90b87..77408788b98d 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -239,6 +239,125 @@ group and can access them as follows::
>  	/* Gratuitous device reset and go... */
>  	ioctl(device, VFIO_DEVICE_RESET);
>  
> +IOMMUFD and vfio_iommu_type1
> +----------------------------
> +
> +IOMMUFD is the new user API to manage I/O page tables from userspace.
> +It intends to be the portal of delivering advanced userspace DMA
> +features (nested translation [5], PASID [6], etc.) while being backward
> +compatible with the vfio_iommu_type1 driver.  Eventually vfio_iommu_type1
> +will be deprecated.

"... while also providing a backwards compatibility interface for
existing VFIO_TYPE1v2_IOMMU use cases.  Eventually the vfio_iommu_type1
driver, as well as the legacy vfio container and group model is
intended to be deprecated."

> +
> +With the backward compatibility, no change is required for legacy
> VFIO +drivers or applications to connect a VFIO device to IOMMUFD.
> +
> +	When CONFIG_IOMMUFD_VFIO_CONTAINER=n, VFIO container still provides
> +	/dev/vfio/vfio which connects to vfio_iommu_type1.  To disable VFIO
> +	container and vfio_iommu_type1, the administrator could symbol link
> +	/dev/vfio/vfio to /dev/iommu to enable VFIO container emulation
> +	in IOMMUFD.
> +
> +	When CONFIG_IOMMUFD_VFIO_CONTAINER=y, IOMMUFD directly provides
> +	/dev/vfio/vfio while the VFIO container and vfio_iommu_type1 are
> +	explicitly disabled.
> +

"The IOMMUFD backwards compatibility interface can be enabled two ways.
In the first method, the kernel can be configured with
CONFIG_IOMMUFD_VFIO_CONTAINER, in which case the IOMMUFD subsystem
transparently provides the entire infrastructure for the the VFIO
container and IOMMU backend interfaces.  The compatibility mode can
also be accessed if the VFIO container interface, ie. /dev/vfio/vfio is
simply symlink'd to /dev/iommu.  Note that at the time of writing, the
compatibility mode is not entirely feature complete relative to
VFIO_TYPE1v2_IOMMU (ex. DMA mapping MMIO) and does not attempt to
provide compatibility to the VFIO_SPAPR_TCE_IOMMU interface.  Therefore
it is not generally advisable at this time to switch from native VFIO
implementations to the IOMMUFD compatibility interfaces.

Long term, VFIO users should migrate to device access through the cdev
interface described below, and native access through the IOMMUFD
provided interfaces."

Thanks,
Alex

> +VFIO Device cdev
> +----------------
> +
> +Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> +in a VFIO group.
> +
> +With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
> +by directly opening a character device /dev/vfio/devices/vfioX where
> +"X" is the number allocated uniquely by VFIO for registered devices.
> +For noiommu devices, the character device would be named with
> "noiommu-" +prefix. e.g. /dev/vfio/devices/noiommu-vfioX.
> +
> +The cdev only works with IOMMUFD.  Both VFIO drivers and applications
> +must adapt to the new cdev security model which requires using
> +VFIO_DEVICE_BIND_IOMMUFD to claim DMA ownership before starting to
> +actually use the device.  Once BIND succeeds then a VFIO device can
> +be fully accessed by the user.
> +
> +VFIO device cdev doesn't rely on VFIO group/container/iommu drivers.
> +Hence those modules can be fully compiled out in an environment
> +where no legacy VFIO application exists.
> +
> +So far SPAPR does not support IOMMUFD yet.  So it cannot support
> device +cdev neither.
> +
> +Device cdev Example
> +-------------------
> +
> +Assume user wants to access PCI device 0000:6a:01.0::
> +
> +	$ ls /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/
> +	vfio0
> +
> +This device is therefore represented as vfio0.  The user can verify
> +its existence::
> +
> +	$ ls -l /dev/vfio/devices/vfio0
> +	crw------- 1 root root 511, 0 Feb 16 01:22
> /dev/vfio/devices/vfio0
> +	$ cat /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/vfio0/dev
> +	511:0
> +	$ ls -l /dev/char/511\:0
> +	lrwxrwxrwx 1 root root 21 Feb 16 01:22 /dev/char/511:0 ->
> ../vfio/devices/vfio0 +
> +Then provide the user with access to the device if unprivileged
> +operation is desired::
> +
> +	$ chown user:user /dev/vfio/devices/vfio0
> +
> +Finally the user could get cdev fd by::
> +
> +	cdev_fd = open("/dev/vfio/devices/vfio0", O_RDWR);
> +
> +An opened cdev_fd doesn't give the user any permission of accessing
> +the device except binding the cdev_fd to an iommufd.  After that
> point +then the device is fully accessible including attaching it to
> an +IOMMUFD IOAS/HWPT to enable userspace DMA::
> +
> +	struct vfio_device_bind_iommufd bind = {
> +		.argsz = sizeof(bind),
> +		.flags = 0,
> +	};
> +	struct iommu_ioas_alloc alloc_data  = {
> +		.size = sizeof(alloc_data),
> +		.flags = 0,
> +	};
> +	struct vfio_device_attach_iommufd_pt attach_data = {
> +		.argsz = sizeof(attach_data),
> +		.flags = 0,
> +	};
> +	struct iommu_ioas_map map = {
> +		.size = sizeof(map),
> +		.flags = IOMMU_IOAS_MAP_READABLE |
> +			 IOMMU_IOAS_MAP_WRITEABLE |
> +			 IOMMU_IOAS_MAP_FIXED_IOVA,
> +		.__reserved = 0,
> +	};
> +
> +	iommufd = open("/dev/iommu", O_RDWR);
> +
> +	bind.iommufd = iommufd; // negative value means vfio-noiommu
> mode
> +	ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +
> +	ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> +	attach_data.pt_id = alloc_data.out_ioas_id;
> +	ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +
> +	/* Allocate some space and setup a DMA mapping */
> +	map.user_va = (int64_t)mmap(0, 1024 * 1024, PROT_READ |
> PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, 0,
> 0);
> +	map.iova = 0; /* 1MB starting at 0x0 from device view */
> +	map.length = 1024 * 1024;
> +	map.ioas_id = alloc_data.out_ioas_id;;
> +
> +	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
> +
> +	/* Other device operations as stated in "VFIO Usage Example"
> */ +
>  VFIO User API
>  -------------------------------------------------------------------------------
>  
> @@ -566,3 +685,11 @@ This implementation has some specifics:
>  				\-0d.1
>  
>  	00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev
> 90) +
> +.. [5] Nested translation is an IOMMU feature which supports two
> stage
> +   address translations.  This improves the address translation
> efficiency
> +   in IOMMU virtualization.
> +
> +.. [6] PASID stands for Process Address Space ID, introduced by PCI
> +   Express.  It is a prerequisite for Shared Virtual Addressing (SVA)
> +   and Scalable I/O Virtualization (Scalable IOV).

