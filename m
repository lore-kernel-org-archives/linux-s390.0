Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA63914E4
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894609; cv=none; b=EgqT9k6CfQTjZzX6TyXEUuBegPsYgXycCn4CjYJtEI2FIgmwBKd4hp1zD7832ql4Cf6+Qymvq6avNDMnR9qUzwUrb6iGPv87w/Kv9S/keaolFjrNoelXSr/1J+ArqN3uNbE3L1SAFc+KCyBse/NpZiSNasvsIUo+fWitKhleHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894609; c=relaxed/simple;
	bh=FxGhEP4CgH8a2w9XYbVg4vOa7jSLaLx43B2rQNZ8QBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4B2HRkapEW7V8WyPw44Jcc9/PpdQRbTU9qT0Hfy+2PjPlPXZqoLLCmUcaIUTeESZ1EvjhhhFBSnjdK//bh2uq2JJXHTwi8U1fdRpLLP4pSvQ05jAZE8kXTrmHR5jDClCKc6plcUEiFdDd/hR3UH5PL+qrN92I54SaDk+djSpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XKD1a8DX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XKD1a8DX"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506251815a3so41727041cf.0
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774894607; x=1775499407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7XmGXHOl2bFszmYCbs7mBB7gqdOkxQGV5l4CdFJV8g=;
        b=XKD1a8DXk+Z1HY3u3TuFzk0kaipfEI11BxokPX+pr0riyT8kiMvucZqNqOEJW1RqhW
         TWcE6uLY4i4N8RBAjRNkxzuD2LppnInEke7WqljGXhi8kdXqHHV1xvleihVds96aARRF
         jH/TCwWodWeIcNeK1V4gdupzhW8TMv3aZx63I2q4l6ec8Rx2c7TNxzJDqzR1i+90Or0C
         tv4XaVK5/kgO5KP4TP3Xg/kn7wuvT9/FR0lWAsVBitCr9kMstIeMRXteWcc6MzLhvKYK
         MruvTKuqf12QilLdDQl6CuW5advltFYGsBRfZicUeJsf43iVKcHjlF2BY2bsIJrK2051
         rk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894607; x=1775499407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7XmGXHOl2bFszmYCbs7mBB7gqdOkxQGV5l4CdFJV8g=;
        b=PS3aB+t5cOZTgALNSanGFs6l10/7e97aaKYjLn4ytG+ZZ/pejJ3fUAEGPoNTB3s8o+
         JJfSyonrGDBLbW6PdtVUHkO7lwKX6uMZKnO0qkIQ03xllxUwE94CSLzEVzz7wRyZQn+e
         +pSCVjXLOwf1YuImp24K/0ne3JvXkbAoaBiajx4o9FUqEOT5iNaAUVsTdPpURWI8AyBw
         PufL6NTsMkKvWp+z2haNOX81kz0z5cKpJwajhdjTSUobnXHX8jXWVnYEWbtogy6Xm+m+
         rgOXeIQidKEwia4cUks/9kkyGJCuaZFxduSNiYyWFSvej7SbZHoSiVOYZux494MiqDA8
         Fagw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0hadT/fP0bhFLCyle8YFZH/OuqjrM/oA1yaNzMnwLNXHT29guwSPdjNQIhKGNJDbQVxfLLWIQQtr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSlIK+m2CfFBqB0a6hEsuut0efFn1Q3eWlSxlwYlrpsOe1yVE
	msKCj+Vu80K+LxyWHqtllhm2FGvjNBx4dQ6Ocki2xVN9Uiq/J9dyAkkjNVrkQKPDf08=
X-Gm-Gg: ATEYQzwRomrdmz2tg8UNv8d2R7/SRW7KYHfBJo8NzsMBcMQjM9CCrHGVMb4vcctHsns
	pLQvqrD1Q/8u2gpYYe/K2J9YgEc+zbuRQzhTSF+FtRNDIUCY89KIfJUcAt3cdEgRGzVFCHOKHnx
	brBPX+TazFRbsOkI2L/vver6JBK/YZbMnBTHViM1vOgVio3Y3S1zZkk19/0jug0PxlSIDIpc1eX
	oUBOEq833Pn9BSel13AWXioDwJX6WEBQpVoEhxOVGWO1RElk2J3n32h8AxldMEZhzZu9IJ/QzPN
	WDzHN27pMPnEJ+Fj4o7hiB2pNQPDILEdh4O5YR7RYbN9AFTLtfxbnO/Qlg7B2y7m6hh86bYWH9r
	+ZmO+Jy8FsKf/uF1kh2JMpQ34gwpNbxKgJG2F/MKREaAbBGsJIP0quS4wwCkQz2Def6va4sNsEW
	UaC5MPZ+yDfP8Y0RxFPJN9v8+oHnKK88t+5Usv8cmaEE8OvJQOoagLxm1cuUTR3GlkE1rJNphgK
	2zkgNnf
X-Received: by 2002:a05:622a:20a:b0:50b:49e5:989b with SMTP id d75a77b69052e-50ba385dc34mr181731851cf.22.1774894607076;
        Mon, 30 Mar 2026 11:16:47 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2cccbc4sm74354021cf.13.2026.03.30.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:16:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7HAL-00000004Dsi-3Duh;
	Mon, 30 Mar 2026 15:16:45 -0300
Date: Mon, 30 Mar 2026 15:16:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
	ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
	raspl@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260330181645.GE246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
 <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
 <20260330093646.03b0455f@shazbot.org>
 <20260330155651.GD246076@ziepe.ca>
 <20260330120945.023b2295@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330120945.023b2295@shazbot.org>

On Mon, Mar 30, 2026 at 12:09:45PM -0600, Alex Williamson wrote:
> On Mon, 30 Mar 2026 12:56:51 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Mon, Mar 30, 2026 at 09:36:46AM -0600, Alex Williamson wrote:
> > > There's risk involved with changing the default shift.  The fear is
> > > there's userspace drivers that hard code the shift.  DPDK was even such
> > > a user at one point, iirc.  Maybe it's ok to break such users, maybe
> > > there are actually no such users left and it's all FUD at this point.
> > > Either way, I have a hard time justifying that risk for a single,
> > > obscure S390 device.  
> > 
> > If we go ahead with that DMABUF series could obscure cases like this
> > be told to just get a DMABUF FD and then mmap it? Avoid this whole
> > issue?
> 
> The ISM device here doesn't support mmap, so that much is still a
> problem.  However, if we imagine a future where we've fully converted
> to dma-buf for both DMA and CPU access to BARs, then maybe...  I don't
> know how we'd describe a region overflow in the "legacy" ioctls to
> maintain some consistency between what's exposed through the region
> versus the dma-buf.  Thanks,

Oh, Ok.. I go back to what I've said before many times, if we fix this
we should fix it by making the region offset fully dynamic and managed
by a maple tree.

We can detect at runtime when the vfio device is created if it is
compatible with the legacy indexs and use them by default to maintain
compatibility. But cases like this where the region is just too big
(and GPUs will get there soon too!) can run a full dynamic mode.

Jason
