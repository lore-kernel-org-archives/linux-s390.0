Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CC146A8F
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419980; cv=none; b=ehMDrM2EH04rrvoCEf+yJEKWXNva5jEEy19tBntHZ4RolisYuX6V+ZgDW4wlHQPFOJpAtZOy/GAwycr8Ql7fcsziZq5bWvfZzD6BqcuBpSgKZGJM+Ly/I6fcmEWXJrL4opfn1xl0fi00DD42TYoIM4dSTO5eynzB9DupdyJxqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419980; c=relaxed/simple;
	bh=n5slVlqOAykID9MEbfympq1Zg8oJL6MvLOqRwWH0S0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8y8cHR2Z1cabPyI/6GqTk41/H3E8ORkmaT3eeKbH1lycUYoOquh0erR35L2OBAXCV7iRhyl3eKCuxx8jXDN96sobWOvYP4AHiDMJ+cNiGT8hTksMK2nqfKHxuG+p9FogBKpLUVYf+osWkPMBy8WKJtwvwv2KwqcjvvrAWK291U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RC8GZmO8; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RC8GZmO8"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47efc592d9fso495902137.0
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716419977; x=1717024777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSl/xjV6yIg0FZx3wy10QWpD7zCQXutDkJQvlsFhyU=;
        b=RC8GZmO8+77ERwhYuEMryD/cl8rtQZawDw2HYLW8XTen9nrbK8vxSqj6OzlhTeeQ2T
         jawz05EmY3+v2z5RoxovUwxOnf48Mlzect0tQxFz+kdsj8fuV2gSZ9DyUdIivBO7Tds4
         KzG3B4xWjy3EWG3zPY387aHH2RFUtcyO+S+Xzkpf2w/gGLW3GzRmDNqSd6gu5TVbFmwy
         WTni6m3nwNcMfuB7Kqu1pSXpt/2gB6AzzelnUx7QB3Z0Mhup1VR+CdQK0FjXZiGOjXqI
         HIE4Zf8ds3kvMXrRq3wDgd/6Of9nT6hqYnQQyJR1kA2tGQea7BxYejRncy4vwAM6EZ1f
         BueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419977; x=1717024777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrSl/xjV6yIg0FZx3wy10QWpD7zCQXutDkJQvlsFhyU=;
        b=OK35a35oT6BDdIjkTb7iftUiNbvH7Nz5y/WvXsopw09BFdjNjCNXPUTyOf5yubCY4A
         L/Doja4OAk3dlISfcS6it1oCvTlyHThIRstyLSppzk5PFektpvecu8vgseKuzrHUlFgF
         K4Y0j1ZAdbDiJVYGFQNBD/ws0QOqcXW0qHGpmOd4xmDUsVMnusdQfT2Ntjr6Y6aMyIK8
         K3cViYOjjQUEVfvLqCC0MvfxYWuFsr39TVGiIu+Oq4+uOvvgaetbtUFeDCtqje04poel
         zafX4FdVg+Hf50WpYkn6KPgF9VFdlEVlQpwnbEqpavKyoQmNRAqn86tTt+OmhEu6atEM
         t8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuyBgNbE5TIvs0wTe1L6Pg8AUim+fAupmImYhI81A3qQ2m+zG/YtNRreCRJE4sTuDPvY/iqgGo1Yo/R5o4IaDPFPGKV1EWC8UhDw==
X-Gm-Message-State: AOJu0Yz7TaGVHsfj5UuPgK6vpWJcHez49tCDV6dgg36T4H6ja962tHo5
	dd/QABALVs3Cb/+CIQIcGeVzSqN0Texw+IATQuiO+RTBU/6J1lbAchqsFVPygKA=
X-Google-Smtp-Source: AGHT+IGensuS5Pk2fc/N9/agazTDQfEmFFa3e6WHotIo6avs9UZXDQxrWdOHLx2cieNHiAlEyTlUGA==
X-Received: by 2002:a05:6102:a4a:b0:47b:b5a0:6708 with SMTP id ada2fe7eead31-4890a275ffdmr3677299137.23.1716419977636;
        Wed, 22 May 2024 16:19:37 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ce6b9sm137775086d6.83.2024.05.22.16.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9vF9-00DcH9-UV;
	Wed, 22 May 2024 20:19:35 -0300
Date: Wed, 22 May 2024 20:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] vfio/pci: Tolerate oversized BARs by disallowing mmap
Message-ID: <20240522231935.GG69273@ziepe.ca>
References: <20240521-vfio_pci_mmap-v1-0-2f6315e0054e@linux.ibm.com>
 <20240521-vfio_pci_mmap-v1-2-2f6315e0054e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-vfio_pci_mmap-v1-2-2f6315e0054e@linux.ibm.com>

On Tue, May 21, 2024 at 02:14:58PM +0200, Niklas Schnelle wrote:
> On s390 there is a virtual PCI device called ISM which has a few rather
> annoying oddities. For one it claims to have a 256 TiB PCI BAR (not
> a typo) which leads to any attempt to mmap() it failing during vmap.
> 
> Even if one tried to map this "BAR" only partially the mapping would not
> be usable on systems with MIO support enabled however. This is because
> of another oddity in that this virtual PCI device does not support the
> newer memory I/O (MIO) PCI instructions and legacy PCI instructions are
> not accessible by user-space when MIO is in use. If this device needs to
> be accessed by user-space it will thus need a vfio-pci variant driver.
> Until then work around both issues by excluding resources which don't
> fit between IOREMAP_START and IOREMAP_END in vfio_pci_probe_mmaps().
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
