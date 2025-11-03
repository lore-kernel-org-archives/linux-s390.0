Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEB30E831
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179661; cv=none; b=IP3pv+aOn5ykQ+n1M6fjdgAhdBJXQ1e8VFi0hxknjYTPxKprC2P/sEwMxfxfBqq4rGRABLO0xPXTFwjY+DALZtSzNottXS7yPRRvX//sz70WFTe8aoBfiKPUQ90hvPHmiziZ6lrWXjTd/u3AWba9y1ThXrMzaBiYRBjahiTF8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179661; c=relaxed/simple;
	bh=1YE4N+9ygu7tvW7gCAtObLJcxrBRRt5nxWG3Dk/wnq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLY1xVuoXW5Vvjeo4qbe96hkWlnR+lTWdeIcAsNI1vlY3JlHwjsbU1m4YxHpju5AHsCbf2whI4wQGPmoaevcZbvTRygxX6arm45VtRONBwy5nI0WiuHB23VlFgTS1DnMQK16SrT61+OoHfWNBo6CJO5/LbHTGbDc6PuSaAj2GTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDcSarTK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDcSarTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762179658;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7uJpM+IX3iswe8DPfd0iPbF2mfDVsJfMczQqxcPMxc=;
	b=RDcSarTKLRgEH/rUCWYOFdKYYfxJxAlC7QrLa82uUSjMmMuVGfGKZkjU5HBjV9xA6N1Acn
	UZN+dZXQHu/E5Ehtcc83y8T4uUICBodpbM/mzHDt60O3B+cNpKKVnti1tS9DERUfsBrNwj
	c563B7wIBrRiHqSWZ0dAFrBIdEs6l64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-2f7MXTq7Ogir9cvcvyKnfA-1; Mon, 03 Nov 2025 09:20:57 -0500
X-MC-Unique: 2f7MXTq7Ogir9cvcvyKnfA-1
X-Mimecast-MFC-AGG-ID: 2f7MXTq7Ogir9cvcvyKnfA_1762179655
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c71c5892so1566021f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 06:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179655; x=1762784455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7uJpM+IX3iswe8DPfd0iPbF2mfDVsJfMczQqxcPMxc=;
        b=r53terlok6CEbLdSTUjyhrQbghe+URGXEpFrP6Qp106eyoSC6vTf4xZZBjcLqwVjuz
         ALqH1dp610hzaXoHDRIFvMCIxzYgXL+QxMDIB6PEEWmcaNlwrjDqh7LsF6bImFybkcw/
         ta0VFMC97bI1bVsTDS+s6lih7JCOgnNPDAXTPIPf/rEXLoa21h9rLcc8M3D463xFMhI1
         3owquXeqMGxppqUs27Z+EOXdgrrBtJBZcq6Goi0YCK5whtlwBr+uaslohNsI8YKacj9g
         il7n9kBRWN81tmQzk88C0q690cWygPEzCk7NTpDlNZ0q/AOJsBbe7RnCmv1Jy2X99Gc5
         JAUg==
X-Forwarded-Encrypted: i=1; AJvYcCXzLQXoRwq+xoCPoYvBwy2VmUHFK4l8Ui/WTqflNwBMHlye6WaIvlVFqsHIEDw99OYXgBw0YTxii7rg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9FLv3IVuVoXWfa86Fk9FgEsfx3oTEs6NBzU0F5Or5YQyrs4D
	7lRuVWjiFW+PX6kq67F7zhRXcmHyZhZm7tOVdXeFbTOD0++J/gnTXEMz1SH+aeAUYT7z86I2V9M
	UgOUNF2upMc1Q67024ZiYCAtoZc844lEwaVArjETaDW4/dfDr4wc/NUmY6VnrZxw=
X-Gm-Gg: ASbGnctk7WXrlw1sDm1xAxwBgFSvxV5FhKf7RI5amuaI25w7Pub/yOuhj/Ks40U8PBH
	eMjn1ctsenKtg51S9cQ0W0dQAyvZUN5WqHGNmM4+eCy2xn+pK6ttIryKg7MB6pfwNFfQiYt80i5
	54CHhaajBYNCGygGvqsHzlAeo1SEufvzaAB6rYXx6JuQTiKyGQiGH1hVMz3c4X48HWiuBPka4Rk
	KhmfQ/7PW6pkRfp4KNJPps+NTR19O1QLDjYIndiQMKG9zunLDccjo6jNm+QmbSk0l6RAXs8c9ov
	nZsZZN8aHzdXvpxgf5sbMMBwvsqNPe7tc3asqEzdLWVfXI2YJZa9WTrNhXNvSExLBEFRc+b1uZ7
	kjrQ1WscOLJcTPAQV/Xy/f/iBkiJFfFOM9pt87xlGi9Wa6g==
