Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4536AEB64D0
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 14:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjFMOZM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjFMOZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 10:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4C128
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686666273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uNaTTX2jpfAAP/LJoW3TLJvil6qu1dd8mTfnU5F8em0=;
        b=Q8oVyZv87ec/kdtpyS0v9pUu7ugUnln9IyWdA9AlbXwHNZB20RYmZ/In2lzUNQqRcxxpX6
        vHbZrTlmKbTcGztGwq3g4P/0wXLf+0EMZ1D8UbIRzvwrD4RcmOtLZy33av2oEb7zB/ff0g
        Pxu/phordQPCvLtrkbxa52WbTwgawKw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-jce_y_RMMhy81RfALHs_7g-1; Tue, 13 Jun 2023 10:24:32 -0400
X-MC-Unique: jce_y_RMMhy81RfALHs_7g-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-33b7a468d14so59691955ab.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666270; x=1689258270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNaTTX2jpfAAP/LJoW3TLJvil6qu1dd8mTfnU5F8em0=;
        b=L3lCRc9fd4GfLl5tIACjjVyHRAGZoiFUxiJjWJHc98k4zKyecm/DIu2jUkaqfWH70K
         sIegFHmp3AH0K+ve6FIERZvm97MK06jSbCcIZPcCH3mMSZG8mIgIXdAN6JX2DRZs5Deg
         hlisjgLuk0n8DdRNJ4C0ZAqbwSGLJlrI++WW6+/lZXkJRmyNp7sObtgZbJ/IBidtFniO
         PEpZFUNIQ1I10R/IERs9Mq0nD9u1ZgX5tUI7RAnod+TKcVvzBxuNLKaD2c1BzJV8ZjUu
         ZGdmJC5shPPkRsbIu7EHVKL6I8OQoIdPRgUknp9cLaQpUlfq6LDYkGTnUn0cHon9MAro
         tIBw==
X-Gm-Message-State: AC+VfDzQTcx4gHsfSBwSHPW57DUSxOAGJnLR8SJM8mc3Pef8WeVmA0q0
        zd5iDZ9xpO3P6QJdaYHSa4NZUKSFj6cinbVDaPtMgpjtQp7jOfakMBq+QiAqplmSlsHbQ4U5syL
        iCwCOwXqTLx5O5gGWU2HnBA==
X-Received: by 2002:a92:d7cd:0:b0:32b:5e:e22a with SMTP id g13-20020a92d7cd000000b0032b005ee22amr10786001ilq.17.1686666269815;
        Tue, 13 Jun 2023 07:24:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KU1E6AFjVveX2o9hXRzGdCkKtng9KR4tZYBJtO5BSqSOb3FWAM0AzE8jKPCez7h5MNkFahQ==
X-Received: by 2002:a92:d7cd:0:b0:32b:5e:e22a with SMTP id g13-20020a92d7cd000000b0032b005ee22amr10785970ilq.17.1686666269583;
        Tue, 13 Jun 2023 07:24:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056638293800b0041658c1838asm3436802jab.81.2023.06.13.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:24:29 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:24:27 -0600
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
Subject: Re: [PATCH v12 24/24] docs: vfio: Add vfio device cdev description
Message-ID: <20230613082427.453748f5.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529B0A71849EA06DA953BBCC355A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-25-yi.l.liu@intel.com>
        <20230612170628.661ab2a6.alex.williamson@redhat.com>
        <DS0PR11MB7529B0A71849EA06DA953BBCC355A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 12:01:51 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, June 13, 2023 7:06 AM
