Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3622309B2
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150918; cv=none; b=EAlpD3id6bRTuz95ZfEfplSz4wkeYaNos/qTE6sm4zZQsIP+zspIYrz1TzwoA6vaksjdqI38UkurGD/G5mnI2814RIy+OWvY3YBiTf/cbAt03xCCRCs7c35u1xFgkVLv8XsI73h9TR/tTEYXNpM6viz+0yxoSXHdrsFn0Ilu5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150918; c=relaxed/simple;
	bh=q6TURu0Txeo2OJvua8KGcsnP9mDJkJtsWp5sVhFajZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/+SzRpsaF0q2URtK2/2Pg0M+8aXwi9JKeDTgj+KS/nb+lhwy3ksybZFk7nmcJeN7huIRfoCfn3fIgYJLhdd/NSOOTT2lB1npAYwMjIPVKL605Xn51/+6TmqQiLnaEwz358w6nupngfxc/MS+Zbo1JKdT/n8T+aHIi27G7yxc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybIIRbMS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybIIRbMS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-294f3105435so331755ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 22:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762150917; x=1762755717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWlZBJWMNR3o5R9SijDhT22MNLu42EpPET2zOzK998A=;
        b=ybIIRbMSfr9KvmJHVzA+dnkbLCZQ61ragoZTdqBXfMNfe1u2ERwN31q1nykEu/37mc
         XrPp4O4i2MZ4jw0ZTAVTG+bqdTe9JGjdyOPSNT3wePZq7msEfjv6uBTAUUvwolNJZvhZ
         h8ElYZI/rpQK5xw2u2DR+Lz+IuXOPElHOP9XZ9/XuX9M/BwicxwXIhO0KOVuaposQxZE
         nxMIkRLS+h8BdOJc0MnCQrG7/J2Dr0B/+8KeIkN3BGVX8dXB+9uPK7zg83/LnXHXPaPO
         qPggh7lMtCTZ3EH6xGbMBDHD3BujM0Mh/8/XeCeGDC9epceSBSUGcPfR0j6KjESWLoOw
         VpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762150917; x=1762755717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWlZBJWMNR3o5R9SijDhT22MNLu42EpPET2zOzK998A=;
        b=oLKPC/A6IMdi0cTsU+kXprhNOjy2EdYgHq6IE+al7CQRkrk26UQFX7Jhs5wcuNjFlQ
         xlmNqJu64ARylXGbiWkNfRAstRrKkxJTXgh+afvXF1LVQFrPC2PAI33vGOmpgKelhDxx
         1Ef6Xzibra5mBkpwz+K5aXfXlgxvJLD20ZAdpxK36yKnUBxqawjGYKcBdVaTXHWOi+dA
         tEDwU0NLZybs7Dj+QHSRS+ZU1DIgleH3WkAR7M9KoQHPgzqZnLWCa0V0ikvs0hPygkZ1
         V26XNuUe4LCvN80O2lGgVixy4jzOYBhFldwOA5VuQAOZqkBbsNXSHN6aBb4F9tOyeORe
         2lAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQ9ibn2ICt0j3nqnYXreKr+IoSFuQ243S9hOi4/mYzT+/WAbCQ+71E3Bwa+89GL3GRm+NADb2N79g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+x3F5xqFOtxByV78LrqFxpO10tNl/AWgEC3zrT24OlGjzxNHc
	2JMl+4NtyYKhFhjFdNdhTppiUhqFiuHKblpNra+/rXAjYa759Iry857whPr9T+3kEg==
X-Gm-Gg: ASbGncuoAYz5owsEFBRvv11KVTOS+yEdGfgHbRM3QuePzWGlWXjSsnEi3PrIt0n6u43
	7Lrmwqn28gml5i+NT7/7RYZvXrrwBxpytI94h5hZlobW0xl6rocnZfKDS1ZjJmbR1PiAHwgoWLS
	XjcioAeSf8OWUYIa1LQJlymBIZ1uCGZlsNboKcbz2mtr65HrF3a0yUi5wd9JLZfMRnhQoSkCZMV
	zG2N4U9esmZFhADETOCjLyKeMJ76A1r50qyEfqZLGkNwmJ8Nf+xDjtE4oipnvphwUIorDw0FeWW
	cVrgo54BOFe3JFs/PzS4eQgFgCjuDC8ew9QoSky4KdMOdKaHy0vafLSGhCLGGZy/guE60n+tc+k
	+wNZAMPSuZnW33vrT+vjxayCAn9WLbffD8WxIRrZVL2L5aJxEPU8ydqHvr2dE7ciKeikeHctRbQ
	leQN6bdaqLjn6APzBj5CPLipuLbBmnUKEbqIT1qA==
X-Google-Smtp-Source: AGHT+IGruOwIqSOkw/c0UIqbUAnBCrsgVRvu/C4si6qjv3qWziT7RTJr58fgj5zqaOcpkLKvHmo5tQ==
X-Received: by 2002:a17:902:e891:b0:290:dd42:eb5f with SMTP id d9443c01a7336-29554be37d6mr5455555ad.12.1762150907195;
        Sun, 02 Nov 2025 22:21:47 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cbdfsm9912363b3a.49.2025.11.02.22.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:21:46 -0800 (PST)
Date: Mon, 3 Nov 2025 06:21:36 +0000
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
Subject: Re: [PATCH 03/22] vfio/virtio: Convert to the get_region_info op
Message-ID: <aQhJ8OZiVYe06hv_@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <3-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:17PM -0300, Jason Gunthorpe wrote:
> Remove virtiovf_vfio_pci_core_ioctl() and change the signature of
> virtiovf_pci_ioctl_get_region_info().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/virtio/common.h    |  4 +---
>  drivers/vfio/pci/virtio/legacy_io.c | 20 ++++----------------
>  drivers/vfio/pci/virtio/main.c      |  3 ++-
>  3 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/pci/virtio/common.h b/drivers/vfio/pci/virtio/common.h
> index c7d7e27af386e9..a10f2d92cb6238 100644
> --- a/drivers/vfio/pci/virtio/common.h
> +++ b/drivers/vfio/pci/virtio/common.h
> @@ -109,10 +109,8 @@ void virtiovf_migration_reset_done(struct pci_dev *pdev);
>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
