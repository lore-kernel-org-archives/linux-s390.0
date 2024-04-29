Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038B190698
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428672; cv=none; b=A/oConJJMnNYHwOWhe4g08x49Y26HKfYMe3C75S+8Vt2hlBg+haZB6L/BVzZy+TvboDBANn3Q//aBSHGi3ghoKKVrXyczliIlaf6uBcuERaI7soOREZ/2msqeb9WWUC62af064KTgFQh6dSWfhSmUzLwnhw0qOjRISQjQy9Ryeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428672; c=relaxed/simple;
	bh=GDa/TcZ8sC3kWfrnzfQhsRMEK9WUaRtvGyaX8LcbN4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYAIcgwCPQXvGaLD/IsJLwgaGFalhOv+HJRAWiGrs0SkeaGpSRH3OgvL0Hai99gdPSTw5d6jQD8fXwg5lzmt8jkXmWLAH2J5dGqhr7x1recg05HPT2FCdJKQRqVXPktaph4chINUCNiEFvd/6V8jcmOtVZ1FiLfZq6l9O3dTMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiFaX2qB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiFaX2qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714428668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fit1UkEOUttc0LCd/8to5I6POqCHW/P8m8hZ4bmytFQ=;
	b=KiFaX2qBNrGvVsII9oLM3AJFjJBCPms7v/VWs3n8t9Vvw8tascdI0KkMhtQnl5NZ97ZTTh
	hFlexooVLSXpZNOcJOgWgostg47PWzC+GadlqFg1pEd0guwg55pPyRsp/UPNzasBrK8Prk
	k4KKr2Min2rZrmeGTV/tNTR2R2p9Q88=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-RjwjEZkYNTKJetAMTvZaaw-1; Mon, 29 Apr 2024 18:11:07 -0400
X-MC-Unique: RjwjEZkYNTKJetAMTvZaaw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c6041cd048so4716740b6e.2
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 15:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428666; x=1715033466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fit1UkEOUttc0LCd/8to5I6POqCHW/P8m8hZ4bmytFQ=;
        b=TxTsekJUPmZ2wiSm93i8v7XG/oyoBWwIHQx7lHVRc3/29tYP+k1K+WEWu5opspGWpw
         queShjvUDCvsO8OYiAyF9C+AKwUNbCkVrW72gN6fJ6qJ2+yux/SR5bKnWmm+leR3ewrt
         zr9ufKiUO3ftGWCSZ2M2WcAOo24P5SD//fylvwTudQBteMdAltmacOOqPd7T2BRUqKtm
         mojhA4yf35hZuu7Iev3bvSGuNb3Z7cHer8QRJdaDsPq8MTMptIwlJ/XcYKZDAl+2B+nF
         S3paiSwQs7jssM3iZjTEkqystpR+Yin8Dflxewl3O0jyClPD357Gm0nS4prmHUyvXKs3
         JGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUThzN+ZbTMiXW4EfIQhS1ex6cT8uWeph/mTXcdx0rDFWEgJVpr+fLJHkmEuxNjVzCr6HPsBQk08Ea+ILn8lXJqtvhuCccsCHbYfQ==
X-Gm-Message-State: AOJu0Yx4YiXJoWYRXN6KAMNQkLc/nK2PlEeVaBavzmyn/wdsmyCmTSKf
	EFcHt0wNOkLgNCMoRNz+VJ9aX6R7n5R4LeLNHTv0+my/bvhSLhH0zGmTVmz/IgqoxVHI6l0VCu1
	OnxlpBg/pioHESwMbh2O7iqcwWua/NPe1irhzG6K6Wt6mCtSfRHQdegg7WB0=
X-Received: by 2002:a05:6808:1887:b0:3c7:5091:54e5 with SMTP id bi7-20020a056808188700b003c7509154e5mr15978986oib.21.1714428666163;
        Mon, 29 Apr 2024 15:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9C695P4VdfMezOo8ItHONbG/PZ8XJxX9qrxXW/d+irGNU4JIaBfVBFLmb0S74CkxrBVQbMg==
X-Received: by 2002:a05:6808:1887:b0:3c7:5091:54e5 with SMTP id bi7-20020a056808188700b003c7509154e5mr15978972oib.21.1714428665870;
        Mon, 29 Apr 2024 15:11:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 10-20020aca280a000000b003c73b01369esm3391257oix.42.2024.04.29.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:11:05 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:11:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil
 Pasic <pasic@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] vfio/pci: Extract duplicated code into macro
Message-ID: <20240429161103.655b4010.alex.williamson@redhat.com>
In-Reply-To: <20240429200910.GQ231144@ziepe.ca>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
	<20240425165604.899447-2-gbayer@linux.ibm.com>
	<20240429200910.GQ231144@ziepe.ca>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 17:09:10 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Apr 25, 2024 at 06:56:02PM +0200, Gerd Bayer wrote:
