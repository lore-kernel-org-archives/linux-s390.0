Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3023909C
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152201; cv=none; b=goR64qe8/mYu0lZXLaCnWDklSt59sBStdh5wd7pH1Vk1snAX4pSkkZau4T/KyIOZ8e8lnk5t3bAxTYoonfZtrqtmiScOlnEet8X4bBEWl6CmG7Wdg1+0KB2T+Gq2h1Bq7GG9gRgmsnzEsu9V0Yi9gxWFdnmdCMyB6gZjSmV+9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152201; c=relaxed/simple;
	bh=4+2jNttfGJTUArM3tzL5Y2lmRNiEYuzuOIQmI+CPwVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU+goV4KWZIQRglDkO0eBhvo7X4ygMpxUBuMJWRMN2QHPWvHreZlNHOLk3BY+av+YtnkIXAUhMOgtA70T1lm3VrAOG0a7ypBfa4E7rIEpO4bvnMWrpSN7JaRBYg+pZ3GfO53er0Oi0w7M6Fj/JPPYjhaMOsb83717JhKcKbEk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzqHHDry; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzqHHDry"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295c64cb951so79925ad.0
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 22:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762152199; x=1762756999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxS6TWyQqtdZLWaYvGIMM/0/SSg5nejyyCdpsoAJAw4=;
        b=bzqHHDryQbtysEXyY8A4QLQv3xVfTa7ZF8u2UsJNMYz6MAFNITNAnXMBQWDvsgrsOv
         XdBs9RQkB7n6UD9B+6P7XCPkpN/vt7b7BVOiMfafuJgvQeXB9J2LUPUgkrWcwciefRXU
         yM0d+zc7XWBfyiKx/lURSBlS9xYbFDKMKOotCHPaTvapS8rUYaaEDcQne1GdmULqMCbo
         17ebOzm0JviJxsTxXWko5ePflmugYMT1hIORs83PbXacU1LxUhwHTg0i7nRYLRpd00s8
         3UwA6WraLJzmcRF8fLYCnGVLdMMLMFKOwUg6Z0ltOknqHRRkeYs/kMNKEF/3bw7V3fMr
         91jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762152199; x=1762756999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxS6TWyQqtdZLWaYvGIMM/0/SSg5nejyyCdpsoAJAw4=;
        b=c1XFHdTUGvZDvf5Yco9bUac71ABgSfPuqnc84gOp6LnM6+wHUILr/3+AK7EkNjZabw
         4egu5VLa5kAdcp2DWWEDDLnfUg+3mhL4ekQ9y7+LWQmMYJX+aSq4sFQFVYVjQhdJFzFf
         foRb1fkvrTO/yokQBAS4wbVpWi/JzRz30RIIpqj+N51kMqYeuW0R8hpX/QHfIRC5tQDI
         8wGBelv956aaUQSWK/mDMn8OrbSjI2ZpKJ+BSSPW8TEPgKepXk+rRdB+9ihoq/DVCimU
         va1ohE4aX8CY9Bz/ZE7aNOslUqMyqUqCgsCmp8QLoGUHBbMpIdIzSEKroUlboOPaliyK
         9TIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHfp004Gn6d4Esxr30RgvCj6P7ERbNKJmshzO7fYI4Z83ectQIcKfbeUo9w+6SMz/VPR0vNsgHpx/g@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6s/kirNPm3gB6MtZOLr2GHXXZ63P+Slv91Vz0Vsty5bpyS8I
	8KPWzuRQb8UD1gSTkWdpTm4kCCnZUF4pFf64yoxafP+pTUq15nsSCFEm82G+bMgRow==
X-Gm-Gg: ASbGnct5HiYRazHeK+mMsH7F4BJLN5CCuNvO0khSs40gpxSwSIiDWd+yBRUsEm1q1nH
	i7PTwnufDIqMn4MpBG+fFDO16nn+EMSL9QSXhdZ2c/s/X1/zRJPGJ35JCz670IaXIYto9nW/ckJ
	kFofHdUHfw8HaYdyXtUo+8F4XlkWsRCXqLrfV9CgV1r2ehKTfnk0fr7U6BcM+dDzyol07wBrPGN
	89ByqEcZJ57fZ2TuwG0LfUATSz94JPhUPGEHmOyblTXpZ/zXkOy4EF3mnw0dU17H006YAcLD5Xl
	YgxosKvgahEq70/z7yCr4idOx6YNDuc+8HjJStRCQHDJ7CkhDrgZxZVSW2nbfwkZKYZ1nh2nSav
	ko3rtSh5taXF1+lsh+rbOV6qGEsqL1yRRZ/YpRvaq1oXz1GbtT2TRgnZQysk8HxZdhU3nGGW1vE
	bIIpkVix9NxKsIhVo6ORQyvUOFfKcwIzo6FoFuoya16PlwbPQu
X-Google-Smtp-Source: AGHT+IEazENwFhX4zlZOAPlLrsglGHn3aC4ae1C3vchxLK4wgltvDYn1olscExUoutjpE7Up5ejKXA==
X-Received: by 2002:a17:903:2f81:b0:295:5405:46be with SMTP id d9443c01a7336-295562f73a8mr5347545ad.1.1762152198351;
        Sun, 02 Nov 2025 22:43:18 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2954d5ee092sm80708835ad.62.2025.11.02.22.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:43:17 -0800 (PST)
Date: Mon, 3 Nov 2025 06:43:07 +0000
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
Subject: Re: [PATCH 05/22] vfio/pci: Fill in the missing get_region_info ops
Message-ID: <aQhO-5Ka4b8Mcwxf@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <5-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:19PM -0300, Jason Gunthorpe wrote:
> Now that every variant driver provides a get_region_info op remove the
> ioctl based dispatch from vfio_pci_core_ioctl().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
>  drivers/vfio/pci/mlx5/main.c                   | 1 +
>  drivers/vfio/pci/nvgrace-gpu/main.c            | 1 +
>  drivers/vfio/pci/pds/vfio_dev.c                | 1 +
>  drivers/vfio/pci/qat/main.c                    | 1 +
>  drivers/vfio/pci/vfio_pci.c                    | 1 +
>  drivers/vfio/pci/vfio_pci_core.c               | 2 --
>  drivers/vfio/pci/virtio/main.c                 | 2 ++
>  8 files changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
