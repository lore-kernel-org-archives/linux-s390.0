Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB1226193;
	Mon, 10 Mar 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604901; cv=none; b=CYOJL2dIzcMU5cWCWLTdEz723oiOvg8Hawh3WpkS5w3S/pZ1y3BjcWyLjIsB8AHoliKIr+e3QhVQEmVmq6qPRXGu6nKnnKj2Tr5HsKT4oPxQ47t8q82oHPZshWzuoOjoyZ93WL5hGpRteQbQ6jGZeXLIkg8SmKPgzk6Gi3V8x80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604901; c=relaxed/simple;
	bh=xvMJrDw0y71650wJWd+40aIoJasnNgfqXdrkvrX/7YI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=crG54bwYq5X9bhhDxyIVfcu5ZAhTFnHaRyGWbaoIhkayquQOq2R6ITj9+43Pb7MmJXSN4SXXjt4VJkF4dOc1IO3SaQiqvIdaV4v86D915fNCKYxCbjN4uNca95XOHYUFVDUy0toN8PMB7ctP99aDfYQK2em1ao3hazn4qVePj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DMPkMqbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pPTfCRE3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DMPkMqbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPTfCRE3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 92DDE1382D3C;
	Mon, 10 Mar 2025 07:08:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 07:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741604898;
	 x=1741691298; bh=Apaj21dkzM+VkTh8UH1lJMExSSBSc8XmpLRBgZkT51Q=; b=
	DMPkMqbsjW0B1h0G9cj6+fhuyrAzzqf2jrqYh4rB1LzL/d0tlGcFTCyUkd9hW9Am
	sDvCmliWMLldoChh6L8IxCUFK9vDUe6yMNM4wNZAqK+8lynWPCoodS23wbJg+PEI
	eQ3NmVm0P3XYYgPQJE/H7Rs23p36QW4SeKgQO2tNV5MT0WtcWe2lYYnIvB90NLOZ
	JuzPEg2xTx/z9CyCr/qkYygTUgmMfxXc+T9M4JiV6iJDqKYAdtoGmNXHpJyOAg05
	z9Po/ENcHzf8GHgOikR/08YY1RLuAXVedn9lJLfE4BDW2hp1b+NUozBiyyDu6Xvo
	BkWla6AosU5ZoX1mU0khFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741604898; x=
	1741691298; bh=Apaj21dkzM+VkTh8UH1lJMExSSBSc8XmpLRBgZkT51Q=; b=p
	PTfCRE3bEkYbtm0XRKb8+lrEsWRiIauESbGTQHjHdP67nCDiKU0dJc1oG5PY0JGS
	JklFEMIVarCww6V4VeWZA3eTwp6+Jxny0Fs3V107JOmPd8ZEsXZQAu3kmUHJTW7v
	iN6D7A7JUhxAV82VX1n6h2LrcNDNGnOxHYD6oBnKdIM5prPLnWFu6yjW3BlPZpAw
	LqJpmidNuV8Jtdr8T8MYxXi43by/vpgJXCcKS4XqoCTeWxiofYp9Wl1VaWEW7fmO
	QbrhYotIfkUd3H3J2CJ6DG9lQZdpkPqd1F4trHNNif5IIc3LSNxDGg80C4SI9paI
	6zbHAK0jBde+X07RpglTg==
X-ME-Sender: <xms:IsjOZ5tVzhMUuwVnID3T_CAstLrvmaGTvGmERfH1kjSMq-rAhg2prw>
    <xme:IsjOZyfRnWz7_Cvd1w9Pg1etW_fh3IqJ-Yxe4c7yb5DeUtr2yWQyk8imfOF_pLZB2
    8x-rCBM-JrKpYyiyAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuh
    igrdhisghmrdgtohhmpdhrtghpthhtohepsghorhhnthhrrggvghgvrheslhhinhhugidr
    ihgsmhdrtghomhdprhgtphhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtg
    hpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehsvhgvnhhs
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:IsjOZ8xvb6KmSinwNEfF4ON13Q0qptj6TIfxANrm_UINxyZ1nH3P4Q>
    <xmx:IsjOZwNO14SI5s0L4ce3JPytGFpBYcBXVFAvjkIC4m7eO0OGhzSlqg>
    <xmx:IsjOZ5-tysCkiKEv-A3i38k2IR9vpwn64afzDp5fb_FMv8c0jFCeOw>
    <xmx:IsjOZwVjw59dFx7xojC52puO7VetCqNEH3qNQy8fAJX8IGtphDoTSw>
    <xmx:IsjOZyPzySfhaIaE8ZSmnJAMCgv-QXHvprkvWXfHLb9brf56KjDyx1aa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 351EF2220072; Mon, 10 Mar 2025 07:08:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 12:07:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>, "Thomas Huth" <thuth@redhat.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
In-Reply-To: <20250310104910.27210B18-hca@linux.ibm.com>
References: <20250310102657.54557-1-thuth@redhat.com>
 <20250310104910.27210B18-hca@linux.ibm.com>
Subject: Re: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 10, 2025, at 11:49, Heiko Carstens wrote:
> On Mon, Mar 10, 2025 at 11:26:57AM +0100, Thomas Huth wrote:
>
> Did this cause any sorts of problems? I can see this pattern all over
> the place, so why is this now a problem?
>
> Also, wouldn't it be better to fix this with an sed statement in
> scripts/headers_install.sh instead? Otherwise this is going to be a
> never ending story since those things will be re-introduced all the
> time.

It should certainly be done in a consistent way across all
architectures and architecture-independent headers. I see that
all uapi headers use __ASSEMBLY__ consistently, while a few non-uapi
headers use __ASSEMBLER__.

glibc obviously defines __ASSEMBLY__ whenever it includes one
of the kernel headers that need this from a .S file. Unless
there is a known problem with the current code, leaving this
unchanged is probably the least risky way.

   Arnd
