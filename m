Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0838DC68;
	Tue,  4 Aug 2026 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844964; cv=none; b=MNbmzMaQP3VB0W+MOIkic0+dRGJQM5KZ6lu2bwjsElGrvAHsCT59/OLB1V/HYCunV2ARwRbxdvipUkRCkJRp/FMfw5ZYAMi739FWb4uasEdsFHqwGZeR+KqHEAf6QtDGSURiaazKwQ+7pesZhDVzv+kA6XIcqjjlc389Is1PG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844964; c=relaxed/simple;
	bh=TfoL62eZz7nSoLv8+0E8B+YTOCT6z558wbQb/CMfQdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HsC2U34ICeV6ixQWD7cB4jHLngwGvw1W/iNvksv+xzwozoxbeWnyxVfcnphFXfUt/fR37xplXraPtYQOt7I8AamrnmUY9V+DAHL06nbb07/8EdvpordJVdRwobf4a75lJbEc9q0JLoHOO+ZyWgccUHst4M3RN/vxL51+JBxuhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DhLm6GAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6j93psx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DhLm6GAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6j93psx"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CDD4EC01E1;
	Tue,  4 Aug 2026 08:02:39 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785844958;
	 x=1785931358; bh=Z/wu0JpGiYhd+Hbgzo+FTQjllgTiXml1cxedfhDN9Mk=; b=
	DhLm6GAcjWbpuA6KD+T1GXWUsDUvK03nj7YgJSzB9umEPHoxRG/wt+z5abpZRcIK
	CHYh8i54X/MKso/nXGhF8oq1Z3hIyfmJHIaHfjjh5XjcOHabY0uNWChaJu9+1lmW
	IrP06oqZF4dpnCYaArl3jx4ucPOhuBs06JLETK8XreVFUzrjQ7ixG4rkabHIqad3
	8NxvbQmQCC3bQQuX5RRCNJnK/cqZt+z2o4WAIJS6H4SRnEmBrSssSdXFvOOYcIKV
	Wr+62LRjKrMJP4n2PvNV6l7U8uGoqoCdrk6drzVLGQA4A3rKUma/9j8Sujb6rKEH
	qtI9jzgCuQQv1/D2E/mRuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785844958; x=
	1785931358; bh=Z/wu0JpGiYhd+Hbgzo+FTQjllgTiXml1cxedfhDN9Mk=; b=W
	6j93psx9sB7/CRwDcPtcA50XBY/lW8QO/TjvUicP7hnW4DBd50PRQKOdOp4Moi6o
	KhuTFm6xNleeNBt+kpKGdkn9d497z7/E67a/fsHa7SUAyCcYUL4hc1pckJmKyHmP
	qteKLqGZF+ZOFEY87LYN1LVL0OD7mZQIB2IpA3llpUc4K95A/xmqmqaex0HA26Ho
	ynNClk21KxaF3pbjdsR1xXfPwzXvh7P8cyBYpXIb8q6MFi9scZcZ3GJ9B9jDvTQd
	gcxHuw79XHTKgGSJBVvBOJmMu9XV+M+QKp+Tlbt87gbUJikfrYrSysl3zm/9sVqt
	k3RaWo7LI+BRCCZD8Ttsw==
X-ME-Sender: <xms:1tRxanuUgW9UCM0kFKLlgQDzHqCfW7SuKKBbE-xyOp2djloHEirkXA>
    <xme:1tRxajSOhUx40RH91fxqKMjGWRtdJoc2KEg9-LkFtmHAO2xmzP0O8hqY40dumGhpQ
    mPLpyI1xF8JK2HEchklNugy_aEBFLU2J-WFaGTd37saFFu71qeb>
X-ME-Proxy-Cause: dmFkZTGVMHwlBhYrnIoOOZl4/K95HNiI+6p6yyVfoVn3aP8OYpQJi9nqH6J0gOLwKf3jho
    zxUm0GBc1R04A8H/hhB8YtCAKCZnvZUISCFid133HQSJWXiPwYlpESCUBIJrzTAxLKsSP8
    jRSh4rVnvUYKjsodteiRYrUXAL259DNozYUL6lmAIMiHex+TEl7Civ7+JwrDIlP0GAE/3Z
    BY3WjzPEsXFQd7UhPLdLDBLAtu/wwwP7cwLi0CfLsK8mWhdlanPIe2x6fU4SxKfEBEpjhV
    BTPvMFkjSHTM6I3aGf8ieOZqhhvQdgYWhRnYq7zlH7dMO3uEQcPLCuXXO7LyYCDruke6pi
    aTnXHtUAcaXR+wfzc488iQ5frWRgmd6wIYc2C1yeXztJ7GbToWyc1oK9XOOB3HbeyWPn31
    NcQX3aA30MtOPWZB4ReOzdN7mclgKc5uAxSz6sKr9qah3wgdr+285MKsotVygYBHZ6vhrx
    nk9kt/siwg0fO/aLwFCDvKHsVBI/EtPYoZXKtfSDWO4mnxlFWXxP9FO7SZj4g0f7z5UJmQ
    cJVGcMF1HFPuMpPgBVB6ApHcdJUqGsniAQXdPb/olwkfoS4T5+1e4RKSvVhkYsbOCbn0ta
    dYf9G0hJz/R4tVKzjUqD0+DqKYC/Zt5035Q66gNX/H1H+5kuSDA2otc3MQIQ