X-Received: by 2002:a05:6000:2c07:b0:429:d436:f142 with SMTP id ffacd0b85a97d-429d436f26fmr2390301f8f.57.1762179655451;
        Mon, 03 Nov 2025 06:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzkoLi+d77cMUSgKnEhwbdSo0rEoMdb6I48dSnxMn95tj2GQKmjbzhfBOjcWOs+RDqyIi7wg==
X-Received: by 2002:a05:6000:2c07:b0:429:d436:f142 with SMTP id ffacd0b85a97d-429d436f26fmr2390227f8f.57.1762179654772;
        Mon, 03 Nov 2025 06:20:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm20888368f8f.23.2025.11.03.06.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:20:54 -0800 (PST)
Message-ID: <e3eb5b90-5f56-4669-8c89-1f405d23c5d6@redhat.com>
Date: Mon, 3 Nov 2025 15:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 20/22] vfio/platform: Convert to get_region_info_caps
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, David Airlie
 <airlied@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brett Creeley <brett.creeley@amd.com>, dri-devel@lists.freedesktop.org,
 Eric Farman <farman@linux.ibm.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
 Longfang Liu <liulongfang@huawei.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Pranjal Shrivastava <praan@google.com>,
 qat-linux@intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Mostafa Saleh <smostafa@google.com>, Sven Schnelle <svens@linux.ibm.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Cc: patches@lists.linux.dev
References: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 10/24/25 1:09 AM, Jason Gunthorpe wrote:
> Remove the duplicate code and change info to a pointer. caps are not used.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  2 +-
>  drivers/vfio/platform/vfio_platform.c         |  2 +-
>  drivers/vfio/platform/vfio_platform_common.c  | 24 ++++++-------------
>  drivers/vfio/platform/vfio_platform_private.h |  3 ++-
>  4 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index d600deaf23b6d7..fa754f203b2dfc 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -115,7 +115,7 @@ static const struct vfio_device_ops vfio_amba_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> -	.get_region_info = vfio_platform_ioctl_get_region_info,
> +	.get_region_info_caps = vfio_platform_ioctl_get_region_info,
This would be nicer if called vfio_platform_get_region_info_caps I think
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index 0e85c914b65105..a4d3ace3e02dda 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -101,7 +101,7 @@ static const struct vfio_device_ops vfio_platform_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> -	.get_region_info = vfio_platform_ioctl_get_region_info,
> +	.get_region_info_caps = vfio_platform_ioctl_get_region_info,
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 3ebd50fb78fbb7..c2990b7e900fa5 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -273,30 +273,20 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
>  EXPORT_SYMBOL_GPL(vfio_platform_open_device);
>  
>  int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> -					struct vfio_region_info __user *arg)
> +					struct vfio_region_info *info,
> +					struct vfio_info_cap *caps)
>  {
>  	struct vfio_platform_device *vdev =
>  		container_of(core_vdev, struct vfio_platform_device, vdev);
> -	struct vfio_region_info info;
> -	unsigned long minsz;
>  
> -	minsz = offsetofend(struct vfio_region_info, offset);
> -
> -	if (copy_from_user(&info, arg, minsz))
> -		return -EFAULT;
> -
> -	if (info.argsz < minsz)
> -		return -EINVAL;
> -
> -	if (info.index >= vdev->num_regions)
> +	if (info->index >= vdev->num_regions)
>  		return -EINVAL;
>  
>  	/* map offset to the physical address  */
> -	info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> -	info.size = vdev->regions[info.index].size;
> -	info.flags = vdev->regions[info.index].flags;
> -
> -	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> +	info->offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info->index);
> +	info->size = vdev->regions[info->index].size;
> +	info->flags = vdev->regions[info->index].flags;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_ioctl_get_region_info);
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index a6008320e77bae..05084212a76eb6 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -86,7 +86,8 @@ void vfio_platform_close_device(struct vfio_device *core_vdev);
>  long vfio_platform_ioctl(struct vfio_device *core_vdev,
>  			 unsigned int cmd, unsigned long arg);
>  int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> -					struct vfio_region_info __user *arg);
> +					struct vfio_region_info *info,
> +					struct vfio_info_cap *caps);
>  ssize_t vfio_platform_read(struct vfio_device *core_vdev,
>  			   char __user *buf, size_t count,
>  			   loff_t *ppos);
Thanks

Eric

