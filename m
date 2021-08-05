Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461CC4338F
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04C660249
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 12:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbhHEMh3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240188AbhHEMh3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Aug 2021 08:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628167034;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRFpagrypVV+BGgRFYp8N3LV+BiQcza7EUvR3XzPQfA=;
        b=UKGLG1v+jOjVqxOJ7tDM3thTGCrXMh1d5tF9LoTd1Laiv51wtQeEA+Lqe72JAmfh+QwKHT
        RC2ghY6BXcTOLhKGA7jilnJnxCT9tP91qdfUAWYYA/vUE3jAQujNFE0/b2ZlumVhkX5dgL
        /B98tbebm1jeRzNHPJ5UiquYpFe4b6g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-X_HmDG0WOAWXW_sarrotlw-1; Thu, 05 Aug 2021 08:37:13 -0400
X-MC-Unique: X_HmDG0WOAWXW_sarrotlw-1
Received: by mail-wm1-f70.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1532759wmr.9
        for <linux-s390@vger.kernel.org>; Thu, 05 Aug 2021 05:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=NRFpagrypVV+BGgRFYp8N3LV+BiQcza7EUvR3XzPQfA=;
        b=Nny+spLi8mQvTgJhHl1xZWTCQDaiajceabHnrEV8RWGd+072WteZ0kJIeLisMqvMWt
         tz7jRoPAxWwuEYS3f/TeASyjsBbXcAqDXYwCoGAVDnJ70z3g85Dqvhu0p/jhrNUEB/Iw
         wkAPlLW3buY50CRYpgHSahyk758v7JOOuBJAf9jDNJaXMbUiHuAq0iWHUcz8SppTa3O7
         a/Merv+ovm18p7FHU2CIYg70WffPDaHwxH8iW7q5uJgq/DuCHpamXwbwOVGinNi7DIH9
         e+ggtudGmPuXX5ApOe7PkElI/6axQ7hWhvWIF/TehbkZBH5X4xdSUbgdcWM+kKbF0cO+
         2XzA==
X-Gm-Message-State: AOAM530UW7ARbn2VUz7HYMvUPGVEMIn2AorG7ienyHN0J9T5RNfHDYdB
        qKxDhdeycMN9b5s8ozmoDR6+BZHO/n6jCou9i1bizbdUpPTIqaChMmyw2FsTpfvPgmt8eL880qZ
        9XO1dy7jrd5In7HUKpOERPw==
X-Received: by 2002:a5d:4f0c:: with SMTP id c12mr5169977wru.63.1628167032749;
        Thu, 05 Aug 2021 05:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLHu+SrQzVLrFOrCnDgagxvjKpgeH23p69mYneoScqalozuO0wL4WFwc163DLzD2q1Rkkonw==
X-Received: by 2002:a5d:4f0c:: with SMTP id c12mr5169935wru.63.1628167032543;
        Thu, 05 Aug 2021 05:37:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id b6sm7164149wrn.9.2021.08.05.05.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 05:37:11 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 07/14] vfio/platform: Use open_device() instead of open
 coding a refcnt scheme
To:     Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
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
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <7-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <17c13ccc-8a4a-d784-4237-0014ade1f4fc@redhat.com>
Date:   Thu, 5 Aug 2021 14:37:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jason,

