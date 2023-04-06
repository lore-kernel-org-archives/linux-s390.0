Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E683C7618D
	for <linux-s390@archiver.kernel.org>; Thu,  6 Apr 2023 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjDFQpx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Apr 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbjDFQpn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Apr 2023 12:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A99559B
        for <linux-s390@vger.kernel.org>; Thu,  6 Apr 2023 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680799496;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cj1qdraUDIqQ4wyinXOunxUjzkj6NEpe76it1VNYXg4=;
        b=U9xrM+JdJFxzzj8sS8SM9/eLSM751eu1b7u9NtTfvD7KZvGKSPIv/wTX8fXJOI0ZD4Fro0
        XCOIBi6uiM629Rt815+Y9riT3ySE9nwSe0If+xAEf8FYuw63y9Sjmor9BDp/rpEI8df/2I
        yb9z9n2AzzdNbOVOSUFd9hWgJVpOxXI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-58KdiZ9GNH-cqVu6AEN1BQ-1; Thu, 06 Apr 2023 12:44:55 -0400
X-MC-Unique: 58KdiZ9GNH-cqVu6AEN1BQ-1
Received: by mail-qv1-f69.google.com with SMTP id dg8-20020a056214084800b005acc280bf19so18165568qvb.22
        for <linux-s390@vger.kernel.org>; Thu, 06 Apr 2023 09:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj1qdraUDIqQ4wyinXOunxUjzkj6NEpe76it1VNYXg4=;
        b=Pt/Urm0ENF5PBceBiGWe+kVjtDIZDocQnqQk31Gwo8jxn+srjN9HFP/DgYvUxB8g+f
         bJnjlPvrGSIFgUjQxMOr7sI2A6mncbb2N5aQwVLHnv1wHS5JDi6DthYn7mC84xj6V1dX
         Cyj6HSpeSkectOpJM4qnfEwVj/WuWBk+5InM06pQ8aWOhxq/liLIiUfESaBluZMVhGZm
         5CYifI8BZyyAYSDz9fIgqw9AKXGBSkMMCobhbl+XrOIJmkoCEpx8La/9HsUCo/kNLGpI
         oY3kkaw2yGI4KyprcuPEvDLXmy6CUFlnF7kpBCKYln43A9iWT/7aZJ54anWFli2LPvIe
         2vVw==
X-Gm-Message-State: AAQBX9dB89JsBaAbtyR+5FN93I1JF8DWm0Qa6VDuUPBt4+/S5jZAH+iY
        +IfqyAmIX4lL3cQSpCqiXBQSjlAy3Nvwg12ymiYVKAhAZxk9cx4SNe7kQaEIClEW3z3fuCcaBL+
        DV5Sm2SNvnFhMIi1RwsXPjg==
X-Received: by 2002:ac8:59ca:0:b0:3b8:2cf6:4bd6 with SMTP id f10-20020ac859ca000000b003b82cf64bd6mr12365682qtf.57.1680799494849;
        Thu, 06 Apr 2023 09:44:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZSS7EeAJwH0ALWV4bKpdOrqM0X6ZUGe2iW062njbJkUl7t6KGbG/PG3FNAG8z/sy0GF4g7UQ==
X-Received: by 2002:ac8:59ca:0:b0:3b8:2cf6:4bd6 with SMTP id f10-20020ac859ca000000b003b82cf64bd6mr12365645qtf.57.1680799494556;
        Thu, 06 Apr 2023 09:44:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id h7-20020ac846c7000000b003e3921077d9sm532848qto.38.2023.04.06.09.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:44:53 -0700 (PDT)
Message-ID: <dbf2057d-b715-f32d-454a-e4953921d232@redhat.com>
Date:   Thu, 6 Apr 2023 18:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v9 10/25] vfio: Make vfio_device_open() single open for
 device cdev path
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
References: <20230401151833.124749-1-yi.l.liu@intel.com>
 <20230401151833.124749-11-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401151833.124749-11-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/1/23 17:18, Yi Liu wrote:
> VFIO group has historically allowed multi-open of the device FD. This
> was made secure because the "open" was executed via an ioctl to the
> group FD which is itself only single open.
>
> However, no known use of multiple device FDs today. It is kind of a
> strange thing to do because new device FDs can naturally be created
> via dup().
>
> When we implement the new device uAPI (only used in cdev path) there is
> no natural way to allow the device itself from being multi-opened in a
> secure manner. Without the group FD we cannot prove the security context
> of the opener.
>
> Thus, when moving to the new uAPI we block the ability of opening
> a device multiple times. Given old group path still allows it we store
> a vfio_group pointer in struct vfio_device_file to differentiate.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/group.c     | 2 ++
>  drivers/vfio/vfio.h      | 2 ++
>  drivers/vfio/vfio_main.c | 7 +++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index d55ce3ca44b7..1af4b9e012a7 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -245,6 +245,8 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
>  		goto err_out;
>  	}
>  
> +	df->group = device->group;
> +
>  	ret = vfio_device_group_open(df);
>  	if (ret)
>  		goto err_free;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index b2f20b78a707..f1a448f9d067 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -18,6 +18,8 @@ struct vfio_container;
>  
>  struct vfio_device_file {
>  	struct vfio_device *device;
> +	struct vfio_group *group;
> +
>  	bool access_granted;
>  	spinlock_t kvm_ref_lock; /* protect kvm field */
>  	struct kvm *kvm;
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6d5d3c2180c8..c8721d5d05fa 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -477,6 +477,13 @@ int vfio_device_open(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&device->dev_set->lock);
>  
> +	/*
> +	 * Only the group path allows the device opened multiple times.
> +	 * The device cdev path doesn't have a secure way for it.
> +	 */
> +	if (device->open_count != 0 && !df->group)
> +		return -EINVAL;
> +
>  	device->open_count++;
>  	if (device->open_count == 1) {
>  		ret = vfio_device_first_open(df);

