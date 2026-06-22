Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7D13B58A
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782087368; cv=none; b=CoyO5wl9XUarBpfyPLti+8XgSpLPxqxHr/kcRO+l0pYekY0CHfU51pe6gJUtvQ4XWmEyGm8Q2gqZ6TGMwxaTvgeaxWGfKT4sefDYG4ghJ0PJSYgjJFEy9LMCIL0h2Ch0EK43lReBLkrPwRSScnk1jK40chJ/vrEV298lM8Co9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782087368; c=relaxed/simple;
	bh=Fdb2V3EqRSy6EXNAzAtq+JPb/Nr0M3M/hQiXJBcCWA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxtOWXgzpceXPr8EVey9ki/pmmAZod9s3PhUsoN5Z+3Ge63N9NM5UT+8Aqy/nqzeG50Pmi7UR0pARn/DMC6bcoB2igd2KhfekExPvCwQlNU8bLWdcn1jUuCqM8Wu+SzNawuuvs5HmFmuYzo87+p1kVC/gNBOl+eScRfsCFR8uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMLhsAtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMLhsAtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BDC1F00A3D
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782087367;
	bh=IHIwIiKiSPJeb13YpcTgfxJcsK09+PRa0/JU1j/CnWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cMLhsAttTe8dyYAVQ5ButgRPTCNVZUjJ+rFUJS/Nb+BEGqhTUydcs0LU3Lix/Z3ek
	 KD0MCI/yAPBWlN6wb7sqDiwlAttozmfCiUFWz9O3jE4hYXuyhq8p1QaOAF9Rxm+bPp
	 zboU9r+goMAm9xbYv8LFtKEEZ5j6ZLteAPSQZ6OcSh5MIs/62zPpZIj5oiIaFmvUDR
	 QC6ZRHtySEUkXZIEInSyph82+HpL4LpnJ7gqwRc/Aciq0eNZH9YLMUThL9XzXyeqjI
	 Rm0VjsR1+yxuogHe+HIFTcJ5KRUzQnReJU7/nUzkEoFcP0eQK2LX+MLHdOMaRBfjL5
	 BYH2jN1C6LQGQ==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8dc544dda2fso34131026d6.1
        for <linux-s390@vger.kernel.org>; Sun, 21 Jun 2026 17:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9JnRZEhZuyzjslP70udQCBy9FVf11h1zymlHOKJ2WRPTIrGUCOpQrHuxsFnP58JVF/bo2M3eKnVJ0d@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGVYfySVpIHgqGX7Io5p5rD9c3f81yLO84EnNBnS2abUYrD96
	n4omlBeLq6PRZyACOYVvgyUTN95cGBP0Bnh/GLz+1U6RpJ3f4DpWTqU5dHEPPuePK9QFRFdzGDc
	9j0v5v1w4zgw9LM/4T44sSEFQLTapEI0=
X-Received: by 2002:a05:620a:2991:b0:920:bc4a:6d9f with SMTP id
 af79cd13be357-921d185ff31mr1291391485a.25.1782087366553; Sun, 21 Jun 2026
 17:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer> <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com> <ajhOUdbWsswgQyl2@casper.infradead.org>
In-Reply-To: <ajhOUdbWsswgQyl2@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 22 Jun 2026 08:15:55 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
X-Gm-Features: AVVi8CfKzSAPaNgcIJCxOHQBAHV_wanqXUmTigM-8i98Bk0ci-4XCgmSQNzZol4
Message-ID: <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
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

On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> > Just checking in on the followup plans. IIUC the RFC mentioned will
> > try to implement the solution we discussed at LSFMM: splitting
> > VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> > and another one to fallback to mmap_lock.
>
> I continue to hate this idea.  I don't believe that those who were
> pushing for it have ever tried to understand the whole fault path.
> It's utterly byzantine.
>
> I defy anyone to make sense of this:
>
>         /*
>          * NOTE! This will make us return with VM_FAULT_RETRY, but with
>          * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
>          * is supposed to work. We have way too many special cases..
>          */
>         if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
>                 return 0;
>
>         *fpin =3D maybe_unlock_mmap_for_io(vmf, *fpin);
>         if (vmf->flags & FAULT_FLAG_KILLABLE) {
>                 if (__folio_lock_killable(folio)) {
>                         /*
>                          * We didn't have the right flags to drop the
>                          * fault lock, but all fault_handlers only check
>                          * for fatal signals if we return VM_FAULT_RETRY,
>                          * so we need to drop the fault lock here and
>                          * return 0 if we don't have a fpin.
>                          */
>                         if (*fpin =3D=3D NULL)
>                                 release_fault_lock(vmf);
>                         return 0;
>                 }
>
> Wed need to simplify the fault path, not add additional complexity.
> Josef has said he wouldn't've done the lock dropping had we had per-VMA
> locks.  We should rip it out.

I think you have agreed that, at least for anon vma, we can
keep the current policy, since anon vma is much more volatile
than file vma.
Concurrent page faults and VMA modifications can happen more
often than with file VMAs.

For file vmas, how much code can we actually remove, given that
the first page fault might already be holding mmap_lock?
It could be the case that lock_vma_under_rcu() fails, and then
on the first page fault we end up holding mmap_lock before
retrying. So are we also going to rip out the lock release,
even if it risks holding mmap_lock for a long time?

        vma =3D lock_vma_under_rcu(mm, addr);
        if (!vma)
                goto lock_mmap;
       ...
lock_mmap:

        vma =3D lock_mm_and_find_vma(mm, addr, regs);
        if (unlikely(!vma)) {
                fault =3D 0;
                si_code =3D SEGV_MAPERR;
                goto bad_area;
        }

If we still need to keep the page fault retry code there, it
doesn't seem like "ripping out" really reduces complexity in
the page fault code?

Best Regards
Barry
