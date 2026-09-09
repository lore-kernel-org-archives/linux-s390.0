Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1334389C;
	Wed,  9 Sep 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933595; cv=none; b=j0biSg/JioXPGR7W2HBJsTYXlNKmiDP1mBE1opz05DjocYI2Vf8iEcaytatjyQUiMQI2lUIanxl5eSiLXDAlBphkZ9UDusFCmugphhJaUVUOYFQNTgDF1RN5Bc/18shp+xeNfFgrl2rBNrLP608M9f2IiHfFN+tTQy61a3hrFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933595; c=relaxed/simple;
	bh=3Qbj6r+ei/gkmMYffeb/443xB3qDlB3pxJCAAWsXO50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg9VFzZLSKXFo8oMbAvnje5UyPGnvEeMk52EgoMRgyKE43kxTgvb2aD7ZCXkkybBoQ4kSfLkhxLoNU9ye/b+k7kkn0Cvmo9M+l8BtlooC4dcxaYqu0qtEoP3RLhNHYedP8kMR6CTDEiuYhASaozdibziLj1rD7GCvOdslJhurs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMEIGvTJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VonGHAfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMEIGvTJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VonGHAfq"
Date: Wed, 9 Sep 2026 07:59:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=CMEIGvTJ+RpDUpaQX63YOGpF9L1xMeGi9s7P9EumAFOOXvZhDn04zc5cDcznjmEwFWcMKn
	aV3mh9HSsioEvvDCuqmuPhxAz0EDxVz5FVZWfmObWfXRSybwQ1ZxDVQ4z0tJ5bj8HKl6QH
	2LpCD9FeG6rAkLbfiSKloV9FiP1FFipkSzlhBo3Zplknr1ofEEQBBTOoi2c+qR7w1FFuf1
	oLRZ1Ohqd/R7qrq1gOVWGdmCLZlvGzRsKpGh6crrwVT4V1hNIEeMZP96qZ+DAKQJ/Yh6qb
	V/ykB9y+Wc32WJFwaNxXjYic0iDsUwgblz+2Yps3KMILiE5BRXmRKCLGA9EuDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=VonGHAfqnQoueeh6Hl3Lomphhnqa2H/lUyc5Ke65gvgt5gNmjnE70KZBPhdx4hgXdpJF0U
	tvpV+04d2I30q5AQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Message-ID: <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>

On Tue, Sep 08, 2026 at 08:12:38AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 04:26:00PM +0200, Thomas Weißschuh wrote:
> > The existing, generic ELF definitions are there.
> > The ELF stuff in include/linux/ is highly specific to Linux.
> 
> And putting them in UAPI casts them in stone. I wouldn't want to maintain them
> forever if not necessary.

These names and numbers are defined by the architectures' ELF specifications.
They are already cast in stone. For example see Table 4.9 of [0].
Changing them would break compilers, linkers, loaders and more or less every
existing ELF binary.

> > Also later in the patchset I want to expose the definitions to the
> > tools/ build. Exposing generic UAPI definitions to tools/ is a much
> > easier sell than include/linux/.
> 
> tools/ *copies* kernel headers on a "they're needed" basis. No need to put
> anything in UAPI for that.
> 
> It's even written down: tools/include/uapi/README

That is the documentation for the tools UAPI headers.

Also we already have other, closely related, ELF constants in the UAPI,
see {,tools/}include/uapi/linux/elf{,-em}.h.

[0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build


Thomas
