Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560E463B8B;
	Tue,  4 Aug 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858768; cv=none; b=uUMCgE08cXar0JeWViqh0bGjqUH0Z0xB1W78WWG/tKm6uqrBccYS8X3BmZGXMxQBVbLKRfCR+owbApgghWx5ix71oZniEU+nhafd8wNNCySLdcfWSvXEyCN5mralK4968elMYI+aWV4IwQwfj2lQnscb+TE8W8tK/h16P+bEFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858768; c=relaxed/simple;
	bh=4IMYxJH0hPLNM/inpTfFxvUD3zVh0AxAaEUPOIGaumM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ChbjsP/M0NFdAJYAVHGnvne6McIGNhu2D1zyixlrJorr7k/z/Gb3lLNv/PfFYBgAzsEE9Gzs+lEipoKjbPxO+iXcnqB/hGrrl4AZg43hzcQ+jg46ldc/IvMP+xrqDCanvF+M6ftrSzPF3qbnEIWwGyyJluKqK7xuFYz29zefHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XlbuGjOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJ6wdfMW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XlbuGjOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJ6wdfMW"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BF3B14000DD;
	Tue,  4 Aug 2026 11:52:44 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 11:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785858763;
	 x=1785945163; bh=tvHNcStby7mA2MTedxkPfcu3psZZkC2QAAIerdvv5BY=; b=
	XlbuGjOjzvtkwwzyaMzIY5/q2c25pE6974gbbyEj7QvtE+brS+TEWKMENWwMZnsV
	2S8YvnEK2FkgyXvMcn8EMGGDmmjJdFct/1IGy6y8LlDJu000B5gRyKlho7EbfK+V
	6yGqTT+mH7A+XQiNhkpYXKJSXgxSLg52dvK2lK/QrlMvkVkNfROqZSilXrMjwOMY
	xqDsYcS2bhdSaS9yYPCYg/+g6F/ehTZH+3pbvUs9mgccsYzFj1fQExZOGLPaZS7B
	ZSwokkKQAuMtSTKfbxNXtoE2ku76npIPOayG7OIWqP7iOAEptk18oAufdjgpeVH6
	MPsBicPq4XmrXVUAnNCj1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785858763; x=
	1785945163; bh=tvHNcStby7mA2MTedxkPfcu3psZZkC2QAAIerdvv5BY=; b=O
	J6wdfMWMFi6sSQVuySFR9sQBwgSkRoQZrH/FrkqWgbbr2B4VgyODxgJ/GOqc2tnH
	WyzRJlle83RX7n+7Tb6TpLKlS4A8TImzYhrd8U2WjsBEW08WBoBvwuEUHEIZXYJS
	xVqaMJtHkq+KVy660rz2HDKI9HcyYQrX8PtNol2zPTKfARZdCuwoLauFWAiYD8W9
	YKrbijhAysnw9o45BfgSXH46rfZXrzfnTcCCD/TmNMIgKdxZ7/8bcJv0x0XAYew9
	NYkyNDDKIn/7jVpL0Fxx/4T9eouYSgmf2G4Nsp3zCysNm3tFT5veebLMj8vTx7NI
	6FefIOwtuGg1FcrKHWgag==
X-ME-Sender: <xms:wwpyaoq7LvcUG1u5yPw1YP8DuLa49jXieUbG9ZUvcDjALEQs8-ZZjw>
    <xme:wwpyapepKqYvi_mjS2Iqlm1WRhHNbniW52G0hm9jnwHY1fsY7O9XEiPCjV70_qovC
    0qncrywDQQefIAg-8Ha2a14YWbuBMAjTGoiGxF1ShlQaWhz5eHv6g>
