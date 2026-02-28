Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C9368948;
	Sat, 28 Feb 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772274688; cv=none; b=J7jMukiKIKQ4sSruQOk6E7hcpeYrKVilVPhh7imJrf8yNvZLblVTYGY5e+L18SLAhqJUn/i9R5IvUHKsoCNMkYg/nW01sZNgTNpIjC+Gb1D+Ej8i7kHA2E0r3lFTlWWHEIGCgJkMGP3woMfIcU+y+e7jTwMXw4VKuDT+KO7AmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772274688; c=relaxed/simple;
	bh=yfoqQ9vN7OO2ec4V/ZA9PZIXZ4CKF9DDFJKzwpjOEpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWHeb5YzeXDkdF1vzN33EMA7ovBuVdDNaaT271PF6AbSgMKxgF47ygvRgOUHhpwGoyVuDwZEHoRXm1YCzyrz2YfC6fwTO8YklSc0DYLQTLI61l/tVPDsZfddKmQafKVyeXco2nlBUjdBbRNWDpsZDm1fquaMFFP2RDEkcaKZHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OxdFfyYP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxdFfyYP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TMfQFraLliTO9OYi4VnvV7gf7AjKPxIluxE2boSfq9E=; b=OxdFfyYPeyHINJtVXQAaltcIrD
	vTeUNhJg+lYOIIKq/0VUHQy832LpDDtUbqLL24CJTu1mRxNAtAEgcWv1E1Awck539DVZSB6Uit4JK
	5tjMP/DfJ5iJJBvnAB+fnpbCDIUNu5AUaAZB8XGyd9dS8lN1j74TGmApEKyBmY3Rt2b4HLQQ6AVCg
	Iql5SIDgwWAV8HbcSssR64SYJ9Co5wI9/i76IakA2JDIYajMOfXq0sOfKJbdUf9mrCog1jE4HZ6AN
	pKGq4JnNVE7RW5t700X+8UR2f3A7E8X1m4p141oN1j3jvUQki47Gci44SANrHrNRY/EerLJtCnoiJ
	jg08yUig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwHbS-000000065SN-1WaG;
	Sat, 28 Feb 2026 10:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2ADC430066A; Sat, 28 Feb 2026 11:31:17 +0100 (CET)
Date: Sat, 28 Feb 2026 11:31:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260228103117.GK1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
 <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
 <20260227235529.GA31321@quark>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227235529.GA31321@quark>

On Fri, Feb 27, 2026 at 03:55:29PM -0800, Eric Biggers wrote:
> On Fri, Feb 27, 2026 at 03:30:16PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> > > Move the optimized XOR code out of line into lib/raid.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/x86/include/asm/xor.h                    | 518 ++----------------
> > >  arch/x86/include/asm/xor_64.h                 |  32 --
> > >  lib/raid/xor/Makefile                         |   8 +
> > >  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
> > >  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
> > >  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++
> > 
> > I gotta ask, why lib/raid/xor/$arch/ instead of something like
> > arch/$arch/lib/xor ?
> 
> Similar to lib/crypto/ and lib/crc/, it allows the translation units
> (either .c or .S files) containing architecture-optimized XOR code to be
> included directly in the xor.ko module, where they should be.
> 
> Previously, these were always built into the core kernel even if
> XOR_BLOCKS was 'n' or 'm', or they were built into a separate module
> xor-neon.ko which xor.ko depended on.  So either the code was included
> unnecessarily, or there was an extra module.
> 
> Technically we could instead have the lib makefile compile stuff in
> arch/, but that would be unusual.  It's much cleaner to have the
> directory structure match the build system.

Hmm, I suppose. Its just weird that we now have to look in both
arch/$foo and lib/*/$foo/ to find all arch code.

And I don't suppose symlinks would make it better?
