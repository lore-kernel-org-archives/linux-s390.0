Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4029EB64D9
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 14:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbjFMOUT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbjFMOUK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 10:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AABA7
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686665967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7+SABrVLI0amKNwNw1VarYFD9JfcbmTjrTnN+EtSAI=;
        b=EhuyT6Up91g5tNgGtnUMWNaoSji9ytMh+DtKEJp3V0t+UQ3tgnTgVuEbE0uJV62L3Lls+X
        5FuDsI0at3KcpO9F3c2QJk6seonuDig1mkH52LfLeN/9twCqygdyAOcLcQL9VzSIaGa9sE
        UPzco4oqRexGvBQvTB4jSI31/sQk8Vc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-8JhL7xcqNjOJrDKPuUs1Qg-1; Tue, 13 Jun 2023 10:18:18 -0400
X-MC-Unique: 8JhL7xcqNjOJrDKPuUs1Qg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77b0124d7beso366432239f.2
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665890; x=1689257890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7+SABrVLI0amKNwNw1VarYFD9JfcbmTjrTnN+EtSAI=;
        b=IFGhfPed+2tBeZptmyOPx57HB6KR68XZeNbtMBXYf5sCEqk5cIiQbZwKFjE54iS+h8
         L+//3NL+zw7BnZsM+AcflV6IOe9YvL05Bp/iVMitHYtRYzCflmBi9Xg/yfsFZ1E2YUMr
         BgzaSNbhy2Uw7ClsPEyHpX5msvII3W9ragy/x0rBE81cw6zxZ13QlYtxKLC165sKitsW
         oxnJHWlx1GCNZ9v6AlUHJoN4HUdVRB5X9j2CS1w0ABNZ91PKBEmu68JrADbrxHJM53pR
         96w83qavNcsKkeWKLigwnHKc+V/DyTFKq1CI7BI6u2GWC4YqpV9px/J0fNGIYMLt6KMe
         D7bQ==
X-Gm-Message-State: AC+VfDyYqag/4PWPr8G4KufW8osW2ZH3e42rcrTBqlpdMgXUP30/S617
        9VW1JBfqVxpEXtOJbBPBj0JZHNJwbYBAI9B9HStA9ddIrK+rgiDZdczN/jfrmtM9QyIRoFsVhly
        DuBE1DoBblU/aJqXMcPjTFg==
X-Received: by 2002:a6b:e602:0:b0:777:a8f0:1fc5 with SMTP id g2-20020a6be602000000b00777a8f01fc5mr10407469ioh.5.1686665890162;
        Tue, 13 Jun 2023 07:18:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Qxd5MF9xG9Y2ZhF+JHE0l7/i45VWWs07LUNcJeZBnEYj9JwVM4ub9aLTrzGq/bx1Sqe3MHg==
X-Received: by 2002:a6b:e602:0:b0:777:a8f0:1fc5 with SMTP id g2-20020a6be602000000b00777a8f01fc5mr10407439ioh.5.1686665889883;
        Tue, 13 Jun 2023 07:18:09 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c7-20020a6bfd07000000b00760f256037dsm3841313ioi.44.2023.06.13.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:18:09 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:18:08 -0600
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
Subject: Re: [PATCH v12 18/24] vfio: Add VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <20230613081808.049b9e6d.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB752985BA514AFF36CA3A2785C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-19-yi.l.liu@intel.com>
        <20230612162726.16f58ea4.alex.williamson@redhat.com>
        <DS0PR11MB752985BA514AFF36CA3A2785C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 05:48:46 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, June 13, 2023 6:27 AM
