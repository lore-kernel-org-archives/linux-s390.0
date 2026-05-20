Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A231E2834
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256298; cv=pass; b=E+x+ES56HJ3bHEuPUQ/yYOOipciURq/4MFT7vUi0opGXhk6EFJwoOM0IjB7Z0kHCIXydPHyayQfPUBDCA7f31F2+rYPc6vIKHH+w9ep5s1Dz1EQonwEPcO1wzuPq7Os/2GoIJL98BCN9bQ7ZOGi/LCgIB9njRB24+rcKAvUo204=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256298; c=relaxed/simple;
	bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCfuZYf83QypCxSFUrUFx1uLThYG3Y81x06nmehecplZ38OzMRYN+YkxxHCQHRdrEoaRfTdRg1BXxaJW/Z/w3sIVZIkWdU3TZX3laAGgNlsgR3ROR1BVgsAyZ/aCIf8GcHkwmz+Or+qWWmDMvEYD+FVAuv7a2/hMkYW0BPo4KpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sr3vpPW0; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sr3vpPW0"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-515548f390fso8051cf.0
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 22:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779256296; cv=none;
        d=google.com; s=arc-20240605;
        b=aC+11hjRhRS6L22HjBsztqmRBwFtsDRUhIPLWG1oWu6E+d6Rnk3G0UcfU5K7GDxDEi
         yvqq+bLcWXBEF0qzWOydSFuQ8z8yATVmhfj7J/KG+7bD27R1WlNMN6FsttBY6lBAFPCV
         f1lhhvF9rsXeYoK/aBWoO0DjN45z7lq2/qPyJ4GISd4mD01/FIxZuPQTAb8kD2dTtYrB
         zrlbshQJxYxmlhIkK/+CDk1PK5LOH7J/4f9nB6u1WkMCBSjne+QSQTOzju9+z3L5wx3J
         p0dkV3bkKpOWgq9BLXcZmW45e7Ze3OStnqmPJdO9Ly19nA5NEpx8VluBtI0BHB6nbhBf
         j1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        fh=HxDCg2IPl2kiWOOsPDQC5YGvqKNmJl3GbSR9OzF9nwU=;
        b=av8MsFFr5NKNLl8/VXE2yeERpgUSJmNFu+Ec5v0KthhGZRbYM+PcaEUcSjqSdJ3lns
         oL4bfVXlXLPbKZhLIIPaSV/uLsf52nLfWz4RFQeybLfpZlwO2TJAR+ael7RGdrzSoNdX
         oZyAZ6bfIgpy2LFmRx+7YHdZzNbU+4AxARQMHXMv/2zJjaWuMybYH8wDaIPHykfWdVuu
         l2vYM3rOoUSwL9Js19/qtKQVPUnKE8GLhQbevy2ErQArLEdGcqNRHQpDyKdZ01g1FLmq
         H9rS5xNI0M5zPQEwr9WYS4U6EW0GusCGUsDHjLhnW/dhCScS0P42DtpFuIVInkRvuxEe
         SJSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779256296; x=1779861096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        b=Sr3vpPW0X3En977Z3DFQRK+bnV3g9hofNYaA6Pyaux7C1VsS1B/ETM8jOTtnlIjqg9
         wVdeLgtW0QPwhJqC4QuH04ngkp2egJczmKmnhbh0B91ejQrmqzPLPF7wri5E2WD+pWia
         Q1cZCZ1AjvQopHidN6HWmwIsdYlLsdpA5HiNcUHl/R9W92p9JN/8HRl7i0d5wQhJ/pHF
         M0Hsct9+insIuVCxc8EHQas3p4LTgIyAXDr/eNw5OW5GJogUa/dpkwxT82u+m3OFwFje
         kmZglEbuNygv0wx4OM/seQRINPlHzv1GUujLUmTyP6zZ9DfqVvaONfYhLKZkMCd5C3uw
         UWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256296; x=1779861096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        b=lOaFTilD10IcIWyy2RIVEHPRulrzty/gcswLrekTt+zes/HPUR3Z7g7SVdLNBr+yN0
         jxQvamxhokVu+RpPPC1EJwAaPzbBU39JNIVnOiiSPRYKdrv/vh4Fm3++yBXrCGhEu5CB
         L5YDqgI+oL4kqPuVvW/YcRDnAmgaK0FM5foKJ6sI9+xyczdiP9g+5tjmCv8D+sUx5O3B
         QXQ41euCC6SVMaKxfiW+sb/K71lKdhqvb70LQUzjwV28S/UEsxrRe3Iwlj1Q2BHlgDuk
         B18sPqKcv/A8c1G1QSBBdv+krWYNmNV4O5HA5VUwLQmv9N6k5wip7UEWpr4UwNsAru1s
         olqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L+RrzPRFCEuuhaHiTIbCl3DKRPrEFdhjTmBYFlwHuVx7mnHOINY4BcV/DCoeHx9syHUP/wG48A2JG@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4qWMixZ8UmbSq6jDRbyns2xWc4oqJ8okpwbAZzWxFHUgTqV8
	Qc2M+D3YujGhJ3VC4dNj5LsKgALnReJlJwLM3csClaaF70l+35SK7ouFje2EV+jFAvI3APzKFSU
	Fiu5SpPRPYNNaUlOln8JoN2+Cr+0rIAOHvLRY/qCM
