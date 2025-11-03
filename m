Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27D191F98
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155029; cv=none; b=Hv1puSdExAv1vTQ1GFL8FwCs6Q6EGbA89YhlsFELT9I+VE6EmMGep5pF/LpFdspT/9fFUXOY13jPoaltlzXNetWOb+Nlrnil4H58C/ChXCYTfDVie2q9MiqTdkR5i0tQw1Ll9Epv2XfhLbmfSNxlJWqmKxOwZIayaAfHN3hiMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155029; c=relaxed/simple;
	bh=tcJ9j0rjVgX0LlfeiyBdhL1zp92EWqORHcfEAw97Bb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8xZFvT51BBUumrzM2QFBVQFXx1j27N4yoBtS42rt63DPs7irGfOw+0GYbIScjenssI0VDiU6x8lsjI2hFZsROQCg3IytEXS2VH/tcsx/7vFzQKc7dBi17gXPxGFEItaBqA8MWFKON+oco7QkyB4h/bIxPhgKDhE43ArGoAVIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScYNaf6f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScYNaf6f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d67abd215so384655ad.0
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762155028; x=1762759828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W00R51s/bFZ7FSKiqSW+6LDxOwjjTftHVYebWZvSUlk=;
        b=ScYNaf6f9EOtzOQ+sAS5/NNXTCvNQpxdkAV2QYmdeTmGk7qHtg1dL+WoarU5MJVKTm
         LreYu2/QO9ME+DFAfyKDgOSCox01ogr87O2YxPvjhUo3uCJ+RychcVj/l9o/QZBxMemA
         tsSSl9DGuK2pm24SICFT5FEyNQ6w8PHePwdau2l1Kxwus2avQriyj1hm7/RJwSyKKReG
         GjyZXBaWhzqGRy72bvps9tsGR/5BTWSQ8WwsYkMAc3lMZzHtHmBal8A7jyIglbEi5+Qf
         rwaxifVOp95CNWiEza32uTcIkgTEUq3mRqAdlASL62jPDdA9aMhIntPsXYS1fnKw3WsP
         kokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155028; x=1762759828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W00R51s/bFZ7FSKiqSW+6LDxOwjjTftHVYebWZvSUlk=;
        b=MLtXO5kz8tjNyF62EwWfYqfIa93p0byDdH5r0wKLW0wDzAXJcTCN+eGfBehjAn9dru
         eq2jcESRw2kuHh/bs8kRR9TGuGKct5D3LZtKj12kvl3xGWAogGwxnOLnFC02ZESepZ2N
         mawdVBIJSeLXaWarynXfwEdLSHPvO7oc5kg2FzNWO2AHg62kSFKuUVX8REzxFNpyGUdx
         /JA0s/1py7yF/+AJ5l50R2onuoamTvIb8YUDGDsJ1u30yw1HdDlKf1XxFC5OcAkPFrfQ
         85fA7KVfXsRvwJHX0cxQ4coHUtqmwihjgJVvsS3htEarHHTJnmyGeFtBTKZZwBKWYFwt
         ikvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzyyWu9qS8p24ipjZvI8kmIfzJfJOx4vZk7eMy+AJvywFe0tdhq/rUVahp1rhZVKI/OTCSgwOsOre@vger.kernel.org
X-Gm-Message-State: AOJu0YzC04THZh7hjP1LcgXUQX2kudvSkC2QYVXnhnruy0goj4gaTBEO
	vbW/h9feRnxVDc5Sn9eTfZC1fP8nWprQAzGtXh6AKn+cS4PDAdIE1cQV3rcImvZPfA==
X-Gm-Gg: ASbGncupycr+IAO8Q5HJUrF8XuyBjq6pMfrBjO5lrTqyule07QRzRVt5I4m7SPjmMF2
	p7/apN498mHlq2KXPqmEq0J0y8p2jPM1UbQL5UEy1J/MqEusBCq/tYpd8WEKmfdpNAN/zLJ+eN/
	yqVw2xL7XdkrT7vxfNs2G43UXwDRIY3aaLMIHiXC+oFARtE2HdWLVhYqidFdWp1escrJ7sEofiY
	HmjoSDOxYqjGom/jUPwB63JbSk4xhMSoI/dah78LcO84z/1kRlVo66ftNPH44PDvBQf51e1K4BP
	l2D6wM6g/Z8kV8YvgbPBbdhm+/kFTqbjf32FDvmlppoYD8bzZT7vCcYqn+XRuRcjw/zmEO0Ob3W
	zG6oKNAHgQOadDs6hJ5mvrygg/IzWvxjlWFZQnRZJROCIZmOpLYKa9NmMuhaaG2Y+fUPXxiFdI7
	RtCqDNIfyQ1s1XAYRb5RGIAfrZTUIJ0LOex6ATpA==
X-Google-Smtp-Source: AGHT+IFjaXH+x0wDYP1YTleZ6beMQ7i4yOeGqaMcf/YJxMNIbFnQkDy7S1c8+nxpPDJ2MzqKvGx2GQ==
X-Received: by 2002:a17:903:1a70:b0:295:28a4:f0b3 with SMTP id d9443c01a7336-295549cab2dmr7007095ad.0.1762155027242;
        Sun, 02 Nov 2025 23:30:27 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340acfa77b8sm8320159a91.18.2025.11.02.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:30:26 -0800 (PST)
Date: Mon, 3 Nov 2025 07:30:16 +0000
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
Subject: Re: [PATCH 10/22] vfio/fsl: Provide a get_region_info op
Message-ID: <aQhaCAAliYQVNjgK@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <10-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:24PM -0300, Jason Gunthorpe wrote:
> Move it out of vfio_fsl_mc_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c | 55 +++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
