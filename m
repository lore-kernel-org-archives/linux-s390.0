Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D7328610
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139290; cv=pass; b=jdb+Chu1RTHJpKyUfSL4125n1EkhEdbsyQWajLTsOJntduZ5Z9v7L/DCTTDAlH3GqAByUmisbhHh2gM/uCGF9IBnRsc9FOoXEDddemNn6zsSvQ2khWEP2HxwkIIv6YyCkV4zBEUztb5xqORFyxY52DMeAiPQ3IjMIvPxIiEuH5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139290; c=relaxed/simple;
	bh=laBUtyj65fO2XYeMxoRChgsX3Gr7mjOx+RzG39EAtNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+zWkLBKSMUsNlgqksqkNUEr4vKa6lPGZoYB7OKz1KUDJHgVm2y3rNmOHLLF8QqDNxPjKnyuha2gLr4AM0NElDTLtMJDSlMW2XBOMHqrXfeZnpyAQiFbFwCCC9uxgVKH0qJ4s+xfPgHTAp3MKPBn2DMCqOy7kAC0mO0JYFZnBug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+HKPuHJ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+HKPuHJ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso3366444a12.2
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 14:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139287; cv=none;
        d=google.com; s=arc-20240605;
        b=GlyJehdZiVgKEQbMEj8t2qJB3oFMSLsaJ7eJQZw3Mvdr/FVWUy4p82Vspkf0uAFkFB
         SHjmpraQEZClVXFrLGDzX7UaOQaEDyIvm7wAzPIxQkbk6z2HSkNOOjesw1CwILC5yfQD
         vUb8/7wvSAxMTP16BJsTFCzvuA527pcjjqCJVEGFJPRDpnv4AW7IL2LNcawJNj4IVxnq
         CpegxlB0jygL+4MMqgURmHdP9KaLX1Wu6Ue2pfNHt7GBaLGaia6+xo/EnEdvYV1dYTJB
         pe4MU7Ix/pyLh+Kxv0dj2szXW1xgmQalpS20aEW/UTI7pUg+yqNIIJByf7xmaNcQ9CJ/
         EnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        fh=lSpsJpcOKL7dQUYX4eShvOnu2hA/AQtxsLG3ggtz0HU=;
        b=FO4hUmaGL2FuUqYNdRqSc1XL0jYiL+3h+FjZoqr/ewOqBG0O0NlbKpAcEWDqC8KYXn
         lTqphi4byFmhuugBhm3ju8DNjfRYpC1ns1rUs3j7FRDXXncfGlrVzbWagL+uDIFZ/x+Z
         p0zZV+E6wgj920446HiO5821PU5/SJxEBomya03luQpjKxNVbZGZGnqaKTbvhLo31+Er
         k4QjW2EonLJhOSDDpEdohWHNn04aScwsMBg5Im7CUthqNlrSmBF56ItaukJx21E9rUym
         5eWDj1lEb57kaFf9qTTWlEhFjvuBWPE3BiU0Rb+EPP5tCHFQ71piTaHdeal7HgSYqEDd
         enQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139287; x=1779744087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        b=o+HKPuHJYXL6JXBCmJHDifaGKIg5MmcdjoXoxrEsp/VJVCpMB5xFAr+sL18DgLRMGU
         r60XwRyHtmW9+Er3TAN9J2w6uJLcyGVhFj0iJSs7BZUsldE+wbadZBgmWGgVqwfU1Wyz
         nxq+tJ9PjMuNaDIGbU0A14BkDscTFiTdWJ/mVDth20o3gXggehNFxZBwFmYLhBEruKYk
         F5G5gOfDFRITsjkLQ5QYQQ34BfVLZzedG9oPo0UVabEJVv/bNEOEI5atL6xo721SZ1se
         3jb1FsUrAg9KT6EjwCjC40JxLwd4zioKsDT12PH47B+hldCCCLCnI9INt6yIuYNK/oZx
         sDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139287; x=1779744087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        b=b0Aw1wSe+Rl4pFqHclqWMJvfnceQDhuMLyTsCwcPxE/hchfPorf535sh89b07ZjUuX
         DPlTiQOIZiMTZVNs+pjf4LAs/WSBS/JeNrfZj9gM5lF2FsHuhFs6NDIkvT9hp6LnRvt5
         lBM3RZRx665VAJ8pqaAlZ9/lJLHsZXIFfvsejeQi9aYHsH/UWgh+M6cx7CJdi7EHz2bV
         +EkF8wqAb+nuj8dWFRLvYxe1r87Dj5LArCIDkx6USFjAL2UJAIx45gJLQZ3TvpPYVTCy
         gDPpNpl/nERkIQw/7IxEQFnhUuN8AFWUqqogFR6dF1u8iqfx8VkDKFxsinJAUj6obT3v
         7VTA==
X-Forwarded-Encrypted: i=1; AFNElJ+aV1GY1VjT61HAe3Q0fe1iZApVDJPmV8h+WfH1gzEJRUUjfk0pfsWHcHLCxE1E65IS36xSlkZ5i128@vger.kernel.org
X-Gm-Message-State: AOJu0YzbaV1rFk/a1uSXz9gaG3MkC8ivgOS4tirtMwRJbfQVuECq5cs6
	/iFm7z971hJnwnzJD/ifGWtOKNim2tV4GavgLVrRnKKYRRC0vz+OFTnlxgXsMQwBeuho4WG78i1
	sPRzp5S4tiMdpx6mCk3f5PCaqqT2gpQg=
