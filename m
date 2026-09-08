Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF61397923;
	Tue,  8 Sep 2026 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852955; cv=none; b=Wk1U6rMpr2OqAQlAYj2OxvQ/exBAdJCfFShpLqLUwPDAhPI6as/IAFedaMHJuwMBjBnAzHW2lnTYfs4eAK/RrSvWAl5SHXmpRfqCbyuxnDQ7JHNLoLpox1xjrObLXVwLwsgsxrdfFgxJkdUwvrY2zUw+fXrZMybJTWtlL72aJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852955; c=relaxed/simple;
	bh=Yas4x71zv2CucLgcDzjxZfSt/KtDAAqnSBc20UX9Q9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYAOag9HzfFiWW2VViPsfL/QHcTmEN0Vm7R/y0mdVxR2wnV1tcSCljKAB3izTDPNHFd1TxwzzJrnxA2s4CsgrzvKinHi1ZUK5SzLdrp3dkB6VvpQsf0eAi4+1vaoZU0zEKdRvvz/p4d3gtopD61rUvFkUbAbNIxLhfGo4DqNpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sF40x1Tn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4GN1Dhf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sF40x1Tn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4GN1Dhf"
Date: Tue, 8 Sep 2026 09:35:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=sF40x1TnpsNhyt0sI38rIHaeAvtNg/EM8w3EtHzsFSvvVwHHMnTzo9ND4gwdFmZKWgwiQI
	zIUqZO38xf+hqbFqpxnJEf22XYPf5rduERB4k6rIc5UkCj8/unJYgFDyl/VlE7G+EFDI03
	CNmgd/Vj1Q3c/q3Ydr3Q/DKOj3v431wlaOso4rjeyTahr+hMGIpBnsAkCalXgeDSgVmwoT
	fSwtBw7bhzCeC4FkKyNmCXzfRLo7mT4mBMZCZPU/i5SaXQchJvrd+z5JqASF5WVbgiH5G4
	it4ju8Bz/fYLxG5O3MBiu0Nd1yKjfxaEDd33C3bFc0Qo3/mwB0s4uDaabhB7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=t4GN1DhfMH6AgNQoFSHKMaImcdOBofdEStAoUz2uy11ao2hSCXVnSiB6G9+q7fkA3MPgYT
	C9GJghb2CAl+FqDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908071911.GU4120091@noisy.programming.kicks-ass.net>

On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > All vDSO code needs to be completely position independent. Symbol
> > references are marked as hidden so the compiler emits PC-relative
> > relocations. However there are cases where the compiler may still
> > emit absolute relocations, as they are valid in regular PIC DSO code.
> > These would be resolved by the linker and will break at runtime.
> > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > Work around invalid absolute relocations from GCC")
> > 
> > Introduce a tool to check for absolute relocations during the build,
> > as the current inline-shell logic is not expressive enough.
> > The check is done on the object files as the relocations will not exist
> > anymore in the final DSO. As there is no extension point for the
> > compilation of each object file, perform the validation in vdso_check.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  Makefile                    |  19 ++
> >  lib/vdso/Kconfig            |   5 +
> >  lib/vdso/Makefile           |   2 +
> >  lib/vdso/Makefile.include   |  14 ++
> >  lib/vdso/check/.gitignore   |   3 +
> >  lib/vdso/check/Makefile     |  34 +++
> >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> >  8 files changed, 729 insertions(+)
> 
> Urgh, does this mean I have to have rust installed just to build a
> kernel now?

No.

If you don't have rust installed the build will instead use the existing shell
script for a less thorough check. We only need one build machine at some point
to have rust installed to report issues and this check to be useful.


Thomas
