Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E53A1B5
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165302; cv=none; b=EBxb1s8pkP4l5OZw7VLwmGZ5qqJcfHmQluG06XKG9Ve1iZZoCesEeJD6BAjxQBSgKxj+dxaEUSM4oyTCLZNjVAVkfMXgmLhaCbrBflcxT5DWpDhJcK2j7QVWpubmnwD8bJC80KBSLVHGa9mDc4Ri4o4XQ4cDD4EbVCBFISvV5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165302; c=relaxed/simple;
	bh=/HKMzy5aaV8LtDdSBvQnNIuHvkwtMkRBm1mFEXs55wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpk6x2lPiBF3JEj7yj8utmnvbjOl9hhsbuDbJbzDm9QhL/76KZ81+U99vcRcIvZk2O0dqr+kteqQDeswOrJqKiY4mgB2aUiR3IJqk/muQHM3N+8acF4hzk47JI8y6W62dpmK5xVgPrRVtklOsOef85S5ivhco44Y/SjpGCCMxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNuwm7xz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNuwm7xz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294f3105435so372435ad.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165300; x=1762770100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM2bsN+XnlGuvDGqw1tQvaweGHKrw1JAZACa3YqST0c=;
        b=sNuwm7xzNz9BLR8g0i2a59brtv119zUXWWp3H8jbpe4jCVYshPpPZv5ScrHhTA3Jr1
         XAdKZugGhct9NDwTxzTECaYg5ZcePD1E1jHsbGEdFV+fDSmoVg7CxhsMl9lCxcFqFm5f
         0i6/DFVx0n3GiFjJBU4xc+BeDrbJwMyXySozNTgBGhPJGeL1BgLcJO1DF1QbbtzrLQqR
         t9x0ZeAs+ETfQxnYJf2er3zw3cDVm4/+KGv/5K3xysXao6JY8A2auRjbGwSX1f1Jb4aE
         MowFe5AFaKUEJiHYfGpVkbb6sIJIj+S5DPv26psI09xE6ZWTsuv/XkzfTaCdE5OGVXxD
         2D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165300; x=1762770100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM2bsN+XnlGuvDGqw1tQvaweGHKrw1JAZACa3YqST0c=;
        b=OiqJIUlYu5LdhxihyzyTzboBuianB6k8Qw7HDwY8HhkG8RlJDOan/lA26VzMqQrYBd
         KR8bd4kdV4+bgZq9Vynk/zY46TWPrQlUANNVFglncFUJSYx3nIpEkaX4b8HDLIAGqHLd
         RGXsQB9Cz/F5j2ds6F14SW45Aq2BcGvxRKf0+cKbaqzpn894akzL98DUKNeO1cS48NKJ
         b5uEPr2k6/aW/I9XNJniEW9pSnJcJjAtv+C/rtTFr+ea+jyT8Ur5Bo7AV6M1xBqnEO2b
         n6vj9N2MqdEJOTFbhTGb4VlkS11DoLajQDRHkmaDnJLqqhmETWkPlD1NXy/RlJ3+Vq/O
         v9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAALufY+V86JP5gnBkm6CNp8DgNUlti8E+xzgtGIUIEMaexnYd+Wm/2h7LjDjrMMrw6QbBuz3GGLZE@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdV1jv6QOuLxW1Jm1hHYA4tuGPKCqgQ7CwilBlcQMRFH98Mza
	hy1yTUQ8AqDmh4i0S53Ey70L3hn9h/Gfae+wQny767YtxOgCH9oB9WQOLpm+etKk8Q==
X-Gm-Gg: ASbGncs8r3q86mAHAE6HKXBJyr6Bds33jecZQ/QEuHvXLr7B4jDMCa6dqbEIBU8Y0Fj
	DfotACzOgpo8ntIbHC1lnV49D2LBADCMuxHBA++f8Uc67vPZQ3FtBHbBJKNM1rqRlOncxv78f68
	EoNbZEtbC6oXawExN5v/vt4KYW0qRiYXaYxck9IfZ2H5/OzVtaTSUhOu56MK0/Z0Vf13GzN6RuJ
	MyUL6NJm9yAd/DqCyQh3cK8sh8hT8FFtZqcuTZMi89kslxun9t7ap0HuB/6jlC/RFEDVQhtl4Xj
	C7SfzabYmw5bz39M0fWc0QwfpovTs9j03c4kpz6Y4fgyhQNViZIutN26qvxCcfdxKq2/3/uUod0
	TTkZ25GEDG5JmzkgKj4HU3esZ9iF8vFxCb/Cw0IH4gu8GPIZ108RCILTXZcEsd60Ysnqnk0iRRq
	4pbo1YHq6ajvoX6KXpy7gWkRw0euU0iLJWOZJZ/dAyp3piK9ot
X-Google-Smtp-Source: AGHT+IHDQYQU+xgcIcym40SdSIPVCJL4E/vz3sWG3WXd+xmfQ1K9iSuwfFgvjeHeyY3RCG42umC9MA==
X-Received: by 2002:a17:903:1a70:b0:295:28a4:f0f5 with SMTP id d9443c01a7336-29556476c7amr6429175ad.5.1762165299489;
        Mon, 03 Nov 2025 02:21:39 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f26e0a6sm6205722a91.5.2025.11.03.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:21:38 -0800 (PST)
Date: Mon, 3 Nov 2025 10:21:28 +0000
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
Subject: Re: [PATCH 20/22] vfio/platform: Convert to get_region_info_caps
Message-ID: <aQiCKBl0ScO78Le9@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:34PM -0300, Jason Gunthorpe wrote:
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

Removes all the boilerplate (copy_from_user, copy_to_user, argsz
validation) and lets the VFIO core handle it.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
Praan
