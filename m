Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544EC6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 20:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjDDUcU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjDDUcT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 16:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144A4496
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680640292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqS1tmmJr7PAF8X4LNYoZBpPsb/UgoghZYeXc9m09Fg=;
        b=V8EbIa6p494NRQllx1l36DRDHMMsORtz62l0HzqDIVteUQ0ln+cDxwHBIyOng1tH6T5UMO
        WuzOVo4S/LH6VGkC0QW6cXX8NBXHJWxINKsUmst2MayvGngXP+hZwDo+TGhzLmu3GaSwYh
        yKJmADWJ8qqSQth+BV7l+RP/x8l1Z3k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Md5nrgjBN8CZQYO41-wopA-1; Tue, 04 Apr 2023 16:31:31 -0400
X-MC-Unique: Md5nrgjBN8CZQYO41-wopA-1
Received: by mail-io1-f72.google.com with SMTP id s3-20020a056602240300b007589413aea0so20571004ioa.5
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 13:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqS1tmmJr7PAF8X4LNYoZBpPsb/UgoghZYeXc9m09Fg=;
        b=at6kp4DNDB4D/hG67zg9hZ+jsVud+qjMvMuO1sqHxQI9jg9LaJd8WyCeh34/+Xwpos
         iY9qDzQo1Gh5lW2M2ClFvXGsMb+uZjL5o1HQ+xwXgUpjDjQAtlobol9bWgLZKpjm0Thh
         XZMDPPjm0v/bfnuNVj/6Ulu4C8EoT5YMOJosY2+PMXmDYtQxnMUb7yWdJR6iTM/XpLO6
         6LiRS5W2aM+oIrBLno9DNirLkwBVUXbYG685DhYInHTTVCwntgPKrl/b0IM9TXFeetTK
         w3UMy22ujrPRP8l9z6KKFtcLZwPziIcdL7/XJwJtARyB6yWNHteu3ojK3D6fMe/iljgA
         WquA==
X-Gm-Message-State: AAQBX9emBh7hISjSwiGHwmrAHjnMX2Qpl9q7pn9nylnGYfvHHpaO+shM
        tNjopdDyJqlh9UGJgokjH+NvXjowA85Aay62mv/nsthDy7Mg9Kku0X0jUKZFFRTZv0jzYK61FIu
        jMR8a1OQmbU1J0LpKXwqsAQ==
X-Received: by 2002:a5d:818e:0:b0:75c:8ca2:c9dd with SMTP id u14-20020a5d818e000000b0075c8ca2c9ddmr3054669ion.13.1680640290847;
        Tue, 04 Apr 2023 13:31:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZjUtpAYCx6yaQp4dhQD6EMAb3LqUkY7lWvfjoqBYl2aC4WHyIt9JLMzzeXtpK9Oh7S0irxFA==
X-Received: by 2002:a5d:818e:0:b0:75c:8ca2:c9dd with SMTP id u14-20020a5d818e000000b0075c8ca2c9ddmr3054643ion.13.1680640290625;
        Tue, 04 Apr 2023 13:31:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id j195-20020a0263cc000000b003b331f0bbdfsm3476000jac.97.2023.04.04.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:31:30 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:31:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v3 07/12] vfio: Accpet device file from vfio PCI hot
 reset path
Message-ID: <20230404143128.52d8a256.alex.williamson@redhat.com>
In-Reply-To: <20230401144429.88673-8-yi.l.liu@intel.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-8-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat,  1 Apr 2023 07:44:24 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This extends both vfio_file_is_valid() and vfio_file_has_dev() to accept
> device file from the vfio PCI hot reset.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_main.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index fe7446805afd..ebbb6b91a498 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1154,13 +1154,23 @@ const struct file_operations vfio_device_fops = {
>  	.mmap		= vfio_device_fops_mmap,
>  };
>  
> +static struct vfio_device *vfio_device_from_file(struct file *file)
> +{
> +	struct vfio_device *device = file->private_data;
> +
> +	if (file->f_op != &vfio_device_fops)
> +		return NULL;
> +	return device;
> +}
> +
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
>   * @file: VFIO group file or VFIO device file
>   */
>  bool vfio_file_is_valid(struct file *file)
>  {
> -	return vfio_group_from_file(file);
> +	return vfio_group_from_file(file) ||
> +	       vfio_device_from_file(file);
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_is_valid);
>  
> @@ -1174,12 +1184,17 @@ EXPORT_SYMBOL_GPL(vfio_file_is_valid);
>  bool vfio_file_has_dev(struct file *file, struct vfio_device *device)
>  {
>  	struct vfio_group *group;
> +	struct vfio_device *vdev;
>  
>  	group = vfio_group_from_file(file);
> -	if (!group)
> -		return false;
> +	if (group)
> +		return vfio_group_has_dev(group, device);
> +
> +	vdev = vfio_device_from_file(file);
> +	if (vdev)
> +		return vdev == device;
>  
> -	return vfio_group_has_dev(group, device);
> +	return false;

Nit, unless we expect to be testing against NULL devices, this could
just be:

	return device == vfio_device_from_file(file);

Thanks,
Alex

