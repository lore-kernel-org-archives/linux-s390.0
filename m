Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA049236A73
	for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251746; cv=none; b=djZGINU6ODJDNHx7BAeKaulgwz5KnLQoFSalN8GFT56Jwiau5ehTtXnFghqdZH6z1Q2yzl0s0ig9bxAK17s56OdcKQnSyOVD9i4ikrSYqhMXH+aU6p2DLEgkPjHvxozMZ6zc47FrmD8zswlC+kCC1b6KgTYZAGLuykm9kGw2KrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251746; c=relaxed/simple;
	bh=5by/krL4LkgSMMT5g0Z2p396tLopyd3gucFBw6XyILI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWw/XDVb1sk/YRjuLvZqgAZTa4b1/2iwyHDcUe1xvz+VYO3QQCtIDWCuVjKvCW36jVM/eRXLWsbLoNYMEqr4SxIzruTAnbsvqzxGcIgFeP1ZrpFuqo9j1cZd1ihjYF6OQ2rvLTBIsNozdC6m1RpyPGvkVqDgU/Lf8q/U9gAWs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO9W6wBq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO9W6wBq"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-385c23b88e8so31705011fa.3
        for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769251742; x=1769856542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=FO9W6wBqZnSzLyHl8bLgqcXLeB2FBCw24iZhkVp5h+SIGMt89cbwlFtHNkhArvBFiF
         XK/fhtxdAdaO3glXzpLZvG3n++FXitqL6vu0xkEj2YjmiIV01pYVXDjvNuN644Rzr1o4
         5E9LuVu+IOdip/IUdYD896GXIrqvZylYfLsehs6oibk0Z3CeadfJF17LrAMv8seFIVvT
         qBGFuw5oihSouhAzTCAa98kN9Ea6PCLdSr/hCo2jvZcIxs7dLgJZu/NtEpuhB7Li/Oq7
         WMC46BcuKsZCeWvbu0DxqfVdWnCmZEi4KlRTtk8zVHbcRUmNSMTyA/jmgW3XjhxV2CVI
         sQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251742; x=1769856542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=RK44JBRDDvBhXWjf8LRdMzTHMnAWtCQ/2lFCgt+vcTTKOLfIFrZxSZAiPfdDX9IAci
         6vjoknMJS60uRVKX0r7gTSb7BtKx/hbLbHUdA80onK9n87X/gz1/ekmVwUu93vOFGbPI
         3taSlAfVvQU9cfMP4tkegC1Ly19e2CQFR2SqDSqQOiGqXK5ZRsyR8g6oNOtZ4ls478/I
         gLlITubEly1F8buo8B3ebxmKPiP2Dfly/l0e23+AME7pn6H+AQJZSuXbTMOudp5y56C5
         piYRq8ggk4vJ+hVbGnN3d762NP1b0rBZ2lnXxJsKenwp0Rzugo80qoFBDR1eqOeHQw8i
         KtCg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Wf53PceRck3I/UzWtwSP8IS6kZutBF4Qk4Cq12aPVKlOioxg/oMc4gPTz0YVAzfg/tYSdnLzHfX6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/g7RcroXC4CmI2adQO1QNIhM3k4/bwUbHdA/4nSai7fyCTTT
	ySPrZ1Vc0yf20VmH/1K7VjBwTTHXNZKzCHG/rOg3yTCDOP8dmWUWOPx0
X-Gm-Gg: AZuq6aLAd4l8C+6w9uQdoV+MMWuvy6g68zEc/s/yoO298EMF5E3rCRCFTHqu+vJ5RD8
	zj6161N+Fk5zNdbApNp2vMpBZtIhl/bBK4TOZW6iJq8w1i5bjqShqWmhhurN2nObUqcNuTNyFUQ
	mh2dY1GzVrMvC3RC3Jf9V3Y+WLgaV6eaCxDjeeyRPfssMp5GBptVEP/aYzJJoPoRo0BV03Q5XGL
	Q2y/8XJHt0gSIVZ/ZkKvxPxsUZRS59dzXuuAoYyNkzUOrzK+4/O6T/lfda9CnnPUianjsYMtNzb
	ggiH6RNpHOt/jJtT3GhUIemJb30SKKxu91VrmYBaWB5cUt9Kt9b2iA4cl1SUihtn2kciSJFx8U+
	KdOT049qloKqFOTWCOYf9Mz/jwu5Uzb/Sdzew1gHO2XjjmVlDUQs=
X-Received: by 2002:a05:651c:1a0c:b0:385:c21f:37e3 with SMTP id 38308e7fff4ca-385e1b715dcmr15798421fa.19.1769251741385;
        Sat, 24 Jan 2026 02:49:01 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1ab6acsm11193501fa.40.2026.01.24.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:49:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 24 Jan 2026 11:48:59 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXSjm1DXm6yP62tD@pc636>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124093505.GA98529@j66a10360.sqa.eu95>

Hello, D. Wythe!

> On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > find_vm_area() provides a way to find the vm_struct associated with a
> > > virtual address. Export this symbol to modules so that modularized
> > > subsystems can perform lookups on vmalloc addresses.
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > ---
> > >  mm/vmalloc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ecbac900c35f..3eb9fe761c34 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > >  
> > >  	return va->vm;
> > >  }
> > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > >  
> > This is internal. We can not just export it.
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> Thank you for the feedback. I agree that we should avoid exposing
> internal implementation details like struct vm_struct to external
> subsystems.
> 
> Following Christoph's suggestion, I'm planning to encapsulate the page
> order lookup into a minimal helper instead:
> 
> unsigned int vmalloc_page_order(const void *addr){
> 	struct vm_struct *vm;
>  	vm = find_vm_area(addr);
> 	return vm ? vm->page_order : 0;
> }
> EXPORT_SYMBOL_GPL(vmalloc_page_order);
> 
> Does this approach look reasonable to you? It would keep the vm_struct
> layout private while satisfying the optimization needs of SMC.
> 
Could you please clarify why you need info about page_order? I have not
looked at your second patch.

Thanks!

--
Uladzislau Rezki
