Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F82CC7EE21
	for <linux-s390@archiver.kernel.org>; Thu, 27 Apr 2023 18:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbjD0Sc4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbjD0Scz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Apr 2023 14:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CA46AC
        for <linux-s390@vger.kernel.org>; Thu, 27 Apr 2023 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682620329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6LZTxbqMNSlOAcpVGltFAX5rwaxLlFX1/1eyhmddg0=;
        b=ZgZwZ1DeMwmbfK3Fxtf7N5kZOOcz1hS55XUx5d5KXF1V/PybkFwt7d1qOe+ghtxj5PKZYU
        TP9vWFwd2kj/k0vWP9Xoo0JOhdLVuC+UYT9RXLFLtmTK2gMyPfdWoNRNFy18t1FpVIRRgq
        laGvNOkQDOhhhOqGv/lV5t9YH+YrJyY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-NxWvbXnrMUCQhTHR4VhuEQ-1; Thu, 27 Apr 2023 14:32:07 -0400
X-MC-Unique: NxWvbXnrMUCQhTHR4VhuEQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-328f6562564so138789655ab.1
        for <linux-s390@vger.kernel.org>; Thu, 27 Apr 2023 11:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620326; x=1685212326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6LZTxbqMNSlOAcpVGltFAX5rwaxLlFX1/1eyhmddg0=;
        b=igXob8sw7k5okst/Gs27AlL+X77mQYkfhF3xpNaG+3JaK30RrEyTMFKzkqtt+z5ZuG
         B7r3ZcSDTGQT6H4aJfdqG3GifThGfH6+IC5sjqP9CK0+2dLKVzlsoUA5GS/zSdr59iXt
         kM1E+dcJ7ZqUjF1vZUbxlI5Hi6aAMiENQR+FRYGNZ2Va+PPnEeM4mRIjiBaN6PdNpmtr
         5ZtLA+p3/epAeV9qH8KT4FKFsfWhUbiGA2efJoskTFIr10rRI6+p2JgijW6s3BNgQvrs
         vjiCjcAN+dAQ4815vRTfGvRvn/bIWYE7stkWMmdFx3YxwmkPHScC3VYqcxXR58DB+Mqu
         3PeA==
X-Gm-Message-State: AC+VfDwVZBHdogZ6/GHFEiW+RUv2sYFcbc5UEHFlfYjhEwO4zDgIuiAY
        H+ogAASBxYhUgnMcIxfngrQaq0JbslHpLeIfKWftihqMTevIB6pZnmlIoW0hUJwqZ07XSsIp+G+
        jxSwXFk6WAfKKMjgbdK9Ckg==
X-Received: by 2002:a92:d3c3:0:b0:329:43f0:1570 with SMTP id c3-20020a92d3c3000000b0032943f01570mr1980494ilh.23.1682620326426;
        Thu, 27 Apr 2023 11:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZjtNj+NU5UefOIsxARLgAXnZyiFoLNkWt/mynkGIjXDEBZIDUWBFQOZkzcIK9k2Lxdx+w+g==
X-Received: by 2002:a92:d3c3:0:b0:329:43f0:1570 with SMTP id c3-20020a92d3c3000000b0032943f01570mr1980473ilh.23.1682620326188;
        Thu, 27 Apr 2023 11:32:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a20-20020a027354000000b004090c67f155sm5693305jae.91.2023.04.27.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:32:05 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:32:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 2/9] vfio-iommufd: Create iommufd_access for noiommu
 devices
Message-ID: <20230427123203.22307c4f.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB752972AC1A6030CB442ACF3FC36A9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230426145419.450922-1-yi.l.liu@intel.com>
        <20230426145419.450922-3-yi.l.liu@intel.com>
        <BN9PR11MB52768AF474FAB2AF36AC00508C6A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB752972AC1A6030CB442ACF3FC36A9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 27 Apr 2023 06:59:17 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Thursday, April 27, 2023 2:39 PM
> >   
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Wednesday, April 26, 2023 10:54 PM
> > > @@ -121,7 +128,8 @@ static void vfio_emulated_unmap(void *data,
> > > unsigned long iova,
> > >  {
> > >  	struct vfio_device *vdev = data;
> > >
> > > -	if (vdev->ops->dma_unmap)
> > > +	/* noiommu devices cannot do map/unmap */
> > > +	if (vdev->noiommu && vdev->ops->dma_unmap)
> > >  		vdev->ops->dma_unmap(vdev, iova, length);  
> > 
> > Is it necessary? All mdev devices implementing @dma_unmap won't
> > set noiommu flag.  
> 
> Hmmm. Yes, and all the devices set noiommu is not implementing @dma_unmap
> as far as I see. Maybe this noiommu check can be removed.

Not to mention that the polarity of the noiommu test is backwards here!
This also seems to be the only performance path where noiommu is tested
and therefore I believe the only actual justification of the previous
patch.
 
> > Instead in the future if we allow noiommu userspace to pin pages
> > we'd need similar logic too.  
> 
> I'm not quite sure about it so far. For mdev devices, the device driver
> may use vfio_pin_pages/vfio_dma_rw () to pin page. Hence such drivers
> need to listen to dma_unmap() event. But for noiommu users, does the
> device driver also participate in the page pin? At least for vfio-pci driver,
> it does not, or maybe it will in the future when enabling noiommu
> userspace to pin pages. It looks to me such userspace should order
> the DMA before calling ioctl to unpin page instead of letting device
> driver listen to unmap.

Whoa, noiommu is inherently unsafe an only meant to expose the vfio
device interface for userspace drivers that are going to do unsafe
things regardless.  Enabling noiommu to work with mdev, pin pages, or
anything else should not be on our agenda.  Userspaces relying on niommu
get the minimum viable interface and must impose a minuscule
incremental maintenance burden.  The only reason we're spending so much
effort on it here is to make iommufd noiommu support equivalent to
group/container noiommu support.  We should stop at that.  Thanks,

Alex

