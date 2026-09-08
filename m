Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E53955F1;
	Tue,  8 Sep 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877583; cv=none; b=J8Gd0HwC1FJcmseUK+K1eUsdF31os7MOab8Pk4RvYRs+B0U4pJ6By24a6kNtV7vrcthIcSDtBhiuOC9xVEUPEGJs+Rn7xK+Y6MplbxWJCUZD80Kob7ChUEwPxK5E7XcfP8TDd35d3kS1GZ8xuneM+OdUL6CXwahUaJ6tM/N8Xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877583; c=relaxed/simple;
	bh=5Mv42E8KfV+o7sMkeP3depUAOidAkVxElMYKgS2D8nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVc9Mh7jtZR5cQpoXDX0FvhmQKtMjWJDL15zp2tHrQrligAw4a6WUWYh/EtVUR7Kwv1l9N61TiO0K3pfrbapyPejzQe5WfSgV9qObfsGGS+QpBOXlyUhmVGc4wxSFarY3rSoL2iUIwvzVavrMqMdwH+/yR/2s8GksWD1cr6yyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ibCJ1vTa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dujpHxA7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ibCJ1vTa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dujpHxA7"
Date: Tue, 8 Sep 2026 16:26:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788877566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bG7xzyOLgkq/hT1vQoL2+37rRIngeN99Zi6O3p/t1Q=;
	b=ibCJ1vTaf2PfeTeGGS4CPdeCQlmt6p7aLY7mIyests6CYT2a6E4Mjbx9HP5VcqSFIGIDN5
	lQzNq4LeidtkfT+EysNyxDj3JNRd+SkiSObbBLZntgveQTRfZuO3v/L3jsJBVUb2BH8YCM
	7vKdLixe7hXeDeAfmTR73MLoheT6qddEqn0zSpdo08XfzCFSXasPoLv5PXY5oZ4uUtuuhQ
	ue9dInv7mMssJZ5SEhI8zG40m/o1XMobx0JA0bqLkrd6i/I6QO8W9g5ozGh5HmdlKJSK+H
	nBg3aR8ypjomfwqNmYevI/XWRU18YkOzSNQOVFvzM7BNe1wvopfv0uHl4KPu0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788877566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bG7xzyOLgkq/hT1vQoL2+37rRIngeN99Zi6O3p/t1Q=;
	b=dujpHxA7PKpeJCyeZiOagFVHrYS6MiqrupOYGFJ0EP4mlmR+jdnMRKg1XsL53yLYA37pen
	ASTs5tXfWZYBIDDw==
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
Message-ID: <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>

On Tue, Sep 08, 2026 at 06:55:13AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 08:33:36AM +0200, Thomas Weißschuh wrote:
> > These constants are useful for cross-platform userspace, for example to
> > process ELF files during kernel cross-compilation.
> > 
> > Move them from the kernel-private architecture-specific header to the UAPI.
> 
> Why UAPI?
> 
> Why not include/linux/ ?

The existing, generic ELF definitions are there.
The ELF stuff in include/linux/ is highly specific to Linux.

Also later in the patchset I want to expose the definitions to the
tools/ build. Exposing generic UAPI definitions to tools/ is a much
easier sell than include/linux/.


Thomas
