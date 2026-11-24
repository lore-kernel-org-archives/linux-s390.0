Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531556;
	b=Wmw3lTAslQc7HhlsjgI7OLsNz6DTbjBB2UqDZ1zUikg0I48EstgaH7DXjBLMGMlT/R3u
	 lEU4oqA3Po+2yjr/YqeeDNMe+6dWltB8L0ekNLwDzDQbNbUyuEBGZhF7lEEdZL+KTbh52
	 KBUCF5UDasLcz+V5+4bz1X+6vpvXRm3UCAtzSqF6BN7B4DN7tqqRU9ThKru7BbLvJSF0l
	 gFaoDcDJ1SR+Gr8crymw7+T3zcA/z4V4iGXTgFRznBnUJD74VU5Aj/QHUIUQIWmqe1fN8
	 SfMwlGzV3M99AnWwL4rj/zXUL2kAF8tEZqZL7J465pVL7yRV4sA4ijcaoZjptgdD//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531556;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=PQPLtENkICRsya/wldqN4QFqx2tHDnG58pdrhZSAsk4=;
	b=ScFOwQTBnRT45c1k6to3JAQRdQM0XuoPTo4Db9Z/K/bBKNBhNtl18kkLOJ2C/bfLkvo4
	 kleUfI0fezMOWP5yLv4a/1w05XL8/yr+ps9BkPbX3oC92U27j5YWuXskHEjSzQAaQ8RNV
	 ofI/GyHXMzFJLtN0x6p/+paPtNexPYg5nlL+gosBS8IuWDc4/pRIzmfTjULsdd3UtKJ9Z
	 iX368WPpdDH85CjQAFCNPvlq0xjbm5HRV1n2eO63Tz83Fv9MT+BfoFyEOST7+8jHIE3j5
	 0vHinwyGNZODO1ujrFqjq7ER6ePRw00MO6CCbCPHLgvuXxyGHoXw8RbpzgEIeC76zmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tTEn69Gg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/3Od9jAv";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC198606A31E;
	Tue, 24 Nov 2026 14:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC198606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tTEn69Gg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/3Od9jAv
Date: Tue, 24 Nov 2026 15:45:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795531554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQPLtENkICRsya/wldqN4QFqx2tHDnG58pdrhZSAsk4=;
	b=tTEn69Ggd5O1AMiiVmsQQNdaOTqjJDDdYLlflDKuGjhjFL/gQSfY2I9NFiQO6fLP7zbcsC
	wBLVqGoKfTMXPn74FoHOoS4TMhpYs1rGXQV251w87aqb1UZvPpsY+IazcI3YviwQjfVXO7
	EOPiGIMGZmKYvkcpUCdX7h60CFgHFea0TF/qhae4wfkoaXSMBZ4h26njD9ZbYjRnM7GHV1
	ihIsfN9rYjAghF8bXBcNcWpaMcihiSg4070bow3P9Px7CGcswo4r/xGRkE3wYO8IvpPFpx
	lmY7yyZ9NPf93M8oelEoFArzHfoIC8MMAAUtARoiWQFgq/oXuWoNAo2HxbQe0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795531554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQPLtENkICRsya/wldqN4QFqx2tHDnG58pdrhZSAsk4=;
	b=/3Od9jAvnz4o5peY8lpl50a4JTP+MtAYMfDyacdTmAEhVr9ZKew0yw+rHnnz5TW7KkGRtg
	IgYweoRziAAL8NAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: sashiko-reviews@lists.linux.dev
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
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 01/11] vdso: Add the vdsocheck tool
Message-ID: <20261124152519-f59dca8b-4c72-4102-af10-810dc16ae041@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-1-161e218dd217@linutronix.de>
 <sashiko-outbox-231255@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-231255@kernel.org>

On Tue, Nov 24, 2026 at 01:52:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issues to consider:
> - [Medium] vdso: vdsocheck uses Rust 1.87 APIs breaking 1.85.0 minimum
>   version
> - [Medium] vdso: unchecked slice in get_data_subslice() and SHT_NOBITS
>   slicing
> - [Medium] vdso: missing include/uapi in HOSTBINDGEN_FLAGS and + on
>   host_rustlib
> - [Medium] vdso: validate_linked_dso() rejects SHT_REL/SHT_RELA with
>   R_*_NONE
> - [Low] vdso: missing scripts_basic prerequisite on vdsocheck Makefile
>   target
> - [Low] vdso: vdsocheck main() prints errors to stdout instead of stderr
> --
> 
> commit ba87ba62d5b7688443f8778322978989d53ab4f8
> Author: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> vdso: Add the vdsocheck tool
> 
> This commit adds a Rust host build tool, vdsocheck, along with Kbuild
> rules to validate that vDSO object files and the linked vDSO shared object
> do not contain invalid relocations.
 
> [Severity: Medium]
> In lib/vdso/check/Makefile (lines 18-24), can building bindings.rs fail
> when the host lacks kernel UAPI headers or has an older
> /usr/include/linux/elf-em.h?
> 
> tools/include/uapi/linux/elf.h includes <linux/types.h> (which includes
> <asm-generic/int-ll64.h>) and <linux/elf-em.h>, which reside in
> $(srctree)/include/uapi rather than $(srctree)/tools/include/uapi. Passing
> only -I$(srctree)/tools/include/uapi in HOSTBINDGEN_FLAGS causes bindgen to
> fall back to the host's /usr/include.

For int-ll64.h this is the expected usage.
For elf-em.h I'll add the patch again which copies the header from include/uapi/.

> Also on line 24, the $(call if_changed_dep,host_rustlib) rule for
> $(obj)/libbindings.rlib is missing a leading '+' prefix, so GNU Make closes
> the jobserver file descriptors and rustc emits a jobserver warning that
> fails the build under CONFIG_WERROR=y.

I did not see this warning, but the '+' itself is correct anyways.

The other points are correct and I'll fix them.


Thomas
