Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBE1D416C;
	Sat, 26 Sep 2026 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425178; cv=none; b=UJjUy9azHVu0cfn0dgNO58he2F+p35L1LKbT+UU9zlejtu/JQWjv7ximMm3TEtHRDbEa1tFws+uRr1j/Tj9x0ZfRKlBmpvgL6GowHJR7s19Krmwrg3qdMgXBe+c++xFSa2zeQEnM5pL8HOJzO80ugVjqOb1GodWrXT+e/MJUbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425178; c=relaxed/simple;
	bh=qlGSy0PTIhBUGANsbdLhCUouY4VF8b69xbG82UNGlAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLTLWvv20wusF9oXBEapX2mMt9N9P8CqN9JqrZUJXMw3EaCveqBmTMMr/NiLkvLeKhklcw3PJSyUoclLUNBKEHO5Os2rMOfj5IJgul+a9RyskdTsWMfFqWRnwb6Bki8KXwbekFF1EdGR0IVC9YjhV6Gz18kuFtfPL6lseg588cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUXIg6Sj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUXIg6Sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C6B1F000FF;
	Sat, 26 Sep 2026 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790425176;
	bh=fX1UOorzk2WNkUzS8vq28akGhPcRScYxSKIHc7khZsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUXIg6SjJk+Qr1M0g3x4kQiPdWY0pMcyzGHOa/cNhZMob/KEO2PpiVHQtdd6QWG3x
	 dZ1y+306fsaJBZodcxplS8L82NhW9YwwaaW61njzxIIsMh2aygiTjvDyx579LwgTlk
	 TiNEAn/LIYOFBCadmux7/TrQTROL8C9DBsngCTXN5FvYS+wlAGeerAjS/qGI8F8zSt
	 zNqskNZyO093mE4xSamxYt4pPd91MQE+lyJXBwlx8zyyl/XlWLoHwQD1qUMS1tbOL6
	 bgAKynwX99Ez+3lc/SWDJSSB8c5kqNCTcs0gDxMX99zbcw5tfAFyKVemNQNOkTs/aX
	 D6EfHEKDJYwZw==
Date: Sat, 26 Sep 2026 13:19:27 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260926121927.GA1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zex4ic68.fsf@linux-m68k.org>

On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> On Sep 25 2026, Nathan Chancellor wrote:
> 
> > +#if __has_builtin(__builtin_memset_inline)
> > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > +#else
> > +static inline void *memset_inline(void *dst, int value, size_t size)
> > +{
> > +	char *d = dst;
> > +
> > +	while (size--)
> > +		*d++ = value;
> > +
> > +	return d;
> > +}
> > +#endif
> > +
> 
> memset actually returns the original pointer, not the incremented one.
> Nothing uses the return value of memset_inline here, but it is
> confusing.

Whoops, good catch, I guess my fingers gave up on those last two
characters :) I will fix this for v3 once there has been some time for
further review.

-- 
Cheers,
Nathan
