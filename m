Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17804D0CEB;
	Wed, 30 Sep 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778102; cv=none; b=TEYUvW71P78StC3E2E96eo+jXy5p6rWa2WX3LSqhGW50bHY5wkjXxjEXlyLkCG4AcXugFSYPqlC4XGDpRgaFevxytTwfdaeinDPIU8btDfVvXEwT8r2w3tzPgemQKtZYKGv456D20TcvU96eA14az5U2W+h+p4Wht51Apdn8tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778102; c=relaxed/simple;
	bh=kPxdLIHgctd4mGb5ljs1Z0kF/Hg2+/RBCFtsiT4urG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwyf/CLUKxtJtFmseJz4+aVqtAF+hFkA7AmB6FEZkn1LXz5yBzi6489Jm60OD+KFb7jPedwx7cdUyylRn2G3vHqtOK3f42A8AQ8/H+YKo1MiRzjymbv2qOIu+Bx7mlrnIw28M/97qsr9xVuGik82peRwsJHS9c2bDsktxjCdgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kkRK91cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kkRK91cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F7A1F00893;
	Wed, 30 Sep 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=kkRK91cQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790778087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zcThwgFUB4BfR5xfqdh6THtQYRaz9GGWFb0MJecCduw=;
	b=kkRK91cQzj+9vwUYtmGxpP6XHVefTkbHAXdd3nIiFVR+tOEuf0OaDl9hKkY9dgnZA+uIja
	kvvsMMlW1aun0HmpF4USkn2HKIB/ExvhSKaoIDBa5/FJ8DgYeE/zmuK/55JeWGBQCXPp3h
	CRPitXuJosLH57qy20oRmbXytVm4JwY=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id de3a0bd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:21:26 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:21:21 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <ar0a4b9CjL2YHCkY@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930133813.GA3142230@ax162>

On Wed, Sep 30, 2026 at 03:38:13PM +0200, Nathan Chancellor wrote:
> On Tue, Sep 29, 2026 at 11:24:11AM -0700, Nick Desaulniers wrote:
> > arch/arm64/kvm/hyp/nvhe/Makefile has this pattern for exactly the same
> > problem I suspect.  Maybe that's the right tool in the toolbox?
> > 
> > ```
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > index 8dbf2532a573..27fa72d8fb86 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -27,7 +27,7 @@ asflags-y += -DVDSO_CFI=1
> >  endif
> > 
> >  # Files to link into the vdso
> > -obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
> > +obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o ../../lib/memset.o
> > 
> >  ifdef CONFIG_VDSO_GETRANDOM
> >  obj-vdso += vgetrandom-chacha.o
> > ```
> > Fixes `make -skj"$(nproc)" ARCH=riscv LLVM=1 mrproper allmodconfig
> > vdso_prepare` for me, as per
> 
> For the record, this also happens with the 32-bit PowerPC vDSO, as I
> noted in the commit message of v2. I should update the issue too, I only
> realized this after wider testing. So if this is the route we want to
> go, we would need a memset() for that vDSO as well.
> 
> > https://github.com/ClangBuiltLinux/linux/issues/2183
> > (Nathan, don't forget to link to that in the commit message)
> 
> Yes, thanks, I have added it for v3.
> 
> > I'm surprised I didn't need -fno-semantic-interposition (or one of the
> > related flags... -fvisibility=hidden)
> > 
> > If we want to get better, (if performance matters here and we want to
> > trade source+build system complexity for absolute code perf) I would
> > start with that, then worry about clawing back performance via things
> > like:
> > - __builtin_memset_inline
> > - -finline-stringops=memset
> > - -ffunction-sections+-Wl,--gc-sections to dead code eliminate the out
> > of line copy of memset, though IIRC there's potential for wasted space
> > due to alignment requirements (maybe the out of line copy of memset is
> > smaller...idk)
> 
> Yeah, I guess it is ultimately up to the maintainers what route they
> prefer.

I think linking in an out-of-line memset.o is not appealing. This isn't
a general library or something. So let's just go with your v2 approach,
fixed up in the ways we mentioned.