> > vfio_pci_core_do_io_rw() repeats the same code for multiple access
> > widths. Factor this out into a macro
> > 
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_rdwr.c | 106 ++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index 03b8f7ada1ac..3335f1b868b1 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > @@ -90,6 +90,40 @@ VFIO_IOREAD(8)
> >  VFIO_IOREAD(16)
> >  VFIO_IOREAD(32)
> >  
> > +#define VFIO_IORDWR(size)						\
> > +static int vfio_pci_core_iordwr##size(struct vfio_pci_core_device *vdev,\
> > +				bool iswrite, bool test_mem,		\
> > +				void __iomem *io, char __user *buf,	\
> > +				loff_t off, size_t *filled)		\
> > +{									\
> > +	u##size val;							\
> > +	int ret;							\
> > +									\
> > +	if (iswrite) {							\
> > +		if (copy_from_user(&val, buf, sizeof(val)))		\
> > +			return -EFAULT;					\
> > +									\
> > +		ret = vfio_pci_core_iowrite##size(vdev, test_mem,	\
> > +						  val, io + off);	\
> > +		if (ret)						\
> > +			return ret;					\
> > +	} else {							\
> > +		ret = vfio_pci_core_ioread##size(vdev, test_mem,	\
> > +						 &val, io + off);	\
> > +		if (ret)						\
> > +			return ret;					\
> > +									\
> > +		if (copy_to_user(buf, &val, sizeof(val)))		\
> > +			return -EFAULT;					\
> > +	}								\
> > +									\
> > +	*filled = sizeof(val);						\
> > +	return 0;							\
> > +}									\
> > +
> > +VFIO_IORDWR(8)
> > +VFIO_IORDWR(16)
> > +VFIO_IORDWR(32)  
> 
> I'd suggest to try writing this without so many macros.
> 
> This isn't very performance optimal already, we take a lock on every
> iteration, so there isn't much point in inlining multiple copies of
> everything to save an branch.

These macros are to reduce duplicate code blocks and the errors that
typically come from such duplication, as well as to provide type safe
functions in the spirit of the ioread# and iowrite# helpers.  It really
has nothing to do with, nor is it remotely effective at saving a branch.
Thanks,

Alex

> Push the sizing switch down to the bottom, start with a function like:
> 
> static void __iowrite(const void *val, void __iomem *io, size_t len)
> {
> 	switch (len) {
> 	case 8: {
> #ifdef iowrite64 // NOTE this doesn't seem to work on x86?
> 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> 			return iowrite64be(*(const u64 *)val, io);
> 		return iowrite64(*(const u64 *)val, io);
> #else
> 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> 			iowrite32be(*(const u32 *)val, io);
> 			iowrite32be(*(const u32 *)(val + 4), io + 4);
> 		} else {
> 			iowrite32(*(const u32 *)val, io);
> 			iowrite32(*(const u32 *)(val + 4), io + 4);
> 		}
> 		return;
> #endif
> 	}
> 
> 	case 4:
> 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> 			return iowrite32be(*(const u32 *)val, io);
> 		return iowrite32(*(const u32 *)val, io);
> 	case 2:
> 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> 			return iowrite16be(*(const u16 *)val, io);
> 		return iowrite16(*(const u16 *)val, io);
> 
> 	case 1:
> 		return iowrite8(*(const u8 *)val, io);
> 	}
> }
> 
> And then wrap it with the copy and the lock:
> 
> static int do_iordwr(struct vfio_pci_core_device *vdev, bool test_mem,
> 		     const void __user *buf, void __iomem *io, size_t len,
> 		     bool iswrite)
> {
> 	u64 val;
> 
> 	if (iswrite && copy_from_user(&val, buf, len))
> 		return -EFAULT;
> 
> 	if (test_mem) {
> 		down_read(&vdev->memory_lock);
> 		if (!__vfio_pci_memory_enabled(vdev)) {
> 			up_read(&vdev->memory_lock);
> 			return -EIO;
> 		}
> 	}
> 
> 	if (iswrite)
> 		__iowrite(&val, io, len);
> 	else
> 		__ioread(&val, io, len);
> 
> 	if (test_mem)
> 		up_read(&vdev->memory_lock);
> 
> 	if (!iswrite && copy_to_user(buf, &val, len))
> 		return -EFAULT;
> 
> 	return 0;
> }
> 
> And then the loop can be simple:
> 
> 		if (fillable) {
> 			filled = num_bytes(fillable, off);
> 			ret = do_iordwr(vdev, test_mem, buf, io + off, filled,
> 					iswrite);
> 			if (ret)
> 				return ret;
> 		} else {
> 			filled = min(count, (size_t)(x_end - off));
> 			/* Fill reads with -1, drop writes */
> 			ret = fill_err(buf, filled);
> 			if (ret)
> 				return ret;
> 		}
> 
> Jason
> 

