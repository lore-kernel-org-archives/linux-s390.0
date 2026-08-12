Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E765430CDD;
	Wed, 12 Aug 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533840; cv=none; b=f7QnFC3AVAzoaeWbgqWkeLbglh/VzLMHDy6kv1ghJSU+ouRyCI5COIR0JSO8vi2qz21BrZ3KbbbMYrQ0dgBVVGM47hY/Q7jI2s0OVSxYrG4PfpX97eIJkCuz8OypzQR+N4Q7OqxB9f/bOtPCa5EFHYx5IUPkvAndIo2FbnP0WqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533840; c=relaxed/simple;
	bh=ioMPHBkTbeYq7a69NyMZfdEHzCVK3LOwwzrU8x0yGj4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HqtflBqM/8fK8lDPTfAdZENmnAlZIzKN9QbLsPQhgnbhNT/ToJzUrKvNATYeYBIN7bVSOErLI+60JznQBhuiBNXxAXX+UOZ483MQLiasBsPZqzhIInA3Q8Q3TGH8YcIwka5mrwakNtmdCYsHF41GBOJGAFMDkiSe0k+bjw3kg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D342692009C; Wed, 12 Aug 2026 13:23:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CDD2792009B;
	Wed, 12 Aug 2026 12:23:57 +0100 (BST)
Date: Wed, 12 Aug 2026 12:23:57 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@arndb.de>
cc: Niklas Schnelle <schnelle@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, 
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
In-Reply-To: <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2608120426510.48788@angie.orcam.me.uk>
References: <20260803180931.97202-1-ojeda@kernel.org> <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com> <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org> <20260804071330.24760Aaf-hca@linux.ibm.com> <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com> <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com> <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com> <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com>
 <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com> <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Aug 2026, Arnd Bergmann wrote:

> I think the reason is that there are a couple of architectures
> (including non-MIO s390) that take a shortcut for normal
> ioremap() that avoids actually mapping anything, e.g. mips
> and related architectures have a fixed uncached mapping
> of all MMIO space visible to kernel, while some alpha, m68k
> powerpc, and s390 do something other than a pointer dereference
> for MMIO.

 FWIW 32-bit MIPS configurations only have low 512MiB of MMIO accessible 
via a fixed mapping and arrange for a regular mapping via the page table 
for anything beyond.

  Maciej
