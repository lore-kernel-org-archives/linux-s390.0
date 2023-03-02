Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA25C6FA8E
	for <linux-s390@archiver.kernel.org>; Thu,  2 Mar 2023 21:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCBVFh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Mar 2023 16:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCBVFg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Mar 2023 16:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92B17CD8
        for <linux-s390@vger.kernel.org>; Thu,  2 Mar 2023 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677791092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdnbjlV/XNQ2xABD+7i8aLqQ6C5aoh9/k3+KKrPoC4Q=;
        b=Gw6fqBWZ1XtD7f6JEmmLfvS/1IvduqRQmZ1uZ1tmK5bnITj4TX6ZmD47CmaMrkgiCEbM2y
        ErXUj/wW/rfRXyTsE2Jt6fFRc0m9sR4GZyDajKfbWlxdN1r/CBRcdUy1tfi2OnhhuKCT+r
        dp63OHylAwd9le0uMl0zcVTzoI7ohe0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-pmQlQBF-NJiR7CVU2JvTwg-1; Thu, 02 Mar 2023 16:04:51 -0500
X-MC-Unique: pmQlQBF-NJiR7CVU2JvTwg-1
Received: by mail-io1-f72.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso222957ior.10
        for <linux-s390@vger.kernel.org>; Thu, 02 Mar 2023 13:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdnbjlV/XNQ2xABD+7i8aLqQ6C5aoh9/k3+KKrPoC4Q=;
        b=kNMJnJWraWbhTrlvclsPYdZM8OOJGHGL18Q8+M0WhiOBX6xz/l1el0z58AbqC8Eibu
         zOFg3qmHC4UAdv8Mix5hlDDfebdojF1dX8xQR4s7rF71PJsLIrwglCIn/XAXgjCK+db5
         gfXKH9hiwNSwX9AlCqu7a7Ibi4xNgAFSBxFa9ZFp9IwLOsajRK/h2/ZiXu6zAdcjDV3O
         eabf8CulNh9RyVEuT/OQG4KylPKGK/OUna0xt79VfOE53M6Bs31nLjtJrOfNaVWCf5VI
         N1XhPruIsJOMKrhd5J1p6oB2gdYFLu6n/zhGIVrPIiOoezz04JqdDuT+cNsApZip741r
         8Phw==
X-Gm-Message-State: AO0yUKX4dRra429c1wTigkbr4sPceJLoUWExwCYfF+bAHbWptNDJfwqe
        m373fFWoREq+mH+eOyAWaHmZx9C3M8ZJmZbuaqxSIia/yGPdrhVMSbHk3jM71JYcUoRgx1z0Udn
        DqlFCwmTbfIsh54HB7cvIBw==
X-Received: by 2002:a05:6e02:20e4:b0:317:3f4:c06c with SMTP id q4-20020a056e0220e400b0031703f4c06cmr7773623ilv.20.1677791090656;
        Thu, 02 Mar 2023 13:04:50 -0800 (PST)
X-Google-Smtp-Source: AK7set94uChKRWLMdqu/Ih+nuSAZEd1Mmf7EHZCWSlCtEFZv1sWj3peN/v4x5tVoV8vEfvWV2G/sUA==
X-Received: by 2002:a05:6e02:20e4:b0:317:3f4:c06c with SMTP id q4-20020a056e0220e400b0031703f4c06cmr7773607ilv.20.1677791090355;
        Thu, 02 Mar 2023 13:04:50 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u2-20020a92da82000000b00313ca4be5e1sm109451iln.12.2023.03.02.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:04:49 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:04:48 -0700
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
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v5 09/19] vfio/pci: Allow passing zero-length fd array
 in VFIO_DEVICE_PCI_HOT_RESET
Message-ID: <20230302140448.5a6a748a.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75295B4B2578765C8B08AC7EC3B29@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230227111135.61728-1-yi.l.liu@intel.com>
        <20230227111135.61728-10-yi.l.liu@intel.com>
        <DS0PR11MB75295B4B2578765C8B08AC7EC3B29@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2 Mar 2023 06:07:04 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, February 27, 2023 7:11 PM  
