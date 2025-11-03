Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFA296BDF
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152114; cv=none; b=QxvAv+QuO0DFolD1Un/x9utUh+c4kR7U/nJE4jsgedtuX8pBFMs8PjABtEaKdG31If+mGvC0uEcIZXBJHkGzw9Ym1GC68scxSW835LpZnpBzVQJ1rL1lhvrpBd7yvLZIDI/jIgDyQaF3VnvtNUy2WD0H5hhN+k/XRapv5UPN7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152114; c=relaxed/simple;
	bh=+CzUqqO06i/e7Ypbz0z7VulGOd2vXLPuLoDoGKacS4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpQuT6n6aZ0wiwq+jFJS6sS8mJoBYFf8hqLbiL/vkk87gq6vUo73Ejj2V4BoHBTHam3f9WCK3GQbWw6ievFeZqurX7k2ku9rXHHLj9nHCbenaIeCjkp2LO2VQdlh0EUSGbtbot41dcuimcTbhc2wR44CYQlvyrdOre8RC5ZRRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bnECZYk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bnECZYk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294f3105435so333995ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762152112; x=1762756912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xy09bbBV2an4SjPwDAIo8320NA2LlnNWvmRboTY817s=;
        b=0bnECZYkvrjtiIKzbq/h2ohkxkgZchTqdyniem2q1eBn3bk8l1R7CZyCEMf6SSIAtS
         jDBwAVtSPV+istaECaeSF+3AW+2Vnek7OclbuGgwfEtqH0KyOBEOFSsArSh4Ad6zYtJE
         LSz6Cf+kP6oKQIcnEEcUPhaMGJpoZQ56dYpHyySHmiJ1PbWch9BH23xuKZRHofM4gS2c
         p6z1wCzEqnR3p/eVoIuDR3O9I8qP44O65nQ/70IzqwALw0fFOYm2fxSy+pZiHO/JBVmQ
         +8C9kmzmTPTSjB9QJWXI/J7kCb9c3i8m30otXM67LYtbYuuMgA5Ssm6Y5YUNCHZ0IwIY
         xkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762152112; x=1762756912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xy09bbBV2an4SjPwDAIo8320NA2LlnNWvmRboTY817s=;
        b=ASZrZNtLfOG6kuRXYycxr23BWCbUB/YwkwwYE4LgwCtcykgMTHMyrSyFh/3p3MwlSr
         6NqRrZEUm+PP01QL4pkPKohSKu5fY0BYcowGZkCZ1uVzxffu+orRYiOGngB6WBBcRW1W
         XAVx3u4Pdevn4WmyDkjLB2NHI5DH8Ma1DqIJq8kqMN9jSbZaYPTAc7yhhHnVX9bjll1P
         4GydzUvpANCw1As9PtKimUt6WKIqBBTrFL28XDeRuHTmrS7njxR4rzLZl6fIOyGZz+zQ
         BJMBLpuuMNRFLZ9eikClG/9pwOYLd/V48c2o3kOwQFKuNnRJTMETqWudDYiUCBGJeK3v
         9xyg==
X-Forwarded-Encrypted: i=1; AJvYcCXdefbJOTFpGZU1/m8LbFC4JKbmhjB3gqi9OF0/EbeT/oG1r5XGSGzonBtpu0Kt8GJIjLrjozXlRYgl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FlvK5JCejU5ltnRek0ks/b7sbqC4/zdskrRcBLhHpZNBeZTj
	pY9J00RMEfgLgMM5G2BVseySpFZjK1M7NkIs/QgUsC4+HBb6OhGpIyURNT7+sQUsIg==
X-Gm-Gg: ASbGnctiZsNHwz2HcWbRFQZ0NMOvDN4PyrLt+KrplLOl+vNe1P7jMR4FK6bwkF2g3Ig
	rfCaZ6aZngVOzl9kXEhMfzuj6X4tAkNAyylMGML18hAriM97Z6Hig9TIGiX+nfcep9Bb/cfQakI
	87eresLF3MnsqPjkAwvZzrLTBqcOJo++YzVW5cWwhaxGgCpuHkuMR24zOtmGXrLqJAUlYYO3Gvy
	EvuZhO/4uKZoPUu8Zh1wsug55JuIgRTpiMooOoaTCDOoFeMhkGPpUmKaHLxCkxlOyfkKrVbiWJD
	BTC0hT1ImScjlt+FU6ocK9heO+vbOjDV+uSYetCDqSfZyiJiYiB2nReamX6vGCdJo3V42nt0IBT
	HYwveyxDOhsvNuj2QHiYNr96TyybOadKIjrbUgxazhuS2W2yEQUxY3IOv7OjvwQk0JDvaVl2Y7z
	SVPJ3S5P5SbvLrurdpfAKz/jWgkdKeAX/PJA0PtxiFxGi/ewnU
X-Google-Smtp-Source: AGHT+IGU3X/bvekwg5vtQ6XJGr9uQJGWUTHzyQr+Es6KbcLgu8QfXVso61Ocr0oWX8j6FOttuRoGtw==
X-Received: by 2002:a17:903:1ce:b0:292:b6a0:80df with SMTP id d9443c01a7336-29554bb5aaemr5658455ad.10.1762152111810;
        Sun, 02 Nov 2025 22:41:51 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696eb6bsm105902925ad.58.2025.11.02.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:41:51 -0800 (PST)
Date: Mon, 3 Nov 2025 06:41:41 +0000
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
Subject: Re: [PATCH 04/22] vfio/nvgrace: Convert to the get_region_info op
Message-ID: <aQhOpec7prJD3zKm@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <4-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:18PM -0300, Jason Gunthorpe wrote:
> Change the signature of nvgrace_gpu_ioctl_get_region_info()
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
