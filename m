Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502092C0F6D;
	Wed, 12 Aug 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535245; cv=none; b=MWALKQOUCLiCVicsEeVdX33fdZ2knTQuaQITC0sndua/HFSEKPTXPonOJESXqxFoI+EdJcl2av2M7u9YbTHv2S+cWCNl7ziO3/9SXFmTt5+Cr5yaXNGGg8AED3Bp9eVdEJirIlG5Y/VP8ugo9TzD4YLVPa+lWsMDUE+74caAOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535245; c=relaxed/simple;
	bh=jnxivYxViv0aHFjyB0ecnqcoMlW1GEceC++ncMLm8Is=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bQFpBHDyJSkIYl5mJayaQ4NVdM/qKr6FAjw9klNJAVdYqUECpMNV5HFohDTbsraeENWBwwahtKeMdwsGSNQJzhzhhmxvIXmKHdI4XpUfsIQyj5R+Oas7kWggnGS5lUlmrjki72qH7WmwpPOmcihyU4RrDLddYug3bAW8fjYX0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W1aBkcdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2JlU8iY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W1aBkcdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2JlU8iY"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 651AC14000FB;
	Wed, 12 Aug 2026 07:47:20 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 12 Aug 2026 07:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786535239;
	 x=1786621639; bh=auPqy4hWqOWQzUYNHj1ppeU4j4CcIK3OlMDtI8AbMOE=; b=
	W1aBkcddjTPpKlqX8JqYWHDW8u5ZTYQSOCyImwyoXupsh3XkLwrXyFtP+pmKUiY3
	clUIKsH+AQWd/sETdNvIgiOTEutIJS2HiLCOx2q3TpcG9ZHEAqy+JH7aovQiUbfu
	KpNjwTBVwLIYLvlHCupeGYmIkcH6QIhSbwKmT/+lhCZeZD3nc+ikejQfdwmkyD3h
	4FhNx2bn+jnM/pgaF4XBdKBG56D+LEpw03a6aAZiFTj3pbZ+24sBuAW2lIBSivbT
	QjBWhIIZu2TDyUBTQqynlAY7VCm50JCYYbITRPZqOOlDfPSF2++lv4dBaalPy+IV
	Z8n6nKVbwFjgdbSz2Gksag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786535239; x=
	1786621639; bh=auPqy4hWqOWQzUYNHj1ppeU4j4CcIK3OlMDtI8AbMOE=; b=P
	2JlU8iYuc4NkzbJrWEsgMdz75m1yy/7TC3vtjFcDS59Ddqe2JlRKtrl2JEzoXi6/
	77fmVAei5z1fI7kORgyVwRMp7YFPpbNQ7AtWzlyTMZqIcfbtUZZZ8f9X8LahajP9
	9gOdmmN684frn5Q4J9DzKvbjnI4D9QiWAJ6Ep1bjn3KC/m+tJKtULRlN8qjdm8T4
	ialzoGiGn+TSeY9G1r8uNqYDomjcsjUPWLsmV6qEdCHDF1giUe/SZC9jMFyt2qL9
	5buB1lboaIgjMJy6i7WQ3uUUOD+URWNiwiAx1BuYTmdpFHY4hzZBL6iXH3nkKUZi
	TYLMXwAk1m/SsDUjM8wVg==
X-ME-Sender: <xms:Pl18as1QUWt3b1tzH_jlv0BVErLHe9l1H81R-YF1BgBHwBDxvoLfPA>
    <xme:Pl18ah5pwt7LXZxDePedrXQqREuUFwvcJjHvUSRjNB-OfuY5Fqd68vjJpWRAFrTBq
    2cskbzrIuGScToacTX8H2YyUqVPwBlFsa_TYcnsL2OZtVXByWmteT8>
