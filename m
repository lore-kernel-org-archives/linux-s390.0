Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA23321D4;
	Tue, 19 May 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190263; cv=none; b=DaJqE/WdAo8wDQ/UH8UdfU7IYx910fHaXM6nHcqPTpAyvPSbSfP0YuvXFBdw3/BmbFbUn9e1P0wFcJcPKuBlp4v8th1GA4990CYPgY+RvrPrukBRdkoEU+xVClztm2L8dxGKBAw9fgZoSu85o/eLss6ibEvFmPSL0Sc4QIc3380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190263; c=relaxed/simple;
	bh=0Oo33RznvtqcJCkRGUlgmAdiDOmAVDZUTI3AuCFl488=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L7JcIa4grYLJ1VowosBRAMIqqh3aGp4DQbQ7JL7JtJIVJmKPS9vFxDJO5S92HjD+zYTnvnHuMRlNQexN+wQgYk0yUydITmFHvEcyrKfp+kJmpw/i23Isrn5x4sXMsed+DprwWik/aTqYxmU3DoV3KgmNobLRvgh5coVie/Xg+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YOnoLD2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EELP9MRI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YOnoLD2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EELP9MRI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A69757A0085;
	Tue, 19 May 2026 07:30:59 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 07:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779190259;
	 x=1779276659; bh=NbRQInQDXPaXz/e1ua2onu0M3s38E5rgVu463atNkhc=; b=
	YOnoLD2ZnE1DgLMmmR68H63eVMc4QnYlG8junaxL1tKnT+kZL/AMyfDZuiRpLz7m
	+iELLK6k4VTw5XBFhDGttFkFHvFLSNvgHwMftaRq/MGdfur6BeYb3SBf83mlnalE
	Wx9y/9dEkAXb/NceRlSst/QQH9w+UREAMFM5qsdOT0Y3eHWPb+k6GMUWgQpYay1A
	B+tQ+c7m3j2HYuM2bi35T9QQX+JMjECIsJOx0BbmEQoFOKPrD/1dXwe0+7h/E7S0
	TcJIg6WQVwkhz2IbpzdTaBGldBNoKdQLxpNw/dlB/dPDJfkK0QNu1xHAKWMmKGfC
	bI1dHYmTj+0oPqLq1g6IUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779190259; x=
	1779276659; bh=NbRQInQDXPaXz/e1ua2onu0M3s38E5rgVu463atNkhc=; b=E
	ELP9MRIoV5ic/f/wQgSZfyJ3qrXSoWxAym9hyUn9wN0XHq3BFoBAkJJpK8d572gV
	lchaQW0Xm//fX7d7FXmCw55y+UhTPWJWSeHHeZdPPw4yhC0bYk2rr9iSC9gx6yfP
	I9Ii2761fVTx8AToR/YHAgns093oyiO9YSP6JVCSA2QtJrpbkidI2EpVh8m/cziM
	A9fmz9EnaSzmRTR+ySHr3ZTM/5wnKB6snmjLm9zRRvTY/MfXB/8uJNqC/6nREbAx
	gdgPuJllccyNQXrZXXXSV6TNDJcfqVhMEPf5+4fd4iosc9EEjYwv5NGLbJP0MZFN
	OOj/8Bjju1OEeO3ug5lJw==
X-ME-Sender: <xms:80kMavjN1_fXvztTB1fWRYQpyapNHDNi-zUWfp0MJR1Bg-vfvohkeA>
    <xme:80kMam1WHjYC2nU4eKQabBwqUmyLCX_hz8ns3gaXunh-WhAgpoE77SQzwIWqhGg16
    8SAxFaXfssUWJ82OymMr87iEv0rlEKbfe-7F1OOxr50wT66JPNHMvfR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsohhquhhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgtrg
    eslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:80kMatn5QqT6ac_TYV3RTZhTpY5DAqZUEPRpdIXJL3pJg6u7BTqKSQ>
    <xmx:80kMan5Sci24aYOhypdzlx2uGj1djRPotHFVqBiAsM6lN7s_tisY3Q>
    <xmx:80kMap0Rf_Ni7iPzpPIkvFJ7Ckja2UQ2n2MXQwIJj7VB7mEkwC0d7g>
    <xmx:80kMaqGrkq6JAlW-Q04EuH64oxLPk8tmQ6sX2Fd8vfQY5MsmPvgbNg>
    <xmx:80kMauLFVVPaebob72M2vL2ovm3bcRNIFL7VrKEG5GFJpMo45u0J4uNs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 41F89182007A; Tue, 19 May 2026 07:30:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxTHEHkZNmHg
Date: Tue, 19 May 2026 13:30:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Message-Id: <96b8ee68-a6e7-4496-8510-14812d9a38ec@app.fastmail.com>
In-Reply-To: <20260519110315.1385307-1-hca@linux.ibm.com>
References: <20260519110315.1385307-1-hca@linux.ibm.com>
Subject: Re: [PATCH] seqlock: Allow UBSAN_ALIGNMENT to fail optimizing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 19, 2026, at 13:03, Heiko Carstens wrote:
> With gcc-15 and gcc-16 with UBSAN_ALIGNMENT enabled the compiler fails to
> inline and optimize __scoped_seqlock_bug() away on s390:

technically

s/on s390//

since I have been able to reproduce the problem across architectures
now.

> s390x-16.1.0-ld: kernel/sched/build_policy.o: in function 
> `__scoped_seqlock_next':
> /.../seqlock.h:1286:(.text+0x22030): undefined reference to 
> `__scoped_seqlock_bug'
>
> Fix this by adding UBSAN_ALIGNMENT to the list of config options where a
> not inlined empty __scoped_seqlock_bug() is allowed.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/r/20260515092057.810542-1-arnd@kernel.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

I was about to send the same patch.

Tested-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
