Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06BCC636CB
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 22:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7D1613C9
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 22:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhGOWaq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 18:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhGOWap (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 18:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626388071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLA8eO2Mn4hxr+cJbgc910e8VN/wkTHNL7BaNmCYSD0=;
        b=CZseuO4VjGJ+qQf/Rw1LhVWGrKLWUBZQ8kZuBJ1P/GQJTWgaixX4F/8gGi1HJHnn2gdIxo
        d4jQG+N4/eUR+upugTRhyL+A3gKyJUDs/30Ml3E6FiqMZXr9UrCUAPpMMKzAZpgToVTynk
        xH6yvu5Uym90YwjBaJB4rFHFNXssnLM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-lHkseTPrO_Kz_F268PGfhw-1; Thu, 15 Jul 2021 18:27:50 -0400
X-MC-Unique: lHkseTPrO_Kz_F268PGfhw-1
Received: by mail-oi1-f199.google.com with SMTP id l189-20020acabbc60000b02901f566a77bb8so4889399oif.7
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 15:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLA8eO2Mn4hxr+cJbgc910e8VN/wkTHNL7BaNmCYSD0=;
        b=oyEtmHQ7wa2exmbjMpBNo6NhTEIPt4xpSjqdDyGGoVc62kJyxmxCFblAJlmJtY+PTz
         UL7MtYIy6qn3IrcqFbmitHgxN8MDh9ZfkDVzaduesml1reHagrZtV4erh3FsRBgCbJoj
         psmuYRN8umcVk99BRQwvvxGWx6rMr8jlu/+uRk8MGOueqkLl7wqTQMS4KZlrGDRSX+7E
         zLQ3UNZO0ERCNGGdrgkRwV38NujYhABG9K3eS6nuZ/svuWNh4fXpo5tUA7TlKHAohWro
         urncyZy4oxUzlHyAzLt4WUeVdCYdWpU+gftZTKK7kBkO8Gwf3D9FZDMKgF2sl0qIHW8C
         FgXA==
X-Gm-Message-State: AOAM5326sobZMKyd+ezDdzeoGVYcZd8Bz1+bjGqxp2GdG+mfkHHnl0lM
        0kCV4epx5pY2fQY/CmtO7Rk6fgpgZvlWsaPzoMB9vcAYnfsgMknCsgzR8Cl2MmX2iuv2O9bKM5W
        eqt4Zy7XbHesSpnOJJ9si2w==
X-Received: by 2002:a9d:5e15:: with SMTP id d21mr5845727oti.280.1626388069903;
        Thu, 15 Jul 2021 15:27:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp8ZblGgPS0JAdEwOCHdvHkA3HueEV2SZpBhta6Fuh8EOKxxl4birTsJK3gicGUmZGOxesYw==
X-Received: by 2002:a9d:5e15:: with SMTP id d21mr5845703oti.280.1626388069722;
        Thu, 15 Jul 2021 15:27:49 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id v203sm1565993oib.37.2021.07.15.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 15:27:49 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:27:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 09/13] vfio/pci: Reorganize VFIO_DEVICE_PCI_HOT_RESET to
 use the device set
Message-ID: <20210715162747.4186b482.alex.williamson@redhat.com>
In-Reply-To: <20210715221149.GJ543781@nvidia.com>
References: <0-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
        <9-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
        <20210715150055.474f535f.alex.williamson@redhat.com>
        <20210715221149.GJ543781@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 15 Jul 2021 19:11:49 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jul 15, 2021 at 03:00:55PM -0600, Alex Williamson wrote:
> > On Wed, 14 Jul 2021 21:20:38 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:  
> > > +/*
> > > + * We need to get memory_lock for each device, but devices can share mmap_lock,
> > > + * therefore we need to zap and hold the vma_lock for each device, and only then
> > > + * get each memory_lock.
> > > + */
> > > +static int vfio_hot_reset_device_set(struct vfio_pci_device *vdev,
> > > +				     struct vfio_pci_group_info *groups)
> > > +{
> > > +	struct vfio_device_set *dev_set = vdev->vdev.dev_set;
> > > +	struct vfio_pci_device *cur_mem =
> > > +		list_first_entry(&dev_set->device_list, struct vfio_pci_device,
> > > +				 vdev.dev_set_list);  
> > 
> > We shouldn't be looking at the list outside of the lock, if the first
> > entry got removed we'd break our unwind code.
> >   
> > > +	struct vfio_pci_device *cur_vma;
> > > +	struct vfio_pci_device *cur;
> > > +	bool is_mem = true;
> > > +	int ret;
> > >  
> > > -	if (pci_dev_driver(pdev) != &vfio_pci_driver) {
> > > -		vfio_device_put(device);
> > > -		return -EBUSY;
> > > +	mutex_lock(&dev_set->lock);  
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^  
> 
> Oh, righto, this is an oopsie!
> 
> > > +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
> > > +		up_write(&cur->memory_lock);
> > > +	mutex_unlock(&dev_set->lock);
> > > +
> > > +	return ret;  
> > 
> > 
> > Isn't the above section actually redundant to below, ie. we could just
> > fall through after the pci_reset_bus()?  Thanks,  
> 
> It could, but I thought it was less confusing this way due to how
> oddball the below is:
> 
> > > +err_undo:
> > > +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> > > +		if (cur == cur_mem)
> > > +			is_mem = false;
> > > +		if (cur == cur_vma)
> > > +			break;
> > > +		if (is_mem)
> > > +			up_write(&cur->memory_lock);
> > > +		else
> > > +			mutex_unlock(&cur->vma_lock);
> > > +	}  
> 
> But either works, do want it switch in v2?

Yeah, I think the simpler version just adds to the confusion of what
this oddball logic does.  It already handles all cases, up to and
including success, so let's give it more exercise by always using it.
Thanks,

Alex

