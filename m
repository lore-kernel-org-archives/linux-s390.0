Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96C412C11
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435822; cv=none; b=XjMSAV5iLH3Wm6PH2qKGBdD5j6c033LIG5aLMK6yBvRlC8lsZUCBuz+CSVs6WbkoWuEkC+PBF5Siahye9ulnZcnFx3kuZIYOFkTXVMtdwu2iztj4nKZTFzQ+jFsHRs7tLtB82IfY7uRRIS5IZnTPNAprLG9/+6W8nZyZiJ1kXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435822; c=relaxed/simple;
	bh=G1i7Hmp3x4MyiNkQbU9uiF4+QFCGLyrU0CXxtzNpVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tzc+4eXSO3hSGxoZp2N2lInJCoMad2olb1y9IkJ8h0besJFWayM0SDijGS7EFVFSwyX31tSPniTZhAWkPni05d7vjjpPP+6iWAI94Zbe/LB18bI80ISMOUeqBmhmIQv5oazv83hKOZlcQbXZuE7PMO+YyjOK7pZibmakgsKLMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTKbOcyD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTKbOcyD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so30678965e9.2
        for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435819; x=1787040619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=DTKbOcyDMWHb4HoKjhv/LiJSlKcwrGHUJk+pyU3g9T7LB4SHddJnam+zm/RVr4OHVi
         JmRza0TF3LeijHjPurRsnhis019jAxqy914rzb79tBPQiPUFYYVcQhIVfEjMhLnahSP9
         QdoYf4FK0tiz9lQ66/pwZR3SjMyaDMXLAF3lr85IiCDuJ64jysV3XJUjsKMVPp3yT9Su
         lzVuFGzCT/VFdQ0LCb7YMDBF7SnSGYxmBxYUtkVggOlQrMmpkjX0Vo6KyQ/xil3uxyVI
         e/kugHsi4X7tcVITCTGS2Ap7GVzZ1FJ2dIUx4oSDR74XtpjavFlQRlL+zGHCLTFdrbHs
         BrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435819; x=1787040619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=GWYCYH0/zruaweGCvdqp0dHifGEpdWCWCkd3tiGml5CSvf7T/nvJL9SqI3+HCXA1J2
         pIAA9fqQ5I6fe9g8FRXWHOlMMjaXehS+5PKM6jf8btIeAyeHoKC0tyZmHe/xD/2BLoNq
         5T60JVtvxUWmZrPjwDNW0bAL35nyLckWdDjoLPlM2/hFICB0SJHUULFvS3BqQZD36tgg
         laiiB416HunYdBg22UWIwjZo/IKWssS0Iwh+pTL5upX+6Qs9F1/G/z5G5VKwmXr1Foo9
         XoQkLPXvX26Gx/mNdlpS/7frrjrqDqNqpfDD8FM7e62ekN0EoXrzTfvz/vOhZCPKJvp5
         eTVg==
X-Forwarded-Encrypted: i=1; AHgh+Rpl535JfhADHA/LQdAAE0l/e04kMss5TKKFOm/I5x9pV9LEbvutftF2NcgNzUGRe+W2vKLCDF3oW/8B@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcqyu3K4OrqzHVeeJUBz/ZTgNs7QqWR3kZDisVmvPKQHTjw52R
	cQyNQtgwkFh6/VHdacdXSeqkfkMXXsejvXRfOWaklxvbVp6n8KmvASPL
X-Gm-Gg: AR+sD10OLHpXKgePR47tVbPveQP6YV471gtjRtk8D2RAIj1zp5ilpf1URZkTLprfe2u
	u1ZeD/49HAZwYzV2HkMkIaUjSqocJl+OVYRUBvxbiW01/a8knBeLzSYoA476n1YlD1964ZDI6YW
	MacnGvNkKWzPuCiQqV6QePDZzAeFfeWCkhjW1E1XeKVcsIthTuleG7KuviaXCB6DXyvoVDcOYZX
	Ou5zuO3aAfOwS5b0bbZMuhGpXcVjuhuyEqoY/gVZuA7ziesYWaqyY0/f/XTKz+G6Mvc0PV/FeFz
	LmFNYKWwj2HEQa0UKGT6c0bYD5y1J9qHCPofzEbtht/6HqVojI+Vxl2hymn55vxUoTpGIgt9dKI
	LFi50djisVgCi+rfLKEWBi707Mvu60H7N5HzurHXm0tV1HJkXAOhvFvFCLpsaSbcfZ+9TZv8t0V
	Xnnl1nSF0ASxLpXblwSC5eGjh5VhkBCh16mrYMlatXM4Iva3uSHTGzfjAcTnhpsm65Z9uRVewqy
	mvHJLEEe96WWDLcYU8CFvZmSthN16fwKlg=
