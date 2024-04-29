Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8684E1B
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408328; cv=none; b=i1Vj8RRKiRE2qf5A7FRyItRKeO/UkQ+VycQmPxs03qYMlAczdtiRzRqHQ8kdDZmQiuqQSJlg349FSlgxxx17Qkcx4fPEZbrjdwYkOL5sfbjmc6pjRWBBvDy0PYTRMeDASY3h3Qvk2Qh2b1gEQNW0hooMZ0FsVG1QgQ0mz/BpBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408328; c=relaxed/simple;
	bh=KNY7YfkCFOCGJEjKFw4J5ymcqJqQzD2TMjdp9S6DTnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpQl96A8VK/XFKJ698YOjOD2c1gEoxCr0xN53IEKpMPRZFQ3r6GJ6+djcjbbMW6Do0VBrnT3XBccLORL2Ck1/CEXkbVJgbvMTl3gnFLGTXFv70T+mXXravumhTa3KEqxZTciNr/cNTKnEiH9kiF4AdqGmNMUEoTTgooUaLoyYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XX1Z08lD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XX1Z08lD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714408325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krZbL0UMrNCqvGgRWhIvx68Omsbhhm2kSbHqmbczntg=;
	b=XX1Z08lDuWtq9NKAeoomemt9SaOfLTB9GOrFr8LmSvG8zVk+KLmdPtPi2DOc3q0EIvR/dP
	qX85Y9BrQP4C5zHhu1hkGs99ZHImfK3fnCB/xNF9L3EBN86ZHUQvXfpMvW3E+6TLD64hz8
	RmnvpXza+jQ26pSkZA5+DyYQ1Z+q5/w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Ei67r5X4Ni6sAd_UUfmgeg-1; Mon, 29 Apr 2024 12:32:03 -0400
X-MC-Unique: Ei67r5X4Ni6sAd_UUfmgeg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso537179439f.0
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 09:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408323; x=1715013123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krZbL0UMrNCqvGgRWhIvx68Omsbhhm2kSbHqmbczntg=;
        b=KdCW7iJ1Nop7/OlFl1bWE2xqm0ieR8sVYwDwlyIK1zaMXxH8/eLRPebhUrX3/EiJbM
         4mhURNGZFlDy3xQhsrQeAysVw/gViHlMvxGz5fJeitWkbso7BrJJH/LaCoLGMg/BNpOe
         6UM+/9q4ChsCBlMoaGAr5LIPzps/fNd7Za4wouKcDBTgxg/S1GsTfWU9EqbFFkqTcJsR
         6q2l6QuhtU1tIu0k9xIJo5ApGDLmWsICIPs4bm0hBR6t8ZLSX4qGUtCAXD6PdFaQy4TX
         Bj1fIegeZ0hKD0kxdUR6i9i0kD4XwdlE1cSKpCr0nS7920QtsJ9SyzhCKcO23cwoODqK
         cHww==
X-Forwarded-Encrypted: i=1; AJvYcCXK8Pv47yHUKI/wzBajG3vzPPd8LLeNkWQngSFBhKTgcSm20tx3XOv0+/qeBTlyWSYWRau/kAFuMioaXllvZXhAyio8vny4asPvvg==
X-Gm-Message-State: AOJu0YxSa3Soeo6vSRMMXwDo6kxII7BgeFdtB/pyN0Aj4JGHY4eV5TbF
	z5X2N2tjg0hViTwV+VUEZ19ZCBsxSumQ3ZTUU9zTzWsh5SalsH3eLlpS/AsQwnacc555S6jyZg6
	2LFjzt+MTThY0XnwPoGHpr2CHolTG0zhzGJO4EeoMftnEnB/OQSfmzUFMgNo=
X-Received: by 2002:a6b:7802:0:b0:7da:a00d:8b55 with SMTP id j2-20020a6b7802000000b007daa00d8b55mr12471086iom.17.1714408323037;
        Mon, 29 Apr 2024 09:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuu3m9KV8Dkpua6ArPjFefWK1kmulefZ84u2kCvEoe9tguZjAfNmfbuuSm83m/jDnLO7QT2w==
