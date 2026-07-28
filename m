Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA83AEF4F;
	Tue, 28 Jul 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235662; cv=none; b=GM70h0LpvikEveC5O77oPUKl48F6bgWEWuTt5G+LMTMzYnM/cBa/tNH4LN8VLW+hIWurImPVJv7JE6k+390BlJSGGJyN1VDjL0OFZhyf6jTWvV04fEKHiRYo74HwGNI3cll8yg42JbbFRoswH8kKDY7g6OaeqD6JkFrHfX+URYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235662; c=relaxed/simple;
	bh=AmSEF6HFZys6JjNZa2z9DCyGQ55biJYxxnaeAwaOQUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9KA+OsfGAiU/kDky0dPq1NLw+8A/BcTksVPDA2USRfE1UiBPyUyIeHWtB6rvH16n/wuxOTGXcL4XJo7b8TY8jfBp5bCf8JCALMd9SCaOACB3097P+e5VEGC2F7A0fZFiR3oohpa5JRJhaCnkjrqqz1tw2Xy191EYvHlOd1MvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K8CCxGGr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8CCxGGr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LrI5jV+9lXNAqZIXhKCOO60TpJjIaMeX3ChNxpBQxyE=; b=K8CCxGGrapIcqHInx/7kof6kca
	HCFPPO5QU1klh4tiNTlKP3uNgbwrsSQDJ9nafWEGexokijPJ5vN+3+nL/JDn8Dk91aMNa7wPqJtyb
	u1pWFl/Oax8LyTDsqOjYPlRtnq/H2aft7UIkh4zAET2xULeB5OEYbu9utOEVe9cJhicjY7cWNZc9Q
	J3iJBOYIthtEVS0z6AAqdUEE+8rYWTv4TYZ1/5Auty0QflNhaxHrYJaPtHles362rX9/tB2ZrBebH
	AcurUXuksS3zfrqTfO8Y/aDWsNPmn8kh8Ddi9dDI0UNfRMyNV15/dP+jZT081aEyUpe3rlYr/3kJp
	t2nNPAnQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wofKo-0000000CzEg-1C8e;
	Tue, 28 Jul 2026 10:46:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA9DB30093A; Tue, 28 Jul 2026 12:46:53 +0200 (CEST)
Date: Tue, 28 Jul 2026 12:46:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Huth <thuth@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v6 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260728104653.GH49951@noisy.programming.kicks-ass.net>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-9-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728052540.4728-9-kprateek.nayak@amd.com>

On Tue, Jul 28, 2026 at 05:25:40AM +0000, K Prateek Nayak wrote:
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
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v5..v6:
> 
> o Picked up tags from Charlie. (Thanks a ton!)
> 
> o Picked up Peter's S-o-b from his tree.

Right, so I also munged the Changelog in my tree to include those
benchmark results. I failed to actually push out those patches before
disappearing on holidays, but I recon I should refresh them patches and
re-munge the changelog?

> o Added a barrier after runtime_const_init() after to prevent compilers
>   from re-ordering a later runtime const usage in the init function with
>   their initialization. (Sashiko; Reported by Intel test robot with a
>   GCC14 build).
>   (https://lore.kernel.org/lkml/alNgNvhIkBfkGo1Y@xsang-OptiPlex-9020/)