X-Gm-Gg: Acq92OGpnTE8kB2umZyOMoP28q11fkplTgXr+MIwOtWNRZ7ehBguxOhF050Ec8SKOEy
	xkfmyc+VQ2l0SarOM410QmjsO9u4dvDNvi+uPaV9s872+BxkUlPzs6yB78ccxxoKGIGoNvAx5UY
	dUqmwFzO81gr4dTRmuQx2jiOUvMgwHRAIS3QmEtWrm1o1xUZZH8BysLJBZeDMgKhzs6SquZv5dK
	YNv6LA+NBN4W5KkdrUF4UYqbMVnzwNFcgoe9Gpz37EgrmCCI8FvtMc/t989SCq6jwpj7bPmyfDg
	nlQXGpM=
X-Received: by 2002:aa7:d315:0:b0:683:6705:6e09 with SMTP id
 4fb4d7f45d1cf-683bd38d823mr5757913a12.13.1779139286945; Mon, 18 May 2026
 14:21:26 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 18 May 2026 14:21:14 -0700
X-Gm-Features: AVHnY4JdohddXKx4c8RBQ6M1uUtTSitdJHlU74cl49fvebK4jjJ2w6iuf3X83y8
Message-ID: <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 1:45=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > 1. There is no deterministic latency for I/O completion. It depen=
ds on
> > > > > both the hardware and the software stack (bio/request queues and =
the
> > > > > block scheduler). Sometimes the latency is short; at other times =
it can
> > > > > be quite long. In such cases, a high-priority thread performing o=
perations
> > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced =
to wait
> > > > > for an unpredictable amount of time.
> > > >
> > > > But does that actually happen?  I find it hard to believe that thre=
ad A
> > > > unmaps a VMA while thread B is in the middle of taking a page fault=
 in
> > > > that same VMA.  mprotect() and madvise() are more likely to happen,=
 but
> > > > it still seems really unlikely to me.
> > >
> > > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > > the entire VMA=E2=80=94just a portion of it is sufficient.
> >
> > Yes, but that still fails to answer "does this actually happen".  How m=
uch
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
> >
>
> Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> waiting for answers),
>
> As promised during LSF/MM/BPF, we conducted thorough
> testing on Android phones to determine whether performing
> I/O in `filemap_fault()` can block `vma_start_write()`.
> I wanted to give a quick update on this question.
>
> Nanzhe at Xiaomi created tracing scripts and ran various
> applications on Android devices with I/O performed under
> the VMA lock in `filemap_fault()`. We found that:
>
> 1. There are very few cases where unmap() is blocked by
>    page faults. I assume this is due to buggy user code
>    or poor synchronization between reads and unmap().
> So I assume it is not a problem.
>
> 2. We observed many cases where `vma_start_write()`
>    is blocked by page-fault I/O in some applications.
>    The blocking occurs in the `dup_mmap()` path during
>    fork().
>
> With Suren's commit fb49c455323ff ("fork: lock VMAs of
> the parent process when forking"), we now always hold
> `vma_write_lock()` for each VMA. Note that the
> `mmap_lock` write lock is also held, which could lead to
> chained waiting if page-fault I/O is performed without
> releasing the VMA lock.
>
> My gut feeling is that Suren's commit may be overshooting,
> so my rough idea is that we might want to do something like
> the following (we haven't tested it yet and it might be
> wrong):
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2311ae7c2ff4..5ddaf297f31a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> *mm, struct mm_struct *oldmm)
>         for_each_vma(vmi, mpnt) {
>                 struct file *file;
>
> -               retval =3D vma_start_write_killable(mpnt);
> +               /*
> +                * For anonymous or writable private VMAs, prevent
> +                * concurrent CoW faults.
> +                */
> +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
> +                                       (mpnt->vm_flags & VM_WRITE)))
> +                       retval =3D vma_start_write_killable(mpnt);
>                 if (retval < 0)
>                         goto loop_out;
>                 if (mpnt->vm_flags & VM_DONTCOPY) {

Maybe a little bit off topic. This is an interesting idea. It seems
possible we don't have to take vma write lock unconditionally. IIUC
the write lock is mainly used to serialize against page fault and
madvise, right? I got a crazy idea off the top of my head. We may be
able to just take vma write lock iff vma->anon_vma is not NULL.

First of all, write mmap_lock is held, so the vma can't go or be
changed under us.

Secondly, if vma->anon_vma is NULL, it basically means either no page
fault happened or no cow happened, so there is no page table to copy,
this is also what copy_page_range() does currently. So we can shrink
the critical section to:

if (vma->anon_vma) {
    vma_start_write_killable(src_vma);
    anon_vma_fork(dst_vma, src_vma);
    copy_page_range(dst_vma, src_vma);
}

But page fault can happen before write mmap_lock is taken, when we
check vma->anon_vma, it is possible it has not been set up yet. But it
seems to be equivalent to page fault after fork and won't break the
semantic.

Anyway, just a crazy idea, I may miss some corner cases.

Thanks,
Yang

}

>
> Based on the above, we may want to re-check whether fork()
> can be blocked by page faults. At the same time, if Suren,
> you, or anyone else has any comments, please feel free to
> share them.
>
> Best Regards
> Barry
>
