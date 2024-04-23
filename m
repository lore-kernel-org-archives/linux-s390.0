Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746113CFA4
	for <linux-s390@vger.kernel.org>; Tue, 23 Apr 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888985; cv=none; b=F0JdvuV/0uPsMhtqgUE1PP9I3euFZPQKBTvcR0qhX3/Xxdd2hKR+0ApUPjBHExqy+6rK/vBgGzRJmJNxafT74V3EXNiUPS1mPDqktnJjX8/zTGz/pKcbnZEWQdnlowlQ71OEP2DtXbXwDy42VgfK7F9gjf8unz9WkBPeQLaxz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888985; c=relaxed/simple;
	bh=caNN/BDiP2pUMEFX/RYbMVfSz4poEg3B7Iv0IwQiV2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBi3saokG3v3rjSZJutfaetOsB2tMW3ZYcKwjC2rXrgeWfzwlol/i4XyFcvr57Z+o1OElEREKk2tpPdUEf4Ghff0wjPv5Et1Gy4HC6Cw+T66SDyUTHNYFwAGjM81W3C/NwxYklGs0ik9l3T1ZifFZlvUUYH+mRkVcBK23n0JsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iFNoFT0z; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iFNoFT0z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23981fd7947so2353703fac.3
        for <linux-s390@vger.kernel.org>; Tue, 23 Apr 2024 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713888982; x=1714493782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Th5UesV32Qkq2eBnmkVMzF3pIRCuXeQw4LmG2UmnKGY=;
        b=iFNoFT0zzm+yNrJC7FpTf+FXQ4MlD0+5B7btIITKMD7QefHu9NWQssmMUEWL5tMJKy
         K8TvYZwx91T2FxKOQUIgpx+Z698L/a5sHqdE+ySCNc3HyuhgQ6RuPJmnJKmKdeRJ0bni
         /NlSvskDbsWunFko8jEHbByuz4g+so8mkM1aQdlm8MnTkbEgnRqs9I2Vz+fVITSYuiuH
         14q+l6hjO3I/G8aVSqOVh2w7KM4c1qYlLOmK4jpbjiD7JS6ZRoBM50+fIT17gMv+M+e/
         5MEXbueu+7Bw7Q38D1L8RS6jUzj9QWBPq0YK5T8aKqaDcarJryBnIUI6OMktsp8IWdCk
         e5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888982; x=1714493782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th5UesV32Qkq2eBnmkVMzF3pIRCuXeQw4LmG2UmnKGY=;
        b=TsIfTU0Hc7+2FKFIOG/w/DtVvsfvGnPjH93VadV7B7JYCbjOR3nWUJ2QIW/Ys8qiJw
         qO1cEq2gUeIqGlsQ1XEC90cq/fODtHlSNUhdgDa0hMwkjBh8a7w945XZConPXtUVBOn2
         SVKKO5SI7PKE50VlXPqfxz1aXJf7g5eN5jQW9O1v9uGd425isciAvlBbc+hFOrGbrGl+
         KrWn5umAAI/m3m4EwjftrlJXTDjETENmoefs3tV5yZH/UP8z6fjOJkXOLg4leB08uMYc
         AnBSSFUN7VW3zpEntPt+Nh4/xz3h/Sw2sDnQUN+5SInG3WUchil7unNbfZs5AxdAPQ19
         kcEg==
X-Forwarded-Encrypted: i=1; AJvYcCUHLK7+N5tl+wGAVJ2BqdHGiEvhTrLYaqSVdLrMuNzu5dvoQv+PQD29rfT5JCxenXp9XSMIESIlPQJldO190lEGiO3Qujym1cKQzA==
X-Gm-Message-State: AOJu0YzHX/IGbtWlXczeIUE80NEYh52kq7BRjtPk4nM9HiHy7KKyiILH
	kb1F8ZXjNPTFV54fsnm3aL1C11Wc6DTZu2froablxJUFn8QOsvtIPhg8PBPoWi8=
