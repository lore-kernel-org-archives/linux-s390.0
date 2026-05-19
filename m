Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB72D5932
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216667; cv=pass; b=DGIsE2mVQ7Yj5rjCg16CStEPgm0Dom8mSUE86IrPJarWAjGIJ4998HXeGvsn47smwkrWmEMYyUQS3t+ME9BzwhSggLW3o9/XltqfTwTH+7HIK1pEYmowhhfWa4UaCX2Cq4MUX1X4VnT12qNZyNFk5b/eRh9Nglod2gjUwXIYvvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216667; c=relaxed/simple;
	bh=+XQJx14sQwkC+wuotRPMAP8ptNQrofSrNHWxDOiyXS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0LdPVdRsv8ksgHQ+ndOLJq+vVXI9KUwrQ1w/JKBG3BhyskkuOkW7khICP1ub3P2qfRcWXRlO7xZXtXr30Of7cvbYQArhHIhM4HDxbiSnM4VmOlsupZILAmPoG8sK4XoENxupg/1RzEASIkFPloIp4QqI6Wu6sY180MTbL8mcjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHAGxsTC; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHAGxsTC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd56d108454so816825266b.2
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 11:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216664; cv=none;
        d=google.com; s=arc-20240605;
        b=LHLwBaqb6slGGHcOAYHghlk18inxHd0f3opDHzfnOSzb3o3mSMIaKamRi5CPTQA6L0
         R0WIN4b9qyYt0iSaK7PJlhf296xgbNgW7IoCyRWng5/lMGoFtddE//sdhRmlT6VdssPO
         yODJzwQ86bo3xrNpF/ROVh7vcXOXJS4/FKZct2hEU5/AGsRhqHHlMhMiRYGOiMKNal/A
         l3yyx4zGQux53IV8Sn0FNSst4y0wfOrdCPSIavl+6YlGWCp4Xsy6/3N5EFhJXpyxVlQ9
         U5EqmKUBDxN0VcQLCQFyl6C/WInmLA61Ks0qzXuHBqXGPqF7fjNWNFk1SajMwxIoz6Ce
         rdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        fh=yjr2IfMxmMuPV6wc+JfFmN9QtigkLzEVP+1m54q0WyE=;
        b=IFP/gIDzaZm4Av/FS63Ibpd/3PmVW3cFhMdupdjZbjX/1z0HoTQM6jvZBcLH5At0Zo
         08TQ/VCOUlYFYR6Qz28Uf6JsQITCK1A3M9hkxtyvvvOMSq70C7dGTKuvSFUqhZd7OBmi
         z/JvAQPYpFSMVC4NAND2I5BB4eopLqGukL91IxB78F6him8WKgSK1z7Q471/JiawDpD9
         cgxYl4LKe/OYzDUqSjh8ZnehHMsP74UXdVhB8SitKodAG8KO64D7QjvfQrD0q5dyREng
         cpo/AaeB7zHMYT9plC7HPJZslkeMABO6HCoSNIDwfhjYxEfu7ilrPK59ZrChilaGd8Bv
         Njgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216664; x=1779821464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        b=HHAGxsTC/2a8dIhqDcZSOtB9ko+C7QqqeuEG1c9EUNq4E61+sqcYh1o1OSxtmVtO5T
         drbglnNsU/Q+mJTWG5xLi7FmnvYrv4hUE7POJQI7QMZWUjq0FHYGCOs4pGT4D9VIQJQS
         y7apCeatOAbOhx8UkdPrIqLTgOd20a2zRp2/mXFOoH/wsd7bl5EtQ0pzB139AgbPNu1d
         3KHDULCHdlyVBWji6C1QjpPChkND5B7OqIq/v4gpy6t1Z5CsImLGkiqpDtN7qOL6gBOr
         o0VoNNc20rl73T8bijsuXXhehAI8lms/9pJZxdwm5GQgbVxe/iOTr8/APJhl86baI0tY
         HpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216664; x=1779821464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        b=PqrZBb52a9qc46vFRiNTwxFLG8HrWU20x8PLpFbdOjxjsABQ9/tbXqdJx8bf/HI3sR
         8tWvPKDbXl2qu9/gZca7+KbKwQbq4i5wRdmgrOSqXoQW1p24DbWcpO1EoRd0YIkWoudn
         z5qdORk4RH/QbxiX9o+etmKpUyiCwm9aPrd1D4rqowBnElJI1XyEL27KOqzxWQknLqcZ
         s71x50U45dYehO+Bf7nWqJDU4+JkdadVY48TtNExlN9fN4rb6YQpbBjRPDKV4nFuL74W
         owtp9L5ejaVAkRJz+BS9xZdJElxl0NTN9Ufahengut9KF/os1vBt9GyPTJngR2Os3c9X
         gzjw==
