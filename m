Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45193C05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 22:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBNWra (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNWr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 17:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E630184
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 14:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676414801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jldO6fmfgoCuH/YvBSf2KGCik/zXLxK5KGgKzWj5sI=;
        b=K+YLUVpgvU2XkkUawbaRix+xbfG7yy+KPOtgA98MqQr+0zWs03xKb8DEvJH3wa7SFN/joH
        3gK25u1dHSScfZowEua4Lfu82tVYDT/vtkrSuDSgKyU+HCgs7v7TRBKwbKK3/Gk44mOJFP
        vYFopKF5bCzP8Do7K096ypk7dcayVP4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-iQEE54SGM_uscKM6CgYl7g-1; Tue, 14 Feb 2023 17:46:39 -0500
X-MC-Unique: iQEE54SGM_uscKM6CgYl7g-1
Received: by mail-io1-f71.google.com with SMTP id y22-20020a5d94d6000000b007076e06ba3dso11110587ior.20
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 14:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jldO6fmfgoCuH/YvBSf2KGCik/zXLxK5KGgKzWj5sI=;
        b=G9aojlgNuiFKJ2Pr3PkNCG2D02KrW2XGGCgse1izcu4kz5yO9taSn0Z1bUM0d2WlRE
         z1YOVV9HiSSQaco+bqmxe1KIa/KkEje9tMeWRENA36zY9pUFqmh9AjOoy6HCNY1eEkN5
         2HXiAWI4Tg1h3/SEwK57DX3A4KcC5jrbpJ+aAJK11ss4X89whR7akZ8m8x6+IiIEUkO0
         cIPgqajVIBQQoQSJNbAkUbFFzc9fxlAxaWJxCkxwgmdI1tJe5HnD90+KsPocKcuybS/w
         H8RDXsu6j5EGUBctu64FBSIZkLR60C42UHU3RMrqXL1HAIApRft6TgsOm9qLqNDPXqy4
         cq1g==
X-Gm-Message-State: AO0yUKWPwF52X898eODiYNE7iQOa8ibysZMjwQ2hm/80gWhi0e6uW8Ju
        6j1kiK87se5mc2XZgSl8s+lFNbdCHrlxMd8FidHJ9xcmj/A61VpVn2Wz4qKwCfDpk4FdJC9L/f9
        UQPQmVGhj4sfbl6JGv2IHjQ==
X-Received: by 2002:a5d:9d9f:0:b0:723:8cb5:6702 with SMTP id ay31-20020a5d9d9f000000b007238cb56702mr1318078iob.1.1676414797215;
        Tue, 14 Feb 2023 14:46:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9cfDgyngyCVpoASbTracVSC7acBm/bzA5JaqsBngxVoSVzbVeauNEuEuVYlZXiKXiEdIcJqA==
X-Received: by 2002:a5d:9d9f:0:b0:723:8cb5:6702 with SMTP id ay31-20020a5d9d9f000000b007238cb56702mr1318066iob.1.1676414796958;
        Tue, 14 Feb 2023 14:46:36 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u17-20020a02c051000000b003c2b67fac92sm5245727jam.81.2023.02.14.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:46:36 -0800 (PST)
Date:   Tue, 14 Feb 2023 15:46:34 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 07/15] vfio: Block device access via device fd until
 device is opened
Message-ID: <20230214154634.4bc5dcd6.alex.williamson@redhat.com>
In-Reply-To: <20230213151348.56451-8-yi.l.liu@intel.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213151348.56451-8-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 13 Feb 2023 07:13:40 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Allow the vfio_device file to be in a state where the device FD is
> opened but the device cannot be used by userspace (i.e. its .open_device()
> hasn't been called). This inbetween state is not used when the device
> FD is spawned from the group FD, however when we create the device FD
> directly by opening a cdev it will be opened in the blocked state.
> 
> The reason for the inbetween state is that userspace only gets a FD but
> doesn't gain access permission until binding the FD to an iommufd. So in
> the blocked state, only the bind operation is allowed. Completing bind
> will allow user to further access the device.
> 
> This is implemented by adding a flag in struct vfio_device_file to mark
> the blocked state and using a simple smp_load_acquire() to obtain the
> flag value and serialize all the device setup with the thread accessing
> this device.
> 
> Following this lockless scheme, it can safely handle the device FD
> unbound->bound but it cannot handle bound->unbound. To allow this we'd
> need to add a lock on all the vfio ioctls which seems costly. So once
> device FD is bound, it remains bound until the FD is closed.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/vfio/vfio.h      |  1 +
>  drivers/vfio/vfio_main.c | 34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 11e56fe079a1..d56cdb114024 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -18,6 +18,7 @@ struct vfio_container;
>  
>  struct vfio_device_file {
>  	struct vfio_device *device;
> +	bool access_granted;
>  	spinlock_t kvm_ref_lock; /* protect kvm field */
>  	struct kvm *kvm;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index c517252aba19..2267057240bd 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -476,7 +476,15 @@ int vfio_device_open(struct vfio_device_file *df)
>  			device->open_count--;
>  	}
>  
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Paired with smp_load_acquire() in vfio_device_fops::ioctl/
> +	 * read/write/mmap
> +	 */
> +	smp_store_release(&df->access_granted, true);
> +	return 0;
>  }
>  
>  void vfio_device_close(struct vfio_device_file *df)
> @@ -1104,8 +1112,14 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  {
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
> +	bool access;
>  	int ret;
>  
> +	/* Paired with smp_store_release() in vfio_device_open() */
> +	access = smp_load_acquire(&df->access_granted);
> +	if (!access)
> +		return -EINVAL;
> +

Nit,

	if (!smp_load_acquire(&df->access_granted))
		...

Thanks,
Alex

>  	ret = vfio_device_pm_runtime_get(device);
>  	if (ret)
>  		return ret;
> @@ -1132,6 +1146,12 @@ static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
>  {
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
> +	bool access;
> +
> +	/* Paired with smp_store_release() in vfio_device_open() */
> +	access = smp_load_acquire(&df->access_granted);
> +	if (!access)
> +		return -EINVAL;
>  
>  	if (unlikely(!device->ops->read))
>  		return -EINVAL;
> @@ -1145,6 +1165,12 @@ static ssize_t vfio_device_fops_write(struct file *filep,
>  {
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
> +	bool access;
> +
> +	/* Paired with smp_store_release() in vfio_device_open() */
> +	access = smp_load_acquire(&df->access_granted);
> +	if (!access)
> +		return -EINVAL;
>  
>  	if (unlikely(!device->ops->write))
>  		return -EINVAL;
> @@ -1156,6 +1182,12 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  {
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
> +	bool access;
> +
> +	/* Paired with smp_store_release() in vfio_device_open() */
> +	access = smp_load_acquire(&df->access_granted);
> +	if (!access)
> +		return -EINVAL;
>  
>  	if (unlikely(!device->ops->mmap))
>  		return -EINVAL;

