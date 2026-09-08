Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B6233941;
	Tue,  8 Sep 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853040; cv=none; b=Qt8qTcOswRH1kKTlo+Zw8sbOUz78FUITEqWbMjuuc435y6GoLKz11L7tKs0TD4+hi9NDke3/ypO8bCTIBIp+3+qdmJMoUpLuDr2bhea4KUgt1YUtrNJfQSl+YMmOgqnxhTlvFWHP5xcN29ZkaqJYSriY0zOoWG9bbyw23dOa7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853040; c=relaxed/simple;
	bh=ZwH/nHQww+E+pAX3LZn0JyEZ+Oi3mONaiQzNpCAvNT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8mV29E6BywE5uk4i0g8ErdhYUUlmw1CZJzj8pcDoeK6Q551WxMHf0eWuAjsE4P2XzA/Uru7EOB1t80kGGmBm4G3cANyk7Of3DmpafPGEbmWsQunEJ5wJfkhFhupOwOmzLpyttPvPKkI6b1eG2CLC5wmYlLu/LaGE1ovKPdEvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=irAwsshP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irAwsshP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dMspgRwQUUIexqKss7dqowtOmwD0tLbRBkFb+1ouQnY=; b=irAwsshPXpU7Uf/rfFaj3uWs6G
	difPdlK64/emyFJJjlL7wNOeoAd6Y+U30iaYxFlQNgUaXhJ5XP9GQvgT7SeejFL749VvbdmXzNQmr
	ysoKC7HRo3DXe9AyxTg6XU4ih3jJvnovv2Ujltj+xakHIL0+9ST9dekY+kWUCq6mECTuqGA167fg+
	YqFWds1pqUcKbMJUd2jIJjqcUYt3toc+D0q3aR2UwfeZbWbAc5JAxTcsD0VD8CvN28YZRwquKZu0g
	pKwTeSbCwX4MUVnlh4QxgKngIIgLaxab029w2jsxL2wYaE+8OY428gXbHH21x+RnEEnFMu/t4r9jb
	gZmtLwfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3qOC-0000000H406-301R;
	Tue, 08 Sep 2026 07:37:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0348300400; Tue, 08 Sep 2026 09:37:07 +0200 (CEST)
Date: Tue, 8 Sep 2026 09:37:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
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
	Borislav Petkov <bp@alien8.de>,
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
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908073707.GV4120091@noisy.programming.kicks-ass.net>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
 <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>

On Tue, Sep 08, 2026 at 09:35:46AM +0200, Thomas Weiﬂschuh wrote:
> On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > > All vDSO code needs to be completely position independent. Symbol
> > > references are marked as hidden so the compiler emits PC-relative
> > > relocations. However there are cases where the compiler may still
> > > emit absolute relocations, as they are valid in regular PIC DSO code.
> > > These would be resolved by the linker and will break at runtime.
> > > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > > Work around invalid absolute relocations from GCC")
> > > 
> > > Introduce a tool to check for absolute relocations during the build,
> > > as the current inline-shell logic is not expressive enough.
> > > The check is done on the object files as the relocations will not exist
> > > anymore in the final DSO. As there is no extension point for the
> > > compilation of each object file, perform the validation in vdso_check.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  Makefile                    |  19 ++
> > >  lib/vdso/Kconfig            |   5 +
> > >  lib/vdso/Makefile           |   2 +
> > >  lib/vdso/Makefile.include   |  14 ++
> > >  lib/vdso/check/.gitignore   |   3 +
> > >  lib/vdso/check/Makefile     |  34 +++
> > >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> > >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> > >  8 files changed, 729 insertions(+)
> > 
> > Urgh, does this mean I have to have rust installed just to build a
> > kernel now?
> 
> No.
> 
> If you don't have rust installed the build will instead use the existing shell
> script for a less thorough check. We only need one build machine at some point
> to have rust installed to report issues and this check to be useful.

Ah, *phew*. Thanks!