> [...]
> > @@ -2392,13 +2416,25 @@ static int
> > vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
> >  	return ret;
> >  }
> > 
> > +static bool vfio_dev_in_iommufd_ctx(struct vfio_pci_core_device *vdev,
> > +				    struct iommufd_ctx *iommufd_ctx)
> > +{
> > +	struct iommufd_ctx *iommufd = vfio_device_iommufd(&vdev-  
> > >vdev);  
> > +
> > +	if (!iommufd)
> > +		return false;
> > +
> > +	return iommufd == iommufd_ctx;
> > +}
> > +
> >  /*
> >   * We need to get memory_lock for each device, but devices can share
> > mmap_lock,
> >   * therefore we need to zap and hold the vma_lock for each device, and
> > only then
> >   * get each memory_lock.
> >   */
> >  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> > -				      struct vfio_pci_group_info *groups)
> > +				      struct vfio_pci_group_info *groups,
> > +				      struct iommufd_ctx *iommufd_ctx)
> >  {
> >  	struct vfio_pci_core_device *cur_mem;
> >  	struct vfio_pci_core_device *cur_vma;
> > @@ -2429,10 +2465,27 @@ static int vfio_pci_dev_set_hot_reset(struct
> > vfio_device_set *dev_set,
> > 
> >  	list_for_each_entry(cur_vma, &dev_set->device_list,
> > vdev.dev_set_list) {
> >  		/*
> > -		 * Test whether all the affected devices are contained by
> > the
> > -		 * set of groups provided by the user.
> > +		 * Test whether all the affected devices can be reset by the
> > +		 * user.  The affected devices may already been opened or
> > not
> > +		 * yet.
> > +		 *
> > +		 * For the devices not opened yet, user can reset them. The
> > +		 * reason is that the hot reset is done under the protection
> > +		 * of the dev_set->lock, and device open is also under this
> > +		 * lock.  During the hot reset, such devices can not be
> > opened
> > +		 * by other users.
> > +		 *
> > +		 * For the devices that have been opened, needs to check
> > the
> > +		 * ownership.  If the user provides a set of group fds, the
> > +		 * ownership check is done by checking if all the opened
> > +		 * devices are contained by the groups.  If the user provides
> > +		 * a zero-length fd array, the ownerhsip check is done by
> > +		 * checking if all the opened devices are bound to the same
> > +		 * iommufd_ctx.
> >  		 */
> > -		if (!vfio_dev_in_groups(cur_vma, groups)) {
> > +		if (cur_vma->vdev.open_count &&
> > +		    !vfio_dev_in_groups(cur_vma, groups) &&
> > +		    !vfio_dev_in_iommufd_ctx(cur_vma, iommufd_ctx)) {  
> 
> Hi Alex, Jason,
> 
> There is one concern on this approach which is related to the
> cdev noiommu mode. As patch 16 of this series, cdev path
> supports noiommu mode by passing a negative iommufd to
> kernel. In such case, the vfio_device is not bound to a valid
> iommufd. Then the check in vfio_dev_in_iommufd_ctx() is
> to be broken.
> 
> An idea is to add a cdev_noiommu flag in vfio_device, when
> checking the iommufd_ictx, also check this flag. If all the opened
> devices in the dev_set have vfio_device->cdev_noiommu==true,
> then the reset is considered to be doable. But there is a special
> case. If devices in this dev_set are opened by two applications
> that operates in cdev noiommu mode, then this logic is not able
> to differentiate them. In that case, should we allow the reset?
> It seems to ok to allow reset since noiommu mode itself means
> no security between the applications that use it. thoughts?

I don't think the existing vulnerabilities of no-iommu mode should be
carte blanche to add additional weaknesses.  Thanks,

Alex

