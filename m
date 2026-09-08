Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62D5592EF;
	Tue,  8 Sep 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880443; cv=none; b=gux7VjLlrdhOr/f8tZWDBHvQjgAvjN3tpOfjsUEOu3QkqJhgCF4XedzA/60zzuxlfNlWw63cyaPd1pV8QAPMT/Km/Nbf9NtYJbvuydWy78KIvtj5BUspMFG01vrbvT4NbU0Iu48OdlNF6XHZvqv0eJ7VXf3VEVCR0p0iGtKl/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880443; c=relaxed/simple;
	bh=9VnbqKcFo0PdV/F50ouF++HgJygmdMQ5dTr+q9TdSv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdip1vlPIOM2PqJXL9+Oe8Ka25D5E/TITvZC2uOon45DijyEPp6Fh+4ylESwL81rUF/1PjZzFOrEUVZ8+29OwVw9N2tQ/WU031LOWGEovCRyi5VpJP2LgsFsrRysMlIgkj7gvFUgifBZwAaaiXTCWR/8BMJ2e9D3WTMN3Mi4/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fAETnApx reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fAETnApx"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF2E640E01DD;
	Tue,  8 Sep 2026 15:13:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 90bGYtLVFUMy; Tue,  8 Sep 2026 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788880423; bh=SihVXpN4VvNY3Mg5IOkHy8UfEsHqRfkcnelNTeVhEJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAETnApxBEtfPuqHFKCgIL29nHx0Z2YHgAygdIUM8hU/Mz33/kA4ZUBeN/gRjrvau
	 vtDllihc6pYSe5SXQwgoqpNhfk4/08/8KMfUsCAU9thasCFYYPKC5Y/pV7Y6XU69vH
	 LNwlFlG04npY9qQKxVsZcrZnpWC37yTWxuzhzHRm5KpwYfkHvzNEQeiGPcvB58aLNL
	 CiYr2yyCrB3Kpf/DVc891YwOW/34b2QLG1yPFPyiPhCi535fKHZgiFGNQiM2V+7vT2
	 gPcZgp3ofWVjQmcjoKAe195uX42B3clf9ibePNVbJKWUY1oARNBH9aqSnI0FgzmH5W
	 h3dWuWkymclGp3MUg9haChNnjvPBl3Zfv+FDejA3/AFf/CVXHWsWO5KDUQ2zEgeqt/
	 YAh14BnniVfR4yGoNbbKeldMZUsNF3icLMOF+CXHFJzyhU2PGxTQ2922hXMjHxMdeL
	 Z7VOvQUlIKK4Twu3A1MK/eNhNVBp3Aq4OXXBOciVJLy8/PcJIx0toX/zZ4lcn1jfV9
	 ErcQYDZ5WCkd1WmQQESUO71elKnVOkkPTWwEHl1ZBofjxaMBHmYZWTaJGuyt7QqChy
	 44ZU/2M46IVY51m5w2KmjWEiICeA6W5JNXmeJ3Nh9U8UDaWIWWakyv4XQKa/cqNpso
	 4+S63J9RdOKwhC2R/OGeJJio=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8AE40E016C;
	Tue,  8 Sep 2026 15:12:41 +0000 (UTC)
Date: Tue, 8 Sep 2026 08:12:38 -0700
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
Message-ID: <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 04:26:00PM +0200, Thomas Wei=C3=9Fschuh wrote:
> The existing, generic ELF definitions are there.
> The ELF stuff in include/linux/ is highly specific to Linux.

And putting them in UAPI casts them in stone. I wouldn't want to maintain=
 them
forever if not necessary.

> Also later in the patchset I want to expose the definitions to the
> tools/ build. Exposing generic UAPI definitions to tools/ is a much
> easier sell than include/linux/.

tools/ *copies* kernel headers on a "they're needed" basis. No need to pu=
t
anything in UAPI for that.

It's even written down: tools/include/uapi/README

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
