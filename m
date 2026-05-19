Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0836C59A
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216106; cv=pass; b=aPwvX6HYudwFgR//Sf0BY7PhbG6ZQ7GxTLIQzHe69wofdrB51lD01f8M9JeCwOLRz0YhGGDdlqScqPaqZD1PN9DiyokDkeYnpmz9U3KrcBRaoWKteHQAX577pTUPse5TueiMvyKE3IpqpAnNNufQPyh68ho46ZqG0kqyiDyBk5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216106; c=relaxed/simple;
	bh=NUS9DVD1uBsKADBy/TN1ttZZgthszq/ZhN8ehPHat48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUJ9vQN2hhMMlN9u33UCbpLbmv9Wda9s8Pkh4WdgZfP9jkL8CVDyUnZ84e7BFQB6KdpCFKkPznvg20QJ0CK/k4H3rhaMB5Kg8bX406lJSPpsFU7mwErJMNmjIUHPcAG6Un4jjHpuZyw6x6Wpc/i/DRNc6VOQ1oI5ElHFTMgnQWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzo8Lvg3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzo8Lvg3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso4769217a12.2
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 11:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216103; cv=none;
        d=google.com; s=arc-20240605;
        b=A7HZ5TLX4dK6/BRjC1pRKguff7zjumqkUu53zG/eWeLxgfS5AYggJrVbTn/3uIctCg
         zgIeBOEHUSYRNLa6I54p2Bw9GRU1jws+dvvyq0jQ5qE5HO7Ma5WZ72uswZOclH1hjG6Q
         o/oozC/2Yau8O4ZA+jCOhyD6a8NUM0+kHiIo908YAczFMDlEmb33qQdJO36VPhBP0tTy
         5yGPhTn6M5HJzZ8kKQ1eSvYrRQdjm3kvVn4016NXiXwlYFR0H7i82aX2B2uyOvP9Ygks
         0sxpLO1K3PTntA4rFVLV+1IatukaoreKw8HOrEjzp7tz6HEJPf/l19BH5igBObMttIvh
         5pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        fh=D0Db9zfRqbHTC9vcNPGyc8fIx2vWwl7RpRCQY+9yWgI=;
        b=QdGLA35HzI+0lWh34J2SKD04e8K2+IB+x5UuDIM8JYR2XV9ddIBinLcgaZIe0/AshT
         RvGAnxKQpmpm5rrxizweONGiS+ARG/pnZTtQhy1ZZOuYYAuTfTqNn1tBtZ9r61uJZwnb
         5mCdV9MHaP58pwPdAKazPEaHx2vECcYAQZWzXseI5bZbK/WG5/cDIZSKQgLA5o3c4HEm
         Vfb8dEFPivfudDBculDK6d17Q0WfLSH51EI0EDsXkqcTO3lJis20TFPinTYctAL2apSo
         n0SxEEJ7JyAuBOFRmyKd6FchmK7r3oy5PvHKhkOshc1bkHAxyFAVLQsrcIp0li01sz01
         v4RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216103; x=1779820903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        b=Mzo8Lvg3wnZrEDAQtb1quScDtSfCYO48wZkY3GeHEEe3fvF6+T2OVG6t3q2a43k3uu
         KyviL20pg6Xo/IMSXv3D5hXplw5aZaJuVDOw9/twDT8UGYtkGe2ws2RKxLRIGMuz/iDU
         Eg/hXX3jyuYwxLuGmdNNX4Qze31wPx9DZr9hXSBmDOGHDsbbXO/R9ZBGgtV/+rfO4+CA
         XWDyMGuOxcRATFtkF9jcdnoES1hZ3NOFb0+t6QWOjYj7LU4hLajlaldJdlUeug6fSQHx
         v2o4RY3curVIZMSMeaTNcGB9BxVVyMK0LCjIuL+QDzFpXf85kD0kGp8QDZ3/TJ01P9D2
         jFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216103; x=1779820903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        b=OhGE35ReVmA5ByoToJne3PiyV8luQLnujqBrdC1K5xkSyOOHQuEOuhwVxB6DEbIRww
         OdL7qMYEOLOxdNAiCf2TmExOTBObdV8wy9oo1Y7rVvoSsRaMDtNfT9Ig6tqLWB+YjCxj
         gWW5ZH2ROSTaCSpNRjH1y3PQS97nm1tiJCNv59FtomW5H3s7BYS3ji62MM4Iif1yi5vK
         d0TVYtOoxTZYuPpeQvMPXfaMS5ls0TJubMxg9khW/omBSchcbgTOzqz42B5pxn/3aStE
         J8T5YPmWqChmHmwD+ey13J0Ny/0S3sBBzv6p/T8DB9+1z0YX8lggh53k1o5x6WyNinbc
         fwHA==
