Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DC43AC3
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725902; cv=none; b=hl1fW1gWqrsji39Jz5w1rd9oY/AoSPMQPZD5bbA2B8JSgEenD5dd6+gse09zkA3FfB+RU0NQXY0mLu2ry/bOTULvzB0XCrrBOignm4xGmAPihSeBK8O3ojncze7n0Pnn3F8AcgJc7A92rZAKCVoY72J/KN2nlcWNCeLduD6g5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725902; c=relaxed/simple;
	bh=Lgpc90nKB87dyDcERAWICDYnV6YS1lcg3UEUBLb6OqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxMkZaJV9mifh16YXBs4XbfYvpwhql0RSXhkqvud+jzdtSRC/FDW0B1rAtBel9uhsgg1AKPGsXUjURZ+s/SRYZyeJZQFoHXKHqHRPWBJcLtIkazfTfYS47cWrCe0QBhnQy3SFsOLf5kKbO2WC0no000Gw2Wq3A42jlKMwkZMGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bntZVfoD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bntZVfoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718725900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjSGFR/9hcTm8rLTkGHUAeik1m3Y5cdjjiw+zxskYFU=;
	b=bntZVfoDJckWkRz7suMnuGIOm5b5CNq3oPzNVFrI//vuPfsUuXP4WbFhVByD4mF1zBLDIF
	HlxmBvHP5nPhlZrUWrMbCnbpaKDMXGOb4h5C8dJKrq0VqnBWsamwadY+yBQtUclhGFiHjx
	+HWISwWVMxllVXY9P7kI33j5RstDTAw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-lkB8DglFMsyVvtA-Ezw-tA-1; Tue, 18 Jun 2024 11:51:38 -0400
X-MC-Unique: lkB8DglFMsyVvtA-Ezw-tA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-25bfed6a3f5so195913fac.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 08:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725898; x=1719330698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjSGFR/9hcTm8rLTkGHUAeik1m3Y5cdjjiw+zxskYFU=;
        b=v6gMQsmxqW0nyDdIRZ7rmACXVAgFlRi232unVAtYcJdVv9P3XH/sKHpl2XMZfFT7yM
         8vxpD9bjchiwUOWE/keU56wb7k/vwp2/0jCJKvg6pH2k/eenL5VMgl3hm+tWjp4519Bu
         OBjY1LScRosKMH5BmmXAjITzzrCg6Kjuw5eKhCW/fZ9XjddXejPRE4iOq1Rd0JrLgsYN
         oFl7O2LJ+TtqaQ1xl33Id0l+5bySt+Yh49ufszXn4LiGJW4mpWAAJfa1ptMpQ79HcFCp
         sxXKLWbtnapfrJJLpu04FVifmjamAh6m8DYGcus9a1GEM9dG0Hkwjl+nJ+JJOFerxvjr
         naiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLT3LzBjBs5+z9JRgUSp2Fcdxqetkg6LZ2v7TkxMRlhhq4gjxGGfTzCwj1R1oDJKrU9px6Eb+7M6NU+2XyQgG12/pxXfZhpZ0RpA==
X-Gm-Message-State: AOJu0YxEsDhefIdEFbV9XeN515sgcHV6cJwlFmK+YJBvYoiu1Khp00Cl
	60gtzb7Z+E75X7iVYGa/IhU2p3EuRENGGD29lxFZGweQC0fJ9bGfQ6PRMUKbgeBoHPWvceJQAUe
	vuMUa0muM7axDw2X/w7egsPfW1KHCxzmPnsWdZHHF7wlHGuSn2A5fMMtZVs0=
X-Received: by 2002:a05:6870:8182:b0:254:8a0c:de4c with SMTP id 586e51a60fabf-25c94a21307mr170548fac.29.1718725896759;
        Tue, 18 Jun 2024 08:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE94IS+ik8v5kXlspSo6TVS47o9TWiOF1gb6qUVvv+zpMjmsvNrcNTEoeLkyLjoERTXlXp6Bw==
X-Received: by 2002:a05:6870:8182:b0:254:8a0c:de4c with SMTP id 586e51a60fabf-25c94a21307mr170537fac.29.1718725896455;
        Tue, 18 Jun 2024 08:51:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94e74fsm3228521fac.9.2024.06.18.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:51:35 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:51:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerd
 Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] vfio/pci: Tolerate oversized BARs by disallowing
 mmap
Message-ID: <20240618095134.41478bbf.alex.williamson@redhat.com>
In-Reply-To: <20240529-vfio_pci_mmap-v3-2-cd217d019218@linux.ibm.com>
References: <20240529-vfio_pci_mmap-v3-0-cd217d019218@linux.ibm.com>
	<20240529-vfio_pci_mmap-v3-2-cd217d019218@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 13:36:25 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

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
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 80cae87fff36..0f1ddf2d3ef2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,7 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#include <linux/ioremap.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -129,9 +130,12 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  		/*
>  		 * The PCI core shouldn't set up a resource with a
>  		 * type but zero size. But there may be bugs that
> -		 * cause us to do that.
> +		 * cause us to do that. There is also at least one
> +		 * device which advertises a resource too large to
> +		 * ioremap().
>  		 */
> -		if (!resource_size(res))
> +		if (!resource_size(res) ||
> +		    resource_size(res) > (IOREMAP_END + 1 - IOREMAP_START))
>  			goto no_mmap;
>  
>  		if (resource_size(res) >= PAGE_SIZE) {
> 

A powerpc build reports:

ERROR: modpost: "__kernel_io_end" [drivers/vfio/pci/vfio-pci-core.ko] undefined!

Looks like only __kernel_io_start is exported.  Thanks,

Alex

