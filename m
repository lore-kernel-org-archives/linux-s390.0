Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B013FC76196
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 17:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCaRuy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCaRuw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 13:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0AA72B3
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680284995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2hw7lrP24KFanzOvV8I/Ad+4zEqFeH3Txo9b1cjHps=;
        b=bFWjOIR1njXWS+tbW+TFkNjI5sG+w6J+ceZdnqlsidZ+BL1weugLiBkwKxzgn4mVpmKr53
        ln47q0tNxTSq+xhaH2IsS1Ej7f+JEu4IIgjUS4Rl8YXXxvctmDZiwEn9zI7YjpX3gPgrEl
        xOZvtvH9H9uGiiGMJzK5wZblAENgxpc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-sgVGkmCGMyiBJpifsvtr_w-1; Fri, 31 Mar 2023 13:49:53 -0400
X-MC-Unique: sgVGkmCGMyiBJpifsvtr_w-1
Received: by mail-il1-f197.google.com with SMTP id o8-20020a056e0214c800b00325f0a48812so12325699ilk.13
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 10:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284993;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2hw7lrP24KFanzOvV8I/Ad+4zEqFeH3Txo9b1cjHps=;
        b=oOiZzpEG4t2vR+HFG1J6N6Nu+158hGEg5nYQshf6MY/A3WDCEtARCu1b17TxKi5fTB
         RDpuC5YRnVJ2UJUQCdv7BhhjnZl1sFXqDNqy6HDUgdL4JMJy+o8wITS2LidCRH3xqSKM
         9OsI8TWBSVMtf6pqeb8v36wB61QTwZZ+ppb5jsv70Rk66oce25cOnw6vdWmx0BcSkh1A
         MXFV23FZVcxsCDtIVGKBGparpwuwjjXgDsXdrypDuuy1UE3rNDKd6Wg72/9xAuz3L6bj
         HTsc1JQSsvLXeLRn6MeD2cq8iQbTa4qBAMeLDIIw5tNhdGZIVzr9i/obNTXhRH6ynwBQ
         z1fw==
X-Gm-Message-State: AO0yUKXWBdZQ4ykreqPpMKZWFyWcPU2+aJvhKUpk0bKPHf9jVAeurot9
        vDd2ikJxCRgbxLl98sWDwwMU1+Zx9ESNWXe/IIjwmdWGw6mKmQ1ysIBMAn1nuaoOKrPmhHnHai+
        NVw7dyj0TaIPZlZwN3SqWZw==
X-Received: by 2002:a6b:d911:0:b0:759:706d:a0b2 with SMTP id r17-20020a6bd911000000b00759706da0b2mr18805416ioc.13.1680284992833;
        Fri, 31 Mar 2023 10:49:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set+DPRg+uCCuz/U6HNYYJj0QRQjzjZLhse/nHV02SSaPBWJ2hWNldvvYAEt97qV6PiOkx5PxfQ==
X-Received: by 2002:a6b:d911:0:b0:759:706d:a0b2 with SMTP id r17-20020a6bd911000000b00759706da0b2mr18805391ioc.13.1680284992497;
        Fri, 31 Mar 2023 10:49:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c11-20020a5ea80b000000b0075ba6593512sm681396ioa.53.2023.03.31.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:49:51 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:49:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Xu, Terrence" <terrence.xu@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v2 00/10] Introduce new methods for verifying ownership
 in vfio PCI hot reset
Message-ID: <20230331114949.3dfec232.alex.williamson@redhat.com>
In-Reply-To: <BL3PR11MB64830DC9AC0517B56667532DF08F9@BL3PR11MB6483.namprd11.prod.outlook.com>
References: <20230327093458.44939-1-yi.l.liu@intel.com>
        <BL3PR11MB64830DC9AC0517B56667532DF08F9@BL3PR11MB6483.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 31 Mar 2023 17:27:27 +0000
"Xu, Terrence" <terrence.xu@intel.com> wrote:

