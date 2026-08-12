Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6543B3D1;
	Wed, 12 Aug 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554000; cv=none; b=LyMYdu1s+2gl0GmWH3qPCO8z7Nbrn0Z3pAvwGuQi/vEDHXL/qq5e99FbHg5N/BpOtGdVqDWG3LOSdJetCLasYUi4tHFxb1Uz4Ie7kkX4ZGwMiXRxvxRov5GIEH/FL2TXhOkAZ+0Hook+wrEVG7Ssh/KLTiwxzCXGwKJXpE7V2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554000; c=relaxed/simple;
	bh=COsxPsgzygMQ/mDqla3VOTd+8FeyU7R8a94fdNIC43g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+zPBIQaqNG4I5AYYwVNKbFtjyKFqYi6axdpDeczemJSXwfXvsIJ0PjbVZE7cojvg4vjiww4Fj73MGI0heMFqNL2lUjR9x9GmGh9IdBt6HMoVc3Q4QLrqkuT491VkNep7yqNcBscaN91sBPKYjuWcW74M+X6hk6lkhfaPYyfB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1309092009D; Wed, 12 Aug 2026 18:59:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 10DAB92009C;
	Wed, 12 Aug 2026 17:59:54 +0100 (BST)
Date: Wed, 12 Aug 2026 17:59:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@arndb.de>
cc: Danilo Krummrich <dakr@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Gerd Bayer <gbayer@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, 
    Daniel Almeida <daniel.almeida@collabora.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, driver-core@lists.linux.dev, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, Boqun Feng <boqun@kernel.org>, 
    Gary Guo <gary@garyguo.net>, 
    =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
    Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
    Alexandre Courbot <acourbot@nvidia.com>, 
    =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
    rust-for-linux@vger.kernel.org
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
In-Reply-To: <3eeb0ece-42e9-49f2-9632-962793db8d4e@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2608121731000.48788@angie.orcam.me.uk>
References: <20260803180931.97202-1-ojeda@kernel.org> <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com> <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org> <20260804071330.24760Aaf-hca@linux.ibm.com> <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org> <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com> <alpine.DEB.2.21.2608120349370.48788@angie.orcam.me.uk> <3eeb0ece-42e9-49f2-9632-962793db8d4e@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Aug 2026, Arnd Bergmann wrote:

> >  AFAICT HAS_IOMEM is all about just having peripherals located in the 
> > CPU's regular memory addressing space.  All the DEC MIPS platforms fall 
> > into this category, never seen PCI/ISA, some have no peripheral bus.
> 
> To me this is more about the driver model: On most architectures,
> you can use portable drivers that use IORESOURCE_MEM resources
> with ioremap() and the do readl()/writel() on those to access
> little-endian registers.

 Obviously I can't speak for the s390, but that's been my observation as 
well -- it is a matter of coding style then rather than HAS_IOMEM being 
inherently PCI/ISA.

> s390 and um only support this conceptually for PCI devices,
> and the HW implementation is different enough that the abstraction
> breaks down in some cases (like memremap()). m68k Amiga is
> similar to decstation I think, in that it has devices that are
> memory mapped, but they are always visible in the kernel address
> space and are accessed through their own abstraction instead of
> readl()/writel(). m68k q40 does have ISA devices with both
> port and memory accesses that can use portable drivers. I think
> other m68k platforms use a mix of ioremap()/readl()/writel() 
> and their own lower-level accessors based on the driver, but
> none of those drivers are shared with another platform.

 On DECstation we actually have driver code shared between TURBOchannel 
peripheral bus and PCI (and possibly EISA) and it obviously uses the 
standard MMIO accessors consistently regardless of the bus binding.

 Then there is code shared between TURBOchannel and platform stuff, also 
with the system models that lack a peripheral bus too.  There is leftover 
code using non-standard accessors still there, but that's really a matter 
of resources needed to clean this up.

 For instance drivers/net/ethernet/amd/declance.c has now been high on my 
priority list to clean up and properly convert from its current mess to a 
regular TURBOchannel/platform device.  The only issue outstanding are MMIO 
barriers, which have never been properly sorted out in a generic way; cf. 
arch/mips/include/asm/io.h and the iobarrier_*() stuff there.

  Maciej
