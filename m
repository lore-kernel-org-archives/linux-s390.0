Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2693E16A4;
	Sat, 26 Sep 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425985; cv=none; b=GCVG0PyfW+snWQsInsltKAdaxjD/AmtymTxN4LURHbbj6loEAwPiZQtYWrv75JMFZzAYnwAN48C0bC/4ilqCw4sTrnt+zfZiyaxMv4u5sXOzAIY8GJspTdr9sf2xaOJcs4A1G12nGzy0arkIs7b1kiOJ1aqmLeei0Lza6tO7Lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425985; c=relaxed/simple;
	bh=U99qmECVqrZaphrQ4iZ9gnL9T9adOep2t1USdze/Z/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdNIrSRfrBkfj+6ULcrJnjUdBf2aRaAH0C+ByfpB9ikqXdYlvHLDCq9u4+IjdVMesXl+pjnrcRfAqP6bjvC6xSkic+9Kg2Cgf83ZjZartrd7Gmbnic+BmHqFHLhi+fhqn9q2OY69h97AwwDn7JT7SlXNspk+w0aEQNSHtWLCkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jlCeeByi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jlCeeByi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15541F000FF;
	Sat, 26 Sep 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=jlCeeByi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790425978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wN9D2nKA01y/2x8IJdWZfEnnjMzwFRK3N4mVnSJjkBY=;
	b=jlCeeByiKyNAkRDIl4L4BWyGHQY1JK/6GovcSrkf8oXtiWNghruM3MspMqAjQRrS0A5Y4N
	9+00l0im2/J3X1CtQ1hGQXUesbacPr8oKkkGy3jQrUfnbQNxrABBNqKeaKwtQlF9FRtom+
	IijiL9NA1TH1lfYG6igzuyjRxzyvjCg=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 6d775622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 26 Sep 2026 12:32:58 +0000 (UTC)
Date: Sat, 26 Sep 2026 14:32:49 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <are7cfMIHZZn6jLz@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926121927.GA1486962@ax162>

On Sat, Sep 26, 2026 at 01:19:27PM +0100, Nathan Chancellor wrote:
> On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> > On Sep 25 2026, Nathan Chancellor wrote:
> > 
> > > +#if __has_builtin(__builtin_memset_inline)
> > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > +#else
> > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > +{
> > > +	char *d = dst;
> > > +
> > > +	while (size--)
> > > +		*d++ = value;
> > > +
> > > +	return d;
> > > +}
> > > +#endif
> > > +
> > 
> > memset actually returns the original pointer, not the incremented one.
> > Nothing uses the return value of memset_inline here, but it is
> > confusing.
> 
> Whoops, good catch, I guess my fingers gave up on those last two
> characters :) I will fix this for v3 once there has been some time for
> further review.

Do we even need to return a value at all? Might as well just make the
function two lines:

+       for (char *d = dst; size--;)
+               *d++ = value;

(Technically that could even be one, but maybe that sort of golf loses
clarity. Your choice.)