> > -----Original Message-----
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, March 27, 2023 5:35 PM
> > 
> > VFIO_DEVICE_PCI_HOT_RESET requires user to pass an array of group fds to
> > prove that it owns all devices affected by resetting the calling device. This
> > series introduces several extensions to allow the ownership check better
> > aligned with iommufd and coming vfio device cdev support.
> > 
> > First, resetting an unopened device is always safe given nobody is using it. So
> > relax the check to allow such devices not covered by group fd array. [1]
> > 
> > When iommufd is used we can simply verify that all affected devices are
> > bound to a same iommufd then no need for the user to provide extra fd
> > information. This is enabled by the user passing a zero-length fd array and
> > moving forward this should be the preferred way for hot reset. [2]
> > 
> > However the iommufd method has difficulty working with noiommu devices
> > since those devices don't have a valid iommufd, unless the noiommu device
> > is in a singleton dev_set hence no ownership check is required. [3]
> > 
> > For noiommu backward compatibility a 3rd method is introduced by allowing
> > the user to pass an array of device fds to prove ownership. [4]
> > 
> > As suggested by Jason [5], we have this series to introduce the above stuffs
> > to the vfio PCI hot reset. Per the dicussion in [6], this series also adds a new
> > _INFO ioctl to get hot reset scope for given device.
> > 
> > [1] https://lore.kernel.org/kvm/Y%2FdobS6gdSkxnPH7@nvidia.com/
> > [2] https://lore.kernel.org/kvm/Y%2FZOOClu8nXy2toX@nvidia.com/#t
> > [3] https://lore.kernel.org/kvm/ZACX+Np%2FIY7ygqL5@nvidia.com/
> > [4]
> > https://lore.kernel.org/kvm/DS0PR11MB7529BE88460582BD599DC1F7C3B19
> > @DS0PR11MB7529.namprd11.prod.outlook.com/#t
> > [5] https://lore.kernel.org/kvm/ZAcvzvhkt9QhCmdi@nvidia.com/
> > [6] https://lore.kernel.org/kvm/ZBoYgNq60eDpV9Un@nvidia.com/
> > 
> > Change log:
> > 
> > v2:
> >  - Split the patch 03 of v1 to be 03, 04 and 05 of v2 (Jaon)
> >  - Add r-b from Kevin and Jason
> >  - Add patch 10 to introduce a new _INFO ioctl for the usage of device
> >    fd passing usage in cdev path (Jason, Alex)
> > 
> > v1: https://lore.kernel.org/kvm/20230316124156.12064-1-yi.l.liu@intel.com/
> > 
> > Regards,
> > 	Yi Liu
> > 
> > Yi Liu (10):
> >   vfio/pci: Update comment around group_fd get in
> >     vfio_pci_ioctl_pci_hot_reset()
> >   vfio/pci: Only check ownership of opened devices in hot reset
> >   vfio/pci: Move the existing hot reset logic to be a helper
> >   vfio-iommufd: Add helper to retrieve iommufd_ctx and devid for
> >     vfio_device
> >   vfio/pci: Allow passing zero-length fd array in
> >     VFIO_DEVICE_PCI_HOT_RESET
> >   vfio: Refine vfio file kAPIs for vfio PCI hot reset
> >   vfio: Accpet device file from vfio PCI hot reset path
> >   vfio/pci: Renaming for accepting device fd in hot reset path
> >   vfio/pci: Accept device fd in VFIO_DEVICE_PCI_HOT_RESET ioctl
> >   vfio/pci: Add VFIO_DEVICE_GET_PCI_HOT_RESET_GROUP_INFO
> > 
> >  drivers/iommu/iommufd/device.c   |  12 ++
> >  drivers/vfio/group.c             |  32 ++--
> >  drivers/vfio/iommufd.c           |  16 ++
> >  drivers/vfio/pci/vfio_pci_core.c | 244 ++++++++++++++++++++++++-------
> >  drivers/vfio/vfio.h              |   2 +
> >  drivers/vfio/vfio_main.c         |  44 ++++++
> >  include/linux/iommufd.h          |   3 +
> >  include/linux/vfio.h             |  14 ++
> >  include/uapi/linux/vfio.h        |  65 +++++++-
> >  9 files changed, 364 insertions(+), 68 deletions(-)
> > 
> > --
> > 2.34.1  
> 
> Verified this series by "Intel GVT-g GPU device mediated passthrough".
> Passed VFIO legacy mode / compat mode / cdev mode basic functionality and GPU force reset test.
> 
> Tested-by: Terrence Xu <terrence.xu@intel.com>

Seems like only this "GPU force reset test" is relevant to the new
functionality of this series, GVT-g does not and has no reason to
support the HOT_RESET ioctls used here.  Can you provide more details
of the force-reset test?  What userspace driver is being used?  Thanks,

Alex