X-ME-Proxy: <xmx:2tRxaocEj4BVlYLd4WlZiVJDajwUwR4dqV-D17BGErZzBWrp7WP-gw>
    <xmx:2tRxanp9RMypyh-7thr_MZPRBq_U5I-Kr9TAijcQrSo5R9j3HXO32A>
    <xmx:2tRxapfErRi-p-6Jm5OItSQdJHexx0zWRyhuY7_0CMGavvCOMimf8w>
    <xmx:2tRxavn2FDgZiEqUiJKT-uH4tkZph3BqqsQB81CbP0AhibQ3QRZvEQ>
    <xmx:3tRxaqtbnqWdgcnHEmary2iGsKilCcSGvWvP9Ksvv5ibzz1135u34x2d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7064B32A0064; Tue,  4 Aug 2026 08:02:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Tue, 04 Aug 2026 14:02:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Gerd Bayer" <gbayer@linux.ibm.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, driver-core@lists.linux.dev,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org
Message-Id: <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
In-Reply-To: <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 4, 2026, at 13:10, Danilo Krummrich wrote:
> On Tue Aug 4, 2026 at 12:36 PM CEST, Arnd Bergmann wrote:
>> On Tue, Aug 4, 2026, at 09:13, Heiko Carstens wrote:
>>>
>>>> I just sent out a fix [1]; the only annoying part is [2], but we should change
>>>> those doc-tests anyway. For the one in rust/kernel/io.rs we already did in
>>>> driver-core-next.
>>>> 
>>>> [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr@kernel.org/
>>
>> This looks like you still provide the rust version of ioremap(),
>> turning what is supposed to be a link failure into a runtime
>> error.
>
> Which is the standard for many core APIs, such as [1]. However, I do agree that
> in this case the correct fix would be to have all architectures provide the
> stubs rather than the Rust code.

We have both types of interfaces in the kernel. For HAS_IOMEM and HAS_IOPORT,
the link failure is intentional, as it helps identify drivers that need
a Kconfig dependency and are either unusable or potentially harmful if loaded
without this.

Having empty stubs only really makes sense for things like LED support
where a driver calling the interfaces can continue to work
correctly when the interface is compile-time disabled.

> However, there's already a precedent for this in the kernel, e.g. in [2]. Of
> course, it would be better to clean this up, but depending on whether there's
> more architectures having this issue (I didn't check) that's separate from a
> fix.

arch/um is the only other one that does not always enable HAS_IOMEM,
though most m68k targets don't have any support for ISA/PCI style
MMIO or PIO and probably should not enable it in theory.

> [2] 
> https://elixir.bootlin.com/linux/v7.1.5/source/include/linux/device/devres.h#L115

Right, we are definitely already inconsistent here.

>> The simple change below would just extend that behavior to !PCI
>> and make that consistent with CONFIG_PCI=y on machines without
>> actual PCI hardware. Of course any code that might rely on this
>> is now a bug that likely never gets caught at build time.
>>
>> This still relies on implementing the __raw_* helpers as nop
>> to have the same behavior as the PCI=y version, as the generic
>> version would just end up dereferencing the invalid pointers.
>
> As mentioned, I didn't check, but if this is the only architecture causing those
> issues that'd be the better fix of course.
>
> However, IIUC, your patch below would make ioremap() and friends silenty succeed
> and only the accessors would prevent undefined behavior?
>
> In this case I still think ioremap() should just fail.

In that case, it would make sense to also change the CONFIG_PCI=y
version to fail the same way when the address points outside of
the PCI memory space range. The current version in
arch/s390/pci/pci.c just falls back to generic_ioremap_prot(),
which is what I would use here directly:

void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
                           pgprot_t prot)
{
        if (!static_branch_unlikely(&have_mio))
                return (void __iomem *)phys_addr;
        return generic_ioremap_prot(phys_addr, size, prot);
}

The two methods here (generic_ioremap_prot() and the cast)
are machine specific to refer to two different ways that PCI
devices can be accessed if present, but there is no case
for PCI being unavailable altogether.

       Arnd
