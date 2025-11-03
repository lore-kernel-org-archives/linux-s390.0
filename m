Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B02F9D82
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163592; cv=none; b=JnSZO4oq1nYgh16FQ/6E7zS6/rfXnv3S+XJW49ghLsw4VMHa1LlhPNIUiN7u3Mj38lQVNkudwo95UKh1KhD3O0T/7tWS5fOoHKiy58t5+8RcvDuLa7Y5S5aGTQTChyrE6isR17niWAHzRm6u+drhIVV7jVlVMLLKP4o2Se7tLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163592; c=relaxed/simple;
	bh=JKFySBYZ5L+2LiVx7km0crRWvXRHHVbQF5Z8FU6+lVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSO/sgfbJPYc6RGW767fomGCqimHpIynENRzPYW4IfIZBH59DXJYhx/g6+wAjbC+jd8WnJCTC/2OAyZJzyYs77gfqGPVTrhMM56j8EcNH5iEyqI34G8WVZ1IiC+Mk6Pm/z/5Ma1c73MV/ygS2B2Ynko/Vkw2dD1F6fF9kHhJSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgBEghLz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgBEghLz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475df55f484so84005e9.0
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762163589; x=1762768389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ4RrOu9uCN2bW8pg1KpsPpPzgZldv3XyNgHXUg1t1c=;
        b=qgBEghLzI6p4nXja6eDgqJF5triVdz9vQVhuTpjyBQlTtQv7QA8qzd7dBgrYXKyBCM
         ZaIawiARDYbF5/2a7f6PyBpKhORhJM5z1394TM3b9UJy1o4ObyN60iu3gijdwlOUCfNw
         71HPhor4aXpa2JI15i2mRMzbFcbVOH8BfvIyp/75uCAilDk9efQLX2/j6wJL6C/fFxtx
         UGhXCZhSU39FakV4ZtKlt8GVp5KlW6LVd77awZAYPfhOaPOov0z5H7WbNAT1EadocT9W
         KS+iR/jFb2XNI/7BuaPmzrDI/IwT2T2/6OPoOSdfjzxWAx0N9Gpf+g+OlXXpnD09qmiG
         PbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163589; x=1762768389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ4RrOu9uCN2bW8pg1KpsPpPzgZldv3XyNgHXUg1t1c=;
        b=skVnLkraRI0oL8ZtEGeaip7ADrZa6kqnqaAw5PDMATH+G7QPaziSL9CzY9B6EIZpRA
         OsQWr8uc5p0usubBvm8qkjUobnQjdCVSLES12lFJLUiWtVFqwrtChUxB0E4jHpQE2sbM
         1eLLgmbWAIy7oUnTUu4/Yg4HJBg+QcUBDjrB/zZTQ9a4NrgZmKqiQ7reiPR/Z5axxo9M
         hAiaNWWxiV4OJDIdHmAG/p52q3HcY4b4x//EyW96YkoExNqPF5juEYe6sYAMmgd46vck
         S86vik5/GhGE1YEtEv50jsNrWZVz4ZwENmTx0qjU8jqvdCaGcNcmFNkw+8v/8cULjGJv
         7YKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Z01QmWXY6NJNmlw2zs1bpsZ/XM1QNl3cmz5PtXk48rT8Bjkf3MusHjc6JdYh1XD54lRvPmGLoxGY@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9gUj33rqCfI8crEiQxHewN2ZMHfkK4kkdzpi1/r0w+nQZA6a
	j8X7mWxFyzWWqU7qMYMlB0G42pvrkbZPACOe5bACAKbou2M1Jm1QKhlnV9OiCnQxJQ==
X-Gm-Gg: ASbGncsjn3BBAJlZqEPft/Ra7a+7NUBRKT/PMLOr7FfVTTVnYi0FXeO+HHzV38tC6eW
	8+Emu13X4A74AgXU9GyKlz3zq6Iwo0amZ1xJ1OtGcwJHzwTwOqdjRo+JVDMQGAOK+RbMCKJO74K
	08xKHPUyg02J7ROqI6w/0BfShKjExShG1/Lb80j7B9Y0BcBPIZEO6kCJussysXl6AAAPTXe1aCI
	GWjWSqgPHKx9+r27NvnjxJ4Kf+yNgN9bwlqnpCzIsWBV2fN6rAaoPE+ri3h7d0nDbkm3Yzshf45
	da1pqyYa/Zsi/b4B+I4BoFJFvxJbHmKNkSNfibdOjD2LfGyK+R104TUbJlvxMemmAOI2X+fLvI3
	Vzrbde99c5VsO0O626cmMq2BonLmfprYzefJRHAajc9sP7+HkB8wWx7nlglntwIk/WWHJP4XkZM
	ByDesiecApR0j2lcU+CI7MtY84ENOyNfyCMYyntLDZ7a6IJYZg8Q==