> > 
> > On Fri,  2 Jun 2023 05:16:53 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> > > This gives notes for userspace applications on device cdev usage.
> > >
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  Documentation/driver-api/vfio.rst | 132 ++++++++++++++++++++++++++++++
> > >  1 file changed, 132 insertions(+)
> > >
> > > diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> > > index 363e12c90b87..f00c9b86bda0 100644
> > > --- a/Documentation/driver-api/vfio.rst
> > > +++ b/Documentation/driver-api/vfio.rst
> > > @@ -239,6 +239,130 @@ group and can access them as follows::
> > >  	/* Gratuitous device reset and go... */
> > >  	ioctl(device, VFIO_DEVICE_RESET);
> > >
> > > +IOMMUFD and vfio_iommu_type1
> > > +----------------------------
> > > +
> > > +IOMMUFD is the new user API to manage I/O page tables from userspace.
> > > +It intends to be the portal of delivering advanced userspace DMA
> > > +features (nested translation [5]_, PASID [6]_, etc.) while also providing
> > > +a backwards compatibility interface for existing VFIO_TYPE1v2_IOMMU use
> > > +cases.  Eventually the vfio_iommu_type1 driver, as well as the legacy
> > > +vfio container and group model is intended to be deprecated.
> > > +
> > > +The IOMMUFD backwards compatibility interface can be enabled two ways.
> > > +In the first method, the kernel can be configured with
> > > +CONFIG_IOMMUFD_VFIO_CONTAINER, in which case the IOMMUFD subsystem
> > > +transparently provides the entire infrastructure for the VFIO
> > > +container and IOMMU backend interfaces.  The compatibility mode can
> > > +also be accessed if the VFIO container interface, ie. /dev/vfio/vfio is
> > > +simply symlink'd to /dev/iommu.  Note that at the time of writing, the
> > > +compatibility mode is not entirely feature complete relative to
> > > +VFIO_TYPE1v2_IOMMU (ex. DMA mapping MMIO) and does not attempt to
> > > +provide compatibility to the VFIO_SPAPR_TCE_IOMMU interface.  Therefore
> > > +it is not generally advisable at this time to switch from native VFIO
> > > +implementations to the IOMMUFD compatibility interfaces.
> > > +
> > > +Long term, VFIO users should migrate to device access through the cdev
> > > +interface described below, and native access through the IOMMUFD
> > > +provided interfaces.
> > > +
> > > +VFIO Device cdev
> > > +----------------
> > > +
> > > +Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> > > +in a VFIO group.
> > > +
> > > +With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
> > > +by directly opening a character device /dev/vfio/devices/vfioX where
> > > +"X" is the number allocated uniquely by VFIO for registered devices.
> > > +cdev interface does not support noiommu, so user should use the legacy
> > > +group interface if noiommu is needed.
> > > +
> > > +The cdev only works with IOMMUFD.  Both VFIO drivers and applications
> > > +must adapt to the new cdev security model which requires using
> > > +VFIO_DEVICE_BIND_IOMMUFD to claim DMA ownership before starting to
> > > +actually use the device.  Once BIND succeeds then a VFIO device can
> > > +be fully accessed by the user.
> > > +
> > > +VFIO device cdev doesn't rely on VFIO group/container/iommu drivers.
> > > +Hence those modules can be fully compiled out in an environment
> > > +where no legacy VFIO application exists.
> > > +
> > > +So far SPAPR does not support IOMMUFD yet.  So it cannot support device
> > > +cdev neither.  
> > 
> > s/neither/either/  
> 
> Got it.
> 
> > 
> > Unless I missed it, we've not described that vfio device cdev access is
> > still bound by IOMMU group semantics, ie. there can be one DMA owner
> > for the group.  That's a pretty common failure point for multi-function
> > consumer device use cases, so the why, where, and how it fails should
> > be well covered.  
> 
> Yes. this needs to be documented. How about below words:
> 
> vfio device cdev access is still bound by IOMMU group semantics, ie. there
> can be only one DMA owner for the group.  Devices belonging to the same
> group can not be bound to multiple iommufd_ctx.

... or shared between native kernel and vfio drivers.


>  The users that try to bind
> such device to different iommufd shall be failed in VFIO_DEVICE_BIND_IOMMUFD
> which is the start point to get full access for the device.

"A violation of this ownership requirement will fail at the
VFIO_DEVICE_BIND_IOMMUFD ioctl, which gates full device access."

Thanks,
Alex

