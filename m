Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5E2F39AD
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764275370; cv=none; b=DFLDoDLp8scwk2nJWfJnknx9D+uCBUyfO3umlf4mo7Cqc1E/xwfP0Era4yLSGLcyQBOaAKcjEUPRmyq5qE6haHX1eri9NXy/LECTPN8J/sKzcvKEPBkT9Hjx9AQEMb6LMPiUsvgcfFEsWrXPJjJSRDrAGdkU8NUBUdcAQt7arAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764275370; c=relaxed/simple;
	bh=6PZnzEVSmILv0n6Cfv6JbAHHBE4Y2JV+DHczBHGPSLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anBeLr8fwRiQ5B61b405ORhCoC+7F4ljTeew5tl5EVQZEf06zbjAblHsDutDzysk1Zkn7hYQfBV6QfY/4g4jNwoUjImQFHj6LsVZz95k6WIqnMSFQ00CitNhRhorwLb8ydyhVEuTlJz1AmtJwSixvSFDIJqlEnJdRMYPJo43UwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCRgZvzc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCRgZvzc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-882399d60baso9364266d6.0
        for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764275368; x=1764880168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMTw1kDL8EKjTOAtowuEddJlwPoqJdeq89qWoiUPpVg=;
        b=DCRgZvzchy0qf/JUcfUEONJEFKva2C/o43jg19bPsVtF4BAu5EwLb+pjOxYFCvgFfx
         1rwSV2ZcKiyFvfyGoGuCUnoe1evVNIrYpz8cGHox3GBw8GuQ9RP+oTetYAmtmdpU4eI8
         /dPoovFoO/DB/0mPDDbcK3X6d1NHv2xTz2/scjd2eHRvXtsFIe3X7y6UTSAiF/3C+NSR
         LlInnvPRRopWIvRI9es0JyE0zARhsYSol/7d/oT2Il1uDN+zcnRD3xxMmRPUuamcFMlg
         RLz3R48CBkDPk+I4vblhSMW5v2K+4IFAnqHgbRs787sfZHIgiV2DdecLK11U+rrZNrW4
         GAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764275368; x=1764880168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMTw1kDL8EKjTOAtowuEddJlwPoqJdeq89qWoiUPpVg=;
        b=Az0icbz13MjFTlVcMZkhik6Iz26gmXIuCkZk0UsAHPjUzJITMIAYOlGpH1HhcfKFw7
         Z996lnXIIoUTazu52unWyhMa9kqfWwnhBtuZE9+jyCYyTAgr2RdjsJVtYwIlk/ZXZjz7
         Kqfx+6zSQpbzU7L44gXIto67X0KIPnCpS9Tas3VLyGqcEdf1YMEgdkMP7qhhaPIfOiI+
         PLz9rnAW9rHderHnJOGrOr5jlVBGntUstB/Gr984ToSKUxvkABKiyUZJwMjgKNt+o2dY
         KuXIlQsOssHCAJzLPTHQUZCdgEvMX+k4v57YCBTClo97bQrNsAmcT+DqRLmo3Bqflxbq
         k2sg==
X-Forwarded-Encrypted: i=1; AJvYcCWcqGrIC2H0vivuUtwBcbaHPU2325W/FCh1HzcpkBHUW2JK7ZCYYuJIcWpz14j5F7npD2Nh5HgC1q7C@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgk+vuq9LnooZnP7NqRT+57yUQSz4qlb1fLZY4qvTcwCO/t6g
	CZk5un9KkK4WCrADp3k/RoVLy+CUPW0iv/eb1sJ98mQm47fg0vPlK7pBtBdTSPgquYKayWYa1//
	V4sV0P8uyejCU1GJu+OGn7T0qeFu5fjc=
X-Gm-Gg: ASbGncvGpdl4jx8gAJagAxFL54jtMKW8W6QNrOHS9FzPlZROmdDX7I73BK/eOVq3nhK
	i7/K7l2nfucv04v/8aiqTya+YPF/lcghuGwUYUfI/5hbOZevuwW/0fYpoYqXq8lzl8rV3otrcgE
	/6aAlPtBX8T5xgA1/j5wOnEm5rgyRmIcDPA8OnNMdpKuh+ruySSjVdqcHW75vivjTeI1LELWcDo
	a5v9DtIolKycT/c4eTv4LXO2jK81XXSZmomvdxRpZzCs5OjSg+xZzmw7UjkJmK9qLMp8A==
