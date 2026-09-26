Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F644065E;
	Sat, 26 Sep 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426992; cv=none; b=n35bRuSIkHpXJgeNlnG/T1W5RKwJyw+fpah78Xj+JdOunjDsb9t4qq6PDhxVWxtLOOb4xSkESgvqXxz3fsGWevhLMEEH3U0bPXl6OJLBrEJFDK5eL5U9GTbY7zPTpbmprzVs78j4ly1HtPD7ujklzPHNZXY8Y4332Qk2Rqb74yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426992; c=relaxed/simple;
	bh=wJODCO7qLFS406HdWeGWn9AB/r+Nib0na9ZJ01dnJlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2V22UBxQv1Tp/5E9ibENWhiRa9NYejhpIr1fh8HbRup0FjeA+41HYTmLLV374UdxUvDmNYjsyfGvVFWdidFIsa1r2ToS27YkaIdHeK8lXwZjHxbd43OXop8k/jBXyhMdSwkz/8zeUWXesAfBQeXvbHzZ+RjWpHBy2FSeR6iOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd5egb/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd5egb/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DC21F000FF;
	Sat, 26 Sep 2026 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790426987;
	bh=VcwH+9dD3jn1cikX304Fn2/psmP9ex3vbb4X9xZ4y0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fd5egb/9VQIjjOqS4QVt0JCgY3CjQEWPCjDbq1JPvTO/u/NWzV+lbMU2GnucpD8Cg
	 fQBncBItUBiNpft5Xle3TNZkvASdQXwYT782WczpRC4jNHKnURx/VR4lMI4JBZAg4b
	 za0ej8mPU5YqIeMJVF26LmaALHmhJznID0Q97bqr7HNfNTSy14hNnajBL2yZtPoDr6
	 ZPeKxz/NhMbw/6kJedmpg94MnX+XYJsijQGDTgqkeXja/IGUPPqM+mRcQX86S0NU8a
	 AaymHjbxISsM0nBUg8bnqDkatbTzLbXwZiMwQwM34QeqRDonyX/y1rrUsoEZSMn7fp
	 RycokNiL9jKuw==
Date: Sat, 26 Sep 2026 13:49:38 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20260926124938.GC1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
 <are7cfMIHZZn6jLz@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <are7cfMIHZZn6jLz@zx2c4.com>

On Sat, Sep 26, 2026 at 02:32:49PM +0200, Jason A. Donenfeld wrote:
> On Sat, Sep 26, 2026 at 01:19:27PM +0100, Nathan Chancellor wrote:
> > On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> > > On Sep 25 2026, Nathan Chancellor wrote:
> > > 
> > > > +#if __has_builtin(__builtin_memset_inline)
> > > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > > +#else
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +	char *d = dst;
> > > > +
> > > > +	while (size--)
> > > > +		*d++ = value;
> > > > +
> > > > +	return d;
> > > > +}
> > > > +#endif
> > > > +
> > > 
> > > memset actually returns the original pointer, not the incremented one.
> > > Nothing uses the return value of memset_inline here, but it is
> > > confusing.
> > 
> > Whoops, good catch, I guess my fingers gave up on those last two
> > characters :) I will fix this for v3 once there has been some time for
> > further review.
> 
> Do we even need to return a value at all? Might as well just make the
> function two lines:
> 
> +       for (char *d = dst; size--;)
> +               *d++ = value;

Yeah, good point, no point in returning something that we don't need
plus this is basically what we had before, just with a different pointer
type. Thanks for the suggestion.

> (Technically that could even be one, but maybe that sort of golf loses
> clarity. Your choice.)

I'll keep it two lines just for the sake of clarity.

-- 
Cheers,
Nathan
