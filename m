Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6001FC77B73
	for <linux-s390@archiver.kernel.org>; Wed, 24 May 2023 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjEXPcj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 May 2023 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjEXPci (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 May 2023 11:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885A99
        for <linux-s390@vger.kernel.org>; Wed, 24 May 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684942309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvdaBvxVvgbIEoVnHfDqGdU+6IOYKpfr6BkQPhMy2q4=;
        b=SwHVd9ePwb6TToLsFJBMxkXGEMP9lYkCaCbN+ohsHM4FLMhH+vYBC4ob7nG+6JxF35MOmg
        LW0S56iOeme5VcnxclyNtCnY/nTpOq8utJuTQxEGAZVv4AC8k+6EOrh4REgGKETazGxceI
        iAsoQCFGSOHBMZtjFdzMceMV6exuM0M=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-7QSSLBZUMaimsaz3ddTNGg-1; Wed, 24 May 2023 11:31:46 -0400
X-MC-Unique: 7QSSLBZUMaimsaz3ddTNGg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-335a27baefbso5763435ab.3
        for <linux-s390@vger.kernel.org>; Wed, 24 May 2023 08:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942305; x=1687534305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvdaBvxVvgbIEoVnHfDqGdU+6IOYKpfr6BkQPhMy2q4=;
        b=fhE4wlyFKRbJ4PNQ6EKQKqlhZyBF+7Bw0+GazFlgoLc2GzCTZZsWTkWUvWeISsHoI9
         ZMrbUPvuzoyHHa0D6mnUMBQfDo/LsyXfxZBc9yk4vuuIv3kygkRnp+Y905cf1yinDXXu
         EVBoHUpNFdyURF+aBQapKCtTb1ZGyIOSD+h5QRDDYsDUwm7Bd154bVdxNKDHY3040sDB
         Sv9FgPFexYF6CeefoUVeQgpI/uG2JrzfVCpQEU+tHy6HoqPa9goAF1A2NuyLiVHWDOLJ
         YIMD/5i/JcnJ5uQ+s30CRvJ90JtBem2GTN10KKXTb5nBys9yrhilwpN8QZzIlOpvZH0+
         TcIA==
X-Gm-Message-State: AC+VfDxmYJfsujluGY3LUePpJZsEATeU/HmB0T8z4i9MqKknxE9seF6n
        Vm/AkPVzgHpY4oXB/Ln2urlm5djNuk15gyi8aYmlTSM9Rwb3t9JPH6Kk2HUSIZbG9Ce6+gtXjJ9
        zGog3rRt5Ic65zeohdyZ+RQ==
X-Received: by 2002:a92:c907:0:b0:32b:2884:667d with SMTP id t7-20020a92c907000000b0032b2884667dmr4338079ilp.7.1684942305647;
        Wed, 24 May 2023 08:31:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cy4JMLj0bwMPsJjsNyex61B0gji72MRQyMprj4D6oX0LlHGIbVejgmylTAcQIeRDEmquiBA==
X-Received: by 2002:a92:c907:0:b0:32b:2884:667d with SMTP id t7-20020a92c907000000b0032b2884667dmr4338057ilp.7.1684942305320;
        Wed, 24 May 2023 08:31:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02068300b0033079f435f7sm3133927ils.65.2023.05.24.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:31:44 -0700 (PDT)
Date:   Wed, 24 May 2023 09:31:42 -0600
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
Subject: Re: [PATCH v11 20/23] vfio: Add VFIO_DEVICE_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20230524093142.3cac798e.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75292161F081F27C0650EFB3C3419@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230513132827.39066-1-yi.l.liu@intel.com>
        <20230513132827.39066-21-yi.l.liu@intel.com>
        <20230522161534.32f3bf8e.alex.williamson@redhat.com>
        <DS0PR11MB7529096D1BE1D337BA50884BC3409@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230523095025.1898297c.alex.williamson@redhat.com>
        <DS0PR11MB75292161F081F27C0650EFB3C3419@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 24 May 2023 02:12:14 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, May 23, 2023 11:50 PM
> > 
> > On Tue, 23 May 2023 01:20:17 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Tuesday, May 23, 2023 6:16 AM
> > > >
> > > > On Sat, 13 May 2023 06:28:24 -0700
> > > > Yi Liu <yi.l.liu@intel.com> wrote:
> > > >  
> > > > > This adds ioctl for userspace to attach device cdev fd to and detach
> > > > > from IOAS/hw_pagetable managed by iommufd.
> > > > >
> > > > >     VFIO_DEVICE_ATTACH_IOMMUFD_PT: attach vfio device to IOAS, hw_pagetable
> > > > > 				   managed by iommufd. Attach can be
> > > > > 				   undo by VFIO_DEVICE_DETACH_IOMMUFD_PT
> > > > > 				   or device fd close.
> > > > >     VFIO_DEVICE_DETACH_IOMMUFD_PT: detach vfio device from the current  
> > attached  
> > > > > 				   IOAS or hw_pagetable managed by iommufd.
> > > > >
> > > > > Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> > > > > Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > > ---
> > > > >  drivers/vfio/device_cdev.c | 66 ++++++++++++++++++++++++++++++++++++++
> > > > >  drivers/vfio/iommufd.c     | 18 +++++++++++
> > > > >  drivers/vfio/vfio.h        | 18 +++++++++++
> > > > >  drivers/vfio/vfio_main.c   |  8 +++++
> > > > >  include/uapi/linux/vfio.h  | 52 ++++++++++++++++++++++++++++++
> > > > >  5 files changed, 162 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> > > > > index 291cc678a18b..3f14edb80a93 100644
> > > > > --- a/drivers/vfio/device_cdev.c
> > > > > +++ b/drivers/vfio/device_cdev.c
> > > > > @@ -174,6 +174,72 @@ long vfio_device_ioctl_bind_iommufd(struct  
> > vfio_device_file  
> > > > *df,  
> > > > >  	return ret;
> > > > >  }
> > > > >
> > > > > +int vfio_ioctl_device_attach(struct vfio_device_file *df,
> > > > > +			     struct vfio_device_attach_iommufd_pt __user *arg)
> > > > > +{
> > > > > +	struct vfio_device *device = df->device;
> > > > > +	struct vfio_device_attach_iommufd_pt attach;
> > > > > +	unsigned long minsz;
> > > > > +	int ret;
> > > > > +
> > > > > +	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
> > > > > +
> > > > > +	if (copy_from_user(&attach, arg, minsz))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	if (attach.argsz < minsz || attach.flags)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/* ATTACH only allowed for cdev fds */
> > > > > +	if (df->group)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	mutex_lock(&device->dev_set->lock);
> > > > > +	ret = vfio_iommufd_attach(device, &attach.pt_id);
> > > > > +	if (ret)
> > > > > +		goto out_unlock;
> > > > > +
> > > > > +	ret = copy_to_user(&arg->pt_id, &attach.pt_id,
> > > > > +			   sizeof(attach.pt_id)) ? -EFAULT : 0;
> > > > > +	if (ret)
> > > > > +		goto out_detach;
> > > > > +	mutex_unlock(&device->dev_set->lock);
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +out_detach:
> > > > > +	vfio_iommufd_detach(device);
> > > > > +out_unlock:
> > > > > +	mutex_unlock(&device->dev_set->lock);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +int vfio_ioctl_device_detach(struct vfio_device_file *df,
> > > > > +			     struct vfio_device_detach_iommufd_pt __user *arg)
> > > > > +{
> > > > > +	struct vfio_device *device = df->device;
> > > > > +	struct vfio_device_detach_iommufd_pt detach;
> > > > > +	unsigned long minsz;
> > > > > +
> > > > > +	minsz = offsetofend(struct vfio_device_detach_iommufd_pt, flags);
> > > > > +
> > > > > +	if (copy_from_user(&detach, arg, minsz))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	if (detach.argsz < minsz || detach.flags)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/* DETACH only allowed for cdev fds */
> > > > > +	if (df->group)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	mutex_lock(&device->dev_set->lock);
> > > > > +	vfio_iommufd_detach(device);
> > > > > +	mutex_unlock(&device->dev_set->lock);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
> > > > >  {
> > > > >  	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> > > > > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > > > > index 83575b65ea01..799ea322a7d4 100644
> > > > > --- a/drivers/vfio/iommufd.c
> > > > > +++ b/drivers/vfio/iommufd.c
> > > > > @@ -112,6 +112,24 @@ void vfio_iommufd_unbind(struct vfio_device_file *df)
> > > > >  		vdev->ops->unbind_iommufd(vdev);
> > > > >  }
> > > > >
> > > > > +int vfio_iommufd_attach(struct vfio_device *vdev, u32 *pt_id)
> > > > > +{
> > > > > +	lockdep_assert_held(&vdev->dev_set->lock);
> > > > > +
> > > > > +	if (vfio_device_is_noiommu(vdev))
> > > > > +		return 0;  
> > > >
> > > > Isn't this an invalid operation for a noiommu cdev, ie. -EINVAL?  We
> > > > return success and copy back the provided pt_id, why would a user not
> > > > consider it a bug that they can't use whatever value was there with
> > > > iommufd?  
> > >
> > > Yes, this is the question I asked in [1]. At that time, it appears to me
> > > that better to allow it [2]. Maybe it's more suitable to ask it here.  
> > 
> > From an API perspective it seems wrong.  We return success without
> > doing anything.  A user would be right to consider it a bug that the
> > attach operation works but there's not actually any association to the
> > IOAS.  Thanks,  
> 
> The current version is kind of tradeoff based on prior remarks when
> I asked the question. As prior comment[2], it appears to me the attach
> shall success for noiommu devices as well, but per your remark it seems
> not in plan. So anyway, we may just fail the attach/detach for noiommu
> devices. Is it?

If a user creates an ioas within an iommufd, attaches a device to that
ioas and populates it with mappings, wouldn't the user expect the
device to have access to and honor those mappings?  I think that's the
path we're headed down if we report a successful attach of a noiommu
device to an ioas.

We need to keep in mind that noiommu was meant to be a minimally
intrusive mechanism to provide a dummy vfio IOMMU backend and satisfy
the group requirements, solely for the purpose of making use of the
vfio device interface and without providing any DMA mapping services or
expectations.  IMO, an argument that we need the attach op to succeed in
order to avoid too much disruption in userspace code is nonsense.  On
the contrary, userspace needs to be very aware of this difference and
we shouldn't invest effort trying to make noiommu more convenient to
use.  It's inherently unsafe.

I'm not fond of what a mess noiommu has become with cdev, we're well
beyond the minimal code trickery of the legacy implementation.  I hate
to ask, but could we reiterate our requirements for noiommu as a part of
the native iommufd interface for vfio?  The nested userspace requirement
is gone now that hypervisors have vIOMMU support, so my assumption is
that this is only for bare metal systems without an IOMMU, which
ideally are less and less prevalent.  Are there any noiommu userspaces
that are actually going to adopt the noiommu cdev interface?  What
terrible things happen if noiommu only exists in the vfio group compat
interface to iommufd and at some distant point in the future dies when
that gets disabled?

> btw. Should we document it somewhere as well? E.g. noiommu userspace
> does not support attach/detach? Userspace should know it is opening
> noiommu devices.

Documentation never hurts.  This is such a specialized use case I'm not
sure we've bothered to do much documentation for noiommu previously.
Thanks,

Alex

