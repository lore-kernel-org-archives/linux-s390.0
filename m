Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F343BDA9
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278781; cv=none; b=XmGg06VD6OO9eKnVUw/5rMcr+jYyZMlmTTgykz1OsXfO1iqfPTIUAw3X4C9QPGQjNCPlfNmtAgcECrKTGrEt+ZZnW1H//eN/HjILq1QxoHia+slCUId4BtjfSTooEnj15RPo8dLlQ2PNWzcszhG42zp9O05uOAOfiU8/FYK+j3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278781; c=relaxed/simple;
	bh=m9GF6BVXJghb0t0TACX7Y0SpJfQTXPLs06gu6gZAn2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNgYRB2OQU5EPOS9+A+GghoXiUWzVzADi9Q1aNQNmH3EqBrfqEGHw9ADD0iowAWBV7c7SmqSOsMO6x231Tu//QgHOUKG0tOusY4ZpOVSCteHtdFee6uuZ+z1a2Za8yV7cHVilezPaDlnKMg+98XfEHyqQntNeJQQq/Bfm9Cy+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BQcWIcoV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BQcWIcoV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936cda0e3fbso8102285a.3
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788278778; x=1788883578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=BQcWIcoV7P3Hr2LDZpO5LnlyE0+kl7BJcY/963/R3GpW+crY1co2xJ0VB/jrCBT5U+
         sUWQ0qhCyeJNxHtT6geZRvpMmyBGAmAqykF3LtaV2i1XYHstPYbbJwP2CNyvATO0fX7+
         qdAzbkhHzNaFhbaje/y8wVWDOoJ+O8NTGXOplwJne+lpwuLVz4/mIJkeh0+/O1qhaoSZ
         0L8++LEs2lMFVe4zBAmvRmxeNtGBbF6AWtXQKKjSUg79N+3uZkVTZ45yKLBp848ccCNt
         HkWwtQY+zmVRVYj7zfVvYfJ9ZFsctneRdffIWTYUSyHt/PGBfVimfMFQZCKGETAmlej3
         AErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278778; x=1788883578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=VmPC2/G5sih1pEum2bMGSEcwCjohmR/0HJ1WJ4j91Xvj2Pa5hCb3YiDdomw7tQ4Srx
         g+uk898W43y4xH3E69Ed0rf93OnU6RWRC6sHHxgmdlcNTFObpt+OO5983W47oJBfnL4S
         WIdn5aZaW7D7UB5s3gNYyVDYc5QQe7k/56m0myQ7YFsI5e6oylE2ZAqI2qCUmiW4QsNL
         QyDNKeIWHlk6bdXr35sIf8zLcb+EONDLTpoTQi79dwyQcGdrrxl2VPJd/yu7LmSBqhOJ
         Q/N85CZAOg0edK/NlxHDunJYkIpcnuCKwcUJptfDezhunLecyxz3BmcUcfHaBSm/O0Xg
         mpzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoP/ZBmWkq+o2x8cXXrBbh8kNE5sVvz4T0z46MKi07wVuooP4zK+vraA0MUHrGOuT6yt0NBd3ruMpAY@vger.kernel.org
X-Gm-Message-State: AFuF++kTSDnC/3K1P7xoFdl/uapzJt0o9b2TaWwfX3+gdHNjSZGvYiYU
	6aumSqtXQJ+ARE6GkHGUDq2SHo8nqxgqZHSEj2uGyuzwBWE636spujl1xWa+sM0O15U=
X-Gm-Gg: AR+sD124B7EO8d+piSCXzKGnLvaPjdhpb0PvUj4jrTqBBpIy0nf48WGhKibsjup16Gr
	fGdCk/4eF5WOVEz0bn2MkhpeejwZQT2Sqq67uWcd0PZHGPpd+r8Gj1hcIQdBzIs1C8LuakwOxNS
	xBhlGcfojRVK9iDUSuEy35i5etWiSr7vAdVBG5O2YBM2hLLN2jJZChjQmfPcfI3V0FJgTVdW03v
	gue+XLUDvDIE8zhh5raRoeAUkG3dxijh8g/TkrVgfTM3qU53xCtGK5N0gQRkTNbSAfty0OjEmtO
	hai/x4fckaN0vvPZ6bNcCwChYwTB3PO0MH9l1LsPAYC0LhGCTBxX6UMi9PYU7H0JVwjbCMfpGc9
	IxAvYQq8TQb9FpCvyxjFQzYCDXssS6eDx+XYLVHwjoJjVYoMp20+a7h4G9bu/OJ9XZgVJJ3RkS6
	/GJi9YCYjsrOuq+D6LvKNv26EIcMszhnG7Ra3LWqrKfBmCyugv6nwenItEkozAVJdEeKRV1rd5Z
	TmzgmZ80DLO0PfYuJBxXS2vW91UA/K7CEb7Y/f5aroeEw==
X-Received: by 2002:a05:620a:21d2:b0:936:ea0d:ffc3 with SMTP id af79cd13be357-939139002d3mr3178331885a.22.1788278777843;
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93922e5278fsm886283685a.14.2026.09.01.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1R04-0000000BtB8-1Fgr;
	Tue, 01 Sep 2026 13:06:16 -0300
Date: Tue, 1 Sep 2026 13:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Russell King <linux@armlinux.org.uk>,
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <20260901160616.GD56830@ziepe.ca>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>

On Tue, Sep 01, 2026 at 11:54:47AM -0400, Liam R. Howlett wrote:
> On 26/09/01 04:28PM, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:41:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > >
> > > > > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > > > > increase some time spent in softirq but again is 512x that big of a deal?
> > > > >
> > > > > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > > > > either really, certainly not without it becoming extremely messy.
> > > >
> > > > The less costly version is to thread the page to be freed onto the
> > > > mmu_gather through a linked list in the struct page memory. This is
> > > > super cheap since it is just a singly linked list operation.
> > > >
> > > > Then when the mmu_gather is flushed it does a single call_rcu using
> > > > the rcu head of the struct page of the head of the list. The callback
> > > > clears the entire linked list of pages.
> 
> If you are going through the trouble of doing this on your side with a
> custom rcu callback, it might be better to pack the pointers in a way
> that does not need to pointer chase through a linked list.

Well, I have 8 bytes of memory in a struct page and can't allocate in
these paths, so IDK there is another option..

Jason
