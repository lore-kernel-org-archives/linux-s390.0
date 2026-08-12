Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062B436BEC;
	Wed, 12 Aug 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533579; cv=none; b=NcIGBPUD7q07G1OQvLB22l3td0wS8hsKVGwT83N4kvD/ov5ankCgk7HFeeUkRjTWzZTttZ3SnvJkEZC8vn3UKltRAHdGosZvn+UkmztSMN4huyDdJ1Y0F0UmFsSSrD5EeHXAv+ar7LJP/UIWR8YI4+5Ld2BVNavdSPoOHmvCkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533579; c=relaxed/simple;
	bh=+Bn+Q3nHOn1X2xwaQgCpf5eH6EK4BP1DTQzRz61/xrI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V/D7nn8jCA22w13gCROXkSlG5BuHr7GJceEP86c3k3ovDPo7azZ79L5eLh6Bea62J0HsTS6KztBedTait5jnjs9GekAm9NdohcDnrpSNBOjK8SBjMBgN80ll0d024w+9VoxP7v932kfAk9YiCzXEPNrCA0Pe5q5yU3FmfNr6iLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7A29492009C; Wed, 12 Aug 2026 13:19:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 76D1392009B;
	Wed, 12 Aug 2026 12:19:29 +0100 (BST)
Date: Wed, 12 Aug 2026 12:19:29 +0100 (BST)
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
In-Reply-To: <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2608120349370.48788@angie.orcam.me.uk>
References: <20260803180931.97202-1-ojeda@kernel.org> <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com> <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org> <20260804071330.24760Aaf-hca@linux.ibm.com> <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org> <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Aug 2026, Arnd Bergmann wrote:

> arch/um is the only other one that does not always enable HAS_IOMEM,
> though most m68k targets don't have any support for ISA/PCI style
> MMIO or PIO and probably should not enable it in theory.

 While HAS_IOPORT is indeed a feature that has propagated from Intel x86 
(or really 8080, etc.) to non-x86 systems through ISA/PCI what's been so 
special about ISA/PCI WRT HAS_IOMEM?

 AFAICT HAS_IOMEM is all about just having peripherals located in the 
CPU's regular memory addressing space.  All the DEC MIPS platforms fall 
into this category, never seen PCI/ISA, some have no peripheral bus.

  Maciej