X-Forwarded-Encrypted: i=1; AFNElJ9Sl/UucwMLUOer3y92L7QMGGUpMSqo8vHNtD/6NYYX1OO5UlQb1wSSeQkRw+ptCOYMMXU/yIbXuT45@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnADiAnwo+QliZnBHOW8AlypyUetQWkKAHNnMeg/h3OYBedGg
	6XrfiE4Hq9oBfT2OviNl+CjnrTntOvgpWh/A/XPDqNjUYMwcGL3X4gcVbXw0WnGawXxHHZXR1fn
	5i4CupDs1chgkZh5fmoAAOBC70qsRVUA=
X-Gm-Gg: Acq92OFu1XxWLZ9VI2OnSKTV0YaqN4uryRvraFgTrJLz2rs6a+zqUMWKxpHHFimwyoc
	C2YENZt/IVg+OUOlhddJV5qBGLli+e1cuquubecuuZBmC/hjlKeHAtz7+Sc9Q2qtLP4ag/+Upbx
	bswT4VMhyBoZ27ly/hzh0miB2Gqj7Dn5c9w7DCxIZmXSDuLwYRfg8JVsv1pimMHrImqOKivx4e2
	cVIOe7Nr5F71a6UGSHjRclKDI8VyT61PmZHNetfoFEld6FSbXB7Kn9QkKF37xF0cVVSrkzh/+1G
	N8Knl5yEiw==
X-Received: by 2002:a05:6402:524c:b0:67c:96e7:3427 with SMTP id
 4fb4d7f45d1cf-683bad350f8mr10588073a12.0.1779216103209; Tue, 19 May 2026
 11:41:43 -0700 (PDT)
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
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <agxfLNuLCAT3F4cW@lucifer> <agxnJ8R-G3CRjeTR@lucifer>
In-Reply-To: <agxnJ8R-G3CRjeTR@lucifer>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 11:41:30 -0700
X-Gm-Features: AVHnY4KjLtyViRy-FP1MJx-LYZJZfACCXodkXf2RGwVY3_NriDPxFvXtK5Jn_zQ
Message-ID: <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 6:39=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Tue, May 19, 2026 at 02:12:10PM +0100, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 02:21:14PM -0700, Yang Shi wrote:
> > > Maybe a little bit off topic. This is an interesting idea. It seems
> > > possible we don't have to take vma write lock unconditionally. IIUC
> > > the write lock is mainly used to serialize against page fault and
> > > madvise, right? I got a crazy idea off the top of my head. We may be
> >
> > Err no, it serialises against literally any modification or read of any
> > characteristic of VMAs.

If I remember correctly, you are not supposed to change VMA
flags/size/mm pointer/vm_file/pgoff/prot, etc, under read vma lock or
read mmap_lock.

> >
> > > able to just take vma write lock iff vma->anon_vma is not NULL.
> >
> > Except if we don't take it and vma->anon_vma is NULL, then somebody can
> > anon_vma_prepare() and change vma->anon_vma midway through a fork and c=
ompletely
> > screw up the anon_vma fork hierarchy.
>
> correction: this won't happen as per Barry (see - I managed to confuse my=
self
> here :), since for vma->anon_vma install we take the mmap read lock.
>
> BUT we also have to consider other cases.
>
> >
> > So no.
> >
> > >
> > > First of all, write mmap_lock is held, so the vma can't go or be
> > > changed under us.
> >
> > vma->anon_vma can be changed.
>
> Correction: no it can't :)

