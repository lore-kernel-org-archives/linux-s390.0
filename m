Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C8C761AF
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjDDVtr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbjDDVtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 17:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6CC2710
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680644939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMOmz/hCD9hq0xa7lEyqqxxsKm/tr2tmPnHhHb56dRc=;
        b=SEFzv/igxPOfzMcw2rWYgw5O8d+/rVxEMORSy/vNHOdnrhh8LcsMwJPc+n0YaF6ng1QMVN
        URisvlmVEPTF/hUgrVmGq+oiEASHjLfWI7WfD1nE48r4uvkONBjI5ilyYwUcdoD3rfufzE
        KcU7t3f+p65tUCGXLPGT4kIQZs/nvw8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-W6iAPHYwPbKebokRzvVjrA-1; Tue, 04 Apr 2023 17:48:57 -0400
X-MC-Unique: W6iAPHYwPbKebokRzvVjrA-1
Received: by mail-io1-f70.google.com with SMTP id 3-20020a6b1403000000b007588213c81aso20985664iou.18
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 14:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMOmz/hCD9hq0xa7lEyqqxxsKm/tr2tmPnHhHb56dRc=;
        b=Jw9T04EOoXty6UUYD+xvdx6tK0cLPLYgXRaXGA5x78B73rcAJyCXTfK5h1dBjQ87LP
         a11oTTH9t4AOD4z/gNh6FVpO3stAqikocRQm8ZJdmJ4MaCqBWjb1eyRTK6yqYhFLXrHt
         LFa8ZwhGkT/DSCUMLzK5P8p1Jr7jSEecNReYkcviAM/1pt23asvpQ9CK6mOL6htC5I2V
         vEFpHU9L9Mes7nMYdL+1TnstQ5gDwOzE2e6hD2PO/+s2zUVk7twSVp2Q1tKSn6yFRMF6
         U0IRjG2hY+/xDNoAcsUK5FcQwNewY/rRvxQm9vBl1YxmEOAYpb3sSYXBxqMSZcoouI7B
         Cxdw==
X-Gm-Message-State: AAQBX9cBFry38yQXyjvk5YPp6vpwpr2qGio6E5RWAJvseIJQQVEy8uC+
        Hu3gJPzUdl6hdvGaG6kpmOR1l1BYE24Bg01vgNIPRBkDGU4wG3FKC9elYotevDaoXfkop2DpWcO
        5yH0nI5a+MvZwcMQ1Jyag4Q==
X-Received: by 2002:a92:dac3:0:b0:325:fb39:8494 with SMTP id o3-20020a92dac3000000b00325fb398494mr3960296ilq.4.1680644937157;
        Tue, 04 Apr 2023 14:48:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8lhguNnSPsqwDGg9DndWThvVQtcWBignwR7e7WGC5/A4W046vPbFQR7NCsx0PzkO+Dv+mIw==
X-Received: by 2002:a92:dac3:0:b0:325:fb39:8494 with SMTP id o3-20020a92dac3000000b00325fb398494mr3960288ilq.4.1680644936898;
        Tue, 04 Apr 2023 14:48:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c13-20020a928e0d000000b00325df6679a7sm3456502ild.26.2023.04.04.14.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:48:55 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:48:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, jgg@nvidia.com, kevin.tian@intel.com,
        joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v3 04/12] vfio-iommufd: Add helper to retrieve
 iommufd_ctx and devid for vfio_device
Message-ID: <20230404154854.4d9a95f0.alex.williamson@redhat.com>
In-Reply-To: <702c2883-1d51-b609-1e99-337295e6e307@redhat.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-5-yi.l.liu@intel.com>
        <702c2883-1d51-b609-1e99-337295e6e307@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 4 Apr 2023 17:28:40 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 4/1/23 16:44, Yi Liu wrote:
