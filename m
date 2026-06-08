Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDD3BCD33
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932467; cv=none; b=m/vpFe5GXBd419LkgWp82jboW0vDSKInMwh0tvH0LvBjPm0HBGYBLLApoDKlNOeLAR/Br3rwhJ7JDjQe1/2E2qI0Rf4bUNy6iTR6oPiqrb/M8L+EcEBMFFVouOsUJI6g6VJ3fFAoBw0Aa8s6CSWqFPIU1Bf2Q30lI2NFHAFlsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932467; c=relaxed/simple;
	bh=nCG933nQPeoFVRfOrxJzr4DbOXEyeRKLr41Z0txUjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXdXcZ4mOxGG0kv1VFlLtV5EL/wdGjeqeYatpOESU2QFhVgeMvPan0qv/q8q+7+CLyd7QSo8zF71EqR5oTVBKf0YwMTuVUjd/2m0dlevhY9sJ/Q+ya5pW8jEteiGuJXYRZG7AKiIU/xLGmf4a+bhyB9CnEzZnra3Y+oQvqLVWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bk4s2mRD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bk4s2mRD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccea53f35cso47730616d6.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780932465; x=1781537265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=bk4s2mRDkUI886TqYJXvOR3o6P+dWOfLgtNjhLDESKeN6PLQDH97E0084ruESKt42/
         l4kzy/4qxUaR2w4TYe5lY618sLNJTHJsmEJxMpn1sAGzpwCs8S1XNOOD3Tk0ymKwLXhZ
         7JgiovHdSlTITmqTbQFjrsad/UoOR2uRUxc1AShB99SMmmBbOy6dFTDcR8KwgeXrVMiv
         cYCFk8RWBidPtXfgyA6aA8LgQavMxaBNc1yh3zjnuX35e/jwpMUMlcMSScAyJooYKYsj
         CAtEtXjnAymv52/+lz5pH9yssdRafLPqijm7VEfiYOLHq/x6ebDdIxdFd71a9RNl1qZg
         3Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932465; x=1781537265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=DIbLWYnkKGQa/tep7FG0PPb7/Bb/esbVwpydnZT8StsT+erRgSoBMr17uC6fTvkQyB
         /Tax0VuWWvVn9Cw6VVGOQqI+FBwL/ePfC0TBZ+7VAxN81tm7FvJtCFF/JmLHa+0yYB32
         jI7jt6VxUHilANsPa2bFpEmISSd0M16Z2LnCg3e7ajtyHVYDFR0PalR1eqIPcGWnPAhv
         DyJPPROHGiWlAUjr4YQgwmfn6W+3JjVDEMw0miXN7ZbkxgRSsWqwhP+DlCZTh5YswYFn
         b2BhodOqratZrXXq4packDWKD7QEXg5MFx3njn8B7abC0/Y1lOrW0cYtYatmJ/0+zrfG
         GWKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DT4XbDVcNxVNhr7e6XpiYiQrkAXiseyVx5FHz3Rsz8KZ/NXHZqh/aXF6xBKE4F+HduFBgoQ85cvRD@vger.kernel.org
X-Gm-Message-State: AOJu0YzVL8UN/4AGL72sDZddj4rA8VoO0lyWlNuWWHtppTlo2k0tHKPa
	HmSQzkDI1n4TYTbCzbsx3uT2O1/kLT1p97vE6J+dHJrhuNBJviIYq8J0hcU6YYU39q4=
X-Gm-Gg: Acq92OHPYbGsbpudiHkXqmR+UMjqAqLOvRl+aIk+jI9qjtcerNh9OMGBVvZcyLCEzXh
	Zzn3bX2NeaesS41AR6hcF1n7kGbrLsOuxW5mDK1QECYLl4pOgqFqNIN5Yrxu6GNXwfSPoxpt7em
	5knv2RNKNJZjXpsQ3O3WAROcHoeP7MS2VQCrrLqN7mS5j5C2wsUL369e8aryTHu7D6XmH224kL5
	2a/UcM1IIogxIJA/rsuIMxqsHCzeUIF3QOb8m5oLOph2p6eNuqvXMmL29o4Gu3x5VzEprw93zyB
	DhxgZHknl1gNwoEJEzTCphnvx6EunLrvKqioqvbfbgV/vSDUFp9NRBAVt5x8hMBXc4uLHXbiNwY
	YNtB3LjHcye3ZX7XsWPSF3a3nP00NHp2bu4Aodwp/nTxEy7cYNFAXby3EC6rxKYLudZFiHxyii9
	VYaybkC5jZ0SJ581QjO6TT5NrrgmuNqqzG588sUTyBicjPTOnIJXRxnPEHOJaTFSK3d0PuRV7Mr
	a32ygzb0z72du6m
X-Received: by 2002:a05:6214:4e09:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-8cee6252853mr236200376d6.30.1780932464978;
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0611sm170331636d6.1.2026.06.08.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWbt9-0000000HQjH-3xEo;
	Mon, 08 Jun 2026 12:27:43 -0300
Date: Mon, 8 Jun 2026 12:27:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260608152743.GD2764304@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>

On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> Hi Jason,
> 
> On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> >
> > > Given that Christoph's objection is not really about the modules part,
> > > but that the set_memory_{encrypted,decrypted} should not be used here,
> > > one option is to revert 78b30c50a7ac until that issue is sorted out?
> >
> > Please no, we have stuff already using this so it would be a
> > functional regression. Revert making heaps into a module since that
> > doesn't have a functional regression.
> 
> Thanks for your comments.
> 
> To me, it looks like while system and system_cc_shared heaps share a
> lot of code, their user bases have different needs. It's apparent that
> system_cc_heap users don't care about it being a module while system
> heap users would very much like so.
> 
> I also discussed this with Arnd, and he suggested we could rearrange
> the code so that system_heap_cc_shared_priv depends on a new Kconfig
> symbol like
> 
> config DMABUF_HEAPS_CC_SYSTEM
>         bool "DMA-BUF System Heap for memory encryption"
>         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
> 
> This allows building both into the kernel or leave encryption choice
> up to the consumers of the system heap.
> 
> If this is agreeable to everyone, I can post Arnd's patch.

Yeah, that's fine for me for now

Jason
