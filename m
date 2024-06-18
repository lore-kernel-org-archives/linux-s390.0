Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C9210F8;
	Tue, 18 Jun 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693204; cv=none; b=JR5EeP4i8Q4BqSjtc9MHlnC+tN8TrOnSEJB5EPNQIWI9tXP2/pX812MsOztlI8Gk5f0YBbVfeXEu0kdPmpahfkUwPx0RWuX+sSL6I+R02nqWtFDANznNYlarbg5fVmgaW25JZ9xHgIDf7xfGM0OTCmzAL4HyCy5ClBGnlEmw6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693204; c=relaxed/simple;
	bh=j06F/kFwr+kpQRTEON4VfXRMzVQHBeDN1gyaBYXRmlI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kazKJBTgvVhTqqenzLa7cPd3LOAjww7LWvLGt7hwiyOMjJFFnZqCfQnlAHc+aVirxOZ3h72Nd34IZE0uYUamWR2Yi2FmUaxWjT5Hl8TS/IHtC0kKgkUXwiaI8PfcMfO7/80OH+IQMPkTjp4fTEvFQ3LiHDkqHgc35i2dN03s9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K3HCS00e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uUUVeTmR; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K3HCS00e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uUUVeTmR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id DEEC41C0009A;
	Tue, 18 Jun 2024 02:46:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 18 Jun 2024 02:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718693199; x=1718779599; bh=lxINc0kCB3
	nKZUg8Pjgeb8a0G1bTVhsiHfqgN5vLdOo=; b=K3HCS00evMayfUwfFBnHSUAwsU
	TG/znK14ZMvP5DL4hsl0iQyD4QETJhSufI4c2rzvJLpqtB53BaTYETkEnLNT2tKp
	l0Z5j7DajyKcZ3K+CLyifHOoNpCF9vF2PZUGauLt3yVmgVIOjZyG14RARnDf2846
	GeCzl+52I+xfZEh/0X7KvAFy+M0bBsFKpDNBO2YfAFUEYYVmqNj9VJt+xVeu0WMG
	XjVZthJ9FxHv5+9ae/7rREnXWyNdYUjvgtYIF0ZVA3mnCmYtwxRjGjWOupTuoJnd
	26kQnLo0HCxp3KMdv7OtSGoqZuOzrUiI3Bbr/QrYLV6a0EXwbQFLZSCu7mqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718693199; x=1718779599; bh=lxINc0kCB3nKZUg8Pjgeb8a0G1bT
	VhsiHfqgN5vLdOo=; b=uUUVeTmRuXVF7AHPEr5LPKz+ARzDCYCBQU2tMpyj/YZ8
	BJD23ffueXoiF60lNkXjs5gPOhuz3V3ebWOUzK9H93d0nET+kFixODe+BVoVvmPU
	NvTm0TfPKpF+DE30Vgrg9Otr5kJM5n62A23QrQAVOrChwzfk2eX8M9Z56nXbNYCD
	JgPYNwtVQezh0N5gzmW+2xw3KOloTe4GR/6VQppgLx9EywObZFP8HOYf9zZfi4Mz
	WaVfir8Xfr+jTK1xskURUKl895M3NqbmNlfgH/2y3zs4Tbs7gNx6U8OpA7TMscsC
	QphwyElmc36kG6IEfuTG8VBek9eMsPHGDmlmsCHOjQ==
X-ME-Sender: <xms:Ti1xZkIBK-IrM9dRu8fquS6-axCA4T7fvvCfQV70PtT-cxPRKZQ0QA>
    <xme:Ti1xZkLxPpxlJqS7ukGGuRVIJyM3jmo5z9qWtSBL4xTljdTPxTMWoU5qZN0YvOVsw
    1btQII6fZNreJoF2D4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ti1xZktdxq8yTuOTsFHwMNUzIeaaTUK_n2C7V_mA7WiZ0XsdY5cDxQ>
    <xmx:Ti1xZhaHTl_DKzBEPTT4dgt2Yl3OU1Vx_F4bYoSxIL8GDgrl2uYizg>
    <xmx:Ti1xZrYMWfpTLXTs-ijlOmXxF4F_ynT3fUYiXYWFIGrb8JWHi8k8aQ>
    <xmx:Ti1xZtCJBKbz-WJBjuvmDkU5IO4YJDUOBZBMoyaAOO5HeJag-_nSyg>
    <xmx:Ty1xZvLAlOYTJf9ksrH8NMJd0Ic1xh6O66Vn0yZWULGwUSd60Ensc2F4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7DE7EB60093; Tue, 18 Jun 2024 02:46:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3965437-bd7d-41cc-abb6-0311e5d933bf@app.fastmail.com>
In-Reply-To: <202406171618.A92D064@keescook>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3> <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
 <202406171618.A92D064@keescook>
Date: Tue, 18 Jun 2024 08:46:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>
Cc: "Mark Rutland" <mark.rutland@arm.com>,
 "Yuntao Liu" <liuyuntao12@huawei.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
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

On Tue, Jun 18, 2024, at 01:31, Kees Cook wrote:
> On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
>
> I'm all for more entropy, but arch maintainers had wanted specific
> control over this value, and given the years of bikeshedding over the
> feature, I'm not inclined dive back into that debate, but okay.
>
> FWIW, the here's the actual entropy (due to stack alignment enforced by
> the compiler for the given arch ABI).
>
> standard cap is 0x3FF (10 bits).
>
> arm64: capped at 0x1FF (9 bits), 5 bits effective
> powerpc: uncapped (10 bits), 6 or 7 bits effective
> riscv: uncapped (10 bits), 6 bits effective
> x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
> s390: capped at 0xFF (8 bits), undocumented effective entropy

Thanks for the summary. 

Right now of course we need to fix the bug from 9c573cd31343
("randomize_kstack: Improve entropy diffusion") that has led to
using full 10 bits after diffusion but put fewer bits in than
possible on some architectures. Unless you want to revert that
patch, we should ensure that any truncation is only done in
KSTACK_OFFSET_MAX() rather than passed into
choose_random_kstack_offset().

     Arnd
