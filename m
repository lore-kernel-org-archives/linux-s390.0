Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68F41B342
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971445; cv=pass; b=p51rLr2aM3kmqTQl2bwtgue3LOlzPQXNX3xhraXJrdnm/T8SJzR34TvLhDgrxne96HAfCkJyVX6uui1Krgboq6IpACjpEtdn7BFbRef/qUq0uOTEoAqakM1xc94/k1xllJRmqlDX3kNU765DbjA0JMKQSuZekaXimMib0YwU+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971445; c=relaxed/simple;
	bh=sGV64qBtQMZv/QMbs7giOc7t/2tP43WBgyfNE742SZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIb4yH95kj8552/9MRex4D8/8dnvl2whaQZ1ozquT68d8zL1w/xR4hE7loZpNm3r02dmr/ngznOLcJKx3XMzcmTzmhudYXvQBYRMFVShesgFu6dkRqJZRQq18ANx5mLmdRctTvNxqQbFVcXDAa6AsjuejHhHmPaDBMrmEYHZejQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwZ/MOU4; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwZ/MOU4"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so14087a12.0
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 08:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971441; cv=none;
        d=google.com; s=arc-20240605;
        b=UELddmMGimVPxwtzxEAbk+4fI0GutHzFjHQj9ulF0BD97JLryxxxVqQ0XwXSdYxOFY
         d0qtjIRSKeQNOqt1TGKhMYMVETzXprKcrB9Y8iPOqWoKZV7LTA/72pxRFmzZUVO5p1uU
         9CRxR76sAyVKRKT6Kbyo1HDnWocJRvaexSYuNi6FK8ZrIUTFK4QvWwCdjwlMAxRdZSxK
         TJN6r0tf8PuStJD2nYI3V3F4V2EGoxipkjZmq5JU8e45KBldMJSEW7gBW6jfYG3hCjVZ
         bDrOTDs1tZuoLeNQ0Hbx1u9K4tWefz4VXlsTIkqpx4L25fF0nhXHSdCNxcHfz1t2l+s7
         QB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        fh=EAbbMOhnml+hvhEF/gumO2xKRbGOrWny6I+iY2zVRow=;
        b=b/JyeMnK33Mtfsn2nTnbt7+Nc+BwUD8oHKdtxedQyeBMW4glxQ9pHzesAUlrtpxByP
         5x6986xoNOQ82BaRqFtaAI3h2EZixwbW0hlxyeu5+hNdAvH8F6tD+hHZ5LiObVPIrL77
         HCRed2/esXWmleLJOTleQTF/bQ0eMzZuati30sWCxzxzLtTArv5pvEwWoEZmCWzUYKwm
         jKjKnimCkqaIek27pF7zf05OSW54h3Mdo5wt61fqMdpvY5LPkmppUFKGu9SrYRZIT0yn
         mYFLz20Zl1eUOESddhjopf3XGDkHkS3C3dklqXUKwDuNrhcUi17oY7Y7wXpfQ5wmr7L6
         /uVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971441; x=1775576241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        b=cwZ/MOU4acfnAw128bYO1i4LjmsOc+6CtqHZpOh8gBj+u4fCFUB8lYAmtW6E8MX6sj
         Cw4wj8eGg8HovojhVkW1Bp48vn7GEo9KPdNu+/cKJXoT+sFzbtGin5hpQgmQ97VqV55v
         Q+dZlyYtTR47q7f9hGUQ5TJIbLjA/OS9Djrv0SRffMy6XJOYxi1wRyJ2oVZBXEalDUTu
         0C5/2256lTGU9ZKlHwdBjSjK7957n78gKuBAeEq+uh1Py4y3y3VV8THYvanaZv3LSw1P
         hlHL7npbOKUFoIjjRpVy/AUNdMtO6nLJrg0iS1G724rlHQCGYnwEjiiNvW//OJskuGVq
         p4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971441; x=1775576241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        b=iMLvMhZfTdC/74T8t9M1CrmpmgPCPs5AdiWclsy1ZpgIDYkH7xoVg9KNUA+H0R6vIN
         oIU4LtwdU2bBxfdEBS58ADNvKyEwhWsmdX67+GRRq44ftkE3Rozegpz5MM6DvmirsWS8
         ZAc1GkcnBSDUIMAei7qkD11vZxNX9IiMZdZjp3JH1AGqwHxIBC/4o3sQSug0M7MvZE5e
         pufQgUzwLOdcPQRoH4n8zE9FQoihNfaSAmZmC0J1srHBgR5Eh7HiI7HSkysz7P+4EB9o
         jT2n300V0qb1lh+DwIw9FygXC3cYKSp7xU/knrbTwZ+O/HqVm6SUlAJv0HgbFeOzXT2l
         vT/A==