X-Gm-Gg: Acq92OEbLYQwPChora0WrpuBTpZt/L8IIl9/8456MEiE4gir0DWbYq6eYNy4CVze17y
	AoHPB+b8kN/Rl+huDE5MC7RaGPJ//fNet/yzeIzfYl3m0USvi4FGQbVlNhgNLebDJcvRrCDU8BE
	RLqGXUI4fHNQe0zpIYeljAqcDQTToo/EgER4MPRz9QCKQvvfLCZPwEe9McVapOYKRkBgzQ9y8oJ
	iVhNzJFU5xdk5vu88cx7/FcCxr2/5ppzVBkITOPzqIRwCuPPXz1j9X/t7U4zAYRzu6QI2Q4Uslc
	SdEiI9xwPM8P6YnDYRqKxb6acDYrqTv5wp9QqjI/B+hX9g==
X-Received: by 2002:a05:622a:1920:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-51679461795mr15633081cf.12.1779256295164; Tue, 19 May 2026
 22:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com> <agxbq1TxJdniMQT3@lucifer>
In-Reply-To: <agxbq1TxJdniMQT3@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 May 2026 05:51:23 +0000
X-Gm-Features: AVHnY4KMccW5pUeVLxDyTF9Gnh50gzRE3EOZpgiKFqqXipSU5KPE9rQdYzJrFBQ
Message-ID: <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
>
> > >
> > > I think we either need to fix `fork()`, or keep the current
> > > behavior of dropping the VMA lock before performing I/O.
> >
> > I see. So, this problem arises from the fact that we are changing the
> > pagefaults requiring I/O operation to hold VMA lock...
> > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > any VMA modification. On the surface, that looks ok to me but I might
> > be missing some corner cases. If nobody sees any obvious issues, I
> > think it's worth a try.
>
> Not sure if you noticed but I did raise concerns ;)

Sorry, I didn't realize your first comment was a conceptual objection
to this approach of allowing page faults to race with the fork.


>
> I wonder if you've confused the fault path and fork here, as I think Barr=
y has
> been a little unclear on that.
>
> What's being suggested in this thread is to fundamentally change fork beh=
aviour
> so it's different from the entire history of the kernel (or - presumably =
- at
> least recent history :) and permit concurrent page faults to occur on a f=
orking
> process.
>
> I absolutely object to this for being pretty crazy. I mean I'm not sure w=
e
> really want to be simultaneously modifying page tables while invoking
> copy_page_range()? No?
>
> OK you cover anon and MAP_PRIVATE file-backed but hang on there's
> VM_COPY_ON_FORK too.. so PFN mapped, mixed map and (the accursed) UFFD W/=
P as
> well as possibly-guard region containing VMAs now can have page tables ra=
ced.

Ugh, yeah, I realize now this is a minefield. Resolving all possible
races there would not be trivial and might introduce other performance
issues.

>
> That's not to mention anything else that relies on serialisation here (th=
is
> would be changing how forking has been done in general) that we may or ma=
y not
> know about.
>
> The risk level is high, for what amounts to a hack to work around the fau=
lt
> issue.
>
> I suggest that if we have a problem with the fault path, let's look at th=
e fault
> path :)
>
> So yeah I'm very opposed to this unless I'm somehow horribly mistaken her=
e or a
> very convincing argument is made.

So, current approach of dropping locks during I/O sounds like still
the best solution.

>
>
> >
> >
> >
> >
> > >
> > > >
> > > > I'd also like to get Suren's input, however.
> > >
> > > Yes. of course.
> > >
> > > >
> > > > Thanks, Lorenzo
> > >
> > > Best Regards
> > > Barry
>
> Cheers, Lorenzo
