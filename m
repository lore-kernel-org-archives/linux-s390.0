Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC73ED11D;
	Thu,  2 Jul 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991115; cv=none; b=vGa3jZ8Z+LaR2GDe140wlSO2GOBYQTG9JRXPAkDaCqU7RI1lvYfiGrCsY6jQ29GZOvVRO4SpNJ8M7HWTDADZwvpjV5JlerHdRVfWnJP03smBGjgknj5gE+8lgOXo2s94dMmLBA+zBh6RfiyVFBRAjWasXPc6B6tDKO4jGDUQjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991115; c=relaxed/simple;
	bh=dSfJpS53PNdDDMLqEcpN4j0gf3ZqFlu965He2ZZE/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLDzBm3G4W0CGumfDayTrbGvzWsl7FuLkuk7EBQ0oXYI8QIh8ISkkl8hXe9G/zLfJkRa+Xf5WyUSZDB4zK0Ztxq0uWhd4PfNG3UXlu58kjMf/MmN61JA0U6IARS45LfqOYDX8zfU4zZZhMaaNNa2gIUrkiLEj0SdUeBp6Q/ZODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d9FS99uQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9FS99uQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jJg3inX5iy8rb6nSuSXw/iPxmbpJ7Y/aBoGJRj/Me0s=; b=d9FS99uQdqdRPtX0epGTfBuXv6
	YddgtwIuQV8k6gbBrs58fB65WzNZXegFxrXWCyWbPtqz2opt9JB6OURvje2XjsiLEuRc1NgDzJ4dV
	c9LvrtuEM+QV3Tbo3N6VHRRkkTH8O/oynZZpGIGpyh0xs8fg2QiXkXrap/6upwYQfZQq9ouTRK9qL
	SjdTEPE4Ogcp9HG7XveSo/IKQCjZ7AV/ICKOsijLCsM58+YyPlNG+XqiQksRtK9NftxvDWklJkZrp
	nx6+k+BJN/fr9DZ0IYCyI92MXVxSYVMRZb1WlEXE7MHRv3UhhwBC+AqKlGmudwNYA3kYxGGvg5dy3
	ASBmS/ZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfFQm-00000008Qd5-0pXm;
	Thu, 02 Jul 2026 11:18:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E93BD300220; Thu, 02 Jul 2026 13:18:07 +0200 (CEST)
Date: Thu, 2 Jul 2026 13:18:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH] futex: Optimise the size check get_futex_key()
Message-ID: <20260702111807.GI751831@noisy.programming.kicks-ass.net>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
 <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
 <20260701161736.xYYizA0e@linutronix.de>
 <20260702085921.GD49951@noisy.programming.kicks-ass.net>
 <20260702105615.PiYhQ9Rt@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702105615.PiYhQ9Rt@linutronix.de>

On Thu, Jul 02, 2026 at 12:56:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-02 10:59:21 [+0200], Peter Zijlstra wrote:
> > > Could someone verify this, please? The 5% look a bit high. This is on
> > > top of the series (but not worsen by the series).
> > 
> > Bah, I tried to reproduce and couldn't. Then I noticed I did a clang
> > build and that is in fact clever enough to do this optimization itself.
> > 
> > /me tries again with a GCC build.
> > 
> > pre:  [thread  0] futex: 0x561f14430680 [ 9021408 ops/sec ]
> > post: [thread  0] futex: 0x55feadbbb680 [ 8977527 ops/sec ]
> > 
> > (and this seems to be well inside the error threshold of this test).
> > 
> > So I see the GCC build do the DIV, and no longer with his patch applied,
> > but for some reason I cannot get the runtime performance to actually
> > improve much of anything on my system.
> 
> I did open https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126078 for the
> div.
> 
> My .config is the debian distro on the 4 node big iron. [ in case it
> it has so much overhead elsewhere that this place a bigger role].
> 
> "perf top" showed this as 6% or something and red in the function. After
> the removal it did not show up.

Right, I build whatever random config I had on the SPR test box. But I
can't argue with the patch, it is sane and GCC does generate better code
with it. For $raisins it just didn't translate into actual performance
for me.
