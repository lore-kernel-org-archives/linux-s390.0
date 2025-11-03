Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2E299949
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155125; cv=none; b=uDGgsPfvsDkOHZqZHRnlUYBAYlzwhyFn3QGvb9eoM+eJQQbGSj+ionDcKnRmT6dmNC1jaIZAZQ8jJWzo0QT6RCKA4cI6jPG9yhen9EB4SS2oHoOLbkn/qGISV+usCzR+wm2PmMDyLkEPgGvgAIe6s/iI8Iz67AAfaPDs62veaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155125; c=relaxed/simple;
	bh=I7HDUIQg/KdqyDmPQ+qrxG240GLYIT2LqIXpnIqKcNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnl5muDQhNqJjkQZjNg/ErNh1wdtQjVp77I5LUIZKw+QiXOTvCVse+tluUGg/Qq5hWwyyNKovRRiVuQE07DveSzPz0XdX2h4KN/K81PZfoKFIf3qaq1wkA3ONsi/kwSR70GbCuCkdwSVf74Cmr3CFnbPHUgQ2ZerJwLZ5BTqylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSookYoF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSookYoF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294f3105435so342305ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762155122; x=1762759922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dADjXQcJVAcOBFwaI/JeQVroSWZH3kzmeM+gasunsjY=;
        b=zSookYoFfRjRsve0TquPbNlYHAKP8u8FjlXo1epzJ6/MiQOm3xl17tPdtSpUkKMd8d
         wwt2uP+wqJVBOc4WxSuC4VPnKPS+96pFg219qfLnd5GeGFo6HmHghY55eRmYR8Csw6AD
         G429iGUTkh0fMW1GPkmq9CDj00OZl2DSRdi0avBZqa75Y6Z7pe7bk6IIkFHNg2IlzxGg
         +YErQEbQZj4EIcQ2pji1k9FVSyZ10O0tDol1UhmvHbtx1KkbJRaPo7PILN3lL6lwqTUb
         JFqxwMAB7kcpqlAQLM0HEiTJ1FdYKnsxHXJseW+lSy5tLB2Z6Hu21xaHBP+YT+hSB2UC
         mhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155122; x=1762759922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dADjXQcJVAcOBFwaI/JeQVroSWZH3kzmeM+gasunsjY=;
        b=e2pTmCdQswhXODNkV/qYZ3SnnJnebLYj5B5NE8MobQ9zYIs01VRCEiQDgwPgJD7s9u
         uENn1B0JA6dHB8Ukyrv5dYhc+txByCFuJyiJilvnSexHkEUejoQxhjGYSytY5LlH2SWr
         eRFCgcXZDwZ3xMFUJdPrchJGgwOkWmifj4w1xnEaTAU23nubqSUlT0GxfmBDqLacBrYg
         y5i+8OMy87xrB20rXjvv6nR0EGSOcTm7szB7+kFcZfZgazDeyBZSJvNbDiafr/miH1iF
         vG8zPSTjlDRAciZ3B9wm+BKTGd93ekLMZyDR2Xb8WetPXbrDRv2gGi8R1VRzOOtyQMmB
         Tf3w==
X-Forwarded-Encrypted: i=1; AJvYcCWH8nTR7Jok+TxLMNsanhIsMZC59ijsw55YmGJbtkU2ewF7qMeeoMKkiy9k60j+TnmcJ/vLEU3SnCBU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2Howp1w9Pv0/yfL5Doy/CEJX2VbHbV7y8KbsW6zEhHPmTyc1
	Oeh85lOdDA9AbzisROJMleuYHcPW8p2/JMes1UQt95tbVlwlyCHMXtwI8cFdCG59JA==
X-Gm-Gg: ASbGnctrBKK/OFX8qispe73ehbTqXBrR/QbnQApHHJ+0clZA51foNhv9LoiHp2lJRyP
	mKBBLZZziTriWiFkMIg6fwpPra7ETdamfbqT1g0mq3mA0uwuADZwTFs9kCl2cYrxlJOpVt1FqLD
	q3DiNM8ByESN+o0AOI+fGkFCpP/EhUwOeWeF7lMHurJhNtu3/Eu8lG+BrOC0mpPKMKeid5BxqSs
	e65eDXfgTAldv2/KmVVi0Tck2iWVFXbsGvKmrOgnEpgO0Qk/Nu49Kqbi/2p6//XVM9FanvwGaPK
	ApoTBkj54lZyF3p6Hl80KYTuA5drJKhFkLca7Gh2KiGq6zg1/Zl30hY12J3M9sBBtQOZWHUC3GM
	jEiskyOfLDofoZ+uta1bheeDy4n3usH5XgWoCbwIgFK6/2TV1DdG8o3j5J04h8XsAq3jPz0W1N3
	o5QtdITE7sDVcnsDdhlzp9Ji6o0ooLiDe82HFgbw==
X-Google-Smtp-Source: AGHT+IHfrP3JzShs73f4Ou9j74BKdOau8otZ+u7WUYTtBZ6PInXsEFYOD9H0FiQHWOz2YtGspU3bog==
X-Received: by 2002:a17:902:ec8e:b0:274:1a09:9553 with SMTP id d9443c01a7336-29554bb5d5cmr6804875ad.6.1762155121865;
        Sun, 02 Nov 2025 23:32:01 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295512dedabsm82398675ad.5.2025.11.02.23.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:32:01 -0800 (PST)
Date: Mon, 3 Nov 2025 07:31:51 +0000
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
Subject: Re: [PATCH 11/22] vfio/cdx: Provide a get_region_info op
Message-ID: <aQhaZ2HvTTtanNdu@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <11-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:25PM -0300, Jason Gunthorpe wrote:
> Change the signature of vfio_cdx_ioctl_get_region_info() and hook it to
> the op.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/cdx/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
