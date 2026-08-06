Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30250314D05;
	Thu,  6 Aug 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023890; cv=none; b=heNCn1KP792BCUgJz2rWGZgMWVSLFfLReOn/C88Lp5u+PnCQ+NaQKEs4DFAPvwhLaxmt5Up49BSHwSJfrmvXcV/IdwhwrkChVZw66zdAA5IHGnF0oYkfvJlbwJY9bjjRgW3HctH7eaYGXP9w5vNbRJCFPvv316Op/iwAKy6aaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023890; c=relaxed/simple;
	bh=rvHfPVUPrp0Q1BvwdhU0hjfhSiYL2rHUnDCmQRbwAY0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TWKsTjb3zOuZ3kbJLbxWTPu4BPLSWXyxpwtqURfTB1qCKs2fb0mcMlONxdCvXQJM+AdGX/+cU5utf1qgZ+iDTOq0FdWmQRKbKDFQrBIDSVG6FI0lvoPb6dxmcRz6hWVo1Gu7tRLZcB/NVuLQ5x3VOPEFIVJ2Nm+S1YL0oHXv9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CXVVo1gv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4IV2er3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CXVVo1gv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4IV2er3"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 140DE7A0130;
	Thu,  6 Aug 2026 09:44:42 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 06 Aug 2026 09:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786023882;
	 x=1786110282; bh=SffWfkAuC6IpPL//dChg3TjS6eFD6okWUDUROiR7ojo=; b=
	CXVVo1gv4BnbINd+1Iopqu+oaSt+t6CVhbcEuJcsA6IJH4TQKlX3A+8fE9WP7HTD
	hTXHmDdNNa8M16OgZtXuzyHHZwLPT6cj3+Vjz2vswRCn7XgMfLoOcUMS57Oun5m4
	7XdTMrdIz/Nx6mhax0R83uI5rGPMlFRNgXPejtmO2xFOMScEvzvAjUIj2L3RSA1G
	RgPH09/zraPvmr4RbqFLvuCH5JbCahJ0fxwSJqOK4DzXo5gLs7M/s3yfOp5DMWfS
	0EUh1NcTzYLIwC84r0uvbQGywmRMUw2U5SnaRZrgz1JkXluLcF/1xAP84N/pGz68
	DK+vkb0OrzetqY5Upi8akg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786023882; x=
	1786110282; bh=SffWfkAuC6IpPL//dChg3TjS6eFD6okWUDUROiR7ojo=; b=i
	4IV2er3OmQWRnVPmrcaOE7Nn7HjGT/dIyysjOqn6MuinYa2ikqy/dL1X6XvyQp4l
	EawFVs3L21MfUk3kqwyBG/34cD7A9psxABHsOWW1hoT8RujXs9cMbwcs/pDttpMu
	r3bRbwpr1S4yo0dxchD7YzTdDdKEXtrThW3Rur0H99y8V4YLx4HDJhXgY/ZkVpUX
	4K23OtTma9i01MtViSt82svpIjqKGXbxo95YHd4QA0MnbNocxvGur84/Wxd4g3qn
	CbQSzpajkymBqkzCsvoxQY96WBzaNtwJkyAPcETlqbjSJRjNk4xaABTXGN6r3WIX
	2jc96u9FWEbDOMIDZNKgQ==
X-ME-Sender: <xms:wo90aq28hrGZD57YGy8Q4hF6nmXOMDZztTGOFTa4QFY-i6836nQv_A>
    <xme:wo90an6X7HRIKaO6IUD2BnJ1wpu-nkKxm14zVMJKt0W0bZ6Kw2jX1zAXM3mUbnMOf
    PuIjWAL7lHNzKm1ZhP9ObpBAcQNtvj78qBdDyuCQTuEueK06foxLKaa>
