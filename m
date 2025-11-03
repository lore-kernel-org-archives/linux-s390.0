Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCED28D82F
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149489; cv=none; b=ggf+KI73AreOl/NLCScFGY79S7jKeJs7Dxy6joOYCTrWkezxnWZ+B2GTiP2qktRRghzgANmHdHp/0fxcrA4follkA+KKWOKkWokpo8LpCbbh71EtCAzdpIZR8NcWJD09Cqy3v86N6Q+1Kj0I3QYoi/Jkn7aG8AGUjlJ01DMeOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149489; c=relaxed/simple;
	bh=COnfabRE25CHEyik36bmtXTyjtL97X8u2YW/C0gU2+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWgV2d10gI45UXOiK8xDZcGikR7oaNqCy5SC4uGUGGn1uO+q0cHXMEiIDMR03dRy6AfcnL84FFKeM6Sss8UBL3r2vPubjY6ZRTz2Z8EqCEHEfBYh5ToTq8m2KFjUZN1OfzhPxpP3kXMZzaB/5y3GH+8GibK2zuLVACuGMSeFmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSxpVBUC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSxpVBUC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so73725ad.0
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 21:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762149486; x=1762754286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNN38kSQW+Z67K4qsM9EOBHtmYi+rj4bbcXqoaYoYec=;
        b=lSxpVBUCQ5psG5bCyY6pior0r5FZzvdbgyl0Dop2N15B5GXuZNirV1ebLJXJhhnJoJ
         4jHPJ1N/O0kCPWvqd2cxSmXQ6MGQMkfTGHtiwqk0C93ToyDndlPEfDozniE0xyzOgf6o
         z3f5eo9BlYvLzSHefq/vwAkkk0GPAVn7yErdOtxpK/olAMlYvA9w3kzwwyqUEiC374Tm
         SA5XXQk4v6niXORba3G+Fvyzg3kxGNp6Og+/L+bqsnj5+PGXvjmy5cSY7pE36Bhw8WAU
         0ayq54s2KNM4DdtOSWs6k/AYbGI9y1cy7yUombMl8bLpqCrXZypHZYYpyL5shMRCSBd7
         FlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149486; x=1762754286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNN38kSQW+Z67K4qsM9EOBHtmYi+rj4bbcXqoaYoYec=;
        b=Htr6tVAAYJkCOBmbymcC8LXakeHWUCSvKd2Lv/uews2DSUY8Ea0l+diM1W9JT/nI0B
         Dqani4CqzdIYv+xNlG53ywQYP11+1UYb1O5hnuyb/+n/1ZnuWA5gliSqpuCjDmNd/Amn
         yFEhS2Wo0rx2dIFTIz3lNIotMYSo4+5sUQUzniHWnNzWv6b5snAHNOmpKTDAIbJAHXWk
         3yXoMSqyPeQsqWbZlXitkEJp1ELuY+/prC5DjaZ56PNphW0YkbUrWwGxaTlcjdzBPNj6
         WVTi2H2qmwc+pYhIqT271AdBCP4ipe6S5b6w64wDiPb1DKKQPUqvHPXcZ8FTZckbgenp
         VhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytJL6N8+jgXBTjOIcJLBKyC6+vl6L9eAbS75I4BgAfThLwGajqBE80DL/si88c64uPz/jgwsAnGfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdWi34Xs4XmvCQdxXTBXy+kTznVKUuFA2k9sEVUJxxqsWZDhj
	XTcEL+HSWvmCqrxDo1Xr1zNRKo/ahBQcZYvuedbV9K/v4IsIwSQp/aVzeGYifmdJig==
X-Gm-Gg: ASbGncsGql/InXQNDnQtZUI0Qe/2ikqoHtLRFIC1YO0ZHVP++221F8QQd/Zek0V3Ft4
	QQP5geS5yIVRkkdro8tnTbEYfja9iUOzXWak9dmNXCkSpT6tbojcPVwStyL1TmccYDBAKIQ+f5N
	DEXsg1opjlpjYopSLSTYXglBwPbO+rrESd+8VAgHhBiMxbJeIAmCGwSbtV6EjDzIiD1sQuuihpf
	WbVXANDJ47gOoacdqQFdLg5UStMGo79SNY2z64Fh+ot/WrdCSUC3BbhW73fSqMqSwfx/Cv0fg5W
	JXHUJrZvumyfu3cJia54m8WqU7Q5hs37xgddH8ZlQOpgOyb8WLt55yC5gqXZf8cjvmwbzIHec0s
	2+Rrfjy2C1Ay+a2BkjVa7GR+kZmIwhWK02jnZZnMlO5pV7MjD/sF4i9w9Nnz5BTB7JrmPh9plMW
	e8J3bEdEmRyStS8YrT6HBzUWFSI9S+5s+kXUyQHu2v43lkZeWP
X-Google-Smtp-Source: AGHT+IHe2S0n2gwZ091UPBX6ERfL1n+n8BtlVw9vlL1yBRvzccFZt3lfIo5NNtd6hxmzG7hv2JOREg==
X-Received: by 2002:a17:902:f68e:b0:295:5138:10f2 with SMTP id d9443c01a7336-29556599a23mr4787225ad.11.1762149485582;
        Sun, 02 Nov 2025 21:58:05 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f26e0a6sm5783366a91.5.2025.11.02.21.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:58:04 -0800 (PST)
Date: Mon, 3 Nov 2025 05:57:54 +0000
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
Subject: Re: [PATCH 01/22] vfio: Provide a get_region_info op
Message-ID: <aQhEYq9YVzbBlWnC@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <1-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:15PM -0300, Jason Gunthorpe wrote:
> Instead of hooking the general ioctl op, have the core code directly
> decode VFIO_DEVICE_GET_REGION_INFO and call an op just for it.
> 
> This is intended to allow mechanical changes to the drivers to pull their
> VFIO_DEVICE_GET_REGION_INFO int oa function. Later patches will improve
> the function signature to consolidate more code.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 9 ++++++---
>  drivers/vfio/vfio_main.c         | 7 +++++++
>  include/linux/vfio.h             | 2 ++
>  include/linux/vfio_pci_core.h    | 2 ++
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