X-Forwarded-Encrypted: i=1; AFNElJ89EPHfYN2tomg9qnhJwu6SrCCjUEWC9i0zF12aHpepGqYT2bX62Txm/4Imq9b0S37F9aTc/r8liWHy@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsSpjKODzS4dN4OcbuPeoTjoCdHleju1bdkrYGLivLjA2cAkD
	cg6KAyqF0SAEerX1wXTMxcuyq2SBQ9MkaYyo83QG8tn1f9b0qQt3kfCvgxosl2TgWF+8qpYPjZs
	LWpiokUZ+WPlsA48rBnZYoqxK6xalqvc=
X-Gm-Gg: Acq92OGBA3lgePY/NJC1Lse/HvbvgGF3o/y/kUDoVXn6zB89nwGecdLys6Nrre31xcl
	vN2Fh5kOyD+gIqoA2sZULs7a5tXSNpk/1sAI1vb4LAUUYBoknCwhJE7V7rvnzCeNMdMAoxBcxgv
	pyNeV90csC1AXA1gYviOBZPAMBMBe807OQWNezXp2rw/sG0RztRyjinLTVkECOsKHA57Va4alJ8
	Yl8IW75UEybyDKKIdLeTu/hsZE6fdv7dbHbq0/SRZsWpg0PLUzn2oa69G8BczFk/V3x+a/Vn78o
	lc79qbWkHg==
X-Received: by 2002:a17:907:a68b:b0:bda:2928:ff9a with SMTP id
 a640c23a62f3a-bda292920a3mr99249366b.39.1779216663733; Tue, 19 May 2026
 11:51:03 -0700 (PDT)
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
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com> <CAGsJ_4w_-Y8qNLDeLX9OWpLpK01YG2bF-N6_mGypgsauvfCvkA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w_-Y8qNLDeLX9OWpLpK01YG2bF-N6_mGypgsauvfCvkA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 11:50:51 -0700
X-Gm-Features: AVHnY4JjQJo4iM5wAoXXEGJ4OEpxos0PYW3wieiPnlRi6plEliJjiQongYt0ODQ
Message-ID: <CAHbLzkpbQ4Ca0xC74BJ6iJUVKdpH90qE+E=g7HkDXvcNH1+8+w@mail.gmail.com>
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

On Tue, May 19, 2026 at 4:07=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 19, 2026 at 5:21=E2=80=AFAM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Sun, May 17, 2026 at 1:45=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
> > > On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > > >
> > > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > > 1. There is no deterministic latency for I/O completion. It d=
epends on
> > > > > > > both the hardware and the software stack (bio/request queues =
and the
> > > > > > > block scheduler). Sometimes the latency is short; at other ti=
mes it can
> > > > > > > be quite long. In such cases, a high-priority thread performi=
ng operations
> > > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be for=
ced to wait
> > > > > > > for an unpredictable amount of time.
> > > > > >
> > > > > > But does that actually happen?  I find it hard to believe that =
thread A
> > > > > > unmaps a VMA while thread B is in the middle of taking a page f=
ault in
> > > > > > that same VMA.  mprotect() and madvise() are more likely to hap=
pen, but
> > > > > > it still seems really unlikely to me.
> > > > >
> > > > > It doesn=E2=80=99t have to involve unmapping or applying mprotect=
 to
> > > > > the entire VMA=E2=80=94just a portion of it is sufficient.
> > > >
> > > > Yes, but that still fails to answer "does this actually happen".  H=
ow much
> > > > performance is all this complexity in the page fault handler buying=
 us?