X-ME-Proxy-Cause: dmFkZTEwMyLj+YIpdMh9D13N5MOyTmf5E4tXtrYh5XsBywu5xKvrnx8kBAGbf8NR8m09b7
    ludXZWYIJO4LcIafhsaQES+HJv6JFZiRfaGqCH/BaTmDY/nA4J6qOEPr3n6SW9409xAGLQ
    ayXmK9zjKLW/9pgLqZdBF5U3DSjuGG3y8Vl2NMbLc0H/wAFD4Ew0SeTM9qfxS+KVrpadFp
    cfZ/WJtu6521j0agBPVW4NDfWQ00OFnjGkREfpOP58lc8VLNABahSt0CvvoL3YbVG2EsSq
    bDgBAgznIlETibeGcWwgGrDcFP31DoDE5bq8k4zT1kOYuM8BGIHWre+ZJ3yCRomoa7K7fF
    qqN51Wjfe0zBHoX+JwVgi46bJ2JzCBdkHwK9/wG+dT0p7IxhaV0oW/ZhNxrZnVR3xjQbBR
    uAs7bqOmja4U4ZrjTmyBGit6bschuOa2MqLqTYGqbuCh4E36B8xbNGT99SqaIt4gp5EwHV
    igOwKzgMw6OzYiuQ0g8eK8o6TAKg872WF9GZiWken7bPooA9Hsl21C8n43tPnpVAy3P1e3
    i90Cs5csORElUr4UzSvgqMVEBS0EEf6WUAMCbMnKxPA/rofuGRHBH/Ysm8QbxOdmWwYIYd
    3pKxtxSgycKzPk/auXTpUn8aGt0ND1YipcDigYQTXgAzL6/i0kLffOU0ZGaA
X-ME-Proxy: <xmx:Ql18atIIziyguunkHgKZ_k37KtFvCz1Vi0yV8Iri6ywHS6I6m_UNHw>
    <xmx:Ql18agrFNSUSGwKJwqzVbNhqLrMB4s-cBRJL-CRLY_MgHXnowoDiig>
    <xmx:Ql18arz3xwHalWjYgvKPV6LPCG8jABVpuwwjvNNN8Spj2NMtAW-ETg>
    <xmx:Ql18asdsuCNiuIZSujGMBJpsri5LmUbauMQOK7DFCzAChDfxRCjlqQ>
    <xmx:R118arYa8e6qMYrKN4zz2wskcZfMVp9u_w048Zv8xs53-MDtAeCPp_tx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5FD8F32A006E; Wed, 12 Aug 2026 07:47:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Wed, 12 Aug 2026 13:46:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
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
Message-Id: <3eeb0ece-42e9-49f2-9632-962793db8d4e@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2608120349370.48788@angie.orcam.me.uk>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
 <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
 <alpine.DEB.2.21.2608120349370.48788@angie.orcam.me.uk>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 12, 2026, at 13:19, Maciej W. Rozycki wrote:
> On Tue, 4 Aug 2026, Arnd Bergmann wrote:
>
>> arch/um is the only other one that does not always enable HAS_IOMEM,
>> though most m68k targets don't have any support for ISA/PCI style
>> MMIO or PIO and probably should not enable it in theory.
>
>  While HAS_IOPORT is indeed a feature that has propagated from Intel x86 
> (or really 8080, etc.) to non-x86 systems through ISA/PCI what's been so 
> special about ISA/PCI WRT HAS_IOMEM?
>
>  AFAICT HAS_IOMEM is all about just having peripherals located in the 
> CPU's regular memory addressing space.  All the DEC MIPS platforms fall 
> into this category, never seen PCI/ISA, some have no peripheral bus.

To me this is more about the driver model: On most architectures,
you can use portable drivers that use IORESOURCE_MEM resources
with ioremap() and the do readl()/writel() on those to access
little-endian registers.

s390 and um only support this conceptually for PCI devices,
and the HW implementation is different enough that the abstraction
breaks down in some cases (like memremap()). m68k Amiga is
similar to decstation I think, in that it has devices that are
memory mapped, but they are always visible in the kernel address
space and are accessed through their own abstraction instead of
readl()/writel(). m68k q40 does have ISA devices with both
port and memory accesses that can use portable drivers. I think
other m68k platforms use a mix of ioremap()/readl()/writel() 
and their own lower-level accessors based on the driver, but
none of those drivers are shared with another platform.

     Arnd
