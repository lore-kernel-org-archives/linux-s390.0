Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F6C4320A
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFBE61104
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 17:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhHERdb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230338AbhHERdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Aug 2021 13:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628184796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDWzWOKY9gRGQIrv08IMtQtjh7HeqqaHb9oXpUOEXe8=;
        b=DoCR06XO/gXSuCDB6NQi9KHmEi0n8/Ob+Ui1i5GkutNbNFfFHefa8uWwcUJRWO7E/GZJwS
        mBX3uNvQI5YRJ0m9m2QYm853OsK3andTgnAjXPClRdJixCj5AiP8y4lFHsMqkpykGsv5nV
        rocOEgEIzNaRjEh3jErVRy15v/+7FJw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-aoZnbS4xOdKVpgC-ww3gUw-1; Thu, 05 Aug 2021 13:33:15 -0400
X-MC-Unique: aoZnbS4xOdKVpgC-ww3gUw-1
Received: by mail-oo1-f72.google.com with SMTP id u5-20020a4aae850000b02902869d22d7a1so356924oon.5
        for <linux-s390@vger.kernel.org>; Thu, 05 Aug 2021 10:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fDWzWOKY9gRGQIrv08IMtQtjh7HeqqaHb9oXpUOEXe8=;
        b=a5MxG8VYsziyRuEV93A8/Mf2PmIQsOD8fBZcZq6zE4nPpUM/0Z7kjFv7UHX8SYy5tX
         Ofu3vOObatqVtvyPiYP325bBSbqZdItmdeos16GxjJ7V6+/+25Gra6VwOgA0Ni3ukQvW
         HMrbf6/T6EVKH1J/FWbpGgEoTbbSCEpqF4UoBeYkJerGTw7mUda95YjmW9xinFq/eITS
         9ZcPBVVxGcUqhTwiMOoFliLx5jifDgXNwsY2oBxJVM8lAjgRLlwPyXnst1CCfGIzIRZf
         DxMQIfjl3a6qBQ+ydv/1CC2X3jqkGxOoFiFr4aP205LmwtKPCas046UW1U2cv1E/tmic
         p9mg==
X-Gm-Message-State: AOAM531WdUs0y1gOQK0ky/i4vtrYt+eX2KCWlXsPeaHZLR9NDZcy/w31
        mDmTncd46dlfClSpKcf79bbsWJQa/pf50sJS/gVZgbsgOwzgCntAbkI4e8ShHMIiL5QOeLyjIHX
        E8J1HcwJ+uE6RofpPllSvBA==
X-Received: by 2002:a9d:4e16:: with SMTP id p22mr4456199otf.173.1628184794731;
        Thu, 05 Aug 2021 10:33:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgne5vH4F/tdkjcY9nwVFcfF47fNX2nFmDPhfapXicykX6MF2W8wxSNajz6keH3dZKwbyTaw==
X-Received: by 2002:a9d:4e16:: with SMTP id p22mr4456177otf.173.1628184794507;
        Thu, 05 Aug 2021 10:33:14 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id 50sm1021773oti.31.2021.08.05.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:33:14 -0700 (PDT)
Date:   Thu, 5 Aug 2021 11:33:11 -0600
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
        Zhi Wang <zhi.a.wang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v3 09/14] vfio/pci: Change vfio_pci_try_bus_reset() to
 use the dev_set
Message-ID: <20210805113311.65a16bba.alex.williamson@redhat.com>
In-Reply-To: <20210805114701.GC1672295@nvidia.com>
References: <0-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
        <9-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
        <20210803103406.5e1be269.alex.williamson@redhat.com>
        <20210803164152.GC1721383@nvidia.com>
        <20210803105225.2ee7dac2.alex.williamson@redhat.com>
        <20210805114701.GC1672295@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 5 Aug 2021 08:47:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Aug 03, 2021 at 10:52:25AM -0600, Alex Williamson wrote:
