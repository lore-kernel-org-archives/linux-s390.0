Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CA33BBAD
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454718; cv=none; b=KY8MlDbyJvPTbrNYPaXB8UNDg9p6h6NvLyDOxVRgvwP6fwOrnsKjy013RGAxCNhFp34axwM77bSKJEFKY3j6c8QjvnIu28MmNQr2rZewQ+MQ6X1SoGWBW5v3zEU/oTsFaKa1195ta5c2DQo77GylgYE7KifZIPJZwdZBymHX1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454718; c=relaxed/simple;
	bh=CJ25QsZC14Dq2xSASACZGaavy+QR/WSe/Ecg1RU88VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeBsS2trM0nbDGZFySqRscUD5+bPdJ/jI2fdEJKIxQKI/vnQbb+FTl6rSog8S8B5MqPG5wEQ89zLp0QCxhZNAMAKA1GVosDw4i/SgTShAsqlt1YUFZcr7H3nS4W59m1zuGgPARntXNcsJVu45zUJHhXHhWg8tqDerUdC87Fm4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnIStsS6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnIStsS6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so6527475e9.3
        for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454714; x=1787059514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=QnIStsS6yw333/uQFn4gHwHOIAM/BwaX8RtDlSZYzxgMwoqEGzDdG3xtTh3I6cJPpU
         5V86JZENSXZWK5ScM1s4g2wjrRt93cLdZ+ZtmdkDcjKiyG+XEUtJ99aurnod5r6UxF1e
         uAkXDqJMGMibbwkRk5JC21p++4aFBsRDXgezbx89Nx7PRyVQZJAfiq0f/V0he0UZnujx
         kHJ2h+FGJftbCFXFJkssI6gS29+sQVVeBeWk69TZo0nbR8UCLxZqzzOdserI4ehdCOFx
         dPoWrh/Mc0EjmKrXJhIq/KJjJf1ZwReZhTW8e+gZjgz0HiJXFzcO5eeZeTcbCteDnZ+M
         ISIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454714; x=1787059514;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=L5/KMUW8BDTTUFFQzUQ9z3qgIp+xT4m8WRjfiucWb+gcDHmkDffdu3mXYz7XRtL48T
         +rxt9QMXZziGIp2Wpb3fZz4nmPnCTTOHSAVl9+hpCQiam2y3I/swKKu58RKwbLW55FsZ
         YMsYjcZBIUd9OBtXZYOtEtetRfhKhB3gyyOvDaYTwxFu4UsVupAYotmCIo5xX4/CEATK
         YRx3i1tbrYbWtYmAoXn4GCuXBWSbCDpvn8c8uRwCAGohqknY5dDjs/o24yEFKjRq34Ax
         vqGGipIhxZOhMRIK+XtMeTdBscsDDH1JPrv7sZ47FTUDpIYNVr/yg3WH+VAWTpf80QmT
         0B3w==
X-Forwarded-Encrypted: i=1; AHgh+RpHvfTPqpSrP+Dc06x5Y/ws7NfAw19e9FURapv3bfdT45ZTPcBK3nEsfue3BQu558q3nLldCP3lXM3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKn0sRGt/aGbOHjwRb/+T+LJyAxW7U6kVIyKO60DGSpG1s0y4
	+DkX8RC4ce70541QT+unqoyvb3cQBvHPTljzCTitLfQIkEyKIFdJAmZ7
X-Gm-Gg: AR+sD10+l6UaM7b5Z3b8VRc9zAII93u5C44UFVf+KwUvylq4ww0bJxB8bvd0gt82a7G
	gH8wmLqtUgHwEH5VGTClMsaKcw/ILU9rTF9Db+4Pdmt37vhe+OH2Y2k6NKKqHGa/x2VlpZnqiuD
	c5PnvjjpbCIZ4aSSvveJ+BCaUMGx2uNygp2ieNvMf0yqwzIyXHnBdC1nBwzW0ksQ9SsAc4s91Ca
	iqtLyDcUdrfUKkKZ/5CFdyjE+/8Q7hvH4W2WGf859gFdZRoNMHwAuXUkuAOEnOsMp/e9aL19Kb+
	ffQjLjN6A7b4yTnxnvwGfbvgLeisL9M+e8KeQbNNHMpMKklPXxQG7WLH0HJ3v6Vli+rsBO7K2sq
	JQ3xya6orTHtwol64zrNpxhkVwB5cxH0TO0LpOuVgYa73Vs5mqvvmvjddTUriBxjH1flTqKzT1f
	y3XvPnQMCXJa/OBlOtYSLpTPFKfsD4OtbLvpUUnX633Vkv42Jg5SqQYE9Qh/ZO+vt2b6ohJuqaR
	cZpsqEDzI+ObPzyZQw30WCM1psqb9A3+597
X-Received: by 2002:a05:600c:4513:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-49978468c2bmr48261215e9.9.1786454709883;
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm83541285e9.1.2026.08.11.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:25:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, x86@kernel.org,
 tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, Vishal
 Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
Message-ID: <20260811142507.4c6c760f@pumpkin>
In-Reply-To: <01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Aug 2026 15:59:35 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0:
> > mm code often needs to know whether some mm represents a kernel or
> > user address space. This is currently done by comparing the mm
> > pointer with &init_mm; besides not being particularly elegant, this
> > ignores the fact that other mm's (e.g. efi_mm) may also represent
> > parts of the kernel address space.
> >=20
> > Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> > Subsequent patches will use this flag to replace comparisons with
> > &init_mm. No functional change is introduced for now. =20
>=20
> Did you consider performance impact ? This test is usually done in quite=
=20
> critical memory handling functions.
>=20
> init_mm is known at link time. Before your patch 08/22 there is just a=20
> comparison of mm (r3) with a constant (loaded in r10):
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	3d 40 c1 09 	lis     r10,-16119
> c001404c:	39 4a 03 98 	addi    r10,r10,920
> c0014050:	7c 03 50 00 	cmpw    r3,r10
> c0014054:	4d 82 00 20 	beqlr
> ...
>=20
> After patch 08/22 we have, it first checks that mm is not 0, then it=20
> loads the word located at mm+528 then AND it with 0x1. This load might=20
> be costly.
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	2c 03 00 00 	cmpwi   r3,0
> c001404c:	7c 85 23 78 	mr      r5,r4
> c0014050:	41 82 00 10 	beq     c0014060 <assert_pte_locked+0x18>
> c0014054:	81 23 02 10 	lwz     r9,528(r3)
> c0014058:	71 29 00 01 	andi.   r9,r9,1
> c001405c:	4c 82 00 20 	bnelr
> ...

Thought...
Could the check be replaced by one that checks for kernel static data?
That would require that other mm that represent part of the kernel
address space be static (and probably not in modules).
ISTR there is an address range check that can be used - and might be
cheaper than the explicit test for init_mm on many 64bit archs.

	David


