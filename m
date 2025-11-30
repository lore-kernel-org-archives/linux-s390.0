Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83011A2630
	for <linux-s390@vger.kernel.org>; Sun, 30 Nov 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764462497; cv=none; b=uNJ+jibJI7sQrliRFhTV3qseEtOMyBlC99nEBC1pSe4TbQ7I4lcfgdv2zcdkUYBoNG1PzbZ4dSCUSudRrs/4JxZmXG0vqnnGkduUWU0+d6B2+Fa1r2kVIkV3Td6fV4UQcVjrUhnPAjzsnPVsvffA15xlcUoDWEXz7STtO6Fx8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764462497; c=relaxed/simple;
	bh=Mzgtx6eILlsGb7LK4nPkMJ+u5m8B7FYrZ7injL6JS8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNV1zjTRx09FDg0FqzAlhwPetfdjsUspszp7RhvLcVno1wD/MIFzJUfXglJ14IIgg3BwwIe5kOuBHa/Og3Y1h1JG+5tcohlz9uItNTILSrvrWNlHXl8ZSBCpGs1iLRkQOIl1jg+7iCPNpx1zz+dp8nAd9c22n9qkmv8P+xeBOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1lasM7R; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1lasM7R"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed67a143c5so942211cf.0
        for <linux-s390@vger.kernel.org>; Sat, 29 Nov 2025 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764462494; x=1765067294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdkwplQZXP7FjFnU+v366rZ413pi5bTQ7R9T4YIrwjA=;
        b=Y1lasM7R378MJKjfw7T24hsMmiU0aW5AeB91Xau9QbEk1jzTg/aFFqzoYQolnB70WI
         0L/5+xpdqOQUKVfja836A+EmiNisUIi5pG6VuTZ8Ps7IrSIUTj1bcpgBEHZ2B4T4zJ1o
         2lEe5YOIDGQPZFWzeJlmOcdwaE2uqlT6YjQqo5McTXnEJaZVSyc8A1ucHdtlwsMlcOMy
         z184amR5k1cC2D+MfRCW3XN4vlrI0Z71AMR00JRsIyCmiw44tEc4NqbZYSBSGXMCC/Sr
         zab4pOorr+bKP0TbP8u4AAgORp64LLkvFfdzPZh5HvgjyaMOr2N2ZI5+5OqD49gDiIwQ
         jRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764462494; x=1765067294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdkwplQZXP7FjFnU+v366rZ413pi5bTQ7R9T4YIrwjA=;
        b=DFeP6NHogFb701xKUVKy3Jq+HdZZPucboi5u76HeVh2ThWF6hJYKHmVXCpl5rpq3CW
         0jU2UKaWrM+iMpA5eAQkTACeEoSbKLaMF8FE+LveHDs77/O8F332EYuhl4d13TaTBXGs
         XXE71Jk+vKYvYoGHuzreXJTZ+iZ1NRSqAwhNl2TAmBll19pX4UVxG7uV7Bqky8wZz3Q0
         99QWkDzhAxjKslXh8n11XhpsnsVgkV67WtgPPdSS20Faj5jOepk+xFjfrIl++5Pz5cUd
         lAcS5Wc0KJUnuSFex7JcDTB50D5srahJ/1txGVLK3zDpNzvDrnZ1qQNExfsAYihz6w8j
         llAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJrf45zhAzXFtej3eugKJCMcFEYXHPBjTRYP81OiV+WD35vVvGnLmZgDY2dXrOpb66RTh45YfyplTC@vger.kernel.org
X-Gm-Message-State: AOJu0YwokB/oLBHh4McCKlUfb++48ivB5gwmEFMI2dQSN9N5PU/xA00L
	yGChEdoYk4tNFqJzQc8/f8JaA9vj1NCkVBxTLDrHPjO+qSYiiDfZGmyU6WuFUH1T1E3fQPVdEuE
	KlgV+MQh//yMr4kGDWyru4viPf/KchJKmFPkP/JpK
X-Gm-Gg: ASbGncsW3FR1uNcOVjjCfaglEKOQuzfhD6cuYk9+cylmVNw5MfBUb/6W6QfT1ysnJ1/
	eL/vdYskXqfLLASGhUrnX7cfBwu/xBkvvXzI9RW2i2vAbDZh9j18iN8yWWBw6LIHZeRE5H2zenV
	Wr/cn4OT6Q4vfOcYp0yN5zR4VEe6JHAFuo8AqkHFoNBW3mzufBse+TQhdZSSk3gBWnJEXA4cu2q
	8XRW9TBLWq3gkSstbzqd7XTwolOTIcbscpUmOgOcXdhU245ts7lYAQgCk4evVwZPafJ7z3DM2qK
	HIE=
