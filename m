Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE64E0211;
	Wed, 30 Sep 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779493; cv=none; b=iWzFchRRmKSnpFio92OPIM3ttUYTRPqJTNN65gh6JIp8tw+e3ic5+B31yjC/etHVb1b/19b9Ou/DAoGPFtXPS1prILQOkoQDekCsZaeVN+hPBF+PCyxzNZ99g3PggjQEyAZ2aDa/+j+FHFOSX+wbdGYvI/I4Z/bXarXfzApzrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779493; c=relaxed/simple;
	bh=/hM1w5/BmBCVc2LW35g0T+OFMc+fP5hSm+8wCLn9WNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIzr7tS+9Fjb3Lrd39M9of3qhKdTpBdHWAAbcwIM66000zuIdIHCFD59X/A6Ce68Wk0u1zsZ+RrxLu7JISRPrlQW7CFVr0P3TSgKwnaF8p2kPjoIDCVRsa7AT0VVJAK1lRtRwq0x/X+rd/6HHlN9RczxxvNp8/oDlVkPMyVLn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eGVmIQ1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eGVmIQ1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838751F000FF;
	Wed, 30 Sep 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=eGVmIQ1p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790779473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdb5KJwsOub7GoIR9aTYq/rRFnLlERiJ3o2Jnsmzbdw=;
	b=eGVmIQ1p7gCV5dnk5+JFddnWgLfBu5xMxZ854bpWe1Jl20d7doFs45uLc1gZORYJ0tlqO2
	uH+lg4TyWRsgbKZe7UJ0gcyw4uEpd0lzcz2PcAO46tun3AzihC/zqqBjfUkChIc/WPoZwv
	NpC/wsRCLYwN84wsE5WUkj/UVaIoBqo=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id df032bc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:44:33 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:44:29 +0200
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
Message-ID: <ar0gTS71qxnx9AkW@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar0a4b9CjL2YHCkY@zx2c4.com>

On Wed, Sep 30, 2026 at 04:21:21PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 30, 2026 at 03:38:13PM +0200, Nathan Chancellor wrote:
> > On Tue, Sep 29, 2026 at 11:24:11AM -0700, Nick Desaulniers wrote:
> > > arch/arm64/kvm/hyp/nvhe/Makefile has this pattern for exactly the same
> > > problem I suspect.  Maybe that's the right tool in the toolbox?
> > > 
> > > ```
> > > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > > index 8dbf2532a573..27fa72d8fb86 100644
> > > --- a/arch/riscv/kernel/vdso/Makefile
> > > +++ b/arch/riscv/kernel/vdso/Makefile
> > > @@ -27,7 +27,7 @@ asflags-y += -DVDSO_CFI=1
> > >  endif
> > > 
> > >  # Files to link into the vdso
> > > -obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
> > > +obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o ../../lib/memset.o
> > > 
> > >  ifdef CONFIG_VDSO_GETRANDOM
> > >  obj-vdso += vgetrandom-chacha.o
> > > ```
> > > Fixes `make -skj"$(nproc)" ARCH=riscv LLVM=1 mrproper allmodconfig
> > > vdso_prepare` for me, as per
> > 
> > For the record, this also happens with the 32-bit PowerPC vDSO, as I
> > noted in the commit message of v2. I should update the issue too, I only
> > realized this after wider testing. So if this is the route we want to
> > go, we would need a memset() for that vDSO as well.
> > 
> > > https://github.com/ClangBuiltLinux/linux/issues/2183
> > > (Nathan, don't forget to link to that in the commit message)
> > 
> > Yes, thanks, I have added it for v3.
> > 
> > > I'm surprised I didn't need -fno-semantic-interposition (or one of the
> > > related flags... -fvisibility=hidden)
> > > 
> > > If we want to get better, (if performance matters here and we want to
> > > trade source+build system complexity for absolute code perf) I would
> > > start with that, then worry about clawing back performance via things
> > > like:
> > > - __builtin_memset_inline
> > > - -finline-stringops=memset
> > > - -ffunction-sections+-Wl,--gc-sections to dead code eliminate the out
> > > of line copy of memset, though IIRC there's potential for wasted space
> > > due to alignment requirements (maybe the out of line copy of memset is
> > > smaller...idk)
> > 
> > Yeah, I guess it is ultimately up to the maintainers what route they
> > prefer.
> 
> I think linking in an out-of-line memset.o is not appealing. This isn't
> a general library or something. So let's just go with your v2 approach,
> fixed up in the ways we mentioned.

Nathan, would this be okay with you?
https://git.zx2c4.com/linux-rng/commit/?id=d216701724b7d8209ff42150658ad5c712bdb503
