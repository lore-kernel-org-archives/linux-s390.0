Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C27305E3B
	for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786203; cv=none; b=fdi1z70P0DcpuDNRn8CKiInMrHDT8r0wMl1OnHFLIQ2fggZD+kECEW7Z02VqjbSvIO8UMaBoDtaNMYtD3ebb2gu4YTaT7PFsM3JN1V6NDT1LqXQmtRJa7COAqNau6MBK5sWlcEeUU2U3pKMApLZXh2xL4c0MLdUTGXtnv9qZfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786203; c=relaxed/simple;
	bh=WmHtBHSTYxbfJ263YgNe7PXPFBdQFrEByiiVtkOz+uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFDPXLxgoVf4knPfdC2bHGDfHkKyi4ueNjKspyCXUbwPc/cA+otnJg8dEryMfmO0wo5YTvKY9CgBo+InSfKZJ7avk9895qiAtOvZs6j0Qy/7Uo6oY24v7tSrUn3hH+MvLYjAPvGFfq75Rqin4nujeBBH5HnBPtGhuRXMqYSebYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o3p/t+Oz; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o3p/t+Oz"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8948273f5d0so32543506d6.0
        for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 07:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769786199; x=1770390999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9si664lpAABtSRH5NCDTNiWW5Zo1E2FOdd2kZn8cRsw=;
        b=o3p/t+OzNolmstthDKxfQ2xaDr4SG5Cd5MhbMtCpLSmb1pSCcPW8jaVlip9X438OsU
         pvqcK+zIuEQTlyP6cyjSPpPISnUcNH8HBRF8XscGM0zgrtsq9YMvJCbOascyJ6SYle3K
         5+lplx4rOZBELiGFXi7Z029vg2gzMC0aiSCWP/xkR9Zj42Ur8ylSVCaRV6w/kOkYPsRI
         NCWMbQlXq7eyk4aNHKTwPQQYIk6ntQG++EF1z3KRTnDa5JBk2tRP7dJov/Sgzp0Jnu5a
         SVuV3RCSgr6Qe2RLxTELd34T9s4IMJbMo5I1OeLdPPTA68gyCEv8RiFwF6w3hkirjZTv
         /fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786199; x=1770390999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9si664lpAABtSRH5NCDTNiWW5Zo1E2FOdd2kZn8cRsw=;
        b=vA6c+yf9/pmC5H8sCUeXw2F16b7sEfgxU/UsgwsRV/iFpWUFkEZlVV8qbp8NC1/z0j
         VkMGF1QbTICVPdYcAPf2qcgR8J0DNi2cTyD9CThOsIPFj8V7zuuik28EMQwiFAcEuV+q
         gEeYiFhWh/1skr/A0u2dKfBCwNXfp8JLdcVprjRiiPd9WrqByODrromBm4yrJ8Zf0oMV
         mU2WxWSTwT+gHn3LLVCMcPRlzQajjAPzgh73rYCbZf8xL+cUOt4Je2+9Hb/U3RYsHI+P
         D5DroMMZoBNWxlZgIkLBiYlnzRY7Rjn3Y4e3e9HDrskOqWREK6L74rKBGo0/+WXenrEt
         S/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh6HKwZ2VG7jELJbAV5JPk6zMKt1z6enXTrB9XIe7S8ibZPDlrM4Zk65cxNzVq+xNzaCTcGDakybfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwM+fbyguLBzvnjsLTiyjWiZ8xPlZ1HEkFf+3vnK8Xp4N9qIo
	AczmJezquJa+FCaeZiMGIwjFsDvyzXyZSolHDlGq5J4mIfKPzoR8POH5aeHc70VyPH4=
X-Gm-Gg: AZuq6aJcMfRhLzh7ee6KmL7qostRC8s6ywy9YZk01tf28Ui0F/8Y/12x6g1TxdJYK5C
	LZFD/3DRdYzCtfRzIVwfrca+v3Iqu6aEkwEufqhH3E+0QXMTkiNUcxHLKW/mnTivICbKj+NwcIi
	pFiJ+ZeQqjJk6wQly0ZpQE9SzK3JN8TbBSzJu/Vb8DXbN0XAEdY8RxT1Abg/1orFzoEY39reZho
	cbpkR/dBhcrVPJgUY5e/pXjtIHddwXtLyCYRZrVWqyCb7ManOH9sqXe9np43h5cKBDL9XQ26n/P
	DT54X6I0jdD+cRkEF5GlmDpH5z+nuSWuCvFpOjQdDDYtuWA8rqMCyaOVy3olfro5k/UAtyXMGuC
	Dp0Sc1Q9UCdZx/IHyejT6UA0yz9nqczsrvHBcWpbTfe5CQE5ufcDl9QBVwQ53qw+8R6GdKdfd9e
	PzVw1O7jNoNh4GapWZJhaiYoZ+GMdtQPcqlRUElNlYmszxDQaeDYqit1hjvbhxa9thFes=
X-Received: by 2002:a05:6214:501d:b0:88a:4c50:3be0 with SMTP id 6a1803df08f44-894df970109mr86470926d6.6.1769786198441;
        Fri, 30 Jan 2026 07:16:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c5d4sm58414081cf.3.2026.01.30.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:16:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlqEe-0000000BAef-38VG;
	Fri, 30 Jan 2026 11:16:36 -0400
Date: Fri, 30 Jan 2026 11:16:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20260130151636.GF2328995@ziepe.ca>
References: <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
 <20260129132058.GC2307128@ziepe.ca>
 <20260130085131.GA122673@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130085131.GA122673@j66a10360.sqa.eu95>

On Fri, Jan 30, 2026 at 04:51:31PM +0800, D. Wythe wrote:
> On Thu, Jan 29, 2026 at 09:20:58AM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:
> > 
> > > > From there you can check the resulting scatterlist and compute the
> > > > page_size to pass to ib_map_mr_sg().
> > 
> > I should clarify this is done after DMA mapping the scatterlist. dma
> > mapping can improve the page size.
> > 
> > And maybe the core code should be helping compute the MR's target page
> > size for a scatterlist.. We already have code to do this in umem, and
> > it is a pretty bit tricky considering the IOVA related rules.
> >
> 
> Hi Jason,
> 
> After a deep dive into ib_umem_find_best_pgsz(), I have to say it is
> much more subtle than it first appears. The IOVA-to-PA relative offset
> rules, in particular, make it quite easy to get wrong.
> 
> While SMC could duplicate this logic, it is certainly not ideal for
> maintenance. Are there any plans to refactor this into a generic RDMA
> core helper—for instance, one that can determine the best page size
> directly from an sg_table or scatterlist?

I have not heard of anyone touching this.

It looks like there are only two users in the kernel that pass
something other than PAGE_SIZE, so it seems nobody has cared about
this till now.

With high order folios being more common it seems like something
missing.

However, I wonder what the drivers do with the input page size, 
segmenting a scatterlist is a bit hard and we have helpers for that
already too.

It is a bigger project but probably the right thing is to remove the
page size input, wrap the scatterlist in a umem and fixup the drivers
to use the existing umem support for building mtts, splitting
scatterlists into blocks and so on.

The kernel side here has been left alone for a long time..

Jason