> > This is needed by the vfio-pci driver to report affected devices in the
> > hot reset for a given device.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/device.c | 12 ++++++++++++
> >  drivers/vfio/iommufd.c         | 14 ++++++++++++++
> >  include/linux/iommufd.h        |  3 +++
> >  include/linux/vfio.h           | 13 +++++++++++++
> >  4 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 25115d401d8f..04a57aa1ae2c 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -131,6 +131,18 @@ void iommufd_device_unbind(struct iommufd_device *idev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> >  
> > +struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev)
> > +{
> > +	return idev->ictx;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iommufd_device_to_ictx, IOMMUFD);
> > +
> > +u32 iommufd_device_to_id(struct iommufd_device *idev)
> > +{
> > +	return idev->obj.id;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
> > +
> >  static int iommufd_device_setup_msi(struct iommufd_device *idev,
> >  				    struct iommufd_hw_pagetable *hwpt,
> >  				    phys_addr_t sw_msi_start)
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index 88b00c501015..809f2dd73b9e 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -66,6 +66,20 @@ void vfio_iommufd_unbind(struct vfio_device *vdev)
> >  		vdev->ops->unbind_iommufd(vdev);
> >  }
> >  
> > +struct iommufd_ctx *vfio_iommufd_physical_ictx(struct vfio_device *vdev)
> > +{
> > +	if (!vdev->iommufd_device)
> > +		return NULL;
> > +	return iommufd_device_to_ictx(vdev->iommufd_device);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_iommufd_physical_ictx);
> > +
> > +void vfio_iommufd_physical_devid(struct vfio_device *vdev, u32 *id)
> > +{
> > +	if (vdev->iommufd_device)
> > +		*id = iommufd_device_to_id(vdev->iommufd_device);  
> since there is no return value, may be worth to add at least a WARN_ON
> in case of !vdev->iommufd_device

Yeah, this is bizarre and makes the one caller of this interface very
awkward.  We later go on to define IOMMUFD_INVALID_ID, so this should
simply return that in the case of no iommufd_device and skip this
unnecessary pointer passing.  Thanks,

Alex

> > +}
> > +EXPORT_SYMBOL_GPL(vfio_iommufd_physical_devid);
> >  /*
> >   * The physical standard ops mean that the iommufd_device is bound to the
> >   * physical device vdev->dev that was provided to vfio_init_group_dev(). Drivers
> > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> > index 1129a36a74c4..ac96df406833 100644
> > --- a/include/linux/iommufd.h
> > +++ b/include/linux/iommufd.h
> > @@ -24,6 +24,9 @@ void iommufd_device_unbind(struct iommufd_device *idev);
> >  int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
> >  void iommufd_device_detach(struct iommufd_device *idev);
> >  
> > +struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
> > +u32 iommufd_device_to_id(struct iommufd_device *idev);
> > +
> >  struct iommufd_access_ops {
> >  	u8 needs_pin_pages : 1;
> >  	void (*unmap)(void *data, unsigned long iova, unsigned long length);
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 3188d8a374bd..97a1174b922f 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -113,6 +113,8 @@ struct vfio_device_ops {
> >  };
> >  
> >  #if IS_ENABLED(CONFIG_IOMMUFD)
> > +struct iommufd_ctx *vfio_iommufd_physical_ictx(struct vfio_device *vdev);
> > +void vfio_iommufd_physical_devid(struct vfio_device *vdev, u32 *id);
> >  int vfio_iommufd_physical_bind(struct vfio_device *vdev,
> >  			       struct iommufd_ctx *ictx, u32 *out_device_id);
> >  void vfio_iommufd_physical_unbind(struct vfio_device *vdev);
> > @@ -122,6 +124,17 @@ int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
> >  void vfio_iommufd_emulated_unbind(struct vfio_device *vdev);
> >  int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id);
> >  #else
> > +static inline struct iommufd_ctx *
> > +vfio_iommufd_physical_ictx(struct vfio_device *vdev)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void
> > +vfio_iommufd_physical_devid(struct vfio_device *vdev, u32 *id)
> > +{
> > +}
> > +
> >  #define vfio_iommufd_physical_bind                                      \
> >  	((int (*)(struct vfio_device *vdev, struct iommufd_ctx *ictx,   \
> >  		  u32 *out_device_id)) NULL)  
> besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 