X-Received: by 2002:a05:600c:821b:b0:499:6a92:fff1 with SMTP id 5b1f17b1804b1-4997847e9b5mr25827975e9.18.1786435818734;
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac6e6sm2454288f8f.6.2026.08.11.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:10:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20260811091016.5ca67143@pumpkin>
In-Reply-To: <33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
	<33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2026 14:07:01 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote:
> >=20
> >=20
> > Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0: =20
> >> mm code often needs to know whether some mm represents a kernel or
> >> user address space. This is currently done by comparing the mm
> >> pointer with &init_mm; besides not being particularly elegant, this
> >> ignores the fact that other mm's (e.g. efi_mm) may also represent
> >> parts of the kernel address space.
> >>
> >> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> >> Subsequent patches will use this flag to replace comparisons with
> >> &init_mm. No functional change is introduced for now. =20
> >=20
> > Did you consider performance impact ? This test is usually done in quite
> > critical memory handling functions.
> >=20
> > init_mm is known at link time. Before your patch 08/22 there is just a
> > comparison of mm (r3) with a constant (loaded in r10):
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 3d 40 c1 09=C2=A0=C2=A0=C2=A0=C2=A0 lis=C2=
=A0=C2=A0=C2=A0=C2=A0 r10,-16119
> > c001404c:=C2=A0=C2=A0=C2=A0 39 4a 03 98=C2=A0=C2=A0=C2=A0=C2=A0 addi=C2=
=A0=C2=A0=C2=A0 r10,r10,920
> > c0014050:=C2=A0=C2=A0=C2=A0 7c 03 50 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpw=C2=
=A0=C2=A0=C2=A0 r3,r10
> > c0014054:=C2=A0=C2=A0=C2=A0 4d 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 beqlr
> > ...
> >=20
> > After patch 08/22 we have, it first checks that mm is not 0, then it lo=
ads the
> > word located at mm+528 then AND it with 0x1. This load might be costly.
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 2c 03 00 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpwi=
=C2=A0=C2=A0 r3,0
> > c001404c:=C2=A0=C2=A0=C2=A0 7c 85 23 78=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r5,r4
> > c0014050:=C2=A0=C2=A0=C2=A0 41 82 00 10=C2=A0=C2=A0=C2=A0=C2=A0 beq=C2=
=A0=C2=A0=C2=A0=C2=A0 c0014060 <assert_pte_locked+0x18>
> > c0014054:=C2=A0=C2=A0=C2=A0 81 23 02 10=C2=A0=C2=A0=C2=A0=C2=A0 lwz=C2=
=A0=C2=A0=C2=A0=C2=A0 r9,528(r3)
> > c0014058:=C2=A0=C2=A0=C2=A0 71 29 00 01=C2=A0=C2=A0=C2=A0=C2=A0 andi.=
=C2=A0=C2=A0 r9,r9,1
> > c001405c:=C2=A0=C2=A0=C2=A0 4c 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 bnelr =
=20
>=20
> Is that a real problem, though?

The cost of the read is likely to matter most if the branch gets mispredict=
ed.
I'd also guess the mm isn't usually NULL - so that branch needs to statical=
ly
predicted correctly as well.
I'd also not assume that the mm is in the cache (unless the surrounding code
has already accessed it), the L1 data caches are small.

	David


>=20
> What we could do is to just keep the =3D=3D &init_mm check internally on =
configs
> where we know that there is only a single such MM context.
>=20
> Just a thought.
>=20

