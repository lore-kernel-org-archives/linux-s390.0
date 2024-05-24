Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00585277
	for <linux-s390@vger.kernel.org>; Fri, 24 May 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559219; cv=none; b=Gh9+ilSlwLQNHrPOAM2bk97EbriwMvlzrkWVP7SHtztCmW/slXVVbe9TlVwAyR2bNxDwYRjVMgiaSsx4wFx9UQQBEo9blpiirSvppZfNYy2ih1Klnq5sxC85vjf7/Yo0RZPMw1+SwBdsAHewvbIsoGjVBSV5huN4qBl1R44QL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559219; c=relaxed/simple;
	bh=m9EXEHgn58Nz0k3zepJ67YxfXXLeManwCE96gtpQJlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf2ICCF0V0/vXzMl1jlCYB2Y97NQj6DHw8lTIUswMFdYAe30JIMeSgM2zd8aJ83OycaZRV6S+EruUnysHYlxQ3rooqwj0g82YSwtlBI6Uskek3quDIKHiWW8USpdXgS4fh2LGUZc90kwtOuTBW8wD8lgBILklUQwd5zO5H0Zb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K+UERycP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K+UERycP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794aa87af7cso34804985a.0
        for <linux-s390@vger.kernel.org>; Fri, 24 May 2024 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716559215; x=1717164015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn2WGg2eQ70N/KJT+N/gGNSB60ehRMCCIv//ULnCXQ8=;
        b=K+UERycPlUY1khzMRqKshMhy5oFgAJ6RXXON+4+VEhif6i4SU8heQk7cg5ttSj6xED
         vD6WmyTXv82uS7sqWLoauj6Q+Ow/tkuZ+tHt75UpAEJqPkXImlJKC5ctfI9AWSsrnHpO
         MsS09vmk7+LKCtAqPg5iWcY3mh3V0ifT1s+QwkfO/RJB3qQGcUT5bmQiv5TxD2WiFMFc
         yrX/ZCkuUOdxVmjH0k3/JzvbgyLgd1nW7g8X4ncf/Ghp8/REXX9uvKKi8zdZuX30HOoM
         EW2iXk3WT80NEe8nQgb2wwAO15crv0zA5VS1HIuzjqUpFnadBrfPUlkxS4brZYjQUOFc
         VZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559215; x=1717164015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn2WGg2eQ70N/KJT+N/gGNSB60ehRMCCIv//ULnCXQ8=;
        b=HOgYboATX1nZEA0LmrLPldR6poX7qhRSK241d0wX2nYVazvb/50p/26Fd2weSm4Stu
         fdX0y5CrPMkYSO0VDBqdA06ZlsL6MGqaV2Bsso/wYs/5ZaWt5ATfLq+qjF8LYSHRi6Az
         T/SLshVtf2Ncv6pIsTgfg34nLWFmDaSahD+dSx5CL7Xw7PRnw5d5FLaCVWmBd1WSWhV7
         MF/11Gela1PZQkLj6dSC3fP+3OpGL3Nz/z5Rsr/qCAhjv8knPfXI/y9LiChqV4iJajNr
         y8f/qZ9LrOPUDQk5um7QwgCj+99sF2rn2RRSyK3vSAxOcb+/iAyOofNNoiq390McAkax
         IPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy/PTZjF0xms0jxAIKHxfA+IVngjXXbsQ7zpqOdVeC1fq5WJPOPrPu2sYYexJObFq+xb+JzMgVo1BZFDdrUgXdV4Ov7jv4d9EpPA==
X-Gm-Message-State: AOJu0Yw7BnSc8xk1UPXWnFG7cM0DpVhpsEAKpG9ura4F0mGKqf9YJyvl
	GdJq0DJYM266EWcwd3vqT8AK+QSID8WiI3FKwc37aoWCDnyu9bO2iATNekWq+XA=
X-Google-Smtp-Source: AGHT+IHxOBaD+7IzWccHqf8dVfDLepdFFdrMdqpmsYeH9ASfCrINsAAnEEUG9Ei91kpeZM575T0SHQ==
X-Received: by 2002:a05:620a:3916:b0:794:a0ec:6a0a with SMTP id af79cd13be357-794ab060b47mr272043185a.8.1716559214959;
        Fri, 24 May 2024 07:00:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc22c8sm66766985a.32.2024.05.24.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:00:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVSv-001IGC-IT;
	Fri, 24 May 2024 11:00:13 -0300
Date: Fri, 24 May 2024 11:00:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com,
	gbayer@linux.ibm.com, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, ankita@nvidia.com, yishaih@nvidia.com,
	pasic@linux.ibm.com, julianr@linux.ibm.com, bpsegal@us.ibm.com,
	kevin.tian@intel.com
Subject: Re: [PATCH] vfio/pci: Add iowrite64 and ioread64 support for vfio pci
Message-ID: <20240524140013.GM69273@ziepe.ca>
References: <20240522232125.548643-1-ramesh.thomas@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522232125.548643-1-ramesh.thomas@intel.com>

On Wed, May 22, 2024 at 04:21:25PM -0700, Ramesh Thomas wrote:
> ioread64 and iowrite64 macros called by vfio pci implementations are
> defined in asm/io.h if CONFIG_GENERIC_IOMAP is not defined. Include
> linux/io-64-nonatomic-lo-hi.h to define iowrite64 and ioread64 macros
> when they are not defined. io-64-nonatomic-lo-hi.h maps the macros to
> generic implementation in lib/iomap.c. The generic implementation
> does 64 bit rw if readq/writeq is defined for the architecture,
> otherwise it would do 32 bit back to back rw.
> 
> Note that there are two versions of the generic implementation that
> differs in the order the 32 bit words are written if 64 bit support is
> not present. This is not the little/big endian ordering, which is
> handled separately. This patch uses the lo followed by hi word ordering
> which is consistent with current back to back implementation in the
> vfio/pci code.
> 
> Refer patch series the requirement originated from:
> https://lore.kernel.org/all/20240522150651.1999584-1-gbayer@linux.ibm.com/
> 
> Signed-off-by: Ramesh Thomas <ramesh.thomas@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_priv.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 5e4fa69aee16..5eab5abf2ff2 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -3,6 +3,7 @@
>  #define VFIO_PCI_PRIV_H
>  
>  #include <linux/vfio_pci_core.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

Why include it here though?

It should go in vfio_pci_rdwr.c and this patch should remove all the
"#ifdef iowrite64"'s from that file too.

But the idea looks right to me

Thanks,
Jason
