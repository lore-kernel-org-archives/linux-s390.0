Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49430C174;
	Fri, 15 May 2026 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878308; cv=none; b=VJDyL/NUT6UafDaYsD/SYXLCR+X9IuOi81gxHCbGeI3v9Dqs6e1dAWISqXM9KV7MEokTHffVrb2fQ6/WIV1fya0SdJ/k2KWVFQmlxfz+uFWgUDofZlrcatKFigaI2lM/l8XdhxfFj2WVZ4ZgoF/iSdVwcDAFCizf+lDpXanJHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878308; c=relaxed/simple;
	bh=x+vLSkXCJNQ05repT0IHPhoUUAu3mSh4lu7BJ/e4z3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aLM3myusKJhROb6zHkhSEAxKv0KcK3/TzWiK4L09FbOahQd0pR/BOSNNIAZFqFxua8tI8y6ErRyOZTyCs/NaKi5OZ0VDonzIAMroYCdmUWCxqtohgee3OmvPZSXHUI8G8rt0KPjXqT4zR006eJ1Zhc5DtwazOnp2zPwyOXnLfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K4txOVOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBDBV7+w; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K4txOVOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBDBV7+w"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D23341300102;
	Fri, 15 May 2026 16:51:44 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 16:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778878304;
	 x=1778885504; bh=lX4nJlxbqCT1SqPB0U+wt2alGi7/SuKCjG3lA5xdSKU=; b=
	K4txOVOGwllZHxeJQ5XBvOTKMUOgEeo8iJQB3FdPNaiYhZwTEb7pI5Yo4+gYlFnR
	7Y2P6U4N3XWJmJgfjA7j5ZLo9MTA690OhL0aJovQ7bi8y7a+UCBwUOKe8BG4BfGi
	LDR6GSflXgyTPeOlgo3ebSsSohk3E/Qcs7dTrWPBgjrcMvufrj6DFjHLKhL42T2I
	1ZJvaLWzrkwQGthjEkbCyoRBAP78dSNODDkBVjeEBfV3fzKGnMVo04wsFCKqaZsM
	XP4/egwW2K7Z+LZYBihpunmgEr6DwknGqoNWnveBZdBKKHhL82STsUs4gh1AowCL
	BAEpLBRZfmOpjXWKUIjvuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778878304; x=
	1778885504; bh=lX4nJlxbqCT1SqPB0U+wt2alGi7/SuKCjG3lA5xdSKU=; b=H
	BDBV7+w0AogogJ+lkEVj1eY4DPq6n7n22XrfpSkOXuBsEyAcQFQPAMvfNk4RTBiW
	ELBPVjHEYLQwkHGtdkPanKjXsoAs9H5Cj5uAnLBHBLFQUQzAjSRUh+qEWL+JhKt3
	xDmtwaaccdpLm9uUfPIyOpOwt445rKS61XRUrv7fPooqB6V1gdOzyldJPHC/fbje
	Z/ShnK15RSdnHM8i4WHswJq7uxI8uvFW0ehkj7m+Cpjq9dP3YcQAxJYRIoL/QxoH
	OfT4qSzMeJZUnWl7keHe6wW3r5jEHYkx1tG8t1N/ihb9r3e4zrDs8dQ0BWC/2lM2
	TYNVPTpVJdbF9oluexXKA==