On 7/29/21 2:49 AM, Jason Gunthorpe wrote:
> Platform simply wants to run some code when the device is first
> opened/last closed. Use the core framework and locking for this.  Aside
> from removing a bit of code this narrows the locking scope from a global
> lock.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 79 ++++++++-----------
>  drivers/vfio/platform/vfio_platform_private.h |  1 -
>  2 files changed, 32 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index bdde8605178cd2..6af7ce7d619c25 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -218,65 +218,52 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>  	return -EINVAL;
>  }
>  
> -static void vfio_platform_release(struct vfio_device *core_vdev)
> +static void vfio_platform_close_device(struct vfio_device *core_vdev)
>  {
>  	struct vfio_platform_device *vdev =
>  		container_of(core_vdev, struct vfio_platform_device, vdev);
> +	const char *extra_dbg = NULL;
> +	int ret;
>  
> -	mutex_lock(&driver_lock);
> -
> -	if (!(--vdev->refcnt)) {
> -		const char *extra_dbg = NULL;
> -		int ret;
> -
> -		ret = vfio_platform_call_reset(vdev, &extra_dbg);
> -		if (ret && vdev->reset_required) {
> -			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
> -				 ret, extra_dbg ? extra_dbg : "");
> -			WARN_ON(1);
> -		}
> -		pm_runtime_put(vdev->device);
> -		vfio_platform_regions_cleanup(vdev);
> -		vfio_platform_irq_cleanup(vdev);
> +	ret = vfio_platform_call_reset(vdev, &extra_dbg);
> +	if (WARN_ON(ret && vdev->reset_required)) {
> +		dev_warn(
> +			vdev->device,
> +			"reset driver is required and reset call failed in release (%d) %s\n",
> +			ret, extra_dbg ? extra_dbg : "");
>  	}
> -
> -	mutex_unlock(&driver_lock);
> +	pm_runtime_put(vdev->device);
> +	vfio_platform_regions_cleanup(vdev);
> +	vfio_platform_irq_cleanup(vdev);
>  }
>  
> -static int vfio_platform_open(struct vfio_device *core_vdev)
> +static int vfio_platform_open_device(struct vfio_device *core_vdev)
>  {
>  	struct vfio_platform_device *vdev =
>  		container_of(core_vdev, struct vfio_platform_device, vdev);
> +	const char *extra_dbg = NULL;
>  	int ret;
>  
> -	mutex_lock(&driver_lock);
> -
> -	if (!vdev->refcnt) {
> -		const char *extra_dbg = NULL;
> -
> -		ret = vfio_platform_regions_init(vdev);
> -		if (ret)
> -			goto err_reg;
> +	ret = vfio_platform_regions_init(vdev);
> +	if (ret)
> +		return ret;
>  
> -		ret = vfio_platform_irq_init(vdev);
> -		if (ret)
> -			goto err_irq;
> +	ret = vfio_platform_irq_init(vdev);
> +	if (ret)
> +		goto err_irq;
>  
> -		ret = pm_runtime_get_sync(vdev->device);
> -		if (ret < 0)
> -			goto err_rst;
> +	ret = pm_runtime_get_sync(vdev->device);
> +	if (ret < 0)
> +		goto err_rst;
>  
> -		ret = vfio_platform_call_reset(vdev, &extra_dbg);
> -		if (ret && vdev->reset_required) {
> -			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
> -				 ret, extra_dbg ? extra_dbg : "");
> -			goto err_rst;
> -		}
> +	ret = vfio_platform_call_reset(vdev, &extra_dbg);
> +	if (ret && vdev->reset_required) {
> +		dev_warn(
> +			vdev->device,
> +			"reset driver is required and reset call failed in open (%d) %s\n",
> +			ret, extra_dbg ? extra_dbg : "");
> +		goto err_rst;
>  	}
> -
> -	vdev->refcnt++;
> -
> -	mutex_unlock(&driver_lock);
>  	return 0;
>  
>  err_rst:
> @@ -284,8 +271,6 @@ static int vfio_platform_open(struct vfio_device *core_vdev)
>  	vfio_platform_irq_cleanup(vdev);
>  err_irq:
>  	vfio_platform_regions_cleanup(vdev);
> -err_reg:
> -	mutex_unlock(&driver_lock);
>  	return ret;
>  }
>  
> @@ -616,8 +601,8 @@ static int vfio_platform_mmap(struct vfio_device *core_vdev, struct vm_area_stru
>  
>  static const struct vfio_device_ops vfio_platform_ops = {
>  	.name		= "vfio-platform",
> -	.open		= vfio_platform_open,
> -	.release	= vfio_platform_release,
> +	.open_device	= vfio_platform_open_device,
> +	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index dfb834c1365946..520d2a8e8375b2 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -48,7 +48,6 @@ struct vfio_platform_device {
>  	u32				num_regions;
>  	struct vfio_platform_irq	*irqs;
>  	u32				num_irqs;
> -	int				refcnt;
>  	struct mutex			igate;
>  	const char			*compat;
>  	const char			*acpihid;

