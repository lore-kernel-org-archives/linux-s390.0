Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ABFC636C8
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8261360
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 21:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhGOVDy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231215AbhGOVDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 17:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626382859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6cMvV3xGXdKHq4WzPyleEVhevpPRqkhvlCWSt+Y12E=;
        b=UlZ//gQ9Vq9zWrksL/UIApx4nA5S+VDj0vuN0tvDhwpVVekNoeqHLefIFyDzX8Ua1hAzfE
        o/5g8GmTroPI1h0CiwuTxiZ2cLn3XVvuN9FzDidCwwoDysuu5prpyUgQQiOFa4t7KwX0bK
        lJWlOOTuuoxfKut6P177d1pGtODlIUo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-SCde5kDnOoqtLMl0jtgFwA-1; Thu, 15 Jul 2021 17:00:58 -0400
X-MC-Unique: SCde5kDnOoqtLMl0jtgFwA-1
Received: by mail-oo1-f72.google.com with SMTP id s11-20020a4ac10b0000b029024bc69d2a8aso5291688oop.16
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 14:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=w6cMvV3xGXdKHq4WzPyleEVhevpPRqkhvlCWSt+Y12E=;
        b=PxAnzwOGKGPZOKuzBiZYz1DM/N1RZ6Q0EsO4pHmbbSXi2j9ZO3Rgn4jlHVDCFoj16j
         PITZjbqPFY3dpQma69ztL9pyrWYUzeJIQrpPiKswBWbaO+DDrVIN/nmjQuk9P99ycY0g
         PMu9B5XjQ8od1MAHnIReQP3ufQIFbXWBA3+mHVYY8ya0DbCktnc5Kgpo2FLPuUKMbOWo
         w4KEa+kPtTihwPtaCk64c5hO3tV+tDesYdy7mYANPQmQ7tDvNMWA2gDvkc/6hmew7eiZ
         +oa8xWUSS0k3ShjAZfoYEghwS3cSObmlnf6Egz2tHQTPDOcdU31Y6s6nhdBIGcGvfadx
         6/GA==
X-Gm-Message-State: AOAM531LXfjj+iSmKiJj0RepAVxn3cT6qlU6w82+0K+eOxz7gLbmUJX+
        ELed7cJftwupefMhT/aAYFYRiFh84WrnR7iu3eMnPuFxrWyv3zTZ7ZbduwNVTnLO6UvFYkDvm4W
        /E+2fhdr6flX4Z0xaSw8PAg==
X-Received: by 2002:aca:2112:: with SMTP id 18mr9993623oiz.48.1626382857936;
        Thu, 15 Jul 2021 14:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhGopnxXSOUkiyj2IazWlzUmam8q3Wm1mG8M1diFnOhbK2stM6MvqH6+i/pmWQg4ZlT4QnEQ==
X-Received: by 2002:aca:2112:: with SMTP id 18mr9993610oiz.48.1626382857721;
        Thu, 15 Jul 2021 14:00:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id n9sm1367932otn.54.2021.07.15.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:00:57 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:00:55 -0600
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
Message-ID: <20210715150055.474f535f.alex.williamson@redhat.com>
In-Reply-To: <9-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
References: <0-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
        <9-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 14 Jul 2021 21:20:38 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> +/*
> + * We need to get memory_lock for each device, but devices can share mmap_lock,
> + * therefore we need to zap and hold the vma_lock for each device, and only then
> + * get each memory_lock.
> + */
> +static int vfio_hot_reset_device_set(struct vfio_pci_device *vdev,
> +				     struct vfio_pci_group_info *groups)
> +{
> +	struct vfio_device_set *dev_set = vdev->vdev.dev_set;
> +	struct vfio_pci_device *cur_mem =
> +		list_first_entry(&dev_set->device_list, struct vfio_pci_device,
> +				 vdev.dev_set_list);

We shouldn't be looking at the list outside of the lock, if the first
entry got removed we'd break our unwind code.

> +	struct vfio_pci_device *cur_vma;
> +	struct vfio_pci_device *cur;
> +	bool is_mem = true;
> +	int ret;
>  
> -	if (pci_dev_driver(pdev) != &vfio_pci_driver) {
> -		vfio_device_put(device);
> -		return -EBUSY;
> +	mutex_lock(&dev_set->lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^

> +
> +	/* All devices in the group to be reset need VFIO devices */
> +	if (vfio_pci_for_each_slot_or_bus(
> +		    vdev->pdev, vfio_pci_check_all_devices_bound, dev_set,
> +		    !pci_probe_reset_slot(vdev->pdev->slot))) {
> +		ret = -EINVAL;
> +		goto err_unlock;
>  	}
>  
> -	vdev = container_of(device, struct vfio_pci_device, vdev);
> +	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
> +		/*
> +		 * Test whether all the affected devices are contained by the
> +		 * set of groups provided by the user.
> +		 */
> +		if (!vfio_dev_in_groups(cur_vma, groups)) {
> +			ret = -EINVAL;
> +			goto err_undo;
> +		}
>  
> -	/*
> -	 * Locking multiple devices is prone to deadlock, runaway and
> -	 * unwind if we hit contention.
> -	 */
> -	if (!vfio_pci_zap_and_vma_lock(vdev, true)) {
> -		vfio_device_put(device);
> -		return -EBUSY;
> +		/*
> +		 * Locking multiple devices is prone to deadlock, runaway and
> +		 * unwind if we hit contention.
> +		 */
> +		if (!vfio_pci_zap_and_vma_lock(cur_vma, true)) {
> +			ret = -EBUSY;
> +			goto err_undo;
> +		}
>  	}
>  
> -	devs->devices[devs->cur_index++] = vdev;
> -	return 0;
> +	list_for_each_entry(cur_mem, &dev_set->device_list, vdev.dev_set_list) {
> +		if (!down_write_trylock(&cur_mem->memory_lock)) {
> +			ret = -EBUSY;
> +			goto err_undo;
> +		}
> +		mutex_unlock(&cur_mem->vma_lock);
> +	}
> +
> +	ret = pci_reset_bus(vdev->pdev);
> +


> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
> +		up_write(&cur->memory_lock);
> +	mutex_unlock(&dev_set->lock);
> +
> +	return ret;


Isn't the above section actually redundant to below, ie. we could just
fall through after the pci_reset_bus()?  Thanks,

Alex

> +
> +err_undo:
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> +		if (cur == cur_mem)
> +			is_mem = false;
> +		if (cur == cur_vma)
> +			break;
> +		if (is_mem)
> +			up_write(&cur->memory_lock);
> +		else
> +			mutex_unlock(&cur->vma_lock);
> +	}
> +err_unlock:
> +	mutex_unlock(&dev_set->lock);
> +	return ret;
>  }
>  
>  /*

