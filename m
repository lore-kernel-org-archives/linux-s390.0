Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0F2C15BA
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155590; cv=none; b=EHf3//HYKcpdObDukBKnytVHApsFI7ucC1xha9zig0VAuI5MLkVTIDajUerb0h8YxofGqExHfCgeSziK3cMSjwTmXU8+parrSx+o/DmxHCrNKBBOxjSjRHofu2n8qN7mG+NhSOu7VTSXu3LSz91Gpfhf3t7CtOct81XlDIC+KYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155590; c=relaxed/simple;
	bh=30R4PwwoDn0ue1N2GS0GOY1SWIFA7GBPa8q4kx5mc+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSIVNg8trAbnLZBkC9qVkO6+qQjjq50rDX2IpJi98KONlJoMF4Ir6rNL4lISMIItSH8jEs1xITXh9ScszPoytpr0CENlV7coI4vGk7UZEvk5pm1z9scOe60LsRQgFAr04dTdPtTQfOagZRIVlpEwkvJ2pfE3ngMuGnsSXIcQzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xbSGM1m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xbSGM1m"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295c64cb951so89455ad.0
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762155588; x=1762760388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzwh3KfEQpKPksD5Xn4ZAd8EEqdDZL8lWisUmSvX4T0=;
        b=4xbSGM1mPiF/5mRata4Qedj/4eMBsRxrlBvOyJ/WRxJmYaaudM9u/jHawCavHJy5zS
         zNajQolEqAOlkri6Y9CYfPH+Xz1QidD1HKDek4zBj0H4+/tTWlB26MuDTKkUaJx8h7sV
         P2V8EOfUxIX82cSMk/UpbFQNAidfIwJPcXMJZwOhAhEz3UWc5LhY1FplbXJlk5DlZtdI
         R9pLstQWJi9iwyAmV/TG60n8N/419R61sruPSBuh8zMksPHKd5cQ1vJ2YNVqm3I6uM49
         Vb5SIwDOGLz5Wlzb/ka/p3RpES6a+ruAN/bIuoeVjeTXr403latneInTCizTGfrihLqB
         IeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155588; x=1762760388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzwh3KfEQpKPksD5Xn4ZAd8EEqdDZL8lWisUmSvX4T0=;
        b=w94B8eJxwwswjq+vTQaPxWr2ZyZOnyKrFRSFaUk8fuQSj4O5gbRTCx5oVBiYuovrP/
         /myVx5HiV2a31vOMx8tGAvd7jgIff4aW11wKjx7IPm23OeYxMgZGYbCVW3p02zyp5kZH
         5aw7vspHxGh6BiLHZnmyiqwOwuIGz2maOZqZPY5JlEOhC7xI881qJx+/zEudG8fpkcpv
         JuBQIBejk3CllpNXKvWGrjV1HAsp1Yj6zXVcEtggzV3C2cmgrurOwEtENbJ6rOm0hs6Q
         /RvKEr3gepRXeGghIs2j2DyhTF79hTwZVpTvibrsP4HBilV1FMO5ulqwEe0Mt2SjArKG
         tLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUVllQHLecfVbx0qra9uWF/zTqIxv+FS2g28ZxL1/3z6VIW7uh6C2fWhGOfsU/X+gHsBz22juIc1Knm@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdraN3MxTPsz3zJh9OxGBriqzFKvLcA7t9t3hnFbhfhTnMU2N
	gN4abSel9lvdNtYcO9CAEgqNKNWjnmxa2NHMRd0d1nBszhpUuuD+au3na+1Do6Ek2Q==
X-Gm-Gg: ASbGnctZBC85jOEMdlZuLRMNa4erwWtobAamv9UkXarxVQJkA4VQHuMQGarPhwFOLxz
	KWpInY8oBab3GnELBGH6VLH47NOXsR/HZCBmwsUf4uzA5pYt5aEkozhMMh7Yx3+K9y3uZLDiRJd
	DjpgYHV9X7hXFB+IdfDJhdfkx9b2Y5AYenIGebcA2bksts7MLwh3sKymrwWINqKUzZ+f9eSWkVD
	ejOJZWvCGwx3Z6zgxnloIo7Bu04ZNyPMNxDBfqYc+sD458svz6VYrXXKBJ/y6/LwmpsNVP/g8gQ
	w/kfVpB9dYxAIwcEMrce+uVeQhJwknv92urbMbdmv1bW9ZCAADbS3islNrBJd2D2W+25OekzQUt
	YSR3IyQFzhaIIlFseoKtmOw+s+zoIqWCXXj5Hrw3w4uI6w0Cl3Sg2DDo+lTvxayME5/p191X7H6
	XlsNaQVffVk+1TgYAfup1pJH8VB4Yq2kg9UEnpt2NEuMXDFOn0
X-Google-Smtp-Source: AGHT+IGoX/eRPHIgiRFzzACV20d0ftHJvRprPrWC1Oq8kyrn4muK0Mu+0fpj1flmH53tBH91iPLzGw==
X-Received: by 2002:a17:902:ea0d:b0:24b:1741:1a4c with SMTP id d9443c01a7336-295549f6bcbmr6601575ad.0.1762155587782;
        Sun, 02 Nov 2025 23:39:47 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952e9a399csm102714425ad.33.2025.11.02.23.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:39:47 -0800 (PST)
Date: Mon, 3 Nov 2025 07:39:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	David Airlie <airlied@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Brett Creeley <brett.creeley@amd.com>,
	dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 14/22] vfio: Require drivers to implement get_region_info
Message-ID: <aQhcOYVbY-LqOjW5@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <14-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:28PM -0300, Jason Gunthorpe wrote:
> Remove the fallback through the ioctl callback, no drivers use this now.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index a390163ce706c4..f056e82ba35075 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1297,13 +1297,13 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  		break;
>  
>  	case VFIO_DEVICE_GET_REGION_INFO:
> -		if (!device->ops->get_region_info)
> -			goto ioctl_fallback;
> -		ret = device->ops->get_region_info(device, uptr);
> +		if (unlikely(!device->ops->get_region_info))
> +			ret = -EINVAL;

Nit: Let's also add a warn/err log here highliting that the device
doesn't populate the get_region_info op?

> +		else
> +			ret = device->ops->get_region_info(device, uptr);
>  		break;
>  
>  	default:
> -ioctl_fallback:
>  		if (unlikely(!device->ops->ioctl))
>  			ret = -EINVAL;
>  		else

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
