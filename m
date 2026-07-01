Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE243AF676;
	Wed,  1 Jul 2026 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892661; cv=none; b=hJR3TD643L0XEUge3hi6ItAIyLPmECaU27Kxb2yBnF8vSh2woKd9a2hgqWttNv08wOz3v7AthPshPuIx+sf1TpAPjSCFSmcjCg2xxpIlKaw0JgdfEmz1fUiS/U7977x8tW+0Pn+idl2ltrTdL0cy74tKSwTsOW+KEPSHZMKbxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892661; c=relaxed/simple;
	bh=/Jy4G2oYdf04xJ0weQ9H4v51vT0W9bTA5sYzHA5iGdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anVfRxmk0yy88uB3cN14Y9zIDrehkiYzyAbIJVszxKKpaVtC1fC1XjZACh+jS7o9gpxsb6GTCqGiHjpvUjjK+mk7pcfsqBHH9liF28MhvsWV7/5fNNicJml/J4VPxbY0RrjioU8tJh9bTR+25AiQ9bIe+m0+KRfpVhcTmkRllSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wMVEkvpb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wMVEkvpb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y3bOd8rRJgZw0SFI6BSvsmTa5xtyQqK8il7r7D4IeLc=; b=wMVEkvpblBw2MJ7Lj/oZ7R/r+l
	FWtnVgNCCuGrBzahJ/0gKwq7BEhfJyozTvLxb4UW6tPDfLUASGNHU3AalDnhaOYgoRZX5S+YYiCeW
	B0hTn6saaoF2pD0kgGf1UcFszA9sad3AHA9Qjw4czU61n5bAEasZ2XQxclhvuuqno1vsEbxWnDQXf
	enk2gV8UJ5toEBZaORClRcNZAdSJ95ZQdGOt0+V+Ct6zuVDWFJMt3gSQyELiV2dN+JYBKm6eI4vV2
	p+xcCSTX5hywYVEcSZlc1deNHi7U62qwsclG4chEQ3XnrtiB/XwMKLQEnqrZlSz2mZss9LnUogWHx
	8DBmDRMQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepoo-00000006G7w-2a6v;
	Wed, 01 Jul 2026 07:57:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1815530035C; Wed, 01 Jul 2026 09:57:14 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:57:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701075714.GP48970@noisy.programming.kicks-ass.net>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>

On Tue, Jun 30, 2026 at 04:55:31AM +0000, K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
> 
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> 
> Runtime constants are initialized before their first access and
> runtime_const_init() provides necessary barrier to ensure subsequent
> accesses are not reordered against their initialization.
> 
> No functional changes intended.
> 
>   [ prateek: Dynamically allocate __futex_queues, mark the global data
>     __ro_after_init since they are constified after futex_init(). ]
> 
> Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>


The big $1M question: does it actually make it go faster? The whole
point here was performance, right? But I'm not seeing numbers showing
how awesome these patches are.


