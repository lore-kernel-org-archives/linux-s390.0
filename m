Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50A3C3F44;
	Wed,  9 Sep 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983316; cv=none; b=fn4qP8tCBOmbNn/smHlbg+crTTo0NDCajPY0vdQlmutsCui/NI6RWt0dt3dZNeFP68ZsAFDB/IqSP4Ya9of2uwmE74uZPbOe1pVnKpFZWytz4ZdhfAFghrLciKtgYK5AjX1ghcUWDoO+umS/O31v0rbYkLctiKcw3dttDQwlZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983316; c=relaxed/simple;
	bh=6oUQ+t2HfnNmMn8E7DOjKEm67dWjSNq8owP113wq1z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPyldlczzeOZ3OFb6f8egajkbcb7OtmN3VriEnUW9BdLL1DadFTZ6llywyVYigNFOx9U3kioXqG83L2LggZoU21DM3SLX0GkYA83DzRVlvHPImbiyxMocmkrrqWjJQvdq4oGETp3A7RNASVZRL3caHDeCJlvobyCx+jSxgGWMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dwPEQtMe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dwPEQtMe"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 66BA040E020D;
	Wed,  9 Sep 2026 19:48:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xTz0R741EH0p; Wed,  9 Sep 2026 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788983306; bh=J47hfMemV3x17DwbT77P3iNi200v7sArNBFyj4FIEqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwPEQtMeNA/0X4YLMHgzSgsrJEReG+/8XquiXTEMnDnzYNtgPhOSI1ZuSGGmf+uhU
	 V5oLCoI78r3zgomqpkBhYGGK+og2znQrV4khKuBGPQqxLpck4AnonixUBFFT+OQ9pO
	 XoUFWUpeutEqUWw6qWZlF4MSezuaZDbfmEkEMesoxESuMOiVSVBIpvn/lv+oZivGlF
	 NbJK5pOApwMB2U2u72e0KDAnjAnnVYBqW7hqQCjgkPVGWIyW67likuKOr8KL2iCigy
	 wfxOcixBxel6j9y0nGeCklkkuo9SS7BzFZrMmfwjY0x8ZNHxCfzFe8nm3kMfbW2SkQ
	 hVt6NGm6loU4cNhNTVlWkweLsqiDVWKEfmcR69gNzENXWQF+DAqzhl1dooy8yRdyQ8
	 hzYMVbv7DEaFBzo345o2SdVnqq8Hbvr6zEs3Jz+soHKZ00hNuarCPD8kKht9ZWHhDX
	 K6qLog8avAPiAmQEstoo2bUscQYMRoJj1G/FpwnavifIGACdSvVBx3KQXFGuPZFI6C
	 LW+eR2FIosDuuKNbgs+V1Q5Aiz3ngAXwHI3OctVEHffGJL4rAUmbrTcA7D2mTokDP5
	 cDqR90QAouoVLFeoaPRexpBIoBjUfItvei9H8egAwCVgnmg67MgfJgP2vnIu6Np7cO
	 rVr0gT+x4+ZZPc8QFps0Hbqg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0329240E01ED;
	Wed,  9 Sep 2026 19:47:23 +0000 (UTC)
Date: Wed, 9 Sep 2026 12:47:20 -0700
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <20260909194720.GCaqG3yPjDmwKikdIQ@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
 <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
 <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
 <F9786718-8378-443D-A21E-77E057B62BB2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F9786718-8378-443D-A21E-77E057B62BB2@zytor.com>

On Wed, Sep 09, 2026 at 12:27:30PM -0700, H. Peter Anvin wrote:
> I do believe there are *some* headers that would be reasonably to export to
> tools/ beyond what it is in uapi; a major reason for that is that the tools
> are suffering from a crazy level of internal inconsistency right now. 

Well, as long as it stays "internal" I don't mind.

What I do mind is this unnecessary and senseless exposure of headers.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
