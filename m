Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8627D3E8
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420029; cv=none; b=afPjFBYe0yyr799WbGYk/aOzVQVCg7PG/LtwHC8Z9kGwYMKVI7bCxnaX7zivek842KbQVagCuB7JVzcRxvYRDwbSfAGR0WKjebetNeDU+kxBKqK3Sf3AV1Gt01fBh7QOSLo7CVgtC4vQIOx0vHTFLHFofGg6B+xODDmIvWD6VB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420029; c=relaxed/simple;
	bh=sw8yapCLRtTv5bLqcNyAlitdCMqg+LKpbh2Il4sznmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlDUAgJamFVlVMRybxebPfA5KrwYFySTL972TqrApVFe+vI9JYAYnEsI0/wgGedPKVdGzX2AVokdil2Np55A7nn8VYLi/csfWONszOeVpu3bqiqWpHgjmbj1/ZGCV78Klt4xvMPbQSScIFgFqhU/Ww5t4jcMzqzrqy+i+7BpzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ctNuss0D; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ctNuss0D"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61be674f5d1so52050847b3.2
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716420027; x=1717024827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRVT/HQCpieEX4UPQ3b9FruvZ7YPs6vzZePRdAjyEWU=;
        b=ctNuss0Dyy3Rxrd/Q6AUBdArj6zQJX8n9finRlT2oLz2zv+GA2SPOg9yrqhLjRYw6p
         BLR3PyQYXtO9AyFvxvT/se/JVm9YJq1uJ8E95sDC9SehVyhDPgKifKqiF1J+Mi8nYU2o
         IrHJmqzkjDd31XLRoJlhD5oPkM7OduWkkGsaajWY9w+F45qPKQ4pc+d6Gr4okG8z4gpj
         +v8U5SVg2PQ2tmldNAmhJPoPsvUvnl7ykC9smDeRaeZplsn/rhq269GOAelk1FKsNt6I
         aeBXmw0nmjdixEsNMhdimWxwqWVP8mXXQzEzFUixatd1dcHFeemC+W9qPjcQ6TNXp8lX
         uSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716420027; x=1717024827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRVT/HQCpieEX4UPQ3b9FruvZ7YPs6vzZePRdAjyEWU=;
        b=ApsydC3JEWCvcyLYY8Dukv5FeATaKzDNOrbyUUxPMY3pkjw5WR4Kjw98zWq85mpUqB
         b7kb/6EZjDrnAtn0/CAiVwKQ0l5oHlpARk8ey5fGYk4tmRbCE8GX02MYasz3zRwA0itY
         EJip/ErQv7o4anUAfXBXPZ1qfI4r3mvAtI9826WuA6khWDWPMaUDHblOcUehipTXfrTq
         RC940CeQmm0arh97R/O7MUKDObyP0zlJwhVW4DhnTZQqbc4JX41tLrrxZ7OSy7DTxOQx
         Ft0ZQzFWg7i+5PUA7fm0DKUcWlc+qM5BWQvnujka3f9SkxuaqgKW0gb8Erbmpbq5DDpi
         1NUw==
X-Forwarded-Encrypted: i=1; AJvYcCXC7yBHDv8udbGEr/crbSxVb3Q3HOEWIQhH0a+/hdURDs4AekoJDqDAswyONMxA08Cy8W9E3q8ruZcEk0k5u47hLNj9d7ASjXo/pg==
X-Gm-Message-State: AOJu0Yy8/FvagX6fZj5hsBWoYm0p+UOF43FcNxfk2ZCWfqr8+xQgx4zx
	VP3zDpGOgzK7+XgnvuzQqvrMDuqYGb0O6/PCtioc+6lBcoPajZZCjqSdQ2+Ev1UGjpvxnzO6cAD
	q2P8=
X-Google-Smtp-Source: AGHT+IHvW5aCdlXJsaBLmnifAzEUlPyyjqpEx6u3uIPqRTKh7DLWMe+zoge0ZxLclJp8Db8si4PB6w==
X-Received: by 2002:a81:4524:0:b0:61a:ca09:dae3 with SMTP id 00721157ae682-627f0975f7emr25218317b3.26.1716420026923;
        Wed, 22 May 2024 16:20:26 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aab86b0e55sm33972586d6.85.2024.05.22.16.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:20:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9vFx-00DcPG-7p;
	Wed, 22 May 2024 20:20:25 -0300
Date: Wed, 22 May 2024 20:20:25 -0300
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
Subject: Re: [PATCH 3/3] vfio/pci: Enable VFIO_PCI_MMAP for s390
Message-ID: <20240522232025.GH69273@ziepe.ca>
References: <20240521-vfio_pci_mmap-v1-0-2f6315e0054e@linux.ibm.com>
 <20240521-vfio_pci_mmap-v1-3-2f6315e0054e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-vfio_pci_mmap-v1-3-2f6315e0054e@linux.ibm.com>

On Tue, May 21, 2024 at 02:14:59PM +0200, Niklas Schnelle wrote:
> With the introduction of memory I/O (MIO) instructions enbaled in commit
> 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions") s390
> gained support for direct user-space access to mapped PCI resources.
> Even without those however user-space can access mapped PCI resources
> via the s390 specific MMIO syscalls. Thus VFIO_PCI_MMAP can be enabled
> on all s390 systems with native PCI allowing vfio-pci user-space
> applications direct access to mapped resources.
> 
> Link: https://lore.kernel.org/all/c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 15821a2d77d2..814aa0941d61 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -8,7 +8,7 @@ config VFIO_PCI_CORE
>  	select IRQ_BYPASS_MANAGER
>  
>  config VFIO_PCI_MMAP
> -	def_bool y if !S390
> +	def_bool y
>  	depends on VFIO_PCI_CORE

Should we just purge this kconfig entirely? It is never meaningfully n now?

Jason
