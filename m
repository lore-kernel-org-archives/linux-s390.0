Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D0548EC
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408304; cv=none; b=BrQMHttqOZNmoGQJy4S6oB0ZnhS5yIlDfML679bshFAF01efT9K9y2/ghykYDgCU2VopPvGMlxqlkNipNE4wSV6twIgnHVzO4sO3B5EYqsgetQoR9Y+8Cot4JKXXtibj+46IAAa0+0FfXNFJ5lmR1Z1pH572IUYdqa6S76JUSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408304; c=relaxed/simple;
	bh=9LZtxJD6B+6zioX7BNC1oyMqWg0YmSIbb9AD+1CR/UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVYlgZCxD7LGzNbnplZUBoVgCwvUunX28Y3kI89+/uej8yKJ+3RcSSTaW4NqROo7bl/FDizMNOf9K/D4PPrm4PsKVjv6CKK+VmVdK+9yYCVJ3M95rpFE4QECRQhgOxMGMbZPe5sD+4ovtrdKKYVkM/Tv1AqLw/crtMZ8uTOPYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5eeGgHX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5eeGgHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714408301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3bnP5fq/PnIo0P3cjy/umu94aFyOl2Akp5t0nlUjdE=;
	b=R5eeGgHX+ksJJOiQL9vZtNbaFpOlQPP0na4Fz1Mz2LNHV8vw4yQ8/3XrpVkpBK9HM12/YX
	v4biZvEpUC/Gcb74jJ9YS/2Pj7V1lfB62YV9cf8fMx19yJcQzo5nx9VSfrVWMiHiJ6J0oL
	3pEH6jYPSXU8Fmd9SyzVGKlM1jXwwNY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403--ue9LJ5NOPq9ZJZd3H2UQQ-1; Mon, 29 Apr 2024 12:31:39 -0400
X-MC-Unique: -ue9LJ5NOPq9ZJZd3H2UQQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b34b3a5fdso44796055ab.0
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 09:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408299; x=1715013099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3bnP5fq/PnIo0P3cjy/umu94aFyOl2Akp5t0nlUjdE=;
        b=EtiMPzwRjOnUzmOCUmRbaNB4tuaGwWBrgMeYHXSDkxD8l0EQU5IU9Ed0GxMyreZ+4G
         QmBJYF80IJ8PTZpW9NX78lSEOOK1lMQmNZz4KcbMuaDrSSvmARq1ALUkdeuZx1NRpoBO
         TRV2SSFfbgd31QbCxC8Qt8W6xLWmCjKlHmFw3722vr2zdYbBGPAVCnGrcUH6gGyixfGn
         cyGxV1Pz4rdbXtfIstSAKZ2GnH2MVcI19xi5ubdjxlmpXRxcY43acjqu5zwNKwdyZeON
         lOqv3EwNRKD0S5fNyus61Yd1AZXv6b0eG1RkhORAZjNpvCvY+jhiDM/ezfMmmqcJd7iC
         59Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVipFQNV+8JwdtCgyaR2QMN4sgPkAM5uUkjOFUg0ZNmMY17F+H36mrI8xFHDo5H3HjDFITFF6iUKqVGbcPDr7welxC2E5Zsl5VEzA==
X-Gm-Message-State: AOJu0Yx6ph/7i+XJbRDpUlpCbBj8+53NjeDkXXs2D9gVuA8eWwXjHgHX
	4BJo7nDB+o9xIu0OtoaM0gMXpnGuklPUgzeq1DXNxQWyb/hKdbt90flJYa+sw9YK0s/NdI/9QyU
	+CyBFJhJbZhfnweVGmg822VIHskns1khgT48pWeyrQYH9smcaDI+27Fp9hwU=
X-Received: by 2002:a05:6e02:1aa3:b0:36b:1e1:552f with SMTP id l3-20020a056e021aa300b0036b01e1552fmr291821ilv.23.1714408299194;
        Mon, 29 Apr 2024 09:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBWRGB/H4xzITyzWAXi20ENkjfQgAIHe1Cpv5I8TUJlPz91KZJwLgwMQ7idtqRUHZMs8Rag==
X-Received: by 2002:a05:6e02:1aa3:b0:36b:1e1:552f with SMTP id l3-20020a056e021aa300b0036b01e1552fmr291789ilv.23.1714408298764;
        Mon, 29 Apr 2024 09:31:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id v12-20020a056638358c00b00487cb697fc2sm399310jal.23.2024.04.29.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:31:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:31:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil
 Pasic <pasic@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] vfio/pci: Extract duplicated code into macro
