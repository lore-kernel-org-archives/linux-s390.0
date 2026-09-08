Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BE5581E5;
	Tue,  8 Sep 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875797; cv=none; b=l5vBVMFuK8ZYhADbsM/BiS1RyimLA/j6Zi/nrVrlutttpE3DlaE95wyfSnfblBIk+pg6v4mRxImGJYaRkujS7pnOkUWd+VfqR773KnJtGcsWU78PosC7GEXqqNjxqXUbjo6HyHZgU0JDKbaayyfvEUeQCvJLSOYjHQVBRyZcr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875797; c=relaxed/simple;
	bh=3GhasZEbt8NBvKiXdHgvjM+VMuOEV7WWgVkvCeM6fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgSpcUim54QXG6Bx1PcJRC4vSDSuKR1lBouBIBrSyiq1Tx4yJXPAYHSiDcDKhKOr8H9G7hwjILUIGOWpXTyCys/4i7wP7xK7Tb9PxqeXFuFxmhEx4lJmlyIygTIaMNCblbqy0MFCTKfyNDdlp12zjAYEEsc0JlwcUuux6rT/EZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ckTRe3AP reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ckTRe3AP"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD33440E01E1;
	Tue,  8 Sep 2026 13:56:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7AQVUOgIjxGA; Tue,  8 Sep 2026 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788875778; bh=kXNkLBcr+MG7BHJqeeHaLokvBdBeeMHnjUE3stY0luk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckTRe3APsxV8zd3aHLDbRKowGC2zSniJAA24Kt5+oY7o0ve9PWKF5qzBPopM3MPzG
	 nCHC8z+inSEFr65KsTY7v0y5Me+yxQN+yYGf0Kea05MstOcF30c+7CTOeWLs4WHaen
	 saUDiKtXKzodmoUWrICUVq2iX5AeQy5l0ohpxjUzLl6c9IHXEVVo3SiU927VoT+/6x
	 qAopQ5XI0Z3df6psiX43eUXujqenUV0SMfLOjXQ7iu+N/pdMO135Hu0uia3OiezG6F
	 3BQXZyL9gEAYT0T8MlWNODVy867kXqXWDznQLaaS3hnYUtTHX7ZPkioJ+C661mIH9b
	 ic/QzGZYvbQCTW7sP6SYp95dpERxWEEjf4GNtlzOSWbxOHiLn0RHmVPtvW4BYJoWvh
	 c/tOCDFqYnvh5YFTyN9GfAK6l94m91l6GS5sSYV+wFiupKKyMLGl8CaK+9cb3cZoI4
	 mlWKwNA2s4fKHKSubYMAlCtd8a2o6fUxhWShY9aLdMFEqUQwrJenLRWIpJ0ag8aYsb
	 W3QKYQQmTp4Jjf5zXuVHiRwAluE432BXUeWt7qI0luGw7gKHWwuLMGnQL1MEHEyLdb
	 ONqhiiI6fb2L7uOxLcZK3mU619FPi/FBNNiTWRBnrCXpLvKVraEnxfnW1PUmkkdke8
	 34u7wSXUJmbuZU/MSeUYx8hM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 253D640E016C;
	Tue,  8 Sep 2026 13:55:16 +0000 (UTC)
Date: Tue, 8 Sep 2026 06:55:13 -0700
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
Message-ID: <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 08:33:36AM +0200, Thomas Wei=C3=9Fschuh wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>=20
> Move them from the kernel-private architecture-specific header to the U=
API.

Why UAPI?

Why not include/linux/ ?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
