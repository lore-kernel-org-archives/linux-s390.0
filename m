Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5999566C58;
	Wed,  9 Sep 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965446; cv=none; b=jxRbINvVjb8P0Mil68to4/rhm681uN1+F2+AhTWCqr27GdN+ZC6LOLR0+1IcmG9Ifhw2IpeSEsGitv1gEIfDt/Mn8Xlt/hvjqlnuLjnSI4AX9hJAg11TkUpez3yr9tPsL8erHZqCZYss+fr5pama1HECpZWogm3qCznEyF0B+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965446; c=relaxed/simple;
	bh=t6FVs61JioooI1FKzSdD8k2cGUyImh2GzcX9te2ZX9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9mkGlsJ1Uqb62T2frqSdOOL6LGBhYC0DxR0qQEeMalEoUxQe8CF4BxSlqe7auEIE6EnJYnffzGAY/IROuZtLn5MPXwZyL9RNQTrjgOKgKQcxByF/UA5vJsRSX64g+MZQgMfIGcIWyEtZTkupycnNBYllT0A9xJEPMDFxtX991Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bEJ/8Uz5 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bEJ/8Uz5"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D530E40E01ED;
	Wed,  9 Sep 2026 14:50:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p3kpomh8L402; Wed,  9 Sep 2026 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788965436; bh=mhGQ4FEjJypHCScKuxG2hVB2Cr7EilB+iYsfNtWHQqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEJ/8Uz5UTuL3M3aJaZ+2GA6fHLcktGtyqNCvODV6vja9c5ofeLAw9r5500Ldr25H
	 Qb1xaJZtybSTYQEAFER7kNXSbt0/1P3vev75HfTrRPKQqXMq8vzzF9d2raqW7yK4Jp
	 bgsBr5p7kVDTB9kpcsKXnfA2oZFXqMgcW2v064dS00SqLJQ4fh+FTTqMfbeE6ylt6W
	 xeBJaGn3HYw68e4HreCBSdk1xrJVqweEaR0hTlsp9ViWUcauqO5nf8umq0Nui9YTkV
	 GKJQEUzDD6o8zodTcnqrpM4CPq6NuYAB1O13ttqJjGS36Z2uCbR6KyqXxKlafFr7b1
	 7ctU5lA269NQ8wM09FSxrsRFiMlY4SvpNIR6FjrwsJi2GrkgzDphwoLgFgtc6VBlX6
	 sZEWd8ZjXFr7d4kNRkfTSiYGwhdgPhGoqgJg8tB+bIw14Mw3cuHC0Q9xIa6xFUY5jp
	 VWgJEsz5szwqtlotZDwBq7NU64xcPZ4oXFJ2qKu7h8QPHqSvB8mLBIMN7DQzBr9yKh
	 3B1hlQLHULtH82PyIzJVS+TDy4H+TQutkiZUSuErREjAkJcHO33xV54eAiErgaiPkg
	 dq6isTjw+AUWrupRkPovwFJvsVt6Naubw0PkaGCiRjPqR2r5eGwo9f4RLg22qsPqFP
	 0lcuEVktIzws0Z/idTv4tvxk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D243A40E01E1;
	Wed,  9 Sep 2026 14:49:33 +0000 (UTC)
Date: Wed, 9 Sep 2026 07:49:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-mm@kvack.org,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Message-ID: <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
 <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 07:59:51AM +0200, Thomas Wei=C3=9Fschuh wrote:
> These names and numbers are defined by the architectures' ELF specifica=
tions.
> They are already cast in stone. For example see Table 4.9 of [0].
> Changing them would break compilers, linkers, loaders and more or less =
every
> existing ELF binary.

So?

Your goal is to provide them to tools/. You want to provide them to
*everything*. See the discrepance here?

> That is the documentation for the tools UAPI headers.

Did you even read that file?

"Why we want a copy of kernel headers in tools?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.
..."

Just read the damn thing before you reply.

> Also we already have other, closely related, ELF constants in the UAPI,
> see {,tools/}include/uapi/linux/elf{,-em}.h.

Srsly?!?

You moved them there:

commit 626fd35278295fbb21f2da331cd8028e9738d965
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Date:   Wed Feb 26 12:44:46 2025 +0100

    tools/include: Add uapi/linux/elf.h
   =20
    It will be used by the vDSO selftests.


Looking at the rest, it looks like some elf bits got exported, you added =
some
more and that ship has sailed. I still think us providing headers is
completely unnecessary and it will come to cause conflicts eventually but=
 hey,
not my problem.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
