Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855FEB64D0
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbjFMOUT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbjFMOUK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 10:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176F184
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686665963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hh7dDn79BmR3GsS4yLCOwuPTkSZ8D9roEztDs6aeojo=;
        b=emktZ1Ykh+boj8Ys/gDP3CJ2UNpUNmT/8Rr+Cx+bLprR+IJZvNTPel+3khVrLWl+1GvI7s
        IHIqJfKTaXQ50gXxS8IkCwc9dklkPrNhR5fiRF9LebL1GZj5XjwjXniv59Ck1mad/lPHrb
        1IGkj3e+G0mGzk4jv6vXR6eZtHy15Tk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5c-Zm10-OWSmMKXf26-lxw-1; Tue, 13 Jun 2023 10:19:16 -0400
X-MC-Unique: 5c-Zm10-OWSmMKXf26-lxw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33bbffccf69so64602845ab.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665956; x=1689257956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh7dDn79BmR3GsS4yLCOwuPTkSZ8D9roEztDs6aeojo=;
        b=iqDgzCGiRwrNRrFxazjFcDX/eNC4EhQARr1kFQjEmWIGqR8TJr8xPqcQ39GrbHHK0q
         qDebG/BDwxqIzyP3zn5A/KVe0l3ahBwhx+TC+XM/beAajEymVrSQ9Nk+TF1AOkDREq+V
         2I7Sy4rX8ijdd85bBIfmK1PWoaFzAX8xc59YU/o7v5wuaO7Hf21sa8eGY2DeCP27oOmn
         6nHkmmhQs8OrjUFZhkyKeVgEYLPQx2WuCtibl5/28elp44h4uEmiGdxBBvBCzak4TD3x
         qBCGI6/a4dH2ID3MEM0AtzowU2OY6AfNxnD0sCPqmTleVLDVNq40oWO/o28KTrWslNk9
         QCHg==
X-Gm-Message-State: AC+VfDwWcjI1K7+clGZA4UJILerhnI0TavvnJEjAuqEw/F5DacwYNdGO
        agw3c9+BTs+czuvd5aUkSswGqgRJ9wY8yBFCAMdL3MM5DRyhYyp2l8HvR3QLBw2OqdSc0suzoYG
        5q93Og/mTSnWFtsTSVsoUWg==
X-Received: by 2002:a92:d84e:0:b0:340:7ab6:1f49 with SMTP id h14-20020a92d84e000000b003407ab61f49mr1362179ilq.20.1686665955818;
        Tue, 13 Jun 2023 07:19:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70y+1gcH35hXRid2B015UTZDwXVqcqVbwY3awzvwLMsL0aeKs+cVPwaqIPq185U12jr3QsrQ==
X-Received: by 2002:a92:d84e:0:b0:340:7ab6:1f49 with SMTP id h14-20020a92d84e000000b003407ab61f49mr1362166ilq.20.1686665955589;
        Tue, 13 Jun 2023 07:19:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r5-20020a92ce85000000b0032a8e1ba829sm3844570ilo.16.2023.06.13.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:19:14 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:19:13 -0600
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
Subject: Re: [PATCH v12 21/24] vfio: Determine noiommu device in
 __vfio_register_dev()
Message-ID: <20230613081913.279dea9e.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529AE3701E154BF4C092E57C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-22-yi.l.liu@intel.com>
        <20230612164228.65b500e0.alex.williamson@redhat.com>
        <DS0PR11MB7529AE3701E154BF4C092E57C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 05:53:42 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, June 13, 2023 6:42 AM
> > 
> > On Fri,  2 Jun 2023 05:16:50 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> > > This moves the noiommu device determination and noiommu taint out of
> > > vfio_group_find_or_alloc(). noiommu device is determined in
> > > __vfio_register_dev() and result is stored in flag vfio_device->noiommu,
> > > the noiommu taint is added in the end of __vfio_register_dev().
> > >
> > > This is also a preparation for compiling out vfio_group infrastructure
> > > as it makes the noiommu detection and taint common between the cdev path
> > > and group path though cdev path does not support noiommu.  
> > 
> > Does this really still make sense?  The motivation for the change is
> > really not clear without cdev support for noiommu.  Thanks,  
> 
> I think it still makes sense. When CONFIG_VFIO_GROUP==n, the kernel
> only supports cdev interface. If there is noiommu device, vfio should
> fail the registration. So, the noiommu determination is still needed. But
> I'd admit the taint might still be in the group code.

