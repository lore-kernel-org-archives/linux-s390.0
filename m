Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B76140E50
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421355; cv=none; b=KIZUo7Lr+a0GyctEgiabHeFonn4cgI52GDpV8Zzq/ab+qk0vIfDrqZ4O60IGr+lExLuAv4TAB/H2kNs32dc4gBftRvJ1EnWCKlelherOfJLoRY2JrhSnUxxdGQyy83TEG5kjc7mOAhht0aBur58qY7qQ8QnOblbrXqa+LkFkSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421355; c=relaxed/simple;
	bh=u3uInMv3GovLySt6hNXkxVXG4iYHsM1cHCrDPmXBXh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTZR9Ec79kT4vB9XofBCIe8Hd/Dn8/HmCydt+lL+C5InupemXxRrsX01DwECJt6EfClqPZmXE+l3+5ReJx6vg9MJUbanWjMoxhtGHrTTSEEGyljydCB5QjsejE+mxZqoX0Vf+RA8h9dGkLwWU7vSGW9eXv3eIrLdqRKYoXkPZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mNXiMw6s; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mNXiMw6s"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47a0bebeacaso1381672137.0
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714421352; x=1715026152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uD+v0Myecvi4JLGVtz2H/p0vC9IC2MSMPkRl0WDjKA=;
        b=mNXiMw6sPelScyuE1lviE/XN7CzkkOvJ5afenaJwdAESOYa7VAnXYjBsp+EuTl/eQn
         tyXpgE1KWtzC8pvNQZEief/mIUdoX95A1FG34PjAVpF4vUkk2a/u0NBTbXUCwiQHlYr+
         UkPpUDsIILxppQ4VcCyztogW5pfmusi7k4ZwchU+KDcoxEW1ch+5uiHak6XZo44lKlLD
         fM80o1yV2KemG+DY5/oLgDn4MhGX7bBYnvufrBT8Y5ZwNO0E7zEsScIklOr55XmNHyoR
         Fcez+JUTAqG+eMEsrWiz+E16rGO9PTuMzvdIJTo0QbDpXN0S1XCyeF6GsF7XfptCG6oU
         WumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421352; x=1715026152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uD+v0Myecvi4JLGVtz2H/p0vC9IC2MSMPkRl0WDjKA=;
        b=rWS0bFaeZSBk0EVSl8BpwEy7f0EWr12F5jBv1TNFs9ZV596i378zDzh8q1IEJjb0Lf
         sLnsyxS5tKIg6OJoPpEdTHTK2PIYFecFKrn2iQQqojWNy53geZC94S7rA2PMJ+E1dwMY
         ZVVmroprwkm7YI8ay9TqTsXmMzoV7Jw3LuktbizvdoQe090xVkuFXHQdgkUBCFK/26HF
         kbbf5fsMa9+f2dbxvWn1EVkRYbRFhdgMilfRiBECB1cVOa4SyvIRELCEx87cz23rJLzG
         eWQndBNbH2QvBGnYK0Q4brRq0l0BD2HVB9xVJ8PFtrciYEu5hvV60Z3ZMA54JCeQ/Df2
         3KcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOx3O9jPcPwHas7ndtfsTuSLEEAO/FI1CkYOo/0pXgpIdsrt89bJWLWxUuAZlzS0sJAZd5xyLNIYqI81+XSgyLOVbn6awsKuYPAw==
X-Gm-Message-State: AOJu0Yzyi8yz2SbK7njTAvGblZjhsSkHzYNfBuLBkXMkewahTn0cvmfT
	ZJ7/8xrcvGWAvlKJ/O69+7IcN9rVCv0pZSd0pR9kpBan2kGqk0YFT3zMPuZSZ1A=
X-Google-Smtp-Source: AGHT+IEQp5LAzSUEqceAMOZ4Uu3U4DXrwe0G8FjiRbH/1M7d5c095lndVdyyR3xsIqyzMfvxI1xSMw==
X-Received: by 2002:a67:f683:0:b0:47b:d7e7:a8a9 with SMTP id n3-20020a67f683000000b0047bd7e7a8a9mr12027600vso.5.1714421352233;
        Mon, 29 Apr 2024 13:09:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w15-20020a0ce10f000000b0069b6e19090csm10783967qvk.10.2024.04.29.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:09:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1XJG-002nm2-H1;
	Mon, 29 Apr 2024 17:09:10 -0300
Date: Mon, 29 Apr 2024 17:09:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] vfio/pci: Extract duplicated code into macro
Message-ID: <20240429200910.GQ231144@ziepe.ca>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
 <20240425165604.899447-2-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425165604.899447-2-gbayer@linux.ibm.com>

On Thu, Apr 25, 2024 at 06:56:02PM +0200, Gerd Bayer wrote:
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

I'd suggest to try writing this without so many macros.

This isn't very performance optimal already, we take a lock on every
iteration, so there isn't much point in inlining multiple copies of
everything to save an branch.

Push the sizing switch down to the bottom, start with a function like:

static void __iowrite(const void *val, void __iomem *io, size_t len)
{
	switch (len) {
	case 8: {
#ifdef iowrite64 // NOTE this doesn't seem to work on x86?
		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
			return iowrite64be(*(const u64 *)val, io);
		return iowrite64(*(const u64 *)val, io);
#else
		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
			iowrite32be(*(const u32 *)val, io);
			iowrite32be(*(const u32 *)(val + 4), io + 4);
		} else {
			iowrite32(*(const u32 *)val, io);
			iowrite32(*(const u32 *)(val + 4), io + 4);
		}
		return;
#endif
	}

	case 4:
		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
			return iowrite32be(*(const u32 *)val, io);
		return iowrite32(*(const u32 *)val, io);
	case 2:
		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
			return iowrite16be(*(const u16 *)val, io);
		return iowrite16(*(const u16 *)val, io);

	case 1:
		return iowrite8(*(const u8 *)val, io);
	}
}

And then wrap it with the copy and the lock:

static int do_iordwr(struct vfio_pci_core_device *vdev, bool test_mem,
		     const void __user *buf, void __iomem *io, size_t len,
		     bool iswrite)
{
	u64 val;

	if (iswrite && copy_from_user(&val, buf, len))
		return -EFAULT;

	if (test_mem) {
		down_read(&vdev->memory_lock);
		if (!__vfio_pci_memory_enabled(vdev)) {
			up_read(&vdev->memory_lock);
			return -EIO;
		}
	}

	if (iswrite)
		__iowrite(&val, io, len);
	else
		__ioread(&val, io, len);

	if (test_mem)
		up_read(&vdev->memory_lock);

	if (!iswrite && copy_to_user(buf, &val, len))
		return -EFAULT;

	return 0;
}

And then the loop can be simple:

		if (fillable) {
			filled = num_bytes(fillable, off);
			ret = do_iordwr(vdev, test_mem, buf, io + off, filled,
					iswrite);
			if (ret)
				return ret;
		} else {
			filled = min(count, (size_t)(x_end - off));
			/* Fill reads with -1, drop writes */
			ret = fill_err(buf, filled);
			if (ret)
				return ret;
		}

Jason