Message-ID: <20240429103135.56682371.alex.williamson@redhat.com>
In-Reply-To: <20240425165604.899447-2-gbayer@linux.ibm.com>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
	<20240425165604.899447-2-gbayer@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 18:56:02 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

> vfio_pci_core_do_io_rw() repeats the same code for multiple access
> widths. Factor this out into a macro
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 106 ++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 03b8f7ada1ac..3335f1b868b1 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -90,6 +90,40 @@ VFIO_IOREAD(8)
>  VFIO_IOREAD(16)
>  VFIO_IOREAD(32)
>  
> +#define VFIO_IORDWR(size)						\
> +static int vfio_pci_core_iordwr##size(struct vfio_pci_core_device *vdev,\
> +				bool iswrite, bool test_mem,		\
> +				void __iomem *io, char __user *buf,	\
> +				loff_t off, size_t *filled)		\

I realized later after proposing this that we should drop 'core' from
the name since the resulting functions are not currently exported.  It
also helps with the wordiness.  Thanks,

Alex

> +{									\
> +	u##size val;							\
> +	int ret;							\
> +									\
> +	if (iswrite) {							\
> +		if (copy_from_user(&val, buf, sizeof(val)))		\
> +			return -EFAULT;					\
> +									\
> +		ret = vfio_pci_core_iowrite##size(vdev, test_mem,	\
> +						  val, io + off);	\
> +		if (ret)						\
> +			return ret;					\
> +	} else {							\
> +		ret = vfio_pci_core_ioread##size(vdev, test_mem,	\
> +						 &val, io + off);	\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		if (copy_to_user(buf, &val, sizeof(val)))		\
> +			return -EFAULT;					\
> +	}								\
> +									\
> +	*filled = sizeof(val);						\
> +	return 0;							\
> +}									\
> +
> +VFIO_IORDWR(8)
> +VFIO_IORDWR(16)
> +VFIO_IORDWR(32)
>  /*
>   * Read or write from an __iomem region (MMIO or I/O port) with an excluded
>   * range which is inaccessible.  The excluded range drops writes and fills
> @@ -115,71 +149,23 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  			fillable = 0;
>  
>  		if (fillable >= 4 && !(off % 4)) {
> -			u32 val;
> -
> -			if (iswrite) {
> -				if (copy_from_user(&val, buf, 4))
> -					return -EFAULT;
> -
> -				ret = vfio_pci_core_iowrite32(vdev, test_mem,
> -							      val, io + off);
> -				if (ret)
> -					return ret;
> -			} else {
> -				ret = vfio_pci_core_ioread32(vdev, test_mem,
> -							     &val, io + off);
> -				if (ret)
> -					return ret;
> -
> -				if (copy_to_user(buf, &val, 4))
> -					return -EFAULT;
> -			}
> +			ret = vfio_pci_core_iordwr32(vdev, iswrite, test_mem,
> +						     io, buf, off, &filled);
> +			if (ret)
> +				return ret;
>  
> -			filled = 4;
>  		} else if (fillable >= 2 && !(off % 2)) {
> -			u16 val;
> -
> -			if (iswrite) {
> -				if (copy_from_user(&val, buf, 2))
> -					return -EFAULT;
> -
> -				ret = vfio_pci_core_iowrite16(vdev, test_mem,
> -							      val, io + off);
> -				if (ret)
> -					return ret;
> -			} else {
> -				ret = vfio_pci_core_ioread16(vdev, test_mem,
> -							     &val, io + off);
> -				if (ret)
> -					return ret;
> -
> -				if (copy_to_user(buf, &val, 2))
> -					return -EFAULT;
> -			}
> +			ret = vfio_pci_core_iordwr16(vdev, iswrite, test_mem,
> +						     io, buf, off, &filled);
> +			if (ret)
> +				return ret;
>  
> -			filled = 2;
>  		} else if (fillable) {
> -			u8 val;
> -
> -			if (iswrite) {
> -				if (copy_from_user(&val, buf, 1))
> -					return -EFAULT;
> -
> -				ret = vfio_pci_core_iowrite8(vdev, test_mem,
> -							     val, io + off);
> -				if (ret)
> -					return ret;
> -			} else {
> -				ret = vfio_pci_core_ioread8(vdev, test_mem,
> -							    &val, io + off);
> -				if (ret)
> -					return ret;
> -
> -				if (copy_to_user(buf, &val, 1))
> -					return -EFAULT;
> -			}
> +			ret = vfio_pci_core_iordwr8(vdev, iswrite, test_mem,
> +						    io, buf, off, &filled);
> +			if (ret)
> +				return ret;
>  
> -			filled = 1;
>  		} else {
>  			/* Fill reads with -1, drop writes */
>  			filled = min(count, (size_t)(x_end - off));

