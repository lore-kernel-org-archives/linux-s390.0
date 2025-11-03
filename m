Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531E298CC7
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154280; cv=none; b=PJkzESJzawYGuihNhqPJP0wcPt/GeSdk+y94nyJtPP+lRDGzJfKciGL3Rf1bPm1eUjVI2f5jtJ61J1/IZtBn5t6+/Bkm8mhROmCtgdSnzsR0bFWvpZ6bIQq6y8AtsG7p7CGuwsNrpo4uM5IKa38PUwM9FD9r6tGf2nlLjAxWdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154280; c=relaxed/simple;
	bh=u2RitBJJYcOeGrXcJN16D/BkVV6lr7NwWHkSsUefBtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7fdU356zhn+QvO5Wjit6D1DtEYqqWXmVjfLUJr3lioPESsctVHj4N4wYjrVqKbVp/CQP6MeFTHyKM51mtnu36eAMuzgFluetcUFAOaiWYAWEcWoNcbePXZJox4tRyMjSQZbdttXGHwdWFfw4987NgxTejkQqn43lXlmof9C8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5OuQIWZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5OuQIWZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2959197b68eso193765ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154278; x=1762759078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkl25q/g8s7OS88Wbysk4mwVIyDLafMsvz/s+Uj9Ki4=;
        b=M5OuQIWZC9DxXUsMzoFAO+mWl+Z/mFl2K8RQad7408r4wRhLKs1CQMPQxpWfTFLBIX
         6OmB9FlV4eCBEs9ScU00cLnClPhiA1CjX8Y1Xvp9AP0vSt7xv3kZfOTiZgUDEMUQQ2Mg
         hkW852aBT5ch3drnKaMIL9JNX9nvNcgSjAn+aT7B2SM/oVNmibI9o9h1HtEgBUPCoRrL
         SXjsPYK4PChcj/+DOEaAnt15CgTzx6Sco4ujpUR/yF8YGfHsnupBb26unOZb99ha03Xc
         zkeflX1sqtwKqA5G7KpFZW1KS2bFr5KjpaOdypyj8aTlYbqI4GC+rgxQL4eftPxmlJmp
         wBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154278; x=1762759078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkl25q/g8s7OS88Wbysk4mwVIyDLafMsvz/s+Uj9Ki4=;
        b=hdXxjpT4zq6OA+WMe8CfWy0maDBEGL4V2HWI8eIGVDx48juktYur+UN+ODvF9awwic
         nkeppriMEzkmaaA34UgdssQFnFeOwYcyK2rmd7KlVp5iJYLZLiRn4+G1rqcDo8sihyud
         9va1ccotXl9pPys2cfhn1Q6HAYG693h4a6ILTorB81JnGf9YCTyWPGTkgeX0VUdEEOMp
         ZIfYhf8zWVWExTGmK6GoDAYvNauaER12LC2emGkBsePnKS7jz/PFSnmwnjA0zTiJ1l4K
         LknR7QkjyQQCCkofynURIZOwplQ0CWuC6UilvZWMATgkTEIE9rDrN+zRTHdJjrbM/6qU
         sP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW17z/ZkwgZiBYhPG3/1NN2Mq4+GdNxV75IXlGZ3IIHFrFviIrsrgwsxLpgZIlYGiBA4Yx5czIdCxPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWb8VIzd4atVFMe32c6/OY8nFsL0t0/AIxLdKfXRJgWMSGTMBs
	hLoZJgy7B6YpjqpDivQ1lL11Tq2OjFFnIaa8C9Oq8cwJG4TefhTxQ57A4AxdvTGPdg==
X-Gm-Gg: ASbGncvBF4mJyjzdBudPfRA7ktRDo00kJ4cyq5vTuPNtXhgPkwrEX6gULp3Q13ABeO1
	49e1itNe1+kQ1n4T7O7UtomHK3OBwQ8d7e7ti7XCHRkFGQif+GghuYqJuneZ+jf9g6DSCYKcuGo
	VBiFEG5ieGQEIK4N2avvm+qUz//afSDD2Fl/dXezPSwi35r9P2+86CTf/Jnrd2CdABAYFi7AnbD
	bM03F52ZEp/yuJAvOYU4HTcHeqqhRIL87HzBMhsGmmRGMmHTv9P/xXRHY/TkP4EXXzGkG9gIlGY
	B6zoW5CFWU9NYc9dY3zo94v2FqQvIocEeYFWLJYrtjiHJ6JzJ/dgQwX22SExqmLNdgCu0gMy/he
	zR6ljbsDR+GYUhP2+e7Bj+cbpkewharqonRWa4AavOV7VpDTQ4fAIk6wfl7vq+3igwbtCeNBwjC
	W/Gf2ziY1qTqYw2J99D9nT9X7JR7WEmCCfmQpB1yu55RbS3Oq3
X-Google-Smtp-Source: AGHT+IHfDR3pQIMSIQjN/GyrpnHhW694vgQCyWpAq5GaAMMYhNpX5IKRikqyk5tXJtqoi708RLXBcA==
X-Received: by 2002:a17:902:e88c:b0:290:d4dd:b042 with SMTP id d9443c01a7336-29554bc5206mr6800415ad.16.1762154277664;
        Sun, 02 Nov 2025 23:17:57 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e19ea0sm9634160a12.5.2025.11.02.23.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:17:57 -0800 (PST)
Date: Mon, 3 Nov 2025 07:17:47 +0000
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
Subject: Re: [PATCH 06/22] vfio/mtty: Provide a get_region_info op
Message-ID: <aQhXGwlxZrZl5GMN@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <6-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:20PM -0300, Jason Gunthorpe wrote:
> Move it out of mtty_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mtty.c | 53 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

-Praan
