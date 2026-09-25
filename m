Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07A3B19DE;
	Fri, 25 Sep 2026 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374771; cv=none; b=ODZvRlcbsE22qsU9YQM/y9inqqoegFwmzfBBkrgLNvrPusDfx6xGR4wwOOt2cCyxdeD6uBfUvzIk6idyb2QxdVKPQgmDVOMmeElPbet4s3uqOMSQLu1w7o4QP2WB6i/8O3jU5ggR2H3A+UIgnTPcjJ4bfx7vY4tMfJXZouHy2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374771; c=relaxed/simple;
	bh=zSRb9x++qabLIT7ciB+i17Qwgp6yEv3v3XcxPYd1UhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHoBHC72C3txYtGEwQL2xmI5804GFcCwwccyKGSaFAWVKO77DuWHar33NlA2EqJ2Xoqx59I/wvwsfjj9qDRo2hYKwuKZzNgdNowo7YUTa4nt7iATewmi+2fLyHIBtnGq7qj6NsPmEV6WYyyt1q4AwSCy22dzKNXZiUEsr/2KY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQxXz8Bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQxXz8Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFD91F00893;
	Fri, 25 Sep 2026 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790374770;
	bh=Ub6l+gGnhbpnVJSf1sECQFZws1/JGSNU3EBgSX0gJT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PQxXz8Bqrp5fZyfGD0+JAGV/Kt9gf1keLvC0fg5oDg0FbTEbVJGuxWGMfLX4a64tp
	 AWVr2a0nGnUzgI0wEPXnVpyWA2bs9xiS75lcfbRaZsj6SsbeBpDWwM2a1brofqNtc/
	 PMVzMywMMPqnL/kNGdSX9F63rKLKf3sNQoadBGdYyIoJVHaFD9o2FxX3/eeZttbdAW
	 inqLQvas8M54Ltq6wI4sRbZF3B+T/RIAJD3NcO6l0rUleguc0EzcHCV7vzFkNvo/WV
	 yh0CnZKvY/rQthUclqO6rQJbXjy8+yJDamlNxOKl56QmZxkkB7YCoqP8hpwRiy5WMz
	 6mMauv2SHxwSg==
Date: Fri, 25 Sep 2026 23:19:21 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Message-ID: <20260925221921.GA2296912@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>

On Fri, Sep 25, 2026 at 03:00:46PM -0700, Nick Desaulniers wrote:
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +       char *d = dst;
> > > > +
> > > > +       while (size--)
> > > > +               *d++ = value;
> > > > +
> > > > +       return d;
> > > > +}
> > >
> > > Does this work?
> > > https://godbolt.org/z/Tx6EaGMfb
> >
> > Hmmm...possibly.
> > https://godbolt.org/z/ec9rzd9Yf
> > I don't get it...
> 
> Just keep it under 2 pages, it will be fine:
> https://godbolt.org/z/qqoMqfxev

Yeah, it might be worth a comment that this is only safe for small
values of size so it should not be blindly copied elsewhere (although I
guess if it is, the outlined version exists in the majority of other
places).

-- 
Cheers,
Nathan