> > > > If you don't answer this question, I'm just going to go in and rip =
it
> > > > all out.
> > > >
> > >
> > > Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> > > waiting for answers),
> > >
> > > As promised during LSF/MM/BPF, we conducted thorough
> > > testing on Android phones to determine whether performing
> > > I/O in `filemap_fault()` can block `vma_start_write()`.
> > > I wanted to give a quick update on this question.
> > >
> > > Nanzhe at Xiaomi created tracing scripts and ran various
> > > applications on Android devices with I/O performed under
> > > the VMA lock in `filemap_fault()`. We found that:
> > >
> > > 1. There are very few cases where unmap() is blocked by
> > >    page faults. I assume this is due to buggy user code
> > >    or poor synchronization between reads and unmap().
> > > So I assume it is not a problem.
> > >
> > > 2. We observed many cases where `vma_start_write()`
> > >    is blocked by page-fault I/O in some applications.
> > >    The blocking occurs in the `dup_mmap()` path during
> > >    fork().
> > >
> > > With Suren's commit fb49c455323ff ("fork: lock VMAs of
> > > the parent process when forking"), we now always hold
> > > `vma_write_lock()` for each VMA. Note that the
> > > `mmap_lock` write lock is also held, which could lead to
> > > chained waiting if page-fault I/O is performed without
> > > releasing the VMA lock.
> > >
> > > My gut feeling is that Suren's commit may be overshooting,
> > > so my rough idea is that we might want to do something like
> > > the following (we haven't tested it yet and it might be
> > > wrong):
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 2311ae7c2ff4..5ddaf297f31a 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> > > *mm, struct mm_struct *oldmm)
> > >         for_each_vma(vmi, mpnt) {
> > >                 struct file *file;
> > >
> > > -               retval =3D vma_start_write_killable(mpnt);
> > > +               /*
> > > +                * For anonymous or writable private VMAs, prevent
> > > +                * concurrent CoW faults.
> > > +                */
> > > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) =
&&
> > > +                                       (mpnt->vm_flags & VM_WRITE)))
> > > +                       retval =3D vma_start_write_killable(mpnt);
> > >                 if (retval < 0)
> > >                         goto loop_out;
> > >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> >
> > Maybe a little bit off topic. This is an interesting idea. It seems
> > possible we don't have to take vma write lock unconditionally. IIUC
> > the write lock is mainly used to serialize against page fault and
> > madvise, right? I got a crazy idea off the top of my head. We may be
> > able to just take vma write lock iff vma->anon_vma is not NULL.
> >
> > First of all, write mmap_lock is held, so the vma can't go or be
> > changed under us.
> >
> > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > fault happened or no cow happened, so there is no page table to copy,
> > this is also what copy_page_range() does currently. So we can shrink
> > the critical section to:
> >
> > if (vma->anon_vma) {
> >     vma_start_write_killable(src_vma);
> >     anon_vma_fork(dst_vma, src_vma);
> >     copy_page_range(dst_vma, src_vma);
> > }
> >
> > But page fault can happen before write mmap_lock is taken, when we
> > check vma->anon_vma, it is possible it has not been set up yet. But it
> > seems to be equivalent to page fault after fork and won't break the
> > semantic.
>
> Re-reading Suren's commit log for fb49c455323ff8
> ("fork: lock VMAs of the parent process when forking"),
> it seems that vm_start_write() is used to protect
> against a race where anon_vma changes from NULL to
> non-NULL during fork. In that scenario, we hold the
> mmap_lock write lock, but not vma_start_write(), so a
> concurrent anon_vma_prepare() could still install an
> anon_vma.
>
> "    A concurrent page fault on a page newly marked read-only by the page
>     copy might trigger wp_page_copy() and a anon_vma_prepare(vma) on the
>     source vma, defeating the anon_vma_clone() that wasn't done because t=
he
>     parent vma originally didn't have an anon_vma, but we now might end u=
p
>     copying a pte entry for a page that has one.
> "
>
> If that is the case, then your change does not work.
>
> Nowadays, nobody calls anon_vma_prepare(vma) directly.
> Instead, vmf_anon_prepare() is used, and we always
> require the mmap_lock read lock before calling
> __anon_vma_prepare(). As a result, anon_vma cannot
> transition from NULL to non-NULL during fork.
>
> So the original race condition has effectively
> disappeared.

anon_vma_prepare() has some usecases too, but it seems like it
requires taking read mmap_lock too if I read the code correctly.

>
> You also mentioned the madvise() case. If I understand
> correctly, madvise() should take mmap_lock before
> modifying anon_vma. Only some parts of madvise() can
> support per-VMA locking. Therefore, we probably do not
> need:
>
> if (vma->anon_vma) {
> vma_start_write_killable(src_vma);
> ...
> }

I think we still need write vma lock to serialize anon_vma fork
otherwise we may see:

        CPU 0                                                 CPU 1
fork                                                       page fault
   src vma has no anon_vma
       skip vma fork

allocate anon_vma for src vma
vma_needs_copy() sees anon_vma
copy page

Then we may end up being no anon_vma for dst vma, but with pages mapped in =
it.

Thanks,
Yang

>
> >
> > Anyway, just a crazy idea, I may miss some corner cases.
>
> To me, it seems that we could remove vma_start_write()
> entirely now. Or is that an even crazier idea?


>
> Thanks
> Barry
