Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5722FE58F
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167829; cv=none; b=MZmqZ1fWiywPpOTvdrGliOXZov+D+YnbFhWHku2xvTbR4DptOEofxAXZ2x1N/2y4BBbGShljvRezdZAl/VF5C4snCgFow3v347ENC3ckGoTr206DE9vXNhNoqOQFrhxngsjTUk0UTzxdAIZXF5Pu23y5z9rHTQ6NiJ+K9rHWUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167829; c=relaxed/simple;
	bh=oQx/ydTW/nop4AcGUNLqHSf/CC+CTlJRuLVJVH3L6VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvOuVgphN+zzjl16PrGbkoonSDfGrWDbhN6OEO68vFMDSFpuwF4q8f82XA1ItFpb3fdW5GtcjAgJxSkM6/7Ka4nDV2QO5qcJPF4n8ca19z+tDkFmWQgT+cCK3e73sKJ+KFt0r3UqKLVTkE2KI+kQag46SqxvqnCDTiyBw+nrLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRVmQ2zX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRVmQ2zX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-294f3105435so379595ad.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762167827; x=1762772627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JG+etGO4DCF1PIFwJUo34O2NHRXv7sGubVRA4h3tffk=;
        b=bRVmQ2zXPdGFc+lD7QW8lkWRxOkiU3FbeBUvS9oL1tI4C6PpIMP6iO0sTiNBy6vgH3
         mrz/o1uZWUar997JrzXtMJufZBEjurpKwWYEeyk7fED4GkF2gflB15JTNca0tDHQSaMl
         nsPL+F0lSqvFlQio+t4exBEdq4AnmyCUDR5Rd5t5xHZ4EYBBdDrF0LraUU9eRoaUs6pQ
         IKyp/cpp2DPTgWVvxu+5TE17m0Umr0O/AMdG1l+aorm1/xwSngPlnxxw+UChmbs+LQ62
         Eamf4j4reFmOaF0VKqqnqfnbbgnoAJgTzOLMC6fuZyGecxOB8o4BZXQN8zVHUxqvMfra
         nftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167827; x=1762772627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG+etGO4DCF1PIFwJUo34O2NHRXv7sGubVRA4h3tffk=;
        b=L0n/86lcOHfBxY4Mc5jlY+2U0H7u+f/t254T0axNwoXNfbMeSJX/Z1R0WNATFhxvcx
         nkliqY5whw4CBerI1ba+UlGvlWhj9PFHO9GFOB9AE00vI+qyFbd5tDnqHnPhc6n1SKs0
         zm3k2iOtC8Jot7j96tudHAbxONAkVYbH+0PUzBI5/cNuNYKHCgQevQ4562V7L+KItmBR
         YshwMpTj76/zJkexE8dJkeoJ4nUwuzbABQ5vE6HECNjWYId8lwBKPFroLKwFwZfMgrwa
         q3oXqpHZTLgbHk2V78/RD/NYC7SIAu0lDXx3DWkvL1c9fxHuQUP+iLxR6xubyqZ+QkIj
         10JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXflWVkrSViT7+LsYcwi3R0qP52eVcjepz1y/2cyo9c0TMs1Yoyf/FZgHCdGFMFOQ3zuFSM18vc3ymV@vger.kernel.org
X-Gm-Message-State: AOJu0Yypm31twk3b/2darfOchpL9DuSZpEcWD7cmi6rdb7Ips577Ak9S
	nTxZKs8+qQbzOvUQ9KG9RUYyY5jI6m3bv15v8I7IpIUFGHAhcB95VHc5AFgKwdaJfg==