X-ME-Proxy-Cause: dmFkZTE6dy9+2lfDYpR/aLw8faXRHD8Gp+7LDACqd3lgKT3c4TyXY77vVtGtLw+6ogbHJt
    RQ1TcE3RozZ2SKSmFDQ6m+eaxPt+BvQoXFQNJf/uoDzOfVqb/mG16Mwn/s7DlM4yc2yb49
    KqKdeyu0ECs1bNgAJjzJESLzzlkIf0BZuC0WhY+1LlN6Fyh3O1wK1s8ROBp4its/Y5r3z3
    rHRnJxh4mhXbgVgBBbG0AmBtLAdNkpPdL0fZenjvt9OqJUBbiLS7ZUo3URb0a+JLqe4w/m
    bQ0bEWkC7SLImMlL6TzmuBBUG87+UKpXuU5ju0aJK7x1js7JJA4rslTuh12IbmKBX7oKAn
    urSEe69AN5eGR0KvqNwOedlZJrHWtZWlZourX2PWybBQABypSOaW83p/qBhxIsuF85qNo9
    mjeUBE74+saty+KLxFHj4x2WGuO/DrpZquCsNpYIjc5vHoBITY912R314E6ui9iYM7SeTm
    nDECyBPa3JKyvK4OFU55sVReSbFX1vcbYN9DEc6TtYNp1YgszM89KBfoC/E/8NOvk+oBgW
    kIi8sqfCFsN3r70rDTFc49YEiXttdApHS8Kk7/D4yJf6q6ziMy9DC3gUx0SxPqWu/NPXbw
    aSkSsuGlxI0I4jiSIaWl0kpiHX5H9f0C6cjiItFdijVgv8TVNUoyR6LYA24Q
X-ME-Proxy: <xmx:xwpyavYPzTKZOjVb8fu8GS0IEVwQN7nOXJGsR7JmK1MP7clHDC_R_g>
    <xmx:xwpyar0VSTueGpVxBppRaCHJM-ikHwG8H45GxiLXRWFuE9U658R2Sw>
    <xmx:xwpyah7LMvaEgXxgr59Kw0hgurcTrjwXrbyboi6IVxkJn5Has5HslQ>
    <xmx:xwpyanQICiQWRhTwGF4MAcLA67CAWFE3lIzG2FwgY-7_vnAtykEpXw>
    <xmx:ywpyaq4ADYVlAyWSIOHnXxaVtWE4TeJi2fviLbyhkM-YiVQ47DG6-y3A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4743132A0062; Tue,  4 Aug 2026 11:52:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Tue, 04 Aug 2026 17:52:14 +0200
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
Message-Id: <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
In-Reply-To: <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 4, 2026, at 14:21, Niklas Schnelle wrote:
>
> I think there is also an interesting interaction with memremap(). 
> That calls ioremap() under some circumstances and it's a known issue that on
> s390 memremap() will work if the PCI memory-I/O (MIO) instructions are
> enabled (e.g. on modern LPARs) because then ioremap() actually maps,
> but won't work if they aren't enabled. With your proposal it would also
> work for !PCI.

Right, that is an interesting one, as there are somewhat conflicting
requirements:

- On PCI MMIO areas, memremap() and memremap_wt() should return a
  normal kernel pointer that can be dereferenced, e.g. for
  option ROM contents for a framebuffer console. This can't work
  on non-MIO guests but might work on MIO depending on which
  instructions are allowed those mappings (I can never quite
  remember how this part works on z, does this have to use
  pcistgi or does a normal aligned load/store work as well?).

- On areas that are backed by physical RAM but not part of the
  kernel memory (something like z/VM DCSS) should be mapped
  using memremap(), which would fail with the current !MIO
  implementation. On x86 and arm, this is done for mapping
  firmware blobs, but I don't think anything tries to do
  this on s390.
  Right now, not having memremap() defined on !PCI configs is
  the one thing that lets you know if some non-PCI code ever
  start using it, other than crashing a non-MIO guest.

> I actually have a prototype lying around where ioremap() always remaps
> by mapping the address cookies much like we do for user-space access
> via the s390 specific MMIO syscalls and then doing a page table walk in
> the accessors for the case where we don't have PCI MIO support. That
> would also allow us to implement the s390 MMIO syscall via
> generic_access_phys() getting rid of quite nasty inline assembly and
> over 300 lines removed in total. On the other hand it would cause
> overhead for non-MIO systems and sadly this currently includes all KVM
> and z/VM guests which is why it remains on my prototype pile. I haven't
> actually been able to measure the overhead but clearly more work is
> done.

This would not help with either memremap() or the !CONFIG_HAS_MMIO
issue though, right?

       Arnd
