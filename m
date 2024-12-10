Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CE8634E
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852056; cv=none; b=a17fXeCpuGtp9WXuuA6wYqv+sUSp8+uBWPv4T0IhBqbGrjaCmKhwYH1xRZ+w/LOLk98zqghgvi+tV9VZliyarPFDBWkahM+/qmZTl+0zGtu6o5sF/QS1Ko0FMWnqAnqU84v9w1xxX1tnBVu0bLdl7u+Tv58HzBY6e49R86AZsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852056; c=relaxed/simple;
	bh=Y9Up7Zg+iyA0n56miZ38zueiGUjxJwQJgWARnjm2vZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GblwKbqZ3STx8132rK4DlDKb/hHKXmftk+Q4QBtmk1ApUcO0jvfsJiqVhTZTy7JtCULTX3HQWBn68ScMAO4kVk32cWRHdCC4Z6Qk5jV5FxfAuwgAiLFzwSuz6MhuXiI7kNQvlAbzCbsMnMvzV3z8oHc9gxBKCXIlEKuLbCQbIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrJITF+i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrJITF+i"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2155c25e9a4so137415ad.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733852054; x=1734456854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RArVkKSCeMH/NY6o3gQIWtxTREQOsCr1U+SuNtxbEwg=;
        b=RrJITF+ijB+z0s9PlbhtAHtVpSVAqsqFtAX1QLROd7jzZkoeIerRiGYHyGx+AeyS5b
         QrDA1M2s2I8tmg0Z9MzfXCVH0PwcC+v2eyn5h9Bs7/XKEf3O1duuh6X41w0q/mYJFyXI
         kM9nmca5d9OuN8k592OV/1dYQO3gexurKoXfai8mlAmNn2OpNIa5o9i9RSuVZvc+Zea5
         1ZPMT9aQ8XlVZgFS7bBmu5KaTN6h/FNfKrBQbvewJLeSiPDI6GF/4VDbRd0ddGVk9THn
         iwXlYTOHXFzce4J3jjLJX9pj7+ruDWU7tpUywgJx5HrDNzOEg9eIKYuhqN6r5kT+e2H8
         RZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852054; x=1734456854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RArVkKSCeMH/NY6o3gQIWtxTREQOsCr1U+SuNtxbEwg=;
        b=PT+bG1CIbge24UzWsYxvy8wt8qdopbxFXKgariI8cABkYNHdJ/dDKW+aLib/0NbIc6
         SANR8Crl/cC+0PF8GkmFCP77rcLMuWr9419fG9hER1Y8OLLi+OZhPcHlgpnEaW2w+jg1
         ZMC2d7yg+al5DmE7USdhOutBfnOYAdpZS67jcF13BGBz/DHCqmrLWvze6ISzVmu9ZcZN
         VAZRQSMNgf6fdCHeHYTu9cUJycDjLgXfENudwCFr2joBY7XEJqjDsIeg6J7ZGvCjiM+C
         LE4c418zO4V6COkdf3XpmJ0ltvPSyskiZcHhtYYRuHm8XMWujrJyLfs7mXitR2HYbV+W
         l13w==
X-Forwarded-Encrypted: i=1; AJvYcCVZGAi+vCMnZjve+4MhJ0ejPdM0WSM5nWO/cay2gLOGOOwMKG34hGtDPry32CC8oyDOP2/tvJo9Go63@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82StDWyO2lWIgq2sUyhVAsNLKThLYKT6f9N9PBoQq1uq9LMrr
	9VuJCXU+46h6u2CH/lrWf0ukz/BeE2MlatIjLLYOLedINpjIH9y5IAaW7EZh7RvXsKtNJnGIIUq
	MZAsJp083CHVKzRcGwhyW/I1eh1ihAZ86B5qg
X-Gm-Gg: ASbGncuRlNyP8MJ6x4yOLT9aiYaFf2OlEHcYaFNG3eTaQhRZjU34gwnvw/xtfXZcRBF
	26Iv2FiWmyaPRz2le4Ix9/+zlrI1LA3OFYlBF+0CkSASgXzunpGMvCsqjzv9kMWKD
X-Google-Smtp-Source: AGHT+IEDudBnir5+jttzQm+7tNnzRHUlcioRTO8j0Dis2V+coMoC8sfWSozH23fEnrYfZy4bwgZvjEwIXStM7LatHiM=
X-Received: by 2002:a17:903:4403:b0:215:9d29:1aba with SMTP id
 d9443c01a7336-21674cbdb12mr2775015ad.1.1733852054062; Tue, 10 Dec 2024
 09:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
 <20241210024119.2488608-18-kaleshsingh@google.com> <CAHbLzkq2SNaqzx4d981H2QfQvtObS3X0pPL8=oqFsFbMditWPA@mail.gmail.com>
