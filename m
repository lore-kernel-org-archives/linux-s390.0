Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87E2FD665
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165031; cv=none; b=k7apfhayrpbzfdCNdjvEDoYtf6V6r/OfCJexQ5906QWz9dx8kfOW9gf0hEwcoCCDYDRqdf8Ck5lVHKk2fcVfuGYa9i4rIbZKRxE2NYlJ/ezPE/LrBuSLxv0v/3kXuW1xNaZst+OKom3D8rWrd2F+BOIkYjFjPAer1J4NCR/D8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165031; c=relaxed/simple;
	bh=FFZiNUWIFKtxHxItZumM7duOWwpaz/Ziw593xKPC374=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djRvGGaay3/D4+19ipte/aOtOmU4NClmEqVyyrlnCYIt7VK6vCvZaa1VvwkMchhg1xaDQEGVWO2coI3IASq4MV/sxY9cvz+uafyjIfnqk+3Z+7guJf3Vp36Ib1EkdT0mp7gbADzrOjLzDNJy91gyKWoJCJyrDgO1bV3Hg4S4chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLnG6tPA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLnG6tPA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so417845ad.0
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165027; x=1762769827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+B58KtJn/bs233pgZmMdorp656WS5EnyOqIx/RHoAag=;
        b=aLnG6tPA2Lz8JDQ2FACTcqMz+WdTuZgG+U7ki9e1FgPajzlTfXpzy8ku0upyXh3Wz7
         k33jhLkl9tziC5r6T/veZTaKShmn455/bLDckA99pHLfQ736dqIjKrYjGlPnos7+GaI1
         LqPgXhntry+FhO0z28o5nPcGHSp8wE5HmAMMfMfWK+1flaOErwz8yjuih+zf10noPGr2
         HMoC23pppsa+tkq1IxYPjqfrp56N0h4YOqNdQgDPaq51vtfpaKu8YHQpUj3Mm3piXqxJ
         JSD5AHzN6qQJ8NyBAmSD56wR/oSfCvsOJh3cwC/HZgZyQl2vPsUHwGg7+zY1jN8L1DQh
         UrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165027; x=1762769827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B58KtJn/bs233pgZmMdorp656WS5EnyOqIx/RHoAag=;
        b=hVoTvCyb2YDXYGdWfSoXSsj+9SUZr1Vbb50v+fOQr3fuX1OGRd6Z0JzcR5esuv3XkY
         MLHGATo6oOdJLElTkCoIZBqiXCy18q/9UGwsVla8nawWLBOkvsF1mRvsjB8I+NUla9Si
         RyM2V/bNQxiMYRdnbVeKQ2KjxzDZ6iL7AFWxPP90XDaRaL+lXcEcm5/nmscQzT5aKv1+
         84tS2KPC7sfOhPljTxSGR3nV7oMQ9+TV9ExqX/PXPR4PqrA9U9lPyBn4ETUHW/x3oQaD
         GPf+uQ3kx+hB+nJY6wPWhEXxQFeRnVueknTglwLSXwW15n5+qvTa/25LMMXyIEeUvlSb
         urjg==
X-Forwarded-Encrypted: i=1; AJvYcCXV/CQK9qU8FiKgmAxwJVVlMPu8JrI3oS36a5qK7MHB470siNHXTozFwsvNbaPS/waxcyxEsQ+Oz1uF@vger.kernel.org
X-Gm-Message-State: AOJu0YyOX54srdxTfPjV7YD45D+ZxX0CA48UaqceMdPVr2u215mB3V1w
	eTKZ6Cc/tppb3QmPaj+S/IcYYWL/GMweKfYU+ujcMlgL9ToF+ZNSeMqcZ3oCtLFUSw==
X-Gm-Gg: ASbGncuQip/AXB9QIDWetEfkcmYjSJq37bPxkzXWNQUCBlsLRBhLwxM/RhL8VvxGtrp
	guZceb9vOMh1fgrQ8sdiKvwQS2CrlT64F7BBr7FhI6xrfYjbNqgxdPaaPJr3OnWx0XxVqDMyFml
	/WBFGArtwS9+csudreU+eoPKb/UVV5y3hH8mtX1yyamiyHqEvNVJmR/yRe4gYpuXHBn2glKM7ny
	KsmgJYLENnHmBSCSrQlKTonvj1fU+rnJgxJXUR8Ui4A6sCMyPweA+l0r364rLsVGnQzMsLZkDHs
	+B9FrdnKkuH9qFKwb0TNBRHFhnRe9cBhEC9TXfRF51YuKGscZrfB6fYncNAESBZcGE0p2ODEswU
	zN9Zmw8NkV5dge7PWOaMqaFK1wAu/Kygm3RQFMSxYF+ul5UrwIu4buyiVgnjv8t5gubJHPObH94
	Lgzqr3QlTQX+Wujiy8O9WTmDIwQS8DqUsx/qWO1g==
X-Google-Smtp-Source: AGHT+IHxzXLAyCFx7IPmcOnpFb2vp8Rgf1l3Kna0V2OUhXGSl0YxnYi8nj1MD1lWW9qX+m9LVNsxvQ==
X-Received: by 2002:a17:902:e88c:b0:290:d4dd:b042 with SMTP id d9443c01a7336-29554bc5206mr7508255ad.16.1762165026873;
        Mon, 03 Nov 2025 02:17:06 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa4f4c28easm4658013b3a.31.2025.11.03.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:17:06 -0800 (PST)
Date: Mon, 3 Nov 2025 10:16:56 +0000
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
Message-ID: <aQiBGEgQ3vCpCvXM@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <15-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:29PM -0300, Jason Gunthorpe wrote:
> This op does the copy to/from user for the info and can return back
> a cap chain through a vfio_info_cap * result.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 54 +++++++++++++++++++++++++++++++++++++---
>  include/linux/vfio.h     |  4 +++
>  2 files changed, 54 insertions(+), 4 deletions(-)

The newly added vfio_get_region_info seems to pull-in common boilerplate
code (like copy_from_user, arg size validation) into the core code,
removing redundancy across all other vfio drivers. LGTM.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