X-Google-Smtp-Source: AGHT+IE7zSimZxSEQfUXbYtEh0bkBhFSBu+ppGaC0ROHoLmW5kvBviH2Ox3G1rw9lZH4Y1pgy2feHQ==
X-Received: by 2002:a05:6870:7087:b0:22e:75eb:9309 with SMTP id v7-20020a056870708700b0022e75eb9309mr16652676oae.54.1713888982021;
        Tue, 23 Apr 2024 09:16:22 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id oz11-20020a056871788b00b0023a98276d93sm491702oac.36.2024.04.23.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:16:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzIoe-003z4M-Br;
	Tue, 23 Apr 2024 13:16:20 -0300
Date: Tue, 23 Apr 2024 13:16:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH v2] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240423161620.GE231144@ziepe.ca>
References: <20240422153508.2355844-1-gbayer@linux.ibm.com>
 <20240422174305.GB231144@ziepe.ca>
 <20240422163353.24f937ce.alex.williamson@redhat.com>
 <311395d0817e9c2c6a0415b5ece97c68f4c4ba95.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <311395d0817e9c2c6a0415b5ece97c68f4c4ba95.camel@linux.ibm.com>

On Tue, Apr 23, 2024 at 06:11:57PM +0200, Gerd Bayer wrote:
> On Mon, 2024-04-22 at 16:33 -0600, Alex Williamson wrote:
> > On Mon, 22 Apr 2024 14:43:05 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > > On Mon, Apr 22, 2024 at 05:35:08PM +0200, Gerd Bayer wrote:
> > > > From: Ben Segal <bpsegal@us.ibm.com>
> > > > 
> > > > Many PCI adapters can benefit or even require full 64bit read
> > > > and write access to their registers. In order to enable work on
> > > > user-space drivers for these devices add two new variations
> > > > vfio_pci_core_io{read|write}64 of the existing access methods
> > > > when the architecture supports 64-bit ioreads and iowrites.
> > > > 
> > > > Since these access methods are instantiated on 64bit
> > > > architectures,
> > > > only, their use in vfio_pci_core_do_io_rw() is restricted by
> > > > conditional
> > > > compiles to these architectures.
> > > > 
> > > > Signed-off-by: Ben Segal <bpsegal@us.ibm.com>
> > > > Co-developed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > > ---
> > > > Hi all,
> > > > 
> > > > we've successfully used this patch with a user-mode driver for a
> > > > PCI
> > > > device that requires 64bit register read/writes on s390. A quick
> > > > grep
> > > > showed that there are several other drivers for PCI devices in
> > > > the kernel
> > > > that use readq/writeq and eventually could use this, too.
> > > > So we decided to propose this for general inclusion.
> > > > 
> > > > Thank you,
> > > > Gerd Bayer
> > > > 
> > > > Changes v1 -> v2:
> > > > - On non 64bit architecture use at most 32bit accesses in
> > > >   vfio_pci_core_do_io_rw and describe that in the commit message.
> > > > - Drop the run-time error on 32bit architectures.
> > > > - The #endif splitting the "else if" is not really fortunate, but
> > > > I'm
> > > >   open to suggestions.  
> > > 
> > > Provide a iowrite64() that does back to back writes for 32 bit?
> > 
> > I was curious what this looked like.  If we want to repeat the 4 byte
> > access then I think we need to refactor all the read/write accesses
> > into macros to avoid duplicating code, which results in something
> > like [1] below.  But also once we refactor to macros, the #ifdef
> > within the function as originally proposed gets a lot more bearable
> > too [2].
> > 
> > I'd probably just go with something like [2] unless you want to
> > further macro-ize these branches out of existence in the main
> > function. Feel free to grab any of this you like, the VFIO_IORDWR
> > macro should probably be it's own patch.  Thanks,
> > 
> > Alex
> 
> Hi Alex,
> 
> thanks for your suggestions, I like your VFIO_IORDWR macro in [1].
> As I just explained to Jason, I don't think that the back-to-back 32bit
> accesses are a safe emulation of 64bit accesses in general, though. So
> I'd rather leave that out.

It is though, it is exactly what the code does now.

This function is not 'do exactly XX byte store' it is actually 'memcpy
to io' with some occasional support for making contiguous TLPs in
common cases..

Jason
