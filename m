Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FD2F9DB1
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163744; cv=none; b=ANP/LhO6rvsAa3dTeczTXxgbzERFJkMUgkKP4uxxgHylPUdwl/4IZallsmUfYB/3DmOSWYMrNRb61WzZs05BBQVs+q5KnOPIZu679NbyyngNY6OAY/wbSFs8bGbt82Sb6Tgmctx8/bZrLMES7zLCpcsWRUp19hGuXt2yafH2nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163744; c=relaxed/simple;
	bh=i8L9n6bZwkPz17FpheWU6M/n9dfpcR4hkCB+s7fwei4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGdvxFD4+c5VIfp+d1ITCiUpGAghZaXd38p3sJQRajEcoPabLqYWg07iYHleXmbHVeXD36KrH3QmZYp9F8vSbMooOMgMOPKn7H3OuKTvqpMOq5+jhim22obUF9M88WNfEt2gn/WY/jVa1+MxLgpno4v47TWnxlGK1e8/lfAY9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XX8g3HId; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XX8g3HId"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so71995e9.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762163740; x=1762768540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iKwbtWviZdAY+4F++DJl0rWWY/RQA9LSGiuI2/hl/A=;
        b=XX8g3HIdR62tQ5iSGkYke8Tla2ThkWnY4c/NvitotakLZ44KI1lZjo+cd+OG3bKDjC
         tw8mJNQc2fgc5nlrDAv7h57tpqzbzTcsECX8Hq9V+Xl3i04AMqe6fJkJctx3NNB6WkuY
         wUU8gQPkBq+RONN5dldbLB5/8RvRSkaDZ7RK7lFIaYnL4ENoFbwU5f1MnO6ascr4znVQ
         lZJ9P9tnHYq7SvGLfBcsMpWBNOlqnL4gHxtEWMiz3u4/8rCh21luOnmRsoDznEo9hLLR
         8AATk5jdorEx4DgE38jBEAxejYW5QrNAtS2GesGwnfUQXgDDlb4QvY0H4MOPqwFrV/Lx
         dCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163740; x=1762768540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iKwbtWviZdAY+4F++DJl0rWWY/RQA9LSGiuI2/hl/A=;
        b=EHP9rwVyV11fbo/nzyjyPm4cktfp6ht050OSkoxZi8MjzOLHpaRiy1asOrF/QVWF7n
         lfuIB6vD4dL+Xcut7IumOydFa016pRoR4BgbXAEGfwdKU8zVSQzQ8QtF77xbKWOEoyYc
         3yRACJKaYoPHaC1Mjq24q8Pl92SlbSUn7/mpg7Ed9W/JhrFPJKH5rzF6MMOUNn5zOIFt
         94r/iX4rBL0ESy6dInKHvwKoP8HweZiVseLzoQ2vYq7HhmhdmLZZX9bapDFasqYeI7ca
         RvPIlGFh9cdbtQuKztfqRY6rDrAIZjQF0MpL+2mAmyVAhKjn8AElUDUWA/NeGKo05I4m
         gOtg==
X-Forwarded-Encrypted: i=1; AJvYcCWf0/D5IV/SdyQiEbJ/dzk0Thou5XFaWvgNwFgJT6OPPwl8WTnDwePvyOBoO5lHgHY5e0zoAv40CIYh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5JaE7MKGarB9gh/hQb1tOPvrEuhPajMAvGUn/Qwc3hmOVmuZ
	MEnqch78czA4o3HipNBlvGa9E6tfExsQgQfedpM7KUxipZurpfY9QY51yYjcCH21tw==
X-Gm-Gg: ASbGncuXryXpKE5ug1UT2Ov+edo2/TUDYjkbgNnWueBUOKdUnOks+eanWCHUuDzwM6z
	CwTgHAsOTSR/Q1i1sQzSsmYJQSCsPYVulHtil8OgEHPISDzgeZduEL6GeJ870021FCJBCSgI2Eq
	b52ixgUB4N6IyA7u3norWNB/qNNkHN4PBG2JU/3Ys3oGiZrYWkKGan+I8RkYEhyrVvKv79hOMGb
	DTeRmvpUZvQC2Q1E0JJGMnTvrOUuc+gyfl/TRpZ/Y/ESK3sq9gdusZ3yX59yE053WAvkEJnaKti
	hDzzsqS58hyLEC6rVVzLibVcYvbpbNBr4zua+7qW6Z/5kBC8zoMXtguhnCpTeee9ct055+mIVEe
	PInybYjKXGKGlatmLDQL5zEXCBYokBmYbDjiXgQKjKWkdpo6HgUsGfcpY622grNpZI2jBV+MbDw
	nBjDAhSJaxyufr9SUgSe5q5I8PHMkTJh4pCn8312zCGG8inz8B5A==
X-Google-Smtp-Source: AGHT+IHAx+AWORE9paLXTzRW7mKzqe0hb2wtQ9DF+W6v23M9Vo/fGIuffOpRO4zhYPoMBhdyXFmsSw==
X-Received: by 2002:a05:600c:8a0d:20b0:477:255c:bea8 with SMTP id 5b1f17b1804b1-4773da9baeemr5918155e9.7.1762163740369;
        Mon, 03 Nov 2025 01:55:40 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13ebfe8sm19975798f8f.35.2025.11.03.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:55:39 -0800 (PST)
Date: Mon, 3 Nov 2025 09:55:36 +0000
From: Mostafa Saleh <smostafa@google.com>
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
	Halil Pasic <pasic@linux.ibm.com>,
	Pranjal Shrivastava <praan@google.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 14/22] vfio: Require drivers to implement get_region_info
Message-ID: <aQh8GG15d_-Ge2Xx@google.com>
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

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

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
> +		else
> +			ret = device->ops->get_region_info(device, uptr);
>  		break;
>  
>  	default:
> -ioctl_fallback:
>  		if (unlikely(!device->ops->ioctl))
>  			ret = -EINVAL;
>  		else
> -- 
> 2.43.0
> 
