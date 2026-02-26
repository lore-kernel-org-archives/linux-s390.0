Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464A40FDA7;
	Thu, 26 Feb 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120635; cv=none; b=Rs6obBVMqY7FBqd+TKzXys2+f1/Lq7iCWSpt4roxR0B5czBzPO/0dylqyvzkakTpK+FHC4FuTj4AY7ANADw9U3MSV6HCno7BWZ4jF1RfY+Wf0nPwORRugErmyMbAV52KkuwZ1kocVQwKxiUwMbcxCOHHX1KZDdhLP+dJP3yccdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120635; c=relaxed/simple;
	bh=zaIt+6c5Z6aF5nOzcYBB7QJkaXuFxNxAQjsZxA8CeFs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uw6bfrQXK37FXlZ++VgfKEw5eSdj9CavnQ8wr8tLk/Y1NciJpVBoAVk0GHwqNWXTIj03c9uY7LmTQdQ0v7XmukeyyDJl9Fe/yQKYMrHT3psMbxrO21lkHhzvkEAxo58YSe54HHN/SA2YkEiJRhV2GZWtF/TuCr7zlCBl5tCTRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kE1boI3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q18deQNd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kE1boI3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q18deQNd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89BD3140002A;
	Thu, 26 Feb 2026 10:43:52 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 10:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772120632;
	 x=1772207032; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=
	kE1boI3ws1cfLT14/TVxxEoaTMdXc/I1PNXH7GNWRBTllCBgtrzrTSjit+SUhttr
	Eb0fucvitI2zRzMuqR6UG0eh4zA2xMizTkFOHXxSup7P7svCEQa4QG6ViLuf5mR5
	DqhI/u6kRuseZ+jc0FUGUEZY9J442EYkBykyx3ZMQvORYJl/5jeTlWR9Avg3ZFmK
	1aQ3s5BQMTPicz8U3wzNRCQrtM8Yy8EkZu4vaZFq+t60P/2wWo6CEjfJxmi+Eb9F
	geLakIK4l4b0gfCpw6OD9M1LtQiO0sLd769xq21hYFRZVOLN1rz1dtHzxVvlG0Nn
	93wsCzFKgp+Jo1S+xiBqqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772120632; x=
	1772207032; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=Q
	18deQNdFeQPk0V2f0XIHZ7Ojp8SWcxzigQIJDZ7UUHsSU60St1ZxQSgXBXP5TlAf
	Kwy9HxF+WAaPUAxj3/EFIrSAuxG9kk2k195AlqzGpp/dzFQxMa0tAo2RLqTMPHIC
	vXji4OQ+bS1C1d0xIzXHVXGabHysyEGlA+BTKWDa7wCBxmlOoawgKi83sAMF9a5V
	kL1ZzZYK4zft7yxqk98KYQcKfB+urZmPATLUA/SbLYc+zliGRNbdea9TnQWqdM0L
	wNFDFJ2qpGdCNGCo7kFmw1K7rQplgLEsqwcKlxMSRaIRdafFINL1pNCFooIQvSoL
	quMyMAEOqJLyL+xLNkkwA==
X-ME-Sender: <xms:N2qgaYw1z9YGtc2jyohlCZgUE41JpfNk-e8L63NjeeaiyzuFe5DnFw>
    <xme:N2qgaXFo9EDsygeZAIkarS7n9AiIVL3ExBB5UEe90SABj9605l3OZ6AShtJJwrBhD
    0HJMpU5TqkedRrThxaDo_GeBne0cLk0NamJkUiAg0FgXZzxsXsR2qpV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhprghrtghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopehhphgrse
    iihihtohhrrdgtohhm
X-ME-Proxy: <xmx:N2qgaa1Hmj23zi2NwnEav_2GuzL1DEGkxmZpmVQBkFQc3buBo3erVw>
    <xmx:N2qgaScGfXgkQB844dVJs8Kj2JuMZuv7_759dDpv9UsAuqu6oWAovQ>
    <xmx:N2qgaTGP4znwK0QmX1lR83q243FJ8XazQRHtuLSGlP19PAWPDUDE0w>
    <xmx:N2qgab2QyDp0HFr8ls8AFP8jbOKZU9JOsZK85-hLopw22NwXActoMg>
    <xmx:OGqgaSQDW-jqdcPJrzZMqtB1XkHRDRJh1kqJiRl88YaDQ1ONH-ME_m7p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0F9D700065; Thu, 26 Feb 2026 10:43:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQu7KcbS869J
Date: Thu, 26 Feb 2026 16:40:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
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
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Song Liu" <song@kernel.org>,
 "Yu Kuai" <yukuai@fnnas.com>, "Li Nan" <linan122@huawei.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-raid@vger.kernel.org
Message-Id: <29afa24a-f659-481b-b5a8-7b8b9e009755@app.fastmail.com>
In-Reply-To: <20260226151106.144735-10-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-10-hch@lst.de>
Subject: Re: [PATCH 09/25] xor: move generic implementations out of asm-generic/xor.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 26, 2026, at 16:10, Christoph Hellwig wrote:
> Move the generic implementations from asm-generic/xor.h to
> per-implementaion .c files in lib/raid.
>
> Note that this would cause the second xor_block_8regs instance created by
> arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
> code, so add a NO_TEMPLATE symbol to disable it for this case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> 
> -#pragma GCC diagnostic ignored "-Wunused-variable"
> -#include <asm-generic/xor.h>
> +#define NO_TEMPLATE
> +#include "../../../lib/raid/xor/xor-8regs.c"

The #include is slightly ugly, but I see it gets better in a later patch,
and is clearly worth it either way.

The rest of the series looks good to me as well. I had a brief
look at each patch, but nothing to complain about.

     Arnd