> > On Tue, 3 Aug 2021 13:41:52 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:  
> > > On Tue, Aug 03, 2021 at 10:34:06AM -0600, Alex Williamson wrote:  
> > > > I think the vfio_pci_find_reset_target() function needs to be re-worked
> > > > to just tell us true/false that it's ok to reset the provided device,
> > > > not to anoint an arbitrary target device.  Thanks,    
> > > 
> > > Yes, though this logic is confusing, why do we need to check if any
> > > device needs a reset at this point? If we are being asked to reset
> > > vdev shouldn't vdev needs_reset?
> > > 
> > > Or is the function more of a 'synchronize pending reset' kind of
> > > thing?  
> > 
> > Yes, the latter.  For instance think about a multi-function PCI device
> > such as a GPU.  The functions have dramatically different capabilities,
> > some might have function level reset abilities and others not.  We want
> > to be able to trigger a bus reset as the last device of the set is
> > released, no matter the order they're released and no matter the
> > capabilities of the device we're currently processing.  Thanks,  
> 
> I worked on this for awhile, I think this is much clearer about what
> this algorithm is trying to do:
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 5d6db93d6c680f..e418bcbb68facc 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -223,7 +223,7 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)
>  	}
>  }
>  
> -static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
> +static bool vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
>  static void vfio_pci_disable(struct vfio_pci_device *vdev);
>  static int vfio_pci_try_zap_and_vma_lock_cb(struct pci_dev *pdev, void *data);
>  
> @@ -404,6 +404,9 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
>  	int i, bar;
>  
> +	/* For needs_reset */
> +	lockdep_assert_held(&vdev->vdev.dev_set->lock);
> +
>  	/* Stop the device from further DMA */
>  	pci_clear_master(pdev);
>  
> @@ -487,9 +490,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  out:
>  	pci_disable_device(pdev);
>  
> -	vfio_pci_try_bus_reset(vdev);
> -
> -	if (!disable_idle_d3)
> +	if (!vfio_pci_dev_set_try_reset(vdev->vdev.dev_set) && !disable_idle_d3)
>  		vfio_pci_set_power_state(vdev, PCI_D3hot);
>  }
>  
> @@ -2145,36 +2146,6 @@ static struct pci_driver vfio_pci_driver = {
>  	.err_handler		= &vfio_err_handlers,
>  };
>  
> -static int vfio_pci_get_unused_devs(struct pci_dev *pdev, void *data)
> -{
> -	struct vfio_devices *devs = data;
> -	struct vfio_device *device;
> -	struct vfio_pci_device *vdev;
> -
> -	if (devs->cur_index == devs->max_index)
> -		return -ENOSPC;
> -
> -	device = vfio_device_get_from_dev(&pdev->dev);
> -	if (!device)
> -		return -EINVAL;
> -
> -	if (pci_dev_driver(pdev) != &vfio_pci_driver) {
> -		vfio_device_put(device);
> -		return -EBUSY;
> -	}
> -
> -	vdev = container_of(device, struct vfio_pci_device, vdev);
> -
> -	/* Fault if the device is not unused */
> -	if (device->open_count) {
> -		vfio_device_put(device);
> -		return -EBUSY;
> -	}
> -
> -	devs->devices[devs->cur_index++] = vdev;
> -	return 0;
> -}
> -
>  static int vfio_pci_try_zap_and_vma_lock_cb(struct pci_dev *pdev, void *data)
>  {
>  	struct vfio_devices *devs = data;
> @@ -2208,79 +2179,86 @@ static int vfio_pci_try_zap_and_vma_lock_cb(struct pci_dev *pdev, void *data)
>  	return 0;
>  }
>  
> +static int vfio_pci_is_device_in_set(struct pci_dev *pdev, void *data)
> +{
> +	struct vfio_device_set *dev_set = data;
> +	struct vfio_device *cur;
> +
> +	lockdep_assert_held(&dev_set->lock);
> +
> +	list_for_each_entry(cur, &dev_set->device_list, dev_set_list)
> +		if (cur->dev == &pdev->dev)
> +			return 0;
> +	return -EBUSY;
> +}
> +
> +static bool vfio_pci_dev_set_needs_reset(struct vfio_device_set *dev_set)

Slight nit on the name here since we're essentially combining
needs_reset along with the notion of the device being unused.  I'm not
sure, maybe "should_reset"?  Otherwise it looks ok.  Thanks,

Alex

