Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8D19B5A8;
	Tue, 18 Jun 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709340; cv=none; b=lWY61/YabZugXXy9HqXMjSkJkhoFQxUWBRlmFrvyQoJ0APHJrL3hBXn5L+DYHBIOyR46rFZzMYIyqYwyHziDIKZEYuNe+z3R6M5WuOUEv8eGZMSzQ/VUYwgCYD1VCSONvwmcnjWssTsR8PqEtPX1Q52U3FMzKXkayM/56xME0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709340; c=relaxed/simple;
	bh=bQ8atcDoAMJDfXcR5CtM6JEhwxnxsPOFsW5HLOyaBgQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BcBmVxk6m36/OszCdG0wgkRYCNtBolt3FHlqfHI56+HiZDAfKWe2J26JeYq3NGyUsxPi3/PzztCji+54mQJDAPPAtc5xd7NqhXHMTbbo4vEu0xMNG5sUFldcsfuGGGe2dMWu0V4VKMjFvqhOHIh7HvEuPW8aQrFao4HWw+vQ7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tYqlNT8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0pGtVLl; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tYqlNT8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0pGtVLl"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4449E18000DA;
	Tue, 18 Jun 2024 07:15:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 18 Jun 2024 07:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718709335; x=1718795735; bh=ALp4QxWC9z
	gKoPTEnvdpcdX1IlHBjC/eM21B181t8Qs=; b=tYqlNT8GAC/WBA3lxV5xMGLFUF
	nriSWTGMpCIvmCW2quS6yOJsmEG99h5lD6miqXzBpVSs1tvxyGB2SFeoyChM2or+
	QEZ85imi6sTtpQ4nJZELEpNvLjGSH2zpO0xaTSabgP29IbJxmFNaAZ3brdCFTTx9
	yhPYyocFG+FZFuy0Inxn2D9L+1hHfyJNm6mIU820DivdXGeCcp8HZeo4nwxDQWvh
	MxVxZlwgU6L6MWl7vrNhEWGZ9QzVCERobCX4Q5vjOqN5nmjwTYXNkdGWYDWOpQMG
	sSLuIqs30B34hhVNCJZhmOgP+VLan/iaAZuKRKmD3bsyR9Tq1c8tkT6B2CSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718709335; x=1718795735; bh=ALp4QxWC9zgKoPTEnvdpcdX1IlHB
	jC/eM21B181t8Qs=; b=P0pGtVLl3EUqZ5r9okCduwGpVptn3qNKep//qgjPBOqg
	DAG8XsqhGZp8DahniuR+g0c/ZuRk3l8yHWVLSUhiGRSyf83CbK+t0SFCruLi3C6u
	U2CsT5SHPSm58BEmw+mTAbGGxTa2eGTFy438A8mJPmv0iqCD6Rc5OJAGjoBtwVjt
	d7HI6QH1mw2edwa/Wg9XIVonepy69OmGQkRB5sDhSkjZHBc+3gJyP417eDSbIJKf
	P7s0U7AO5i9xFt/hfRdo0M0KK9tGbY/Rj2jxejONoFZwasblEgHxWDkKcGmqShMY
	WAV/PMQnq128JAaMjHHekEQsWif/EjO83qPzGVv8FQ==
X-ME-Sender: <xms:V2xxZmIcczWuFP7LV0BrvGEGZNHEj44n8ywbVCxcLwfJSc4mJ6rKuw>
    <xme:V2xxZuI90ZsHwQA71xJHahTGT2EGEnWe97hDBXfn7wEvxj1UKSTfCZTn2QVdZIpqa
    vUiz850Kgs8D2HQ2YI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:V2xxZmu9aFVnHY0rnU8XOxvHiEL1PQVZpN1NHD5vkdtp34TUFVWR_w>
    <xmx:V2xxZrY0TiXzIF0BSdeIf_NdpXn3Chg3x_idvT18FRKozRr-CnezRw>
    <xmx:V2xxZta5s82tbYTMno3f7pMakDX_Sk-DfzqIwWUUAYer8jwQ1AU0oQ>
    <xmx:V2xxZnAAq3QXrzyq-zNbH0zOg9wEj16rqt0UXf2xqgabPu_1vjgwUQ>
    <xmx:V2xxZhKxiUrYAQ-wuS7SjAjAfFCNzCG8DJeaKMovWV92Pa0FQfwjE-RL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2CF1DB60092; Tue, 18 Jun 2024 07:15:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbca95d9-4818-4624-b3c2-4b51284fe83b@app.fastmail.com>
In-Reply-To: <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3> <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
 <ZnFlQgVSTtf0t2cU@J2N7QTR9R3>
Date: Tue, 18 Jun 2024 13:14:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Kees Cook" <kees@kernel.org>, "Yuntao Liu" <liuyuntao12@huawei.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 gor@linux.ibm.com, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Leonardo Bras" <leobras@redhat.com>, "Mark Brown" <broonie@kernel.org>,
 imbrenda@linux.ibm.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Content-Type: text/plain

On Tue, Jun 18, 2024, at 12:45, Mark Rutland wrote:
> On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
>> > On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:

> Sorry, to be clear, I'm happy for this to change, so long as:
>
> * The commit message explains why that's safe.
>
>   IIUC this goes from 511 to 1023 bytes on arm64, which is ~3% of the
>   stack, so maybe that is ok. It'd be nice to see any rationale/analysis
>   beyond "the offset would be bitwise ANDed with 0x3FF".

Absolutely agreed, and the commit message should also clarify that
the increase has already happened as an unintended side-effect
of commit 9c573cd31343 ("randomize_kstack: Improve entropy
diffusion").

> * The comments in architecture code referring to the masking get
>   removed/updated along with the masking.

Right.

FWIW, I also wouldn't mind to having a compile-time option
that configures the number of random bits on the stack offset,
but my preference here is to have a reasonable default and
not need a config option.

    Arnd