X-Forwarded-Encrypted: i=1; AJvYcCUpdmRjs3VcfdT5A3cv38BWNWEpJM2anPgy1vqPBRs/xYYSptVj1mst05l1cVpniYBWe0g8czxkjffv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsirh/Z0Z66L2aWU7u3ij/sxwTrS+LCcftp8MOQZQ5oR0aQrgD
	Ksqg18XIGAz4k0Ve36cYw6vdYaTSWoDU+XOy5/ZYi0wdi0RPyIPVvH59Wycdt4KKPoVfUeNVKeT
	0weXFvKIzIkVvh4ZVxYGhMgZQ8xB9sSsMSoAhF28v
X-Gm-Gg: ATEYQzwu4JnpGe3F7l+WZAyLqQ/mRvauF+fu9FHg4nTNGr/zL9xNWP2nSRvQdnyfSPd
	3oNeK5/BQ+qyXc8wLLRuLOUVSNuOhpSRxeaTNTmJ5YX46Lad1+jjqklZY7iv3oZfubw8BdRPw8k
	LKIWhUdk1elUhgx8IFCa8xL/EiOIczO250/DCgZM0AGUbNyF78XISvHl1VwBFxGoyvlFH0pb9DO
	uCrDb3PKw1tBTMdZAb0lrT4PJ7W6ondprlXY9SrPec5BBdvPQGYgWjInvHJzA8ZT8L7++fFHtnK
	mzvkOYT+eYBcvedmgste7tKSXKDYTIkhoLwt/Q==
X-Received: by 2002:aa7:d889:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-66d95ac7d37mr2610a12.3.1774971440376; Tue, 31 Mar 2026 08:37:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-5-surenb@google.com>
 <e490c85f-e1e6-4722-9399-e4743549a390@lucifer.local>