X-ME-Proxy-Cause: dmFkZTGpJof1sHKDxQr2kf6+faMHM8CHAoxoFGnmes9chtKSeqbShYa4XU6xJ13UK32Bhf
    +ckyI8Cm082Y/29gK72eKQTeIHMjpaKvc+9pa30E7bsCqQldycyul4xHPPewbMfTeAAbWD
    Z3R2PKC893jRDri041Jn8KmpLQ8YUsRBhF40vBgA0SKnUtK9Og4Sz/Yx3OB/i9Vu9kxLjx
    S5e6nd7RVk6G+ux9CqsZ0/cHmCWniZeaZUYpFJwtQq6TDM+KppgJ/bzzr7sfsLeJwexp3K
    i7DAliX+5oqzzU712NbWgJDkb7k+59fGUimNrzCYm7cuyFtsXVOJLWy3nZHvisHeimLZsr
    UyWdYDOAJXrse+GJuXzsI9o7NRXeiAB1kmbOKvOqtjcOAO7L5sWGHBSrsCgNJ5fX/kNNq/
    7YA952BmmSS2w+LPVjvX1dBoSqhj3Eo0Qgb8W4U17IEOsZBU2k5xvNZZjXEVSwBEbhPgMw
    Fyuzd40eAT2U/iLeJQX10N+UqruaRRa+BvbOtsyCv96TABUSuw0ic1Dr2rXj2DtcoAn3Ys
    LDG2hJZCZ8xQ/0msS+qS6au9WNZNcogcxTYaGsA9tSDK9xFaEEZJxMqeBGkYJEVP6gZs6k
    UBNshwR5Prd/0fdcp+7tLedHneIfFh85N0NEyzCyEhWxbLbizzuiFi3GwGMQ
X-ME-Proxy: <xmx:xo90agTncSz9OG5vtq73FR684m0XeWUfPvlF65yM5PEvYgcenNvmVg>
    <xmx:xo90almwDdCqNIG6ckPJ8UE5qOEwiV5fFmwBCpe0lZCUypFiHvFdQw>
    <xmx:xo90apOklAxX1APulT7yn_pHPPT9_l0yOWZT2MHutBj0O2ENqc1a3A>
    <xmx:xo90at18bkM4KqCIjSN0v3po5B81a_i_xp1jfWZ_LODQOn3oRs7Xfg>
    <xmx:yo90aoQVZq7VcpHkioG2xgXWgld19ltTC1xJNYj7172XhCG42rw2_gdq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5621F32A0065; Thu,  6 Aug 2026 09:44:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Thu, 06 Aug 2026 15:44:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
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
Message-Id: <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
In-Reply-To: <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
 <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
 <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com>
 <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 6, 2026, at 15:25, Niklas Schnelle wrote:
> On Wed, 2026-08-05 at 17:56 +0200, Arnd Bergmann wrote:
>> On Wed, Aug 5, 2026, at 17:36, Niklas Schnelle wrote:
>> Ok, so memremap() by definition cannot work on s390 for regular
>> PCI devices, since you are not allowed to use readl() etc on a
>> kernel pointer returned by memremap(), only on an __iomem
>> token returned by ioremap().
>> 
>> One important exception seems to be virtio_fs, which uses
>> devm_memremap_pages() to map a virtio_shm_region, which in
>> turn can come from a virtio-pci device but is backed by
>> actual cached memory in the host instead of an emulated
>> PCI memory BAR.
>
> Interesting, do I see that right that devm_memremap_pages() and
> memremap_pages() unlike plain memremap() does not utilize ioremap() and
> thus isn't affected by our nopped ioreamp() when there is no-MIO?

Indeed, I had not noticed that before, but you are right that
this goes directly to the page tables while the other variants of
memremap() go through architecture specific ioremap_prot(), which
may or may not create page table entries.

I think the reason is that there are a couple of architectures
(including non-MIO s390) that take a shortcut for normal
ioremap() that avoids actually mapping anything, e.g. mips
and related architectures have a fixed uncached mapping
of all MMIO space visible to kernel, while some alpha, m68k
powerpc, and s390 do something other than a pointer dereference
for MMIO.

     Arnd