> +{
> +	struct vfio_pci_device *cur;
> +	bool needs_reset = false;
> +
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> +		/* No VFIO device in the set can have an open device FD */
> +		if (cur->vdev.open_count)
> +			return false;
> +		needs_reset |= cur->needs_reset;
> +	}
> +	return needs_reset;
> +}
> +
>  /*
> - * If a bus or slot reset is available for the provided device and:
> + * If a bus or slot reset is available for the provided dev_set and:
>   *  - All of the devices affected by that bus or slot reset are unused
> - *    (!refcnt)
>   *  - At least one of the affected devices is marked dirty via
>   *    needs_reset (such as by lack of FLR support)
> - * Then attempt to perform that bus or slot reset.  Callers are required
> - * to hold vdev->dev_set->lock, protecting the bus/slot reset group from
> - * concurrent opens.  A vfio_device reference is acquired for each device
> - * to prevent unbinds during the reset operation.
> - *
> - * NB: vfio-core considers a group to be viable even if some devices are
> - * bound to drivers like pci-stub or pcieport.  Here we require all devices
> - * to be bound to vfio_pci since that's the only way we can be sure they
> - * stay put.
> + * Then attempt to perform that bus or slot reset.
> + * Returns true if the dev_set was reset.
>   */
> -static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
> +static bool vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  {
> -	struct vfio_devices devs = { .cur_index = 0 };
> -	int i = 0, ret = -EINVAL;
> -	bool slot = false;
> -	struct vfio_pci_device *tmp;
> +	struct vfio_pci_device *cur;
> +	struct pci_dev *pdev;
> +	int ret;
>  
> -	if (!pci_probe_reset_slot(vdev->pdev->slot))
> -		slot = true;
> -	else if (pci_probe_reset_bus(vdev->pdev->bus))
> -		return;
> +	lockdep_assert_held(&dev_set->lock);
>  
> -	if (vfio_pci_for_each_slot_or_bus(vdev->pdev, vfio_pci_count_devs,
> -					  &i, slot) || !i)
> -		return;
> +	/*
> +	 * By definition all PCI devices in the dev_set share the same PCI
> +	 * reset, so any pci_dev will have the same outcomes for
> +	 * pci_probe_reset_*() and pci_reset_bus().
> +	 */
> +	pdev = list_first_entry(&dev_set->device_list, struct vfio_pci_device,
> +				vdev.dev_set_list)->pdev;
>  
> -	devs.max_index = i;
> -	devs.devices = kcalloc(i, sizeof(struct vfio_device *), GFP_KERNEL);
> -	if (!devs.devices)
> -		return;
> +	/* Reset of the dev_set is possible */
> +	if (pci_probe_reset_slot(pdev->slot) && pci_probe_reset_bus(pdev->bus))
> +		return false;
>  
> -	if (vfio_pci_for_each_slot_or_bus(vdev->pdev,
> -					  vfio_pci_get_unused_devs,
> -					  &devs, slot))
> -		goto put_devs;
> +	if (!vfio_pci_dev_set_needs_reset(dev_set))
> +		return false;
>  
> -	/* Does at least one need a reset? */
> -	for (i = 0; i < devs.cur_index; i++) {
> -		tmp = devs.devices[i];
> -		if (tmp->needs_reset) {
> -			ret = pci_reset_bus(vdev->pdev);
> -			break;
> -		}
> +	/*
> +	 * vfio-core considers a group to be viable and will create a
> +	 * vfio_device even if some devices are bound to drivers like pci-stub
> +	 * or pcieport. Here we require all PCI devices to be inside our dev_set
> +	 * since that ensures they stay put and that every driver controlling
> +	 * the device can co-ordinate with the device reset.
> +	 */
> +	if (vfio_pci_for_each_slot_or_bus(pdev, vfio_pci_is_device_in_set,
> +					  dev_set,
> +					  !pci_probe_reset_slot(pdev->slot)))
> +		return false;
> +
> +	ret = pci_reset_bus(pdev);
> +	if (ret)
> +		return false;
> +
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> +		cur->needs_reset = false;
> +		if (!disable_idle_d3)
> +			vfio_pci_set_power_state(cur, PCI_D3hot);
>  	}
> -
> -put_devs:
> -	for (i = 0; i < devs.cur_index; i++) {
> -		tmp = devs.devices[i];
> -
> -		/*
> -		 * If reset was successful, affected devices no longer need
> -		 * a reset and we should return all the collateral devices
> -		 * to low power.  If not successful, we either didn't reset
> -		 * the bus or timed out waiting for it, so let's not touch
> -		 * the power state.
> -		 */
> -		if (!ret) {
> -			tmp->needs_reset = false;
> -
> -			if (tmp != vdev && !disable_idle_d3)
> -				vfio_pci_set_power_state(tmp, PCI_D3hot);
> -		}
> -
> -		vfio_device_put(&tmp->vdev);
> -	}
> -
> -	kfree(devs.devices);
> +	return true;
>  }
>  
>  static void __exit vfio_pci_cleanup(void)
> 