X-Google-Smtp-Source: AGHT+IG5GcGrOmVVsePre6BxCVhrhKY7NJnCRBVNCLt/HcgbymNTTZVjYmvrDTtjRkuAQ9GKsIJdwvx3BNDYrNQPC88=
X-Received: by 2002:a05:6214:234f:b0:880:486d:18dc with SMTP id
 6a1803df08f44-8863afb4d8fmr176925236d6.58.1764275367501; Thu, 27 Nov 2025
 12:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com> <aSip2mWX13sqPW_l@casper.infradead.org>
In-Reply-To: <aSip2mWX13sqPW_l@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 28 Nov 2025 04:29:16 +0800
X-Gm-Features: AWmQ_bn_b-JGqeMVPQ751bNAv2Qsiauy9g_kN3cQ2gR4dkmeqYmOBAyRrjCf_ew
Message-ID: <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 3:43=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> [dropping individuals, leaving only mailing lists.  please don't send
> this kind of thing to so many people in future]
>
> On Thu, Nov 27, 2025 at 12:22:16PM +0800, Barry Song wrote:
> > On Thu, Nov 27, 2025 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > > > There is no need to always fall back to mmap_lock if the per-VMA
> > > > lock was released only to wait for pagecache or swapcache to
> > > > become ready.
> > >
> > > Something I've been wondering about is removing all the "drop the MM
> > > locks while we wait for I/O" gunk.  It's a nice amount of code remove=
d:
> >
> > I think the point is that page fault handlers should avoid holding the =
VMA
> > lock or mmap_lock for too long while waiting for I/O. Otherwise, those
> > writers and readers will be stuck for a while.
>
> There's a usecase some of us have been discussing off-list for a few
> weeks that our current strategy pessimises.  It's a process with
> thousands (maybe tens of thousands) of threads.  It has much more mapped
> files than it has memory that cgroups will allow it to use.  So on a
> page fault, we drop the vma lock, allocate a page of ram, kick off the
> read, sleep waiting for the folio to come uptodate, once it is return,
> expecting the page to still be there when we reenter filemap_fault.
> But it's under so much memory pressure that it's already been reclaimed
> by the time we get back to it.  So all the threads just batter the
> storage re-reading data.

Is this entirely the fault of re-entering the page fault? Under extreme
memory pressure, even if we map the pages, they can still be reclaimed
quickly?

>
> If we don't drop the vma lock, we can insert the pages in the page table
> and return, maybe getting some work done before this thread is
> descheduled.

If we need to protect the page from being reclaimed too early, the fix
should reside within LRU management, not in page fault handling.

Also, I gave an example where we may not drop the VMA lock if the folio is
already up to date. That likely corresponds to waiting for the PTE mapping =
to
complete.

>
> This use case also manages to get utterly hung-up trying to do reclaim
> today with the mmap_lock held.  SO it manifests somewhat similarly to
> your problem (everybody ends up blocked on mmap_lock) but it has a
> rather different root cause.
>
> > I agree there=E2=80=99s room for improvement, but merely removing the "=
drop the MM
> > locks while waiting for I/O" code is unlikely to improve performance.
>
> I'm not sure it'd hurt performance.  The "drop mmap locks for I/O" code
> was written before the VMA locking code was written.  I don't know that
> it's actually helping these days.

I am concerned that other write paths may still need to modify the VMA, for
example during splitting. Tail latency has long been a significant issue fo=
r
Android users, and we have observed it even with folio_lock, which has much
finer granularity than the VMA lock.

>
> > The change would be much more complex, so I=E2=80=99d prefer to land th=
e current
> > patchset first. At least this way, we avoid falling back to mmap_lock a=
nd
> > causing contention or priority inversion, with minimal changes.
>
> Uh, this is an RFC patchset.  I'm giving you my comment, which is that I
> don't think this is the right direction to go in.  Any talk of "landing"
> these patches is extremely premature.

While I agree that there are other approaches worth exploring, I
remain entirely unconvinced that this patchset is the wrong
direction. With the current retry logic, it substantially reduces
mmap_lock acquisitions and represents a clear low-hanging fruit.

Also, I am not referring to landing the RFC itself, but to a subsequent for=
mal
patchset that retries using the per-VMA lock.

Thanks
Barry