In-Reply-To: <CAHbLzkq2SNaqzx4d981H2QfQvtObS3X0pPL8=oqFsFbMditWPA@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 10 Dec 2024 09:34:01 -0800
Message-ID: <CAC_TJvdReRHzBSgg2iqOw3Kw6BBOtwGE=8nB2Hsw-nsmkxN0+g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 17/17] mm: Respect mmap hint before THP
 alignment if allocation is possible
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, linux@armlinux.org.uk, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:37=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Mon, Dec 9, 2024 at 6:45=E2=80=AFPM Kalesh Singh <kaleshsingh@google.c=
om> wrote:
> >
> > Commit 249608ee4713 ("mm: respect mmap hint address when aligning for T=
HP")
> > fallsback to PAGE_SIZE alignment instead of THP alignment
> > for anonymous mapping as long as a hint address is provided by the user
> > -- even if we weren't able to allocate the unmapped area at the hint
> > address in the end.
> >
> > This was done to address the immediate regression in anonymous mappings
> > where the hint address were being ignored in some cases; due to commit
> > efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries").
> >
> > It was later pointed out that this issue also existed for file-backed
> > mappings from file systems that use thp_get_unmapped_area() for their
> > .get_unmapped_area() file operation.
> >
> > The same fix was not applied for file-backed mappings since it would
> > mean any mmap requests that provide a hint address would be only
> > PAGE_SIZE-aligned regardless of whether allocation was successful at
> > the hint address or not.
> >
> > Instead, use arch_mmap_hint() to first attempt allocation at the hint
> > address and fallback to THP alignment if that fails.
>
> Thanks for taking time to try to fix this.
>
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  mm/huge_memory.c | 15 ++++++++-------
> >  mm/mmap.c        |  1 -
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 137abeda8602..f070c89dafc9 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1097,6 +1097,14 @@ static unsigned long __thp_get_unmapped_area(str=
uct file *filp,
> >         loff_t off_align =3D round_up(off, size);
> >         unsigned long len_pad, ret, off_sub;
> >
> > +       /*
> > +        * If allocation at the address hint succeeds; respect the hint=
 and
> > +        * don't try to align to THP boundary.
> > +        */
> > +       addr =3D arch_mmap_hint(filp, addr, len, off, flags);
> > +       if (addr)
> > +               return addr;
> > +

Hi Yang,

Thanks for the comments.

>
> IIUC, arch_mmap_hint() will be called in arch_get_unmapped_area() and
> arch_get_unmapped_area_topdown() again. So we will actually look up
> maple tree twice. It sounds like the second hint address search is
> pointless. You should be able to set addr to 0 before calling
> mm_get_unmapped_area_vmflags() in order to skip the second hint
> address search.

You are right that it would call into arch_mmap_hint() twice but it
only attempts the lookup once since on the second attempt addr =3D=3D 0.

Thanks,
Kalesh
>
> >         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
> >                 return 0;
> >
> > @@ -1117,13 +1125,6 @@ static unsigned long __thp_get_unmapped_area(str=
uct file *filp,
> >         if (IS_ERR_VALUE(ret))
> >                 return 0;
> >
> > -       /*
> > -        * Do not try to align to THP boundary if allocation at the add=
ress
> > -        * hint succeeds.
> > -        */
> > -       if (ret =3D=3D addr)
> > -               return addr;
> > -
> >         off_sub =3D (off - ret) & (size - 1);
> >
> >         if (test_bit(MMF_TOPDOWN, &current->mm->flags) && !off_sub)
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 59bf7d127aa1..6bfeec80152a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -807,7 +807,6 @@ __get_unmapped_area(struct file *file, unsigned lon=
g addr, unsigned long len,
> >         if (get_area) {
> >                 addr =3D get_area(file, addr, len, pgoff, flags);
> >         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !file
> > -                  && !addr /* no hint */
> >                    && IS_ALIGNED(len, PMD_SIZE)) {
> >                 /* Ensures that larger anonymous mappings are THP align=
ed. */
> >                 addr =3D thp_get_unmapped_area_vmflags(file, addr, len,
> > --
> > 2.47.0.338.g60cca15819-goog
> >
> >