X-ME-Sender: <xms:X4cHap3e3kVei8rLrMWkej3_Rt85qz0aCb1yqSRV-o3W1Z-gSMq6jg>
    <xme:X4cHaq6qMDYUVODv_7X3vO8jOdDsdr21zXt3dlANeZSwEcqizttIkluuP5Des2H2K
    KPFX1J0duS-4TmfE3hTQ2Rqk4M4TSnID8gYrfu-6tmgCocGDuxXcB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtvghrrhgvlhhlnhesfhgsrdgtohhmpdhrtghpthhtoheprghnug
    hrvgihkhhnvhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhihrggsihhnihhnrdgr
    rdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghlvhgvrhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhgrshgrnhdquggvvhesghhoohhglhgvghhrohhuphhsrdgtohhm
    pdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X4cHao2MN6fXhrMCYkSEavIZfrt9ZFUcA2536eRVBNRn_lza4zAUzQ>
    <xmx:X4cHan95OvX8A0sndaxIPTK9W_Q89uuDeD55zv_PCfUF6b0wvCoHXw>
    <xmx:X4cHauflTW4p9zONdTPPEgORKKQnQ2IeWQk1sqvkdnkvS0ek4QBsnQ>
    <xmx:X4cHaj49T0OeccffGxfZIss2QMrCpjeXEbAsMsY3YTjNfOzDSbSr7w>
    <xmx:YIcHaircjx8SAmStb-YZbk6OSA5oY_PzTotvvSqle_gdgPaMlMGM-O_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB3E6182007A; Fri, 15 May 2026 16:51:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHLmA04tG45J
Date: Fri, 15 May 2026 22:51:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-s390@vger.kernel.org,
 "Kees Cook" <kees@kernel.org>, "Marco Elver" <elver@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Andrey Ryabinin" <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nick Terrell" <terrelln@fb.com>, "David Sterba" <dsterba@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Stefan Schulze Frielinghaus" <stefansf@linux.ibm.com>,
 "Juergen Christ" <jchrist@linux.ibm.com>
Message-Id: <5502d883-a7c4-4e14-8f27-7bffd1f4d35f@app.fastmail.com>
In-Reply-To: <20260515165357.10935D74-hca@linux.ibm.com>
References: <20260515092057.810542-1-arnd@kernel.org>
 <20260515165357.10935D74-hca@linux.ibm.com>
Subject: Re: [PATCH] [RFC] ubsan: turn off UBSAN_ALIGNMENT on s390
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 15, 2026, at 18:53, Heiko Carstens wrote:
> On Fri, May 15, 2026 at 11:19:54AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Testing randconfig builds on s390 with gcc-15, I came across a number of
>> seemingly unrelated build failures that ended up all being caused
>> by the -fsanitize=alignment option:
>> 
>> s390-linux-ld: kernel/sched/build_policy.o: in function `thread_group_cputime':
>> include/linux/seqlock.h:1286:(.text+0x1f738): undefined reference to `__scoped_seqlock_bug'
>
> Does this only happen with __scoped_seqlock_bug()?
> I just enabled UBSAN_ALIGNMENT, and with gcc-16 I can see this too.

Yes, it's specifically this one file that triggers the
__scoped_seqlock_bug check.

>> --- a/lib/Kconfig.ubsan
>> +++ b/lib/Kconfig.ubsan
>> @@ -152,6 +152,7 @@ config UBSAN_ENUM
>>  
>>  config UBSAN_ALIGNMENT
>>  	bool "Perform checking for misaligned pointer usage"
>> +	depends on !S390 || BROKEN
>
> Wouldn't it be more appropriate to extend the ifdef at __scoped_seqlock_bug()
> which emits an empty function for exactly this reason for some gcc versions
> and kernel configs?
>
> That is: add CONFIG_UBSAN_ALIGNMENT to the list (copy-pasted - white space
> damage below)?

This would work around the failed check in kernel/sched/build_policy.o
but not address the underlying issue, or any other the other symptoms.

After trying to come up with a simplified test case that shows
a problem on s390 but not arm64, I have now realized what is going
on: My randconfig build script force-enables 'CONFIG_COMPILE_TEST=y'
on all architectures, in order to avoid known-broken configurations
and options that lead to a longer build time but are unlikely
to find additional bugs. UBSAN_ALIGNMENT in turn depends on
!COMPILE_TEST as of d0a3ac549f38 ("ubsan: enable for all*config
builds"). On s390, COMPILE_TEST is unavailable when MMIO is
disabled, so randconfig builds sometimes run into those broken
configurations on s390 that I don't see elsewhere.

I think your suggestion for __scoped_seqlock_bug makes sense,
and I've sent a fix for the fs/fat/ issue. I'll see if I can
also reproduce the other issues across architectures and come
up with local workarounds for UBSAN_ALIGNMENT.

       Arnd