> > 
> > On Fri,  2 Jun 2023 05:16:47 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> > > This adds ioctl for userspace to bind device cdev fd to iommufd.
> > >
> > >     VFIO_DEVICE_BIND_IOMMUFD: bind device to an iommufd, hence gain DMA
> > > 			      control provided by the iommufd. open_device
> > > 			      op is called after bind_iommufd op.
> > >
> > > Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> > > Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Tested-by: Terrence Xu <terrence.xu@intel.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/device_cdev.c | 123 +++++++++++++++++++++++++++++++++++++
> > >  drivers/vfio/vfio.h        |  13 ++++
> > >  drivers/vfio/vfio_main.c   |   5 ++
> > >  include/linux/vfio.h       |   3 +-
> > >  include/uapi/linux/vfio.h  |  27 ++++++++
> > >  5 files changed, 170 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> > > index 1c640016a824..a4498ddbe774 100644
> > > --- a/drivers/vfio/device_cdev.c
> > > +++ b/drivers/vfio/device_cdev.c
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (c) 2023 Intel Corporation.
> > >   */
> > >  #include <linux/vfio.h>
> > > +#include <linux/iommufd.h>
> > >
> > >  #include "vfio.h"
> > >
> > > @@ -44,6 +45,128 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct  
> > file *filep)  
> > >  	return ret;
> > >  }
> > >
> > > +static void vfio_device_get_kvm_safe(struct vfio_device_file *df)
> > > +{
> > > +	spin_lock(&df->kvm_ref_lock);
> > > +	if (df->kvm)
> > > +		_vfio_device_get_kvm_safe(df->device, df->kvm);
> > > +	spin_unlock(&df->kvm_ref_lock);
> > > +}
> > > +
> > > +void vfio_df_cdev_close(struct vfio_device_file *df)
> > > +{
> > > +	struct vfio_device *device = df->device;
> > > +
> > > +	/*
> > > +	 * In the time of close, there is no contention with another one
> > > +	 * changing this flag.  So read df->access_granted without lock
> > > +	 * and no smp_load_acquire() is ok.
> > > +	 */
> > > +	if (!df->access_granted)
> > > +		return;
> > > +
> > > +	mutex_lock(&device->dev_set->lock);
> > > +	vfio_df_close(df);
> > > +	vfio_device_put_kvm(device);
> > > +	iommufd_ctx_put(df->iommufd);
> > > +	device->cdev_opened = false;
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +	vfio_device_unblock_group(device);
> > > +}
> > > +
> > > +static struct iommufd_ctx *vfio_get_iommufd_from_fd(int fd)
> > > +{
> > > +	struct iommufd_ctx *iommufd;
> > > +	struct fd f;
> > > +
> > > +	f = fdget(fd);
> > > +	if (!f.file)
> > > +		return ERR_PTR(-EBADF);
> > > +
> > > +	iommufd = iommufd_ctx_from_file(f.file);
> > > +
> > > +	fdput(f);
> > > +	return iommufd;
> > > +}
> > > +
> > > +long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
> > > +				struct vfio_device_bind_iommufd __user *arg)
> > > +{
> > > +	struct vfio_device *device = df->device;
> > > +	struct vfio_device_bind_iommufd bind;
> > > +	unsigned long minsz;
> > > +	int ret;
> > > +
> > > +	static_assert(__same_type(arg->out_devid, df->devid));
> > > +
> > > +	minsz = offsetofend(struct vfio_device_bind_iommufd, out_devid);
> > > +
> > > +	if (copy_from_user(&bind, arg, minsz))
> > > +		return -EFAULT;
> > > +
> > > +	if (bind.argsz < minsz || bind.flags || bind.iommufd < 0)
> > > +		return -EINVAL;
> > > +
> > > +	/* BIND_IOMMUFD only allowed for cdev fds */
> > > +	if (df->group)
> > > +		return -EINVAL;
> > > +
> > > +	ret = vfio_device_block_group(device);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&device->dev_set->lock);
> > > +	/* one device cannot be bound twice */
> > > +	if (df->access_granted) {
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	df->iommufd = vfio_get_iommufd_from_fd(bind.iommufd);
> > > +	if (IS_ERR(df->iommufd)) {
> > > +		ret = PTR_ERR(df->iommufd);
> > > +		df->iommufd = NULL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Before the device open, get the KVM pointer currently
> > > +	 * associated with the device file (if there is) and obtain
> > > +	 * a reference.  This reference is held until device closed.
> > > +	 * Save the pointer in the device for use by drivers.
> > > +	 */
> > > +	vfio_device_get_kvm_safe(df);
> > > +
> > > +	ret = vfio_df_open(df);
> > > +	if (ret)
> > > +		goto out_put_kvm;
> > > +
> > > +	ret = copy_to_user(&arg->out_devid, &df->devid,
> > > +			   sizeof(df->devid)) ? -EFAULT : 0;
> > > +	if (ret)
> > > +		goto out_close_device;
> > > +
> > > +	/*
> > > +	 * Paired with smp_load_acquire() in vfio_device_fops::ioctl/
> > > +	 * read/write/mmap
> > > +	 */
> > > +	smp_store_release(&df->access_granted, true);
> > > +	device->cdev_opened = true;
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +	return 0;
> > > +
> > > +out_close_device:
> > > +	vfio_df_close(df);
> > > +out_put_kvm:
> > > +	vfio_device_put_kvm(device);
> > > +	iommufd_ctx_put(df->iommufd);
> > > +	df->iommufd = NULL;
> > > +out_unlock:
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +	vfio_device_unblock_group(device);
> > > +	return ret;
> > > +}
> > > +
> > >  static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
> > >  {
> > >  	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> > > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > > index d12b5b524bfc..42de40d2cd4d 100644
> > > --- a/drivers/vfio/vfio.h
> > > +++ b/drivers/vfio/vfio.h
> > > @@ -287,6 +287,9 @@ static inline void vfio_device_del(struct vfio_device *device)
> > >  }
> > >
> > >  int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
> > > +void vfio_df_cdev_close(struct vfio_device_file *df);
> > > +long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
> > > +				struct vfio_device_bind_iommufd __user *arg);
> > >  int vfio_cdev_init(struct class *device_class);
> > >  void vfio_cdev_cleanup(void);
> > >  #else
> > > @@ -310,6 +313,16 @@ static inline int vfio_device_fops_cdev_open(struct inode  
> > *inode,  
> > >  	return 0;
> > >  }
> > >
> > > +static inline void vfio_df_cdev_close(struct vfio_device_file *df)
> > > +{
> > > +}
> > > +
> > > +static inline long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
> > > +					      struct vfio_device_bind_iommufd __user  
> > *arg)  
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > >  static inline int vfio_cdev_init(struct class *device_class)
> > >  {
> > >  	return 0;
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > index ef55af75f459..9ba4d420eda2 100644
> > > --- a/drivers/vfio/vfio_main.c
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -572,6 +572,8 @@ static int vfio_device_fops_release(struct inode *inode, struct  
> > file *filep)  
> > >
> > >  	if (df->group)
> > >  		vfio_df_group_close(df);
> > > +	else
> > > +		vfio_df_cdev_close(df);
> > >
> > >  	vfio_device_put_registration(device);
> > >
> > > @@ -1145,6 +1147,9 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
> > >  	struct vfio_device *device = df->device;
> > >  	int ret;
> > >
> > > +	if (cmd == VFIO_DEVICE_BIND_IOMMUFD)
> > > +		return vfio_df_ioctl_bind_iommufd(df, (void __user *)arg);
> > > +
> > >  	/* Paired with smp_store_release() following vfio_df_open() */
> > >  	if (!smp_load_acquire(&df->access_granted))
> > >  		return -EINVAL;
> > > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > > index 83cc5dc28b7a..e80a8ac86e46 100644
> > > --- a/include/linux/vfio.h
> > > +++ b/include/linux/vfio.h
> > > @@ -66,6 +66,7 @@ struct vfio_device {
> > >  	struct iommufd_device *iommufd_device;
> > >  	bool iommufd_attached;
> > >  #endif
> > > +	bool cdev_opened:1;  
> > 
> > Perhaps a more strongly defined data type here as well and roll
> > iommufd_attached into the same bit field scheme.  
> 
> Ok, then needs to make iommufd_attached always defined.

That does not follow.  Thanks,

Alex