Yes, vma->anon_vma change should require taking read mmap_lock.

>
> >
> > >
> > > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > > fault happened or no cow happened, so there is no page table to copy,
> > > this is also what copy_page_range() does currently. So we can shrink
> > > the critical section to:
> >
> > Firstly, with no VMA write lock, !vma->anon_vma means a fault can race =
and
> > secondly copy_page_range() checks vma_needs_copy(), there are other cas=
es - PFN
> > maps, mixed maps, UFFD W/P (ugh), guard regions.
> >
> > So yeah this isn't sufficient.
>
> However this is true...

Yes, fault can race with fork. Basically this is actually the purpose
of this idea. We can have improved page fault scalability. In my
proposal (take write vma lock if vma->anon_vma is not NULL), the race
just happens on the VMAs which page fault has not happened on before.
vma_needs_copy() also skips the VMAs which don't have vma->anon_vma.
So there is basically no difference in semantics other than more page
fault races IIUC. It should be safe as long as we can guarantee there
is no writable PTE point to a shared page after fork.

For guard regions, it can be serialized by vma write lock if
vma->anon_vma exists. If vma->anon_vma is NULL, it will prepare
anon_vma, which will take read mmap_lock if I read the code correctly.

I have not investigated UFFD yet.

>
> >
> > >
> > > if (vma->anon_vma) {
> > >     vma_start_write_killable(src_vma);
> > >     anon_vma_fork(dst_vma, src_vma);
> > >     copy_page_range(dst_vma, src_vma);
> > > }
> >
> > Yeah that's totally broken fo reasons above as I said :)
> >
> > >
> > > But page fault can happen before write mmap_lock is taken, when we
> > > check vma->anon_vma, it is possible it has not been set up yet. But i=
t
> > > seems to be equivalent to page fault after fork and won't break the
> > > semantic.
> >
> > It will totally break how the anon_vma hierarchy works :) See the links=
 at the
> > top of https://ljs.io/talks for a link to various slides on anon_vma be=
haviour
> > (it's really a pain to think about because it's a super broken abstract=
ion).
> >
> > You could end up with a CoW mapping that's unreachable from rmap and yo=
u could
> > get some nasty issues with page table entries pointing at freed folios =
:)
>
> Correction: actually we should be safe given mmap read lock on anon_vma i=
nstall.
>
> >
> > >
> > > Anyway, just a crazy idea, I may miss some corner cases.
> >
> > Yeah sorry to push back here but this is just not a viable approach.

No worries. Thanks for all the feedback. Just tried to explore whether
such an idea is feasible or not.

> >
> > And this is forgetting that we have relied on page faults being blocked=
 by fork
> > _forever_, who knows what else has baked in assumptions about that
> > serialisation.
> >
> > Forking is one of the nastiest parts of mm and has had multiple, subtle=
, corner
> > case breakages that have been a nightmare to deal with.

Yes, this might be the biggest concern. The page fault can race with
fork. If some applications rely on such subtle behavior, it may break,
but such applications are fragile too.

> >
> > So I'm very much against changing this behaviour to try to fix somethin=
g in the
> > fault path.
> >
> > We should address the fault path issues in the fault path :)

Yeah, this idea was inspired by Barry's "not take vma read lock
unconditionally" idea. Maybe irrelevant to Barry's priority inversion
problem, just an idea for further optimization on page fault
scalability. This probably should be a separate topic.

Thanks,
Yang

>
> Above still all true though.
>
> >
> > >
> > > Thanks,
> > > Yang
> > >
> > > }
> > >
> > > >
> > > > Based on the above, we may want to re-check whether fork()
> > > > can be blocked by page faults. At the same time, if Suren,
> > > > you, or anyone else has any comments, please feel free to
> > > > share them.
> > > >
> > > > Best Regards
> > > > Barry
> > > >
> >
> > Cheers, Lorenzo
>
> So still a nope :)
>
> Cheers, Lorenzo
