Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215863DFC8E;
	Fri, 27 Mar 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607882; cv=none; b=nPoJ0DpZyvc3A4+hwKDnERGsHocU5fhEwI7kT5He2YmpxZtE4MAXErGtdwq0P7jgZQ6poExUwDQSLeqiv70My/kahahb9uamjtybdjGcvFrGNo1Kvl61xhoK8ZLK1zBU3QO/BqPWHuvSJQhqnUzMUVtXyRcDOh3qPBVbmPOohD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607882; c=relaxed/simple;
	bh=fO1n3N31Hq1DYtmMY0Uiqq1O7a3QRkcXqeW2ikYyR7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=crpUK41WuIMJvIgkwCvbIrNi9AptEGUS2i8tAWe5CT0SWA2hEYJECUo4q3NMP1ZNY2h9GVYYJbOQjFak6U28XQ45kg77CuMe/9ZBhI7ILFkpP5bElHq5OhHCzzRv8RxURCDMogNaZkj1Sfe/Qd05gLvt3cUJ1eUYqZX2rfwgJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLRouDc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLRouDc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F50C2BC87;
	Fri, 27 Mar 2026 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774607881;
	bh=fO1n3N31Hq1DYtmMY0Uiqq1O7a3QRkcXqeW2ikYyR7Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sLRouDc8OnBrB9DCQKOV/4RRVw0xGp/6Lfe1ne2ALxqo62FaIcr3E0NebD4qKHf6G
	 TKMbDdz4x4lG3kxC8bTaAMEK1cN3SIS/VGDZ7RrCIqk7xtYbUbfctzzPY+2Y0wSS5T
	 CxgHGgyi+EmeL8UomAzr90BCQV4qXcCtqpcKqa3G7Yes7xsh3wV9I+LnWQ2rPqrPmZ
	 si2QDPvpy7XejePafp2ibm2mOJ2NoeRAgSIlYkwkoUY8WIjLDIyPwfbaLVbozRjaoP
	 2+pcMFw3oT0h8E80PZ8ZOYrOe3jrSV+/EQhVaGzl4P34YJt+caqIlt0k8WD4a+6gei
	 jT6BbqxtLE/OA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98E72F4007A;
	Fri, 27 Mar 2026 06:38:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 06:38:00 -0400
X-ME-Sender: <xms:CF7GaaumzkrefSLsOtKZoMVl67zidMRMThiPpTHkEm6-09DZBh_osQ>
    <xme:CF7GaaRs7U78TIhoCiU61NzxtQeUQY2YIdrt2DhZpMmyMdXF6iF6PPny3od3uqXMj
    eAfEa918UtfUI4H9e5y_NHlnrcGhQ6qCidAB6wHNDKFuYRyLndSsrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetgedvtddttdeuffegvdefgffgteeiueejuefhjefhvdekkeelkeduteej
    tdetheenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqdeffedvudeigeduhedqrghrug
    gspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgurdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrrghi
    ugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltd
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgrrhgtlhhinhhugies
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnh
    drnhgrmhgvpdhrtghpthhtohepjhgrshhonhesiiigvdgtgedrtghomhdprhgtphhtthho
    pehhphgrseiihihtohhrrdgtohhm
X-ME-Proxy: <xmx:CF7GacBuy6-JNw5sWyd4lAuwh1v09L5WrAJ2XIWH8gqEH3aU7IUsEQ>
    <xmx:CF7GaYjFB62D0LfV9UiDOaxmkdfgIIjxpOarL_pvEzPgQcv3w3XXbQ>
    <xmx:CF7GaWPZZdkuJlHm1UTvLGarQ5h0Rp6PzfPS8EaOuo5G7RujtFtY8w>
    <xmx:CF7GaQ9_qDOMt-ju3hTl9y4A4YONfzeyazaSt4RQPMuMAULoo22U0w>
    <xmx:CF7GaffjfAdZBYk701P5e_kded1Z6brTIns7S3sXSfk5Z6jVLVMT5YjG>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D4BB700065; Fri, 27 Mar 2026 06:38:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUjF8VgfYQMk
Date: Fri, 27 Mar 2026 11:37:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Magnus Lindholm" <linmag7@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Song Liu" <song@kernel.org>, "Yu Kuai" <yukuai@fnnas.com>,
 "Li Nan" <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Message-Id: <b5edd377-423f-4837-a622-ad78654811c4@app.fastmail.com>
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
Subject: Re: cleanup the RAID5 XOR library v4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 27 Mar 2026, at 07:16, Christoph Hellwig wrote:
> Hi all,
>
> the XOR library used for the RAID5 parity is a bit of a mess right now.
> The main file sits in crypto/ despite not being cryptography and not
> using the crypto API, with the generic implementations sitting in
> include/asm-generic and the arch implementations sitting in an asm/
> header in theory.  The latter doesn't work for many cases, so
> architectures often build the code directly into the core kernel, or
> create another module for the architecture code.
>
> Changes this to a single module in lib/ that also contains the
> architecture optimizations, similar to the library work Eric Biggers
> has done for the CRC and crypto libraries later.  After that it changes
> to better calling conventions that allow for smarter architecture
> implementations (although none is contained here yet), and uses
> static_call to avoid indirection function call overhead.
>
> A git tree is also available here:
>
>     git://git.infradead.org/users/hch/misc.git xor-improvements
>
> Gitweb:
>
>     
> https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements
>
> Changes since v3:
>  - switch away from lockdep_assert_preemption_enabled() again
>  - fix a @ reference in a kerneldoc comment.
>  - build the arm4regs implementation also without kernel-mode neon
>    support
>  - fix a pre-existing issue about mismatched attributes on arm64's
>    xor_block_inner_neon
>  - reject 0-sized xor request and adjust the kunit test case to not
>    generate them
>
> Changes since v2:
>  - drop use of CONFIG_KERNEL_MODE_NEON for arm64
>  - drop the new __limit_random_u32_below for the unit test
>  - require 64-bit alignment because sparc64 requires it
>  - use DEFINE_STATIC_CALL_NULL to avoid exposing a specific xor_gen
>    routine
>  - keep CONFIG_XOR_BLOCKS_ARCH self-contained in lib/raid/
>  - don't select library option from kunit test and add a .kunitconfig
>    instead
>  - fix the module description for the kunit test
>  - add a case where buffers are at the end of the allocation in the kunit test
>  - use separate src/dst alignment in the kunit test
>  - fix and improve the kunit assert message
>
> Changes since v1:
>  - use lockdep_assert_preemption_enabled()
>  - improve the commit message for the initial um xor.h cleanup
>  - further clean up the um arch specific header
>  - add SPDX identifier to the new build system files
>  - use bool for xor_forced
>  - fix an incorrect printk level conversion from warn to info
>  - include xor_impl.h in xor-neon.c
>  - remove unused exports for riscv
>  - simply move the sparc code instead of splititng it
>  - simplify the makefile for the x86-specific implementations
>  - remove stray references to xor_blocks in crypto/async_tx
>  - rework __DO_XOR_BLOCKS to avoid (theoretical) out of bounds references
>  - improve the kerneldoc API documentration for xor_gen()
>  - spell the name of the srcs argument to xor_gen correctly in xor.h
>  - add a kunit test, and a new random helper for it.
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

As discussed, arm64 and ARM can share the NEON intrinsics implementation, which would allow for a bit of cleanup as well. I'll follow up with some patches based on this series.

