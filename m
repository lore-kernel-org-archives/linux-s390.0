Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CD3B42E4
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029700; cv=none; b=UyR/mTHt/wnQ8goJ9Rt8r2VhFEVN9WP+9pqEz2iFr8WU5ltA6kG9vES9VBt89XR/QXOxt7qjHeF32ZEL4JOr5M6KB8vEfKES6S0E7gWyVBQrSG+0/4wnEf7seOmxKnxJwn6XkEGJeZ69abtHRyStE/fZ73xQrRcuyDWyP5e+MLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029700; c=relaxed/simple;
	bh=sSOMPBG4fiWze6IAdyKEgJOvNuDwNVHf2DlIvHsEtKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEW8Yx7ODwgoXmUhXnPiKfrCEmv5DWGnwjcQ5csal2Fa6fYqUolxCi2iN1GiDL1GCgoH418DxuMMxLlv6vgDihMbGxlx49/mXggWOr3ZJuPxDK92zC2LE79lifbtLM9QrTp/oPKveL1CGkzbLDSHI/wzEAKKX/IRn+Nt4Ee6OF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-752a7f4d4b5so1154588137.2
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 08:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029697; x=1786634497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ohZ39jK4R7nHBsxWJDOlT0sMAW4jJSovzDHcfJTHmAg=;
        b=Lv+gJeYQDGeN8/rGI0Fg3xqZNgZrTOzvalmtZBEy3ZcnVrzwRlDti0Mjm2wGmvLfUh
         DGJ548OypS5ccsCP6LMuk3VGr7JAz9ODmRZ9eaojMjeEXQyW++3uo78mzmeG5l3ksC+C
         VnuhRVC650NeFvOSrQmwFQ/veJad6GQTQAeYz59vCpYcXbw9H+PSvSKp8YxaY0M60HbP
         CWGd5eaIKBL7vcxzUSN2HwLiAcaED2rZiGTxOzafKwZr13IXCQvrcWH+UzuYmRTDvqMN
         bzm7i15PphZ5U3nwGhhxt1OIwBw9TkHxVbMt7cG3TH2udcQ4F+Myt55cRa+yCOpwRTal
         VPOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn8bNpvgTD/2qzfk5wv4BYhbF5Erz6GNQoDQzNYKIArHcDfStmEDviA3fh6Vj2LxrROGg0K1adiBud@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eVKTzzFzsMFjddCXGqMe046rS0T9ccHnPNcZpigzW4EGSAwz
	pS8tIEIHbMGdy7PDSLFTXH3WRZxURiIXRbFmvUXENUiTIyevQxQi7IptRYLMbT9r
X-Gm-Gg: AR+sD115dla9LhOK62pe4XNDay7D7AGpcCqVN/CgnJG5Ibk6ID+YakF13C38ycV2f/e
	SvHqRjZu/trqWHs4vjUp+FJJwx2HTnTrejb0sp6HqIJjV898Lv2pLLAjNegytD0/lyjNvMiuMod
	324IUAUJj53zmnMoc+RbV7hHpciVtC/zVKCba9UJ49SmBbsq2qgJHyfc3StM+cwNA260MousReS
	09YGng84sV6JzuSpH+umnUPeT2DJYrwpzRrG22kMRxzIxnXaN6z5NEzyzXz5NPFPZjNMCJrhrR1
	rHYATSupX37DtatsG72fczAeb4vCNJJnflsC5lOXqPDR0ha1Mv76uQRY+xRkB3uaU7LLHnxtvUQ
	oMBSj5jLl7GS9+y6tqmGcI+muYCrK779P8sE49GtFpcxah7OX9tccZin4CnmBC7WhrQvV/NnGsK
	MCe3EnF2qBbyV1YHbOQDax9PXyBm9YEd5S93e71rkq677+sE/iRymkZ9uAXD+qhf05I+Bce3ITO
	PBMH0fYdf+z6T8o+iaQmEZhUB2ghFCI+MgE
X-Received: by 2002:a05:6102:3910:b0:738:9c30:2b7c with SMTP id ada2fe7eead31-760e80fb774mr4742698137.6.1786029697200;
        Thu, 06 Aug 2026 08:21:37 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76048b76217sm3623087137.11.2026.08.06.08.21.36
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 08:21:36 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-74748e3a4d1so1135743137.3
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 08:21:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdBz407Oy0U14gOIE1M5U0V6oZN+5uCQ4Iqa/JdbMwOYHUQ+39qkXraqob5L3v3dfEvjETGsyWDMhQ@vger.kernel.org
X-Received: by 2002:a05:6102:2b83:b0:738:133f:8d5e with SMTP id
 ada2fe7eead31-760ea747b4emr4930162137.12.1786029696259; Thu, 06 Aug 2026
 08:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803180931.97202-1-ojeda@kernel.org> <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org> <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com> <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com> <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
 <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com> <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com>
 <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
In-Reply-To: <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 17:21:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBiCA6+SWatmbB5bVdFd7_9CPNgR_eaTcOUpqAEA5J4w@mail.gmail.com>
X-Gm-Features: AUfX_mytiRYZjGYX1aobVkgoZ5obof2d1lrRV5Gr1cwx_C_pvGoMLWUjStMFMZU
Message-ID: <CAMuHMdWBiCA6+SWatmbB5bVdFd7_9CPNgR_eaTcOUpqAEA5J4w@mail.gmail.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, driver-core@lists.linux.dev, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Thu, 6 Aug 2026 at 15:51, Arnd Bergmann <arnd@arndb.de> wrote:
> I think the reason is that there are a couple of architectures
> (including non-MIO s390) that take a shortcut for normal
> ioremap() that avoids actually mapping anything, e.g. mips
> and related architectures have a fixed uncached mapping
> of all MMIO space visible to kernel, while some alpha, m68k
> powerpc, and s390 do something other than a pointer dereference
> for MMIO.

FTR, several m68k platforms use the transparent translation registers
to set up a mapping to the main system's MMIO space (like MIPS,
but programmable), and thus just need to add an offset.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
