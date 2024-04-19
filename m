Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAA130E52
	for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543100; cv=none; b=L2gQnO7DtzJ3/8H7hURYKHgfHFL7Y1X86UFPAItjC4+7VZhBhy5pzBUGUUDL0IUDAzpB1mgxdg3xYQGHtXntz49vYYHa+zALvuUWuCDO/ZBJc4FkfcxzKke2FyN3cDeAQswXdiypnBLR5jgQvwVMKryIqLOK5vp/xm3OWEAtlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543100; c=relaxed/simple;
	bh=c355FjzRXp2PV5fV7cTtv8D/0hSyaEEZty37+zds9PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/B3i1l6hPVC3lKTEa0vd6BNQqTvBkT/oMwFCD+foFk/01p9ItktkPwKZr/f0s2NlpJYTX/VqtcbKIPxNAIC0u+04mvw+VQBB/Cm+Mfaw7smu2trgdsLqtrbAzdhZLsBWMwtmOKIKTJkSLitXE+VOnaBIIvIRKgWlyJt1+5Zjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B08WCqC/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B08WCqC/"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb7d1a5d39so1273346a34.2
        for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713543096; x=1714147896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPdDMUXyiuiq86o/a5LL/jaZpq2sMZf3qusGMS3HcBg=;
        b=B08WCqC/Tlnrq8SKJFHKOOhcHEKDCWyhvENSKiZ47tVdUkiSGE1zWPRCsywsSFebTc
         T+GtiRhCq29lQ7czlkfKIcu4UlQ4iFHwvNoGuIA2z8hQrSIQrM/SJBSbn01+iSrs5J6W
         VaFp3+KzY23aUWCkHkU/xXwrylnpJKzX10mlUPpGvbTxqhGXdWELY/Hu6cwcmnn647Hp
         zqJTEOnh394QwaR7G6OiAgPaGW33XT62z5I+W930K90NZAsCRu6Jnfc1PjdvFi7h+ktd
         bOv6qmTwUIsL1Nk7oBiNGNqUD4sJgpQzu7PCD3bhUONcOlqX+sRomnFIBajV/vyciMIh
         w9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543096; x=1714147896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPdDMUXyiuiq86o/a5LL/jaZpq2sMZf3qusGMS3HcBg=;
        b=m2WjWBlMZR1MaynwSXUOwWFCgVMevBfj7+CKDu0HehJC3QK/R3rDN6YAzxe6lTVeJD
         KzLmALVJp9FF1KpZXT9lzuXATwFOz1aXh2bNbPVrsRCiFvF0mBa+fFRWyxjElE40TAzi
         CO86EFPO7onVQ1T81kxPWiDw4Ou4paZ3fcJ6EKzLqSaXzi8aY/9+4rvieaWuZBkIAFM7
         NxKwraTX1/VU5TSXDmpLZ1ZOn/s8WxA/G8D49/FNIinrcflAtDAiOSm65LAT4PoFrjBL
         dAGK15B1I4CelxcLvWz8CRCgZtfnbDLYQCHOLOVaI+Y23Jdd0+cLaIVKn3m8q8KcCgRm
         znAg==
X-Forwarded-Encrypted: i=1; AJvYcCVMqXLFDdZgCghYeF9+3DJhAtS8LcVuNfo+INFIU3o8M6dAP8UE2vSGbXJlWiQtKj8Jz1+PtNPMl0eqJSBhxDuW0Z+y3Elgrx2GKQ==
X-Gm-Message-State: AOJu0YxFz5OYxPKXIMxk1l3vc7lA1rL+7x52clKRXeQn88mC7V52I5x9
	zAOu1HvD0SAYeRcd/6rptz0MIU2VOv012aDbYmzaB9ovg/Mol94p3K8oyzi+5k0=
X-Google-Smtp-Source: AGHT+IF7DVUq+dJZOo43uX5z1JMrxdHIu7CEnQutVFVuFx4NCCMcQbbW/K0XBawjCJRf1j78VXk34A==
X-Received: by 2002:a9d:7e8b:0:b0:6eb:b2d4:dd30 with SMTP id m11-20020a9d7e8b000000b006ebb2d4dd30mr2812878otp.0.1713543096601;
        Fri, 19 Apr 2024 09:11:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p2-20020a9d76c2000000b006ea19aa0e4fsm733309otl.29.2024.04.19.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:11:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxqpr-00Fd4B-5i;
	Fri, 19 Apr 2024 13:11:35 -0300
Date: Fri, 19 Apr 2024 13:11:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
	Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240419161135.GF223006@ziepe.ca>
References: <20240419135323.1282064-1-gbayer@linux.ibm.com>
 <20240419135823.GE223006@ziepe.ca>
 <c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com>

On Fri, Apr 19, 2024 at 05:57:52PM +0200, Niklas Schnelle wrote:
> On Fri, 2024-04-19 at 10:58 -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 19, 2024 at 03:53:23PM +0200, Gerd Bayer wrote:
> > > From: Ben Segal <bpsegal@us.ibm.com>
> > > 
> > > Many PCI adapters can benefit or even require full 64bit read
> > > and write access to their registers. In order to enable work on
> > > user-space drivers for these devices add two new variations
> > > vfio_pci_core_io{read|write}64 of the existing access methods
> > > when the architecture supports 64-bit ioreads and iowrites.
> > > 
> > > Signed-off-by: Ben Segal <bpsegal@us.ibm.com>
> > > Co-developed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > > 
> > > Hi all,
> > > 
> > > we've successfully used this patch with a user-mode driver for a PCI
> > > device that requires 64bit register read/writes on s390.
> > 
> > But why? S390 already has a system call for userspace to do the 64 bit
> > write, and newer S390 has a userspace instruction to do it.
> > 
> > Why would you want to use a VFIO system call on the mmio emulation
> > path?
> > 
> > mmap the registers and access them normally?
> 
> It's a very good point and digging into why this wasn't used by
> Benjamin. It turns out VFIO_PCI_MMAP is disabled for S390 which it
> really shouldn't be especially now that we have the user-space
> instructions. Before that though Benjamin turned to this interface
> which then lead him to this limitation. So yeah we'll definitely verify
> that it also works via VFIO_PCI_MMAP and send a patch to enable that.

Make sense to me!

> That said I still think it's odd not to have the 8 byte case working
> here even if it isn't the right approach. Could still be useful for
> debug/testing without having to add the MIO instructions or the our
> special syscall.

Yes, this also makes sense, but this patch needs some adjusting

Jason
