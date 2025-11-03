Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2E2FD1DC
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165784; cv=none; b=OhJTAxoOSgqnjqYtZYHPHPEpEcxtRUyzo+Yb4kFwAIaNnUq2CI3RXIFmpZDAKd72k290uMF7HJMDC2QjT7sTHscCOUoAc1Bq5C3pTQgwS/eawwX56euEtZkGuMZ/MqISNXEFatem6y0SbdF62b63mYiBvljEGDr0ippFRO8aU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165784; c=relaxed/simple;
	bh=V327Um22bMTy/equs3K8rbAzzyPzJ9CLEIoEo0OIurE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3E0c5Xpjb6jO0EuSKwnJ3wqkLZZNhBDgv4AJhkSDtgSdAvw14WmSNuPofOiVr1GSPUVzCKaIGTUQJXVWIuKMylXLIJvrEN+L6mSdFQPqpWz81RE26v6WavEcqjyntxLxn5j/zXiqYhNDL2nat7SkxqPEWruaxo7MjTgFIyVnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Da0KLzWH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Da0KLzWH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295c64cb951so124535ad.0
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 02:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165782; x=1762770582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNHaVozbtXB8nI6t/qtWfMkb6Kn6PYTAjlMTSN+Ugyg=;
        b=Da0KLzWH2xxT5C6CmX/7a88N6czNNvZ+LJ7x9Em3OPLVX9p1HjLcpIeyp9q0WHG3O6
         lwpY3ZPxMR+7+N2Ys3q99PVkdBBsqUluXkIPJMEY7OyhBYiwktNlHYEKiAriN2BTBGB0
         cGRUDKtlY2HRRf77Tu8zha19XvJchHa3nBa8E1k85YqCHkIaIrFUZ7Y9VXdXWORa5ns8
         +ZxTxPwboLYygi5chVmxfuOPotUhoybaekvBOOqIXMcPkVPTfq1RmO6nnN1VMZ5n68/X
         JIawwmi62v8pQU6X8WHfVYwHkFhRDiNnACx82SemcHyLQSEXvBtkpICxc3yCd5jXs6Kc
         EMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165782; x=1762770582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNHaVozbtXB8nI6t/qtWfMkb6Kn6PYTAjlMTSN+Ugyg=;
        b=BYa+6jPl1UvQ4DRQJEUCc5uIGKX7M0a2f21QhotJSFPLIgl9hZb26UDS4h1HSBeRrH
         xkBg3IVstUYk92mF9ABTK+lbL2v5duskoYmiW9rTEYRGJ3w+J2kJRxNbRs6/2rYQpgPT
         1zwo8ITdoonZpJov9aOMMKvbPdx2BgS2JCTHyYbMX6ybem679XOllo0aIQ7Mi+4p2SKN
         3VQbK945cA8/MbPUZ66DCk2KRJIsW6SaXw0MhVrrdjoB/wdq4WlRM01UYtw6hlyl6RJD
         AUyOIMkMte/XMQrH1c82J/Qjd9OvZWdOK/W7BpiIbqGx8s9O1XatqGK1KD+yPXJdZ6iI
         BlCA==
X-Forwarded-Encrypted: i=1; AJvYcCW6U3ZjfP3GSBn6G5+W0xk0JuardyL5wEnqd1qPC+8wJ9DnEWiZzIuPKOoxr6ccuco9lpyRMqI9+Pza@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6jrNhNFKHOVJntas9Wo6G3/HLjD6GGufpHo83RYfN7+bZHWb
	VqS6LKC6Nb7pWgYLFQ8V8EKTKYC+DE4v3GPYfpFXMlUaSC3sbVgkCS8muNYt2Pt4VA==
X-Gm-Gg: ASbGncs/1vhv3LBRy2kl3Jxphy0O35Tp7fjUQEMrRcF4Id4qUm2G2GPRjtEOKXMm2qx
	W5tXIP7YsrddaFZJiD/XyWE9fAwyGlPbN/M5TrVF5QyckG7w5/V5EZdFMt3Z6bB6TlrKINM8RPF
	vsE3dmbE0SF9nawvuqnDfOhUSl6RvK2lHA97AOwW9Mj8Vgp9D30kbWI0NaSCJCGObiz+M1krUYp
	zthxQvTJ93hPujHDCY2FybTnhzgTla/nsahi8qTzPu9R03mOKeY96PJOoHuUPGg1fU/pJneipoF
	CDIQndV8TXT9XrGCn/KBYvkI3rQ1s30axd7NExZJU/qjdfuGI+is7IHbY3US2n43nz3Z/WfEV3d
	VEzZw7JmC5z94vS07W1bRgD70OODXd45MuPTyXegTXGRqwnmQPEE7RifHOe5BRKoBGMvpgznny2
	lxJbZWz8CMojNtLXob1GGHndmN+YgyhcZmedbG6Q==
X-Google-Smtp-Source: AGHT+IE7RbmruVQhXsny/j8l+SFhjfD6jlGy79IZqby3HlHJSxLaU8PrnA03I6j8kd1hYd7zo15JRw==
X-Received: by 2002:a17:902:d2d0:b0:295:30bc:458e with SMTP id d9443c01a7336-29556477728mr6652975ad.3.1762165781842;
        Mon, 03 Nov 2025 02:29:41 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ab30909fccsm2991326b3a.20.2025.11.03.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:29:41 -0800 (PST)
Date: Mon, 3 Nov 2025 10:29:31 +0000
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
Subject: Re: [PATCH 21/22] vfio: Move the remaining drivers to
 get_region_info_caps
Message-ID: <aQiEC2Z3lqxAIY3J@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <21-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:35PM -0300, Jason Gunthorpe wrote:
> Remove the duplicate code and change info to a pointer. caps are not used.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/cdx/main.c           | 24 +++++++------------
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c | 26 ++++++---------------
>  samples/vfio-mdev/mdpy.c          | 39 ++++++-------------------------
>  samples/vfio-mdev/mtty.c          | 38 +++++-------------------------
>  4 files changed, 28 insertions(+), 99 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
