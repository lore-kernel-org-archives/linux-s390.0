Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F73CE481
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599945; cv=none; b=FW+/DIko+z8FjjI3CxzScirOWSop9xmrtlH1PltdUAYnR9WegCSbVP87vqfqpOjW4btan9P2/A+bqCnfyGL85g8abY1LPjr62svuUlK0040hx9zqQRht7cWp2uWmr69c7r51Hp0PPeaYFt3vbFX2x1yg0n+QH/LAYQZCHz7XD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599945; c=relaxed/simple;
	bh=oGcTlThlcrf/a6X6Pba0yaQBbOhK2gU5HD6vMRqLYbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IsqpKkyZvpr6+4JsNjEYRr2MtEzPXN58z4MImpmKH9HW98/oeXoQTySGqe37RQy98tsO5cJkFSoi+2I4UV9zcWdN7zHa1JJpVHwBIMp6ub4VYLNfweUTNM1SRotdtG516KSUB+jHabfbsI9vRc+uViODIEEBOOfiNRRWNzQF7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBfAOMCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBfAOMCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6CC4AF0B;
	Fri, 27 Mar 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774599944;
	bh=oGcTlThlcrf/a6X6Pba0yaQBbOhK2gU5HD6vMRqLYbw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iBfAOMCdNXVUtbWDhBFGcWilDfE39obo76ocBxQznbM3ycVkcYhKsIhWHf4vRxpPL
	 bIkBK9J2OZ0i1KQbkC6Im5qIQj9zl5VvaINRhPxvjhpPwTtcNwmB89dciCiEcjaXPj
	 hcxN2d4AsZE14afNOgOlwlYJUZWJEZjvIDMy0leuTEJ2dX90MDcoc2jd+/FaLpUhg9
	 8STIOBpp52KDxyMdqI3OdiX8fopCv8rwjKrncy6nVONdpwBnAwSZw+1zDNvQDozbvR
	 EH7kR87WXyeqs8FRjqzdiiOl6zl/d4tv6D5jmnhDRy5G3fxGfGm3vaYDviebgudkkB
	 jVzLQ0XrKaPWg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68109F4006B;
	Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 04:25:43 -0400
X-ME-Sender: <xms:Bz_GabDJ3xO3CJa4N5Ker9qFJ0KYSr3K01_QXZ6sVdO_Y-68VpfGeQ>
    <xme:Bz_GacXTS-_p_4N9zXVyb3MN9cXl4NXYSHi7ErqMMLuKm65aTHqKRUewT6c7JrY8c
    59bQ-xt8yYe_rq80PLIVDCyXxsaZwMHupbhfS2yXrBCt0C0OrH4mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhrrghiugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsphgrrhgtlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtohepjhgrshhonhesiiigvd
    gtgedrtghomhdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhm
X-ME-Proxy: <xmx:Bz_GadVK7aJUgx3X88MZ97gxnLIoSvXncg2CemL1RdBzzLf6eIPAUg>
    <xmx:Bz_GaXlYibfA6joL8DapJ3ywOwi2RYG4JDGzE_X6RSnq0YanMEgjlQ>
    <xmx:Bz_GaQDwwTBZ_3SMooOq61abVP76XHTcaCJxMf_cFVGXzD9jlOk5mg>
    <xmx:Bz_Gaegt6yA75dxmSLBkjtochtSjjLNzfFwG1vko0GdZUn2zPX2CTQ>
    <xmx:Bz_GaVxMBFR2ELuBErM61svk0AkZTrHR1_cXGtxA0KH5R4UA3nupjFbT>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B247700065; Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALG_cRBuf6HF
Date: Fri, 27 Mar 2026 09:25:22 +0100
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
Message-Id: <e7979928-b33a-4132-b08b-d95b91b14295@app.fastmail.com>
In-Reply-To: <20260327061704.3707577-4-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-4-hch@lst.de>
Subject: Re: [PATCH 03/28] arm64/xor: fix conflicting attributes for xor_block_template
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 27 Mar 2026, at 07:16, Christoph Hellwig wrote:
> Commit 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> changes the definition to __ro_after_init instead of const, but failed to
> update the external declaration in xor.h.  This was not found because
> xor-neon.c doesn't include <asm/xor.h>, and can't easily do that due to
> current architecture of the XOR code.
>

Even if it did, it wouldn't matter - __ro_after_init has no effect on declarations, only on definitions - it only controls the placement of the object in the .data..ro_after_init section (and declarations don't generate any code)

> Fixes: 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/xor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