X-Google-Smtp-Source: AGHT+IE1mff4da9I5vysNB0ob0JmOMr70AWi7AKZOtcSI5qvyyAXHktFY8REU7m0liVQkNgCELSSCg==
X-Received: by 2002:a7b:cb14:0:b0:46f:a42d:41f0 with SMTP id 5b1f17b1804b1-4775268121fmr217365e9.0.1762163588833;
        Mon, 03 Nov 2025 01:53:08 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0325sm20082715f8f.29.2025.11.03.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:53:08 -0800 (PST)
Date: Mon, 3 Nov 2025 09:53:04 +0000
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
Subject: Re: [PATCH 00/22] vfio: Give VFIO_DEVICE_GET_REGION_INFO its own op
Message-ID: <aQh7gG3IAEgEaKY_@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:14PM -0300, Jason Gunthorpe wrote:
> There is alot of duplicated code in the drivers for processing
> VFIO_DEVICE_GET_REGION_INFO. Introduce a new op get_region_info_caps()
> which provides a struct vfio_info_cap and handles the cap chain logic
> to write the caps back to userspace and remove all of this duplication
> from drivers.
> 
> This is done in two steps, the first is a largely mechanical introduction
> of the get_region_info(). These patches are best viewed with the diff
> option to ignore whitespace (-b) as most of the lines are re-indending
> things.
> 
> Then drivers are updated to remove the duplicate cap related code. Some
> drivers are converted to use vfio_info_add_capability() instead of open
> coding a version of it.

The series as a whole looks good.
However, I got confused walking through it as almost all non-PCI drivers
had to transition to get_region_info then get_region_info_caps then
removing get_region_info completely from core code after introducing
it in this series.

IMO, the series should start with just consolidating PCI based implementation
and then add get_region_info_caps for all drivers at the end.
Anyway, no really strong opinion as the final outcome makes sense.

Thanks,
Mostafa

> 
> This is on github: https://github.com/jgunthorpe/linux/commits/vfio_get_region_info_op
> 
> Jason Gunthorpe (22):
>   vfio: Provide a get_region_info op
>   vfio/hisi: Convert to the get_region_info op
>   vfio/virtio: Convert to the get_region_info op
>   vfio/nvgrace: Convert to the get_region_info op
>   vfio/pci: Fill in the missing get_region_info ops
>   vfio/mtty: Provide a get_region_info op
>   vfio/mdpy: Provide a get_region_info op
>   vfio/mbochs: Provide a get_region_info op
>   vfio/platform: Provide a get_region_info op
>   vfio/fsl: Provide a get_region_info op
>   vfio/cdx: Provide a get_region_info op
>   vfio/ccw: Provide a get_region_info op
>   vfio/gvt: Provide a get_region_info op
>   vfio: Require drivers to implement get_region_info
>   vfio: Add get_region_info_caps op
>   vfio/mbochs: Convert mbochs to use vfio_info_add_capability()
>   vfio/gvt: Convert to get_region_info_caps
>   vfio/ccw: Convert to get_region_info_caps
>   vfio/pci: Convert all PCI drivers to get_region_info_caps
>   vfio/platform: Convert to get_region_info_caps
>   vfio: Move the remaining drivers to get_region_info_caps
>   vfio: Remove the get_region_info op
> 
>  drivers/gpu/drm/i915/gvt/kvmgt.c              | 272 ++++++++----------
>  drivers/s390/cio/vfio_ccw_ops.c               |  45 +--
>  drivers/vfio/cdx/main.c                       |  29 +-
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c             |  43 ++-
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  54 ++--
>  drivers/vfio/pci/mlx5/main.c                  |   1 +
>  drivers/vfio/pci/nvgrace-gpu/main.c           |  53 +---
>  drivers/vfio/pci/pds/vfio_dev.c               |   1 +
>  drivers/vfio/pci/qat/main.c                   |   1 +
>  drivers/vfio/pci/vfio_pci.c                   |   1 +
>  drivers/vfio/pci/vfio_pci_core.c              | 110 +++----
>  drivers/vfio/pci/virtio/common.h              |   5 +-
>  drivers/vfio/pci/virtio/legacy_io.c           |  38 +--
>  drivers/vfio/pci/virtio/main.c                |   5 +-
>  drivers/vfio/platform/vfio_amba.c             |   1 +
>  drivers/vfio/platform/vfio_platform.c         |   1 +
>  drivers/vfio/platform/vfio_platform_common.c  |  40 ++-
>  drivers/vfio/platform/vfio_platform_private.h |   3 +
>  drivers/vfio/vfio_main.c                      |  45 +++
>  include/linux/vfio.h                          |   4 +
>  include/linux/vfio_pci_core.h                 |   3 +
>  samples/vfio-mdev/mbochs.c                    |  71 ++---
>  samples/vfio-mdev/mdpy.c                      |  34 +--
>  samples/vfio-mdev/mtty.c                      |  33 +--
>  24 files changed, 363 insertions(+), 530 deletions(-)
> 
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> -- 
> 2.43.0
> 
