Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9343933F;
	Tue,  4 Aug 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841843; cv=none; b=nXyJk3L3yDj+MKVGxtDdlDpgkA0aGDcvms9QyIdjj3FLmNen6kQshC/W25h8ed/g63bx6rEYF/7jUBy2HG5ugLXP5S/ryADhkXdmoHsohv7GDxHCzexAyipVkGFCuykjaU4a7+xH36aL0JvKn43cKNgOER/Y0lIR+uysoux8vjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841843; c=relaxed/simple;
	bh=doSlb3i9NB1iTOqLdWSB1tJl5muSITvRuZ3aYndBMVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Z28Gs1okn7SCX3MU/XnU4KI5CqJN/f890QAYXHNkpESXgzK19L9w83iZKaeahuPlRUr6CHNKB+Zjdiajh1k6AJHerwjwJju5P2b/tpWDXq3WHhUuH06Wl1KBd+9MgrQR97OPIfe/5/pmoaU9y/evch4334cJfAKVYkPRG08e99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO80srqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO80srqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F57A1F000E9;
	Tue,  4 Aug 2026 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785841841;
	bh=doSlb3i9NB1iTOqLdWSB1tJl5muSITvRuZ3aYndBMVg=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=iO80srqOiGoKRX+2EA3QpCTyBGYsVfNupf/1X4qF3d810qvhg/aEErqqnUAEGaM7c
	 qMW081vLHc/Veqx+i2RmcWvkbrE70QoKI7WxUdX7hxJbdy8pIFg4pUGqrXckriDVRv
	 VHlFnpgvcBS68MsCJxgFx43FFFI5h6GfYx4h/NBceriYQ2bASB4WoVgqcpz1+3uPWr
	 iLwwsNQkvGpTmSbNMXRkHlQoSfpsi+Nawef7hNhFVUZjYO7ZjSrnL8qhu+ev63dEj+
	 HWH/VqeSUD0Xu9jb0gVvIQ49nfPRyxEnuZEN7Xk4LybtCMvwERlGaWoS76kLY5wGFv
	 otfdZ2EBfJ8zw==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 13:10:35 +0200
Message-Id: <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Niklas Schnelle"
 <schnelle@linux.ibm.com>, "Gerd Bayer" <gbayer@linux.ibm.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 <driver-core@lists.linux.dev>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 <linux-s390@vger.kernel.org>, "Linux-Arch" <linux-arch@vger.kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
In-Reply-To: <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>

On Tue Aug 4, 2026 at 12:36 PM CEST, Arnd Bergmann wrote:
> On Tue, Aug 4, 2026, at 09:13, Heiko Carstens wrote:
>> On Mon, Aug 03, 2026 at 10:09:08PM +0200, Danilo Krummrich wrote:
>>> On Mon Aug 3, 2026 at 9:56 PM CEST, Arnd Bergmann wrote:
>>> > In theory you should be able to use rust code without PCI MMIO
>>> > support, but I can't see any practical downsides to making rust
>>> > 'depends on HAS_MMIO' to avoid having to add those #ifdef.
>>>=20
>>> I think the implications should be minor without making Rust depend on
>>> CONFIG_HAS_IOMEM.
>>>=20
>>> I just sent out a fix [1]; the only annoying part is [2], but we should=
 change
>>> those doc-tests anyway. For the one in rust/kernel/io.rs we already did=
 in
>>> driver-core-next.
>>>=20
>>> [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr@k=
ernel.org/
>
> This looks like you still provide the rust version of ioremap(),
> turning what is supposed to be a link failure into a runtime
> error.

Which is the standard for many core APIs, such as [1]. However, I do agree =
that
in this case the correct fix would be to have all architectures provide the
stubs rather than the Rust code.

However, there's already a precedent for this in the kernel, e.g. in [2]. O=
f
course, it would be better to clean this up, but depending on whether there=
's
more architectures having this issue (I didn't check) that's separate from =
a
fix.

[1] https://elixir.bootlin.com/linux/v7.1.5/source/include/linux/regmap.h#L=
1809
[2] https://elixir.bootlin.com/linux/v7.1.5/source/include/linux/device/dev=
res.h#L115

>> I'm wondering if it would make sense to make HAS_IOMEM always available
>> on s390, even though it doesn't make too much sense without PCI.
>> But at least it would make s390 again a bit less special.
>
> I see that with CONFIG_PCI=3Dy, s390 already falls back to
> generic_ioremap_prot() and just maps any phys_addr_t into the
> page table as PAGE_KERNEL, regardless of whether this is an MMIO
> address or not.
>
> The simple change below would just extend that behavior to !PCI
> and make that consistent with CONFIG_PCI=3Dy on machines without
> actual PCI hardware. Of course any code that might rely on this
> is now a bug that likely never gets caught at build time.
>
> This still relies on implementing the __raw_* helpers as nop
> to have the same behavior as the PCI=3Dy version, as the generic
> version would just end up dereferencing the invalid pointers.

As mentioned, I didn't check, but if this is the only architecture causing =
those
issues that'd be the better fix of course.

However, IIUC, your patch below would make ioremap() and friends silenty su=
cceed
and only the accessors would prevent undefined behavior?

In this case I still think ioremap() should just fail.