In-Reply-To: <e490c85f-e1e6-4722-9399-e4743549a390@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:37:06 -0700
X-Gm-Features: AQROBzC2ce12XO-wrMbjKgwg4rrHJ7TFHnXAWz9ZLQknqrZfo06VAqH0Uhfwo2M
Message-ID: <CAJuCfpEOynabVz3Z2o6-KZAbE-bT49oXtR68GeS7YmCrYzC6ww@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mm/vma: use vma_start_write_killable() in vma operations
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:24=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 01:54:55PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable(), improving
> > reaction time to the kill signal.
> > Replace vma_start_write() calls when we operate on VMAs.
> >
> > To propagate errors from vma_merge_existing_range() and vma_expand()
> > we fake an ENOMEM error when we fail due to a pending fatal signal.
> > This is a temporary workaround. Fixing this requires some refactoring
> > and will be done separately in the future.
> >
> > In a number of places we now lock VMA earlier than before to avoid
> > doing work and undoing it later if a fatal signal is pending. This
> > is safe because the moves are happening within sections where we
> > already hold the mmap_write_lock, so the moves do not change the
> > locking order relative to other kernel locks.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/vma.c      | 146 ++++++++++++++++++++++++++++++++++++++------------
> >  mm/vma_exec.c |   6 ++-
> >  2 files changed, 117 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index ba78ab1f397a..cc382217f730 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -524,6 +524,21 @@ __split_vma(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
> >               new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT)=
;
> >       }
> >
> > +     /*
> > +      * Lock VMAs before cloning to avoid extra work if fatal signal
> > +      * is pending.
> > +      */
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             goto out_free_vma;
> > +     /*
> > +      * Locking a new detached VMA will always succeed but it's just a
> > +      * detail of the current implementation, so handle it all the sam=
e.
> > +      */
> > +     err =3D vma_start_write_killable(new);
> > +     if (err)
> > +             goto out_free_vma;
> > +
> >       err =3D -ENOMEM;
> >       vma_iter_config(vmi, new->vm_start, new->vm_end);
> >       if (vma_iter_prealloc(vmi, new))
> > @@ -543,9 +558,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
> >       if (new->vm_ops && new->vm_ops->open)
> >               new->vm_ops->open(new);
> >
> > -     vma_start_write(vma);
> > -     vma_start_write(new);
> > -
> >       init_vma_prep(&vp, vma);
> >       vp.insert =3D new;
> >       vma_prepare(&vp);
> > @@ -900,12 +912,22 @@ static __must_check struct vm_area_struct *vma_me=
rge_existing_range(
> >       }
> >
> >       /* No matter what happens, we will be adjusting middle. */
> > -     vma_start_write(middle);
> > +     err =3D vma_start_write_killable(middle);
> > +     if (err) {
> > +             /* Ensure error propagates. */
> > +             vmg->give_up_on_oom =3D false;
> > +             goto abort;
> > +     }
> >
> >       if (merge_right) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
> > +             err =3D vma_start_write_killable(next);
> > +             if (err) {
> > +                     /* Ensure error propagates. */
> > +                     vmg->give_up_on_oom =3D false;
> > +                     goto abort;
> > +             }
> >               vmg->target =3D next;
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> >               vma_flags_set_mask(&sticky_flags, next_sticky);
> > @@ -914,7 +936,12 @@ static __must_check struct vm_area_struct *vma_mer=
ge_existing_range(
> >       if (merge_left) {
> >               vma_flags_t prev_sticky;
> >
> > -             vma_start_write(prev);
> > +             err =3D vma_start_write_killable(prev);
> > +             if (err) {
> > +                     /* Ensure error propagates. */
> > +                     vmg->give_up_on_oom =3D false;
> > +                     goto abort;
> > +             }
> >               vmg->target =3D prev;
> >
> >               prev_sticky =3D vma_flags_and_mask(&prev->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1170,10 +1197,18 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       vma_flags_t sticky_flags =3D
> >               vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
> >       vma_flags_t target_sticky;
> > -     int err =3D 0;
> > +     int err;
> >
> >       mmap_assert_write_locked(vmg->mm);
> > -     vma_start_write(target);
> > +     err =3D vma_start_write_killable(target);
> > +     if (err) {
> > +             /*
> > +              * Override VMA_MERGE_NOMERGE to prevent callers from
> > +              * falling back to a new VMA allocation.
> > +              */
> > +             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > +             return err;
> > +     }
> >
> >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY_F=
LAGS);
> >
> > @@ -1201,6 +1236,19 @@ int vma_expand(struct vma_merge_struct *vmg)
> >        * we don't need to account for vmg->give_up_on_mm here.
> >        */
> >       if (remove_next) {
> > +             /*
> > +              * Lock the VMA early to avoid extra work if fatal signal
> > +              * is pending.
> > +              */
> > +             err =3D vma_start_write_killable(next);
> > +             if (err) {
> > +                     /*
> > +                      * Override VMA_MERGE_NOMERGE to prevent callers =
from
> > +                      * falling back to a new VMA allocation.
> > +                      */
>
> I don't think we need huge, duplicated comments everywhere.
>
> I don't like us effectively lying about an OOM.
>
> Here's what I said on v4:
>
> https://lore.kernel.org/all/9845b243-1984-4d74-9feb-d9d28757fba6@lucifer.=
local/
>
>         I think we need to update vma_modify():
>
>                 /* First, try to merge. */
>                 merged =3D vma_merge_existing_range(vmg);
>                 if (merged)
>                         return merged;
>                 if (vmg_nomem(vmg))
>                         return ERR_PTR(-ENOMEM);
>         +       if (fatal_signal_pending(current))
>         +               return -EINTR;
>
> OK I see you replied:
>
>         We need to be careful here. I think there are cases when vma is
>         modified from a context of a different process, for example in
>         process_madvise(). fatal_signal_pending(current) would yield inco=
rrect
>         result because vma->vm_mm is not the same as current->mm.
>
> Sorry missed that.
>
> That's utterly horrible, yes.
>
> I'm sorry but I think this series then is going to have to wait for me to=
 rework
> this code, unfortunately.
>
> I can't really stand you returning a fake error code it's too confusing.
>
> I guess I'll have to go do that as a priority then and maybe queue it up =
so it's
> kinda ready for 7.2.
>
> In any case I said in reply to the cover, I think this series is going to=
 have
> to wait for next cycle (i.e. 7.2), sorry. Just too many functional change=
s in
> this revision.

Sounds reasonable. I'm not a fan of faking the error code myself, so
hopefully, this change becomes much simpler after your rework.

>
> > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > +                     return err;
> > +             }
> >               err =3D dup_anon_vma(target, next, &anon_dup);
> >               if (err)
> >                       return err;
> > @@ -1214,7 +1262,6 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       if (remove_next) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
> >               vmg->__remove_next =3D true;
> >
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1252,9 +1299,14 @@ int vma_shrink(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
> >              unsigned long start, unsigned long end, pgoff_t pgoff)
> >  {
> >       struct vma_prepare vp;
> > +     int err;
> >
> >       WARN_ON((vma->vm_start !=3D start) && (vma->vm_end !=3D end));
> >
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             return err;
> > +
> >       if (vma->vm_start < start)
> >               vma_iter_config(vmi, vma->vm_start, start);
> >       else
> > @@ -1263,8 +1315,6 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> >       if (vma_iter_prealloc(vmi, NULL))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
> > -
> >       init_vma_prep(&vp, vma);
> >       vma_prepare(&vp);
> >       vma_adjust_trans_huge(vma, start, end, NULL);
> > @@ -1453,7 +1503,9 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                       if (error)
> >                               goto end_split_failed;
> >               }
> > -             vma_start_write(next);
> > +             error =3D vma_start_write_killable(next);
> > +             if (error)
> > +                     goto munmap_gather_failed;
> >               mas_set(mas_detach, vms->vma_count++);
> >               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
> >               if (error)
> > @@ -1848,12 +1900,16 @@ static void vma_link_file(struct vm_area_struct=
 *vma, bool hold_rmap_lock)
> >  static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
> >  {
> >       VMA_ITERATOR(vmi, mm, 0);
> > +     int err;
> > +
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             return err;
> >
> >       vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
> >       if (vma_iter_prealloc(&vmi, vma))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
> >       vma_iter_store_new(&vmi, vma);
> >       vma_link_file(vma, /* hold_rmap_lock=3D */false);
> >       mm->map_count++;
> > @@ -2239,9 +2295,8 @@ int mm_take_all_locks(struct mm_struct *mm)
> >        * is reached.
> >        */
> >       for_each_vma(vmi, vma) {
> > -             if (signal_pending(current))
> > +             if (signal_pending(current) || vma_start_write_killable(v=
ma))
> >                       goto out_unlock;
> > -             vma_start_write(vma);
> >       }
> >
> >       vma_iter_init(&vmi, mm, 0);
> > @@ -2540,8 +2595,8 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap,
> >       struct mmap_action *action)
> >  {
> >       struct vma_iterator *vmi =3D map->vmi;
> > -     int error =3D 0;
> >       struct vm_area_struct *vma;
> > +     int error;
> >
> >       /*
> >        * Determine the object being mapped and call the appropriate
> > @@ -2552,6 +2607,14 @@ static int __mmap_new_vma(struct mmap_state *map=
, struct vm_area_struct **vmap,
> >       if (!vma)
> >               return -ENOMEM;
> >
> > +     /*
> > +      * Lock the VMA early to avoid extra work if fatal signal
> > +      * is pending.
> > +      */
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto free_vma;
> > +
> >       vma_iter_config(vmi, map->addr, map->end);
> >       vma_set_range(vma, map->addr, map->end, map->pgoff);
> >       vma->flags =3D map->vma_flags;
> > @@ -2582,8 +2645,6 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap,
> >       WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
> >  #endif
> >
> > -     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> > -     vma_start_write(vma);
> >       vma_iter_store_new(vmi, vma);
> >       map->mm->map_count++;
> >       vma_link_file(vma, action->hide_from_rmap_until_complete);
> > @@ -2878,6 +2939,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >                unsigned long addr, unsigned long len, vma_flags_t vma_f=
lags)
> >  {
> >       struct mm_struct *mm =3D current->mm;
> > +     int err;
> >
> >       /*
> >        * Check against address space limits by the changed size
> > @@ -2910,24 +2972,33 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >
> >               if (vma_merge_new_range(&vmg))
> >                       goto out;
> > -             else if (vmg_nomem(&vmg))
> > +             if (vmg_nomem(&vmg)) {
> > +                     err =3D -ENOMEM;
> >                       goto unacct_fail;
> > +             }
> >       }
> >
> >       if (vma)
> >               vma_iter_next_range(vmi);
> >       /* create a vma struct for an anonymous mapping */
> >       vma =3D vm_area_alloc(mm);
> > -     if (!vma)
> > +     if (!vma) {
> > +             err =3D -ENOMEM;
> >               goto unacct_fail;
> > +     }
> >
> >       vma_set_anonymous(vma);
> >       vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
> >       vma->flags =3D vma_flags;
> >       vma->vm_page_prot =3D vm_get_page_prot(vma_flags_to_legacy(vma_fl=
ags));
> > -     vma_start_write(vma);
> > -     if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
> > +     if (vma_start_write_killable(vma)) {
> > +             err =3D -EINTR;
> > +             goto vma_lock_fail;
> > +     }
> > +     if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL)) {
> > +             err =3D -ENOMEM;
> >               goto mas_store_fail;
> > +     }
> >
> >       mm->map_count++;
> >       validate_mm(mm);
> > @@ -2942,10 +3013,11 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >       return 0;
> >
> >  mas_store_fail:
> > +vma_lock_fail:
> >       vm_area_free(vma);
> >  unacct_fail:
> >       vm_unacct_memory(len >> PAGE_SHIFT);
> > -     return -ENOMEM;
> > +     return err;
> >  }
> >
> >  /**
> > @@ -3112,8 +3184,8 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *next;
> >       unsigned long gap_addr;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
> >
> >       if (!vma_test(vma, VMA_GROWSUP_BIT))
> >               return -EFAULT;
> > @@ -3149,12 +3221,14 @@ int expand_upwards(struct vm_area_struct *vma, =
unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto vma_prep_fail;
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto vma_lock_fail;
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3183,8 +3257,10 @@ int expand_upwards(struct vm_area_struct *vma, u=
nsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     vma_iter_free(&vmi);
> >       validate_mm(mm);
> > +vma_lock_fail:
> > +vma_prep_fail:
> > +     vma_iter_free(&vmi);
> >       return error;
> >  }
> >  #endif /* CONFIG_STACK_GROWSUP */
> > @@ -3197,8 +3273,8 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *prev;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
> >
> >       if (!vma_test(vma, VMA_GROWSDOWN_BIT))
> >               return -EFAULT;
> > @@ -3228,12 +3304,14 @@ int expand_downwards(struct vm_area_struct *vma=
, unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto vma_prep_fail;
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto vma_lock_fail;
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3263,8 +3341,10 @@ int expand_downwards(struct vm_area_struct *vma,=
 unsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     vma_iter_free(&vmi);
> >       validate_mm(mm);
> > +vma_lock_fail:
> > +vma_prep_fail:
> > +     vma_iter_free(&vmi);
> >       return error;
> >  }
> >
> > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > index 5cee8b7efa0f..8ddcc791d828 100644
> > --- a/mm/vma_exec.c
> > +++ b/mm/vma_exec.c
> > @@ -41,6 +41,7 @@ int relocate_vma_down(struct vm_area_struct *vma, uns=
igned long shift)
> >       struct vm_area_struct *next;
> >       struct mmu_gather tlb;
> >       PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > +     int err;
> >
> >       BUG_ON(new_start > new_end);
> >
> > @@ -56,8 +57,9 @@ int relocate_vma_down(struct vm_area_struct *vma, uns=
igned long shift)
> >        * cover the whole range: [new_start, old_end)
> >        */
> >       vmg.target =3D vma;
> > -     if (vma_expand(&vmg))
> > -             return -ENOMEM;
> > +     err =3D vma_expand(&vmg);
> > +     if (err)
> > +             return err;
> >
> >       /*
> >        * move the page tables downwards, on failure we rely on
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