X-Gm-Gg: ASbGncuYvseIlP2pbRNkDZ/4S+ogcRQclVdIeobgN6qoDgQIWtmEmDEm290ogI3E06k
	NuEMLUE3k4bxZ5eJaEOKc5HWZGScYksBxDOK9skmEaLoIz4x6IgkdBxdoifL0AJmD8aq/4eKvN1
	M+h1BgT9OR5q/KZBUbPNinqURc4/iwL2kry6CDV/tjObm+FMqD33Q1v5HOoTaLOE9qQMfApwcvU
	EHqlqC6Zow855Efvs/e98XLHrmqtXuJ4C0Qm1hBSvio56sxU1BtKAuO7WqueU7qLLVcyCtOA7IY
	W40Ea13JKgxFLFKhDRb/EmW7c+hxkKcVuFdJ0jRjkw6OzZHBJ1bbmvFxpIUvu0j/McpmaQgGnQ6
	MzHziW4hNGmIRov+QXqAEgvLd5Ht66VhLWfngrlU1oYqoZJ7bYgBH0V/rg4h4fDeg1I8QeUoP3M
	0z1Gnh7ngD7yVDiHNPsXjd8G0GO27u+mkPMLNfow==
X-Google-Smtp-Source: AGHT+IGcDUbk6qqLdQjGL3Yxey3X8mTSWxpSXkjqaoDl6gxo10SeAyfD2HQnpWNy1nfGBwMDtJcUBw==
X-Received: by 2002:a17:903:228c:b0:271:9873:80d9 with SMTP id d9443c01a7336-29556476bd0mr5742325ad.7.1762167826744;
        Mon, 03 Nov 2025 03:03:46 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29537cccdecsm102934645ad.19.2025.11.03.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:03:46 -0800 (PST)
Date: Mon, 3 Nov 2025 11:03:36 +0000
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
Subject: Re: [PATCH 15/22] vfio: Add get_region_info_caps op
Message-ID: <aQiMCKszFCvDDHhH@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <15-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <aQiBGEgQ3vCpCvXM@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiBGEgQ3vCpCvXM@google.com>

On Mon, Nov 03, 2025 at 10:16:56AM +0000, Pranjal Shrivastava wrote:
> On Thu, Oct 23, 2025 at 08:09:29PM -0300, Jason Gunthorpe wrote:
> > This op does the copy to/from user for the info and can return back
> > a cap chain through a vfio_info_cap * result.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/vfio/vfio_main.c | 54 +++++++++++++++++++++++++++++++++++++---
> >  include/linux/vfio.h     |  4 +++
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> 
> The newly added vfio_get_region_info seems to pull-in common boilerplate
> code (like copy_from_user, arg size validation) into the core code,
> removing redundancy across all other vfio drivers. LGTM.

I missed one thing in this patch (luckily caught it in patch 22):

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index f056e82ba35075..82e7d79b1f9fe2 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1259,6 +1259,55 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
>  	}
>  }
>  
> +static long vfio_get_region_info(struct vfio_device *device,
> +				 struct vfio_region_info __user *arg)
> +{
> +	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
> +	struct vfio_region_info info = {};
> +	int ret;
> +
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (device->ops->get_region_info_caps) {
> +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +
> +		ret = device->ops->get_region_info_caps(device, &info, &caps);
> +		if (ret)
> +			return ret;

device->ops->get_region_info_caps (via vfio_info_add_capability) can
allocate caps.buf and then return an error for a different reason. The
if (ret) check returns early and the kfree(caps.buf) on the success path
is never reached.

Should we add kfree(caps.buf) to the error path here?
This keeps the allocation and cleanup logic centralized in the core code

Let's either write comment saying that the get_region_info_caps op is required
to free caps.buf before returning error OR add a kfree(caps.buf) here.

> +
> +		if (caps.size) {
> +			info.flags |= VFIO_REGION_INFO_FLAG_CAPS;
> +			if (info.argsz < sizeof(info) + caps.size) {
> +				info.argsz = sizeof(info) + caps.size;
> +				info.cap_offset = 0;
> +			} else {
> +				vfio_info_cap_shift(&caps, sizeof(info));
> +				if (copy_to_user(arg + 1, caps.buf,
> +						 caps.size)) {
> +					kfree(caps.buf);
> +					return -EFAULT;
> +				}
> +				info.cap_offset = sizeof(info);
> +			}
> +			kfree(caps.buf);
> +		}
> +
> +		if (copy_to_user(arg, &info, minsz))
> +			return -EFAULT;
> +	} else if (device->ops->get_region_info) {
> +		ret = device->ops->get_region_info(device, arg);
> +		if (ret)
> +			return ret;

With the above comment addressed,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