X-Google-Smtp-Source: AGHT+IHVf3jUEElcRU5UiElII1poREaWD5vAdlvPdSkAXo0sG8wTVz/TvP7Aj2pleN+SVZmwr5KEBBbORX+cZ2IR4bw=
X-Received: by 2002:a05:622a:41:b0:4ed:7c45:9908 with SMTP id
 d75a77b69052e-4efd0ca4d05mr10929131cf.10.1764462494131; Sat, 29 Nov 2025
 16:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
 <aSip2mWX13sqPW_l@casper.infradead.org> <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 29 Nov 2025 18:28:01 -0600
X-Gm-Features: AWmQ_blhKzVTz_OrE9p2RQX3OU7BXlogLE0D_GARspeRWjGy1hzzkkEbN5F-bD8
Message-ID: <CAJuCfpFVQJtvbj5fV2fmm4APhNZDL1qPg-YExw7gO1pmngC3Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 2:29=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Nov 28, 2025 at 3:43=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > [dropping individuals, leaving only mailing lists.  please don't send
> > this kind of thing to so many people in future]
> >
> > On Thu, Nov 27, 2025 at 12:22:16PM +0800, Barry Song wrote:
> > > On Thu, Nov 27, 2025 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > > > > There is no need to always fall back to mmap_lock if the per-VMA
> > > > > lock was released only to wait for pagecache or swapcache to
> > > > > become ready.
> > > >
> > > > Something I've been wondering about is removing all the "drop the M=
M
> > > > locks while we wait for I/O" gunk.  It's a nice amount of code remo=
ved:
> > >
> > > I think the point is that page fault handlers should avoid holding th=
e VMA
> > > lock or mmap_lock for too long while waiting for I/O. Otherwise, thos=
e
> > > writers and readers will be stuck for a while.
> >
> > There's a usecase some of us have been discussing off-list for a few
> > weeks that our current strategy pessimises.  It's a process with
> > thousands (maybe tens of thousands) of threads.  It has much more mappe=
d
> > files than it has memory that cgroups will allow it to use.  So on a
> > page fault, we drop the vma lock, allocate a page of ram, kick off the
> > read, sleep waiting for the folio to come uptodate, once it is return,
> > expecting the page to still be there when we reenter filemap_fault.
> > But it's under so much memory pressure that it's already been reclaimed
> > by the time we get back to it.  So all the threads just batter the
> > storage re-reading data.
>
> Is this entirely the fault of re-entering the page fault? Under extreme
> memory pressure, even if we map the pages, they can still be reclaimed
> quickly?
>
> >
> > If we don't drop the vma lock, we can insert the pages in the page tabl=
e
> > and return, maybe getting some work done before this thread is
> > descheduled.
>
> If we need to protect the page from being reclaimed too early, the fix
> should reside within LRU management, not in page fault handling.
>
> Also, I gave an example where we may not drop the VMA lock if the folio i=
s
> already up to date. That likely corresponds to waiting for the PTE mappin=
g to
> complete.
>
> >
> > This use case also manages to get utterly hung-up trying to do reclaim
> > today with the mmap_lock held.  SO it manifests somewhat similarly to
> > your problem (everybody ends up blocked on mmap_lock) but it has a
> > rather different root cause.
> >
> > > I agree there=E2=80=99s room for improvement, but merely removing the=
 "drop the MM
> > > locks while waiting for I/O" code is unlikely to improve performance.
> >
> > I'm not sure it'd hurt performance.  The "drop mmap locks for I/O" code
> > was written before the VMA locking code was written.  I don't know that
> > it's actually helping these days.
>
> I am concerned that other write paths may still need to modify the VMA, f=
or
> example during splitting. Tail latency has long been a significant issue =
for
> Android users, and we have observed it even with folio_lock, which has mu=
ch
> finer granularity than the VMA lock.

Another corner case we need to consider is when there is a large VMA
covering most of the address space, so holding a VMA lock during IO
would resemble holding an mmap_lock, leading to the same issue that we
faced before "drop mmap locks for I/O". We discussed this with Matthew
in the context of the problem he mentioned (the page is reclaimed
before page fault retry happens) with no conclusion yet.

>
> >
> > > The change would be much more complex, so I=E2=80=99d prefer to land =
the current
> > > patchset first. At least this way, we avoid falling back to mmap_lock=
 and
> > > causing contention or priority inversion, with minimal changes.
> >
> > Uh, this is an RFC patchset.  I'm giving you my comment, which is that =
I
> > don't think this is the right direction to go in.  Any talk of "landing=
"
> > these patches is extremely premature.
>
> While I agree that there are other approaches worth exploring, I
> remain entirely unconvinced that this patchset is the wrong
> direction. With the current retry logic, it substantially reduces
> mmap_lock acquisitions and represents a clear low-hanging fruit.
>
> Also, I am not referring to landing the RFC itself, but to a subsequent f=
ormal
> patchset that retries using the per-VMA lock.

I don't know if this direction is the right one but I agree with
Matthew that we should consider alternatives before adopting a new
direction. Hopefully we can find one fix for both problems rather than
fixing each one in isolation.

>
> Thanks
> Barry
>
