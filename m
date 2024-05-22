Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD71E4AB
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385700; cv=none; b=PJNHq7sKHFzqD5j1uXmJCOyx6uBSt24tpT5cN8MAlw6a9kO815tOY3Eb5yReORccydwBMU/u9SDRM/k0ATn2HP8dfWqRmpGahavvQxA4ILS4B7Ggpa6zasHIBoNKL8pF3Fp4ehsq1ax8fzxbYh6PYRCttuUpCtQ52meqRur+9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385700; c=relaxed/simple;
	bh=VB7Y6q3P0R0DBaYp5JNlhupnq1sPd9mP3oeB28RMPNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHTis53MqNIHxXusKwuskOdB53c6lRyx+16Ct3bp8yYXhIPxiEx7TCvSv+K6+7kMD4Wk6IPZm6VgYHGkrxOZSqwbf6sdqX7/NwQUScq41xBWlDxHHsmbOpNNQHxHLjnsDkVdDOJapHisl6dseveeFfDJPsDh6c+7e+ttX+ZfqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cWjlHulR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cWjlHulR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dff9da88fso7507041cf.2
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716385696; x=1716990496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VriS+lT4fkCRz6d6ylUVr3xhpMkkPTXruVOhQlHWG1Q=;
        b=cWjlHulRt1XAOrJCoA5OxFIIA+SXaHRL9l1zLSKfXPoKqLFLtG3zHjmBz9FeHIJp7u
         rPJOk+LXrHvBBN4bLLtMrlxl2xKFlEnl5PmdskpN/O25a/3Ya7nRB2GfhIBF0ijZn+Qm
         +bXH9Rqaiw+ZB7cp21XZ9ALdda9a643sN/dz/+ILsviJoWKCw5Qb9lOMRidMdBXPZvoc
         vZFXmXgFUfe5wDBMeNIJ0smYg+OEsEZxGbWIXfPsulj6E6Qn3CehKeTetDYmkrHDLfWj
         D0ctadJNzBM3OyrhB3PFgwrlRS2N8QyYfvgxf60rtBnBoAldspibPF4vyRw/7EFd+rJr
         P1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716385696; x=1716990496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VriS+lT4fkCRz6d6ylUVr3xhpMkkPTXruVOhQlHWG1Q=;
        b=jBu+t9PcLt5VMP5WDCGUlu0PF9NsQ8I3mW/JthaO5U5B96JzIlz3nuDOZhoUMdTh8M
         EuaW2BjFrL4bAxL7od1I0oFoSGGKrTHQiU49HZNXNIJRM4Oo83jjgRSEZNm3tceEt20T
         TSMkBtX9G9dR4YJh9h6WVWMvQ0Pf1p6xs2Vy7qwjDDCmNhajasVYeOVT+3cXV01ztQwC
         uSeRg7fqtz+C9bhkZcBmcs1J9TvWpJalMHw6w50Jm5PbXS9mreMNGG4xUjznzGAs/ebr
         O2EiZ1BDi1ElMEx9qLnWYcKlWDkYer9XbDG5jqaX9K41zoSdB15ucGeFVc5Rhfw9hAQw
         4PIg==
X-Forwarded-Encrypted: i=1; AJvYcCWZZw9/lWL97rWglo3+i79xCBb4X8CerQBIojIDRNJlGg/IYUBhS12c9Iz/1SlaqIOTpoA3lovtUOYLHwrzeUt2E7NkuMeCmKJgwg==
X-Gm-Message-State: AOJu0YxRD5W/ItOAXigTZDhyYcWWNFlVNDasspGmhqRdOCoqZ80p2AJP
	D7SNazfc/kb0NsVdB8DDFOT95teELvSBD0nbFztOj5bam5Fhq6upQkdaAvEuNBU=
X-Google-Smtp-Source: AGHT+IHMRaVIW5wXhRCbaxnSmORMVLlS6qCVXP2eeWq5rIvq0+lwdkbPRBWbztbdALmyLU+dnHqC0A==
X-Received: by 2002:ac8:57d2:0:b0:43a:d3e6:3ecb with SMTP id d75a77b69052e-43f9e0b6562mr22129531cf.26.1716385695758;
        Wed, 22 May 2024 06:48:15 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e069a24basm151668731cf.67.2024.05.22.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:48:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9mKD-00CHmz-Uf;
	Wed, 22 May 2024 10:48:13 -0300
Date: Wed, 22 May 2024 10:48:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Ramesh Thomas <ramesh.thomas@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH v3 2/3] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240522134813.GD69273@ziepe.ca>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
 <20240425165604.899447-3-gbayer@linux.ibm.com>
 <d29a8b0d-37e6-4d87-9993-f195a5b7666c@intel.com>
 <72da2e56f6e71be4f485245688c8b935d9c3fa18.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72da2e56f6e71be4f485245688c8b935d9c3fa18.camel@linux.ibm.com>

On Tue, May 21, 2024 at 06:40:13PM +0200, Gerd Bayer wrote:
> > > @@ -148,6 +155,15 @@ ssize_t vfio_pci_core_do_io_rw(struct
> > > vfio_pci_core_device *vdev, bool test_mem,
> > >   		else
> > >   			fillable = 0;
> > >   
> > > +#if defined(ioread64) && defined(iowrite64)
> > 
> > Can we check for #ifdef CONFIG_64BIT instead? In x86, ioread64 and 
> > iowrite64 get declared as extern functions if CONFIG_GENERIC_IOMAP is
> > defined and this check always fails. In include/asm-generic/io.h, 
> > asm-generic/iomap.h gets included which declares them as extern
> > functions.
> 
> I thinks that should be possible - since ioread64/iowrite64 depend on
> CONFIG_64BIT themselves.
> 
> > One more thing to consider io-64-nonatomic-hi-lo.h and 
> > io-64-nonatomic-lo-hi.h, if included would define it as a macro that 
> > calls a function that rw 32 bits back to back.

This might be a better way to go than trying to have vfio provide its
own emulation.

> Even today, vfio_pci_core_do_io_rw() makes no guarantees to its users
> that register accesses will be done in the granularity they've thought
> to use. The vfs layer may coalesce the accesses and this code will then
> read/write the largest naturally aligned chunks. I've witnessed in my
> testing that one device driver was doing 8-byte writes through the 8-
> byte capable vfio layer all of a sudden when run in a KVM guest.

Sure, KVM has emulation for various byte sizes, and does invoke vfio
with the raw size it got from guest, including larger than 8 sizes
from things like SSE instructions. This has nothing to do with the VFS
layer.

> So higher-level code needs to consider how to split register accesses
> appropriately to get the intended side-effects. Thus, I'd rather stay
> away from splitting 64bit accesses into two 32bit accesses - and decide
> if high or low order values should be written first.

The VFIO API is a byte for byte memcpy. VFIO should try to do the
largest single instruction accesses it knows how to do because some HW
is sensitive to that. Otherwise it does a memcpy loop.

Jason