How is there going to be a noiommu device when VFIO_GROUP is unset?
Thanks,

Alex


> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/group.c     | 15 ---------------
> > >  drivers/vfio/vfio_main.c | 31 ++++++++++++++++++++++++++++++-
> > >  include/linux/vfio.h     |  1 +
> > >  3 files changed, 31 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > > index 653b62f93474..64cdd0ea8825 100644
> > > --- a/drivers/vfio/group.c
> > > +++ b/drivers/vfio/group.c
> > > @@ -668,21 +668,6 @@ static struct vfio_group *vfio_group_find_or_alloc(struct  
> > device *dev)  
> > >  	struct vfio_group *group;
> > >
> > >  	iommu_group = iommu_group_get(dev);
> > > -	if (!iommu_group && vfio_noiommu) {
> > > -		/*
> > > -		 * With noiommu enabled, create an IOMMU group for devices that
> > > -		 * don't already have one, implying no IOMMU hardware/driver
> > > -		 * exists.  Taint the kernel because we're about to give a DMA
> > > -		 * capable device to a user without IOMMU protection.
> > > -		 */
> > > -		group = vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);
> > > -		if (!IS_ERR(group)) {
> > > -			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > -			dev_warn(dev, "Adding kernel taint for vfio-noiommu group on  
> > device\n");  
> > > -		}
> > > -		return group;
> > > -	}
> > > -
> > >  	if (!iommu_group)
> > >  		return ERR_PTR(-EINVAL);
> > >
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > index 6d8f9b0f3637..00a699b9f76b 100644
> > > --- a/drivers/vfio/vfio_main.c
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -265,6 +265,18 @@ static int vfio_init_device(struct vfio_device *device, struct  
> > device *dev,  
> > >  	return ret;
> > >  }
> > >
> > > +static int vfio_device_set_noiommu(struct vfio_device *device)
> > > +{
> > > +	struct iommu_group *iommu_group = iommu_group_get(device->dev);
> > > +
> > > +	if (!iommu_group && !vfio_noiommu)
> > > +		return -EINVAL;
> > > +
> > > +	device->noiommu = !iommu_group;
> > > +	iommu_group_put(iommu_group); /* Accepts NULL */
> > > +	return 0;
> > > +}
> > > +
> > >  static int __vfio_register_dev(struct vfio_device *device,
> > >  			       enum vfio_group_type type)
> > >  {
> > > @@ -277,6 +289,13 @@ static int __vfio_register_dev(struct vfio_device *device,
> > >  		     !device->ops->detach_ioas)))
> > >  		return -EINVAL;
> > >
> > > +	/* Only physical devices can be noiommu device */
> > > +	if (type == VFIO_IOMMU) {
> > > +		ret = vfio_device_set_noiommu(device);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	/*
> > >  	 * If the driver doesn't specify a set then the device is added to a
> > >  	 * singleton set just for itself.
> > > @@ -288,7 +307,8 @@ static int __vfio_register_dev(struct vfio_device *device,
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	ret = vfio_device_set_group(device, type);
> > > +	ret = vfio_device_set_group(device,
> > > +				    device->noiommu ? VFIO_NO_IOMMU : type);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > @@ -301,6 +321,15 @@ static int __vfio_register_dev(struct vfio_device *device,
> > >
> > >  	vfio_device_group_register(device);
> > >
> > > +	if (device->noiommu) {
> > > +		/*
> > > +		 * noiommu deivces have no IOMMU hardware/driver.  Taint the
> > > +		 * kernel because we're about to give a DMA capable device to
> > > +		 * a user without IOMMU protection.
> > > +		 */
> > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > +		dev_warn(device->dev, "Adding kernel taint for vfio-noiommu on  
> > device\n");  
> > > +	}
> > >  	return 0;
> > >  err_out:
> > >  	vfio_device_remove_group(device);
> > > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > > index e80a8ac86e46..183e620009e7 100644
> > > --- a/include/linux/vfio.h
> > > +++ b/include/linux/vfio.h
> > > @@ -67,6 +67,7 @@ struct vfio_device {
> > >  	bool iommufd_attached;
> > >  #endif
> > >  	bool cdev_opened:1;
> > > +	bool noiommu:1;
> > >  };
> > >
> > >  /**  
> 

