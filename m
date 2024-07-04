Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64321AEFFF
	for <linux-s390@vger.kernel.org>; Thu,  4 Jul 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109801; cv=none; b=ZkFV0q2Pv6Wpk10Xz202iXmlED1NpGL0w3IDLPkqSi34+TmJQ3rv8bO9wJe79WCWMzD7EKKKgT+3uXOhV0izrpCaWAnDNCKn84MnrUSgaOYmamjS8Wxv1cU1iUjWtEdF5cYuMRhKIcy6K8Yc4O+rxC40/AS0D+kEZAopzYI8V90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109801; c=relaxed/simple;
	bh=Q64XgPXxdPyF8fceBZsqiK/ZwK9E+LeSQ35lbTiGvTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekDPT9bW5mv95mU2ZuAGd4rqqs8groIP8a4fJLvXEO9wniT0B2AYD0p9/ZD8B/8GCUbkd3Va37EZJ9/+7LqIuYyTz7LqgZsKxSV89ao3Lppjn2WWVgMGKDFjNudYKoNaBh4WnOjws/C87Hp/9UHUuTGNSosia131HTVDY9AH78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ4nmbC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ4nmbC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720109798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJa9zCFGNHZVVWTUWtjqpJT17S7A9QRX0TDrsTkoGKc=;
	b=jQ4nmbC6hfKKVj5LQDFGjb7jVL/2rjO+gp5RWUIBbU0RSy8Q9B7yiMQfdm1UPl/YZnqHGB
	DIkAWPxnWrCjeDo1wIO2+YwpIujBQqzCzlbyslI7Knfnp/eW4EiAiFbp5k7WMrypux30kL
	XAE29lQLjLIVAY7atn0ymv/Rs6Pgsdg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-_duWbaheMjmLokk0ggTjAw-1; Thu, 04 Jul 2024 12:16:37 -0400
X-MC-Unique: _duWbaheMjmLokk0ggTjAw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso105819039f.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Jul 2024 09:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720109797; x=1720714597;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJa9zCFGNHZVVWTUWtjqpJT17S7A9QRX0TDrsTkoGKc=;
        b=MqXGtJQyB9uCI7qgt9tN/bCuuCouEBAEypOxLtTr4XfRRQ4TEcL3u99CYhIjbgR8Fx
         zbChSsCsuf8fDhHpljq2+ImRwPNqL6uK+M9l+ZXjhIPfBIDUpaK0SPW+saFnT/UJiq0+
         tG9azxHt8T9RZ3ucf2/eizAYCeaYvVAWXC6dTOYAqlq0QCHP7Bi/tf2E8WZMApQanRTw
         YZtvbqt3jI1rTI/kfbI/kXIDFgEJdSTt8KTI8QhOZ5ZFg7Jvo6xz2FHLNgFn+IJQw4Mf
         PRUAFNhDSp9+d2od0XvGba4UG6bUO3bOjfTeEGos959tjH8FS8JUccC9A2BdyEWHHyUU
         2tYw==
X-Forwarded-Encrypted: i=1; AJvYcCUPFWthiWo1Sv5tHHCYyDknY42BTiOKD5XDABPpuoxVplYeku0sFP44cspXG54HyWnITrrdvWLV3COFURaRT/ftHNqCwv1NSa5uGQ==
X-Gm-Message-State: AOJu0YzXnMHSM+4KEQnxyoatyPqJIlr7v19vFf5Od6BaQbxfkF2l0jwQ
	eQRipivnnLZORIGCpRzZyhp4XQDnr/tEisu0LvFmklQiNv89TrKVxSICNDQbKr694YRsDPnmMFO
	TmCQZOASOGXxwW1IHhTA+eCE1nYlvAee3UkRCbR1y725bonOJN6thb+IrU/o=
X-Received: by 2002:a6b:e611:0:b0:7f3:d82c:b9e6 with SMTP id ca18e2360f4ac-7f66df1c79emr262809439f.15.1720109796814;
        Thu, 04 Jul 2024 09:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJUTtWQwJuNtpWfpOA8Dm3k5p7PLSbdfR6O6iYLOTaqEpw7ci4MY9M4rg9iu7ACxq2jHdXvw==
X-Received: by 2002:a6b:e611:0:b0:7f3:d82c:b9e6 with SMTP id ca18e2360f4ac-7f66df1c79emr262807939f.15.1720109796433;
        Thu, 04 Jul 2024 09:16:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb361fsm4006058173.23.2024.07.04.09.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:16:36 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:16:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerd
 Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] vfio/pci: Enable PCI resource mmap() on s390 and
 remove VFIO_PCI_MMAP
Message-ID: <20240704101634.30b542a2.alex.williamson@redhat.com>
In-Reply-To: <20240626-vfio_pci_mmap-v4-4-7f038870f022@linux.ibm.com>
References: <20240626-vfio_pci_mmap-v4-0-7f038870f022@linux.ibm.com>
	<20240626-vfio_pci_mmap-v4-4-7f038870f022@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 13:15:51 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> With the introduction of memory I/O (MIO) instructions enbaled in commit
> 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions") s390
> gained support for direct user-space access to mapped PCI resources.
> Even without those however user-space can access mapped PCI resources
> via the s390 specific MMIO syscalls. Thus mmap() can and should be
> supported on all s390 systems with native PCI. Since VFIO_PCI_MMAP
> enablement for s390 would make it unconditionally true and thus
> pointless just remove it entirely.
> 
> Link: https://lore.kernel.org/all/c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig         | 4 ----
>  drivers/vfio/pci/vfio_pci_core.c | 3 ---
>  2 files changed, 7 deletions(-)

I think you're planning a v5 which drops patch 3/ of this series and
finesses the commit log of patch 2/ a bit.  This has become much less a
vfio series, so if you want to commit through s390,

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex

> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index bf50ffa10bde..c3bcb6911c53 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -7,10 +7,6 @@ config VFIO_PCI_CORE
>  	select VFIO_VIRQFD
>  	select IRQ_BYPASS_MANAGER
>  
> -config VFIO_PCI_MMAP
> -	def_bool y if !S390
> -	depends on VFIO_PCI_CORE
> -
>  config VFIO_PCI_INTX
>  	def_bool y if !S390
>  	depends on VFIO_PCI_CORE
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 0e9d46575776..c08d0f7bb500 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -120,9 +120,6 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  
>  		res = &vdev->pdev->resource[bar];
>  
> -		if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP))
> -			goto no_mmap;
> -
>  		if (!(res->flags & IORESOURCE_MEM))
>  			goto no_mmap;
>  
> 

