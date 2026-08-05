Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5913B8BA5;
	Wed,  5 Aug 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942544; cv=none; b=QlDqTARWLEwndA31o9u0MeoTzYxwbXu6AEhGuFHwdrAqr9XvwGTO/5zGw0huu4Er0eu6HIVl87YbgToXGf8OnuAgbnmJ96gM/XSjSWCnAUXvGKmunCs8nBUsBbxJp+mSSmHAqFVBBsq/ASbNXfxGf6PWy/IvOAVDIQ53/daGFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942544; c=relaxed/simple;
	bh=xCP0AJsN0LWwcut9uH1FrBmQbAr/ubD4ThGJWwDnJq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=fvShLo3OZ8QtGZrPmXbn37dO1RIzhEDSLx2s4SE3gNoUSHWTivLcsUXHOfSI74OoIyicz5AXk+L85cHVpEAdoW/LnihdEzXVEdUA3f9xuqWLXuoYh8v2TZQT8DiTgRDn+Xb5vNw0awwdL2K4+3t5ZK9uSlE4rTSShcJsXzoRUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIfHY7e/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIfHY7e/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482CF1F000E9;
	Wed,  5 Aug 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942540;
	bh=qN+jBzY4sO4wQKae/TxHUsaRK5FcAIoanVdZo53PTCE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=lIfHY7e/6dc3DEO6uPgih9oX3DUVdvwadv9Y7ffQmiG/M3DEph7BQ9SIZ56tg9mEa
	 l8IyrNbHpjuWifpBuz75KrCBzPV3Cucxbhj5sRHLBKgmBfJsFByGJdr3KkzJzj8S/t
	 +dzF5XT7FkyPUeOHVj6I6ZetDd4P4j3xSHzDKaF8IwLRYy7DnPoDwGoU3Dh+Ob0hgV
	 T96pORwnxM2oBa18+gaCn7VFftJ1prW3brtGAkAeZ86iibX70hf+XBc7gVIwT0C7Ix
	 J7ne0JYS0H8dy+/BKZGyfFFcaw2OOlFk10+i65gMxO4wb3nrR4+EQNwbAXjvQHR02a
	 +TGFp/IA/1jrg==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 17:08:54 +0200
Message-Id: <DKH3SHX3Q95W.3UTJEVH2K3H75@kernel.org>
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
To: "Arnd Bergmann" <arnd@arndb.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
 <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
In-Reply-To: <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>

On Tue Aug 4, 2026 at 2:02 PM CEST, Arnd Bergmann wrote:
> In that case, it would make sense to also change the CONFIG_PCI=3Dy
> version to fail the same way when the address points outside of
> the PCI memory space range. The current version in
> arch/s390/pci/pci.c just falls back to generic_ioremap_prot(),
> which is what I would use here directly:
>
> void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>                            pgprot_t prot)
> {
>         if (!static_branch_unlikely(&have_mio))
>                 return (void __iomem *)phys_addr;
>         return generic_ioremap_prot(phys_addr, size, prot);
> }
>
> The two methods here (generic_ioremap_prot() and the cast)
> are machine specific to refer to two different ways that PCI
> devices can be accessed if present, but there is no case
> for PCI being unavailable altogether.

I think we agree the correct solution is to fix things in s390. But the
conversation seems to suggest that this rather results into merge window
material, so I will go ahead and pull in the other fixes for -rc7.

Thanks,
Danilo
