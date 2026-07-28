Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D16372B53;
	Tue, 28 Jul 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236929; cv=none; b=tQY+6XIXwINhvSSr5LK1QXl8NgvStzTDYSfMCM4Hv07gB21WP8O8nhdiuf34D1LJ/lbEY77ST4XKZ6C+9AsRYwlsSFpFs3LbcqHrwx8fLZLezDAv6brBAmkciT/Xtb3ibneeK91Ejfg674F4eBzWk3nvXq/qQk+MnrDBH/DkoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236929; c=relaxed/simple;
	bh=50wevO59OXwF+9T3RnkE+MdtqR+OfIFzVNlk09loXME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMsayNsR5OYO68ersuHTo4m+LFs45ONxurpGmVGmACGgb56gggAjoxHhcwoR3VYW03wwhLusYoEfckVxUFxPcouectG4XyKUEcS8JI8jIWGhi1VmnW2hyByQoie+3l3zqgysF/3eHouwbvZ/yGSIEZ2K+/qVt9nQ4h91djsjZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F4iPhNzO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4iPhNzO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XUdocc9AyfaWpOM5SNPJip/RwRNo5MSCyklyHVO9Wws=; b=F4iPhNzOmo8NpbJb+tV6CswPGi
	+YCKtt8bsid6mcaEYcbDf3iYC8DCtCRsMy/bsVClYGCieP2r8DU303Iv4guwsi7UYqR03nOeEDkSK
	56qpqtPT/VLc8PvXtZ5h/g7q9erG4AKjqUkG+4eIl0qMv/j/Xb932EoEnjm4KYzrDd5Fk7iwfl41u
	grFxNPvv2ez60OT3dtPnXylCD1+t/nHHTdYxSmbEUVfTcxHTiv7zkgE7fT/yZm8u8OznQD9ribqUi
	G+fI3woBoHEUDLnKzKsPe7ptdNYj4VnHFzS9cC7Ixype8if2pU52BCJYozxNfjNECkFbGIqBlqMED
	OZuDKqQg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woffL-00000004ryR-2Oyk;
	Tue, 28 Jul 2026 11:08:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DC6330093A; Tue, 28 Jul 2026 13:08:06 +0200 (CEST)
Date: Tue, 28 Jul 2026 13:08:06 +0200
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
Message-ID: <20260728110806.GJ49951@noisy.programming.kicks-ass.net>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-9-kprateek.nayak@amd.com>
 <20260728104653.GH49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728104653.GH49951@noisy.programming.kicks-ass.net>

On Tue, Jul 28, 2026 at 12:46:53PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 28, 2026 at 05:25:40AM +0000, K Prateek Nayak wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Runtime constify the read-only after init data  __futex_shift(shift_32),
> > __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> > hot path to avoid referencing global variable.
> > 
> > This also allows __futex_queues to be allocated dynamically to
> > "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> > (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> > 
> > Runtime constants are initialized before their first access and
> > runtime_const_init() provides necessary barrier to ensure subsequent
> > accesses are not reordered against their initialization.
> > 
> > No functional changes intended.
> > 
> >   [ prateek: Dynamically allocate __futex_queues, mark the global data
> >     __ro_after_init since they are constified after futex_init(). ]
> > 
> > Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> > changelog v5..v6:
> > 
> > o Picked up tags from Charlie. (Thanks a ton!)
> > 
> > o Picked up Peter's S-o-b from his tree.
> 
> Right, so I also munged the Changelog in my tree to include those
> benchmark results. I failed to actually push out those patches before
> disappearing on holidays, but I recon I should refresh them patches and
> re-munge the changelog?

With a bit of luck I didn't wreck things and this new version should now
be available in queue/locking/core.