X-Received: by 2002:a6b:7802:0:b0:7da:a00d:8b55 with SMTP id j2-20020a6b7802000000b007daa00d8b55mr12471056iom.17.1714408322693;
        Mon, 29 Apr 2024 09:32:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id iu21-20020a056638861500b00487366e2e1bsm2547608jab.144.2024.04.29.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:32:02 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:32:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil
 Pasic <pasic@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] vfio/pci: Continue to refactor
 vfio_pci_core_do_io_rw
Message-ID: <20240429103201.7e07e502.alex.williamson@redhat.com>
In-Reply-To: <20240425165604.899447-4-gbayer@linux.ibm.com>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
	<20240425165604.899447-4-gbayer@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 18:56:04 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

> Convert if-elseif-chain into switch-case.
> Separate out and generalize the code from the if-clauses so the result
> can be used in the switch statement.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 8ed06edaee23..634c00b03c71 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -131,6 +131,20 @@ VFIO_IORDWR(32)
>  VFIO_IORDWR(64)

#define MAX_FILL_SIZE 8
#else
#define MAX_FILL_SIZE 4

>  #endif
>  
> +static int fill_size(size_t fillable, loff_t off)
> +{
> +	unsigned int fill_size;

	unsigned int fill_size = MAX_FILL_SIZE;

> +#if defined(ioread64) && defined(iowrite64)
> +	for (fill_size = 8; fill_size >= 0; fill_size /= 2) {
> +#else
> +	for (fill_size = 4; fill_size >= 0; fill_size /= 2) {
> +#endif /* defined(ioread64) && defined(iowrite64) */
> +		if (fillable >= fill_size && !(off % fill_size))
> +			return fill_size;
> +	}
> +	return -1;
> +}
> +
>  /*
>   * Read or write from an __iomem region (MMIO or I/O port) with an excluded
>   * range which is inaccessible.  The excluded range drops writes and fills
> @@ -155,34 +169,38 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  		else
>  			fillable = 0;
>  
> +		switch (fill_size(fillable, off)) {
>  #if defined(ioread64) && defined(iowrite64)
> -		if (fillable >= 8 && !(off % 8)) {
> +		case 8:
>  			ret = vfio_pci_core_iordwr64(vdev, iswrite, test_mem,
>  						     io, buf, off, &filled);
>  			if (ret)
>  				return ret;
> +			break;
>  
> -		} else

AFAICT, avoiding this dangling else within the #ifdef is really the
only tangible advantage of conversion to a switch statement.  Getting
rid of that alone while keeping, and actually increasing, the inline
ifdefs in the code doesn't seem worthwhile to me.  I'd probably only go
this route if we could make vfio_pci_iordwr64() stubbed as a BUG_ON
when we don't have the ioread64 and iowrite64 accessors, in which case
the switch helper would never return 8 and the function would be
unreachable.

>  #endif /* defined(ioread64) && defined(iowrite64) */
> -		if (fillable >= 4 && !(off % 4)) {
> +		case 4:
>  			ret = vfio_pci_core_iordwr32(vdev, iswrite, test_mem,
>  						     io, buf, off, &filled);
>  			if (ret)
>  				return ret;
> +			break;
>  
> -		} else if (fillable >= 2 && !(off % 2)) {
> +		case 2:
>  			ret = vfio_pci_core_iordwr16(vdev, iswrite, test_mem,
>  						     io, buf, off, &filled);
>  			if (ret)
>  				return ret;
> +			break;
>  
> -		} else if (fillable) {
> +		case 1:
>  			ret = vfio_pci_core_iordwr8(vdev, iswrite, test_mem,
>  						    io, buf, off, &filled);
>  			if (ret)
>  				return ret;
> +			break;
>  
> -		} else {
> +		default:

This condition also seems a little more obfuscated without being
preceded by the 'if (fillable)' test, which might warrant handling
separate from the switch if we continue to pursue the switch
conversion.  Thanks,

Alex

>  			/* Fill reads with -1, drop writes */
>  			filled = min(count, (size_t)(x_end - off));
>  			if (!iswrite) {

