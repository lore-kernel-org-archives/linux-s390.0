Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861072E22BC;
	Tue, 19 Aug 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624947; cv=none; b=cX0958DE0MmmmWdHsCvuc5k0ujrETgE0bw5avP0SCDwHcNJAhn4kDFDhNFe6am6lcaw+Wtdoqy0IbO8XJPHWFD1DSlXkaGMp0tOEQFTUhGZofyF5519JWXSCOpCqfliKlI21HWzyDnp6itiMuvrBggE9BPMT90f0CbXHjFdIe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624947; c=relaxed/simple;
	bh=TbYlPaN8y09mXVm7U32ZTGP7XaIU/o4ZbvH5yZ+Q6Yc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FEPflm499rzT1M96gzVOPKZGhKHwTssbE21kt0Cbev6BHvvUzWCiUDxFEg7PotGrZVmiR+NwxoBpqbBtXvQyN1Rti1pc5HwD8m1ZWBgzQF+mrE5qSs8in5nbYt2Juua4tSLoaCRzly1lPTqUwgFTlviUmuhF0M+4Cau7tdV+7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a4y0J3+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y79F2h1d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a4y0J3+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y79F2h1d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3EC014001C8;
	Tue, 19 Aug 2025 13:35:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 13:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755624943;
	 x=1755711343; bh=AfPyoG66MRGoGsRhRebr6qC/Wlem8LqEZGgBOHpR/7g=; b=
	a4y0J3+MvFBxCiIo7y8SBfeEQ/CQ+2iaHuTNLWWVz0kWW97s8sDRxeO/uTJG6ve/
	RG8uTSu0nu4ah3qpS4pJKFMx1TLXiRT10N2vMuuKgmuscNmALPRExwuw13MyZdkl
	nNWhMrj4T3Rq44G6mQFGHPWrYR3ofoNdiZudI/fyj6tIhaLkhL/qMwcJQeWexhi1
	T8jYeBHOM5uEdQbSlno0NX6SWUK3O9b6HbZjCFlx5FlbyK5jKs9qBqlyDSoPB2UA
	VQoet9S3JMD91jOgAYIJYWHBNfodKxW6ucjVWi3dXo+mS6t6FKO/rgHpC2SKgW8N
	tKc9gAl76lsW0mbLa8nFig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755624943; x=
	1755711343; bh=AfPyoG66MRGoGsRhRebr6qC/Wlem8LqEZGgBOHpR/7g=; b=Y
	79F2h1d7oVPzJyNsaCA0z99ZOPZuGOz9skw/dVePF2rinpsiutMH1/rpAhyBUjnp
	f4SiSRIoieGOoV9OVeJIF09URPqF4DTfV+Og2WtRhpjwGVsogr2QoIGAUwb2sRVa
	RtnnC/Eb+gj6KVWY7juYDOaS5uTzXm+emjKAhaR04A24qogp6Dfhw+apITKf+z4b
	6O/XHOuuUgY0KQh3r/bMW9p13cKi8Yn7qVo9ZZXCcraJhmQNPMHqHon0YV9g8rDL
	v9ZI82APtyRpxVY5xP00r9ETlpy94mbKXH+zgAN/2GM3rVMrtlKhH6eMTvY1xWJ8
	nGRhUY9gG7XQeOMRpYDLQ==
X-ME-Sender: <xms:7rWkaAMu4G6h_VRqx2PP7t1V_8KAaxIJLjUgTrYPbQ0SAcQY8W7WdA>
    <xme:7rWkaG9lhOtDlVxcRRtIMZ-ss9PcIoDu_UJLjfNtEnmK_dig_cqGg1XcSdjJ4zczR
    15uHXOTReKIHOtu17Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    rghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigv
    lhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlh
    grnhgusehlihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghr
    sehlihhnrghrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslh
    hinhgrrhhordhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghm
    rdgtohhm
X-ME-Proxy: <xmx:7rWkaOosbCTr4cAmiU6JpdChoouFQxnpot3ea40SuFsNm33heoRmgg>
    <xmx:7rWkaBxQgCCVUjv7bBke2u5GEbDDHFEEZR_2yu_qi1GFgxykD6GC7A>
    <xmx:7rWkaGIbPb2M4YfKlHa-77x2qddx56AXIQLmp-pv8mbOusaPGNzAHA>
    <xmx:7rWkaD79QucciIfIZd3HAgp5e23HgjtH2OnGtRFAdLU4VUEywQZDmw>
    <xmx:77WkaDF0xjZgLdJnMyexR335RTOn6twT6-Eu1zNmUegTtRAyXRN7yd7h>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA9C8700065; Tue, 19 Aug 2025 13:35:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANJBU5t4alyg
Date: Tue, 19 Aug 2025 19:35:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>
Cc: "open list" <linux-kernel@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Jose Abreu" <joabreu@synopsys.com>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Message-Id: <0666e47e-a675-47b6-9b6a-5d4e33f6bf5e@app.fastmail.com>
In-Reply-To: <20250819160049.4004887A48-agordeev@linux.ibm.com>
References: 
 <CA+G9fYuY=O9EU6yY_QzVdqYyvWVFMcUSM9f9rFg-+1sRVFS6zQ@mail.gmail.com>
 <20250819160049.4004887A48-agordeev@linux.ibm.com>
Subject: Re: next-20250813 s390 allyesconfig undefined reference to
 `stmmac_simple_pm_ops'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 19, 2025, at 18:00, Alexander Gordeev wrote:
> On Tue, Aug 19, 2025 at 03:07:56PM +0530, Naresh Kamboju wrote:
> CONFIG_PM is not defined on s390 and as result stmmac_simple_pm_ops ends up
> in _DISCARD_PM_OPS(). The below patch fixes the linking, but it is by no
> means a correct solution:
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 5769165ee5ba..d475a77e4871 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -668,7 +668,7 @@ static struct pci_driver loongson_dwmac_driver = {
>  	.probe = loongson_dwmac_probe,
>  	.remove = loongson_dwmac_remove,
>  	.driver = {
> -		.pm = &stmmac_simple_pm_ops,
> +		.pm = &__static_stmmac_simple_pm_ops,

The correct solution is to make the PM_SLEEP versions use this

            .pm = pm_sleep_ptr(stmmac_simple_pm_ops),

or the corresponding version for the PM_RUNTIME+PM_SLEEP drivers:

            .pm = pm_ptr(stmmac_pltfrm_pm_ops),
 
By convention, the pm_ptr()/pm_sleep_ptr() macro should be
used for any driver using DEFINE_DEV_PM_OPS() or its variants,
though missing that does not produce a warning for non-exported
options and only wastes a few bytes of .data.

>  #define _DISCARD_PM_OPS(name, license, ns)				\
> -	static __maybe_unused const struct dev_pm_ops __static_##name
> +	__maybe_unused const struct dev_pm_ops __static_##name 

This would cause a lot of link failures elsewhere, since _DISCARD_PM_OPS
needs to ensure the operations are discarded by the compiler, which does
not happen when they are defined as a global symbol.

The idea of making this a 'static __maybe_unused' symbol is that
the actual functions get discarded as well but don't need an individual
__maybe_unused annotation or an #ifdef around them to prevent a
warning for unused symbols.

     Arnd
