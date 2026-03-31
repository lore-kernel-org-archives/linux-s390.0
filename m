Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABD421F02
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971294; cv=pass; b=Q+hNdjI7Pg35pUNiOvNZwNS/MdldSaRkwbwQcCGCS2dykX5W/Lvc8LaSQCCabZUdYeYqFC+3o6D6KpCf90LlawL7/oGMTpIvrATNFWt/7Kswhv+eyZDuC+gPMlvWrCb2AAcdsqkA68944hLNPSh/gQbP6IzztlU/TY7t9zy2l4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971294; c=relaxed/simple;
	bh=cUh21QIiIeQZvWIphMul6jErMzcQZ1z24liyA14tYCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir/SKXExbTPHUOz2kfNGRWCy0OkooBFryUR3wBem53x70J8F3wOkd3tjYf/b1AWNwKEXEXNETMmn8i23VvzXXgcqqeLwrWe+Xa3EwA6UH1GuZ+K/AJPnbmpXmtJtUct2nOenX7TDz2N0MJLB2rdL74kOwzlFEWvQdFijZvnRiXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdAXSpqO; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdAXSpqO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so14054a12.0
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 08:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971288; cv=none;
        d=google.com; s=arc-20240605;
        b=Q349qjXYjl5eY6ooya0d+sk3K2EbqK1dwKDia7h0wGD/cDELBTkw/lCbC96vEdP+ao
         NQsTWRKQtWnXpE4uKWObz8ZBBLlWXzIXGixghduFkhRRujRmM/HkUiT6SMxb9ahGOJ/d
         8r7kUo+h/lreBEml9bJW9AM/9qF6kCJQVxjJnqk6cG/s6Zcq+nQgmZrRhDWQRt5eUzto
         lQFJ6eU9V1Tfbk7J3S4Ia5LD8FUHtuZ9V9VAQoUaE3OtS4jDMGr6uPjzqpbc1bllgqtO
         OVyU1WawvRar6ocZWbRTKJIxkfHupI3Nw+YbkzLvjGwzTBcU1O8nMXmnmWa1OgwHUI35
         +bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        fh=tF+v7G2/bkqWAPqOydIlKwzRyuE5BXldcEEoSoRasFM=;
        b=Ky7fUDQ0leb0yWxK6r+6hYV1+AKH3lsbal4QMjS44T0pLmSffL5LBzu55DqsgxR/1j
         8XTCkeazIBHVYS+2C8VednjIaRig0wBh9G+hIVHUfIvcQ361K0nxyCr9U5+p4Kc/49I/
         T88v1z1cMm9HDP15fOe0N8e5apg3rhPj6d8Fv8cbdvVu8tNFRE3ZRAKJfCqX+/rfIOLw
         EFB+1Be15w1xjy+5Mjy5WvgzRF1hTJPsDsjF8ley71mOce+OkzZpszBjLCEoWVG8Uoh6
         XYh5Ns6HHR1eXEtcANmWeiOf5b1GTyBZh6UXWHRJOdmZlbbdN14h3t2//CDafe3Q15ob
         04ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971288; x=1775576088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        b=mdAXSpqOYhFSo4ejfOm0rTihWZ3cP6MR+BQiKVJO1Bc0WQKh9E/3lJ3wniqyGT84Rd
         QW8rc9TE4g43tsY8pGLiEoMcJKJTlGqEN7m2ljvvpYmNEuMmTYo1cuoP7ynu+pWQhGBH
         1Mk7S/86ImaDI4U9lzcOCg02+CUxGK893j3M0r4qlHIZADcu1XsZ1sEdFgt8NgYUQhIG
         8ac+KGKxD8rrl8n3M9AMzGcM7Xow6So52H2PLR/2j7fsZa5uRl9rinGfICihZx/KqG3N
         BnAQifjyNijXqOlze11FV/IbttXfJ3FwJ6kllH73Elow1H8JVQuL9vaiQ/bKRxv9w+NB
         eHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971288; x=1775576088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        b=lmgIkPifevbnhh+K9nrRYJ0OpYVY6Vw2S17C63Y5BlB4L3PRZaT+IQWuDiOKk+gcdh
         dSK95hs+lsO9/aMolFqbIpI4iN0hhbbVDJsrbY9+y87txZPYJ4Bx6+l11xtkKwsg0Kl1
         Rh3BQh/+pdcJ52lEuBMdBBeedpgtcjJ9oKprKzo+bq2VXQS+7P22MlK6JitRtyZDKlHy
         nsRQilwdjXELzvQ+eSS2trUMzbQw5YAhK+TxNnnSlmg1diLDEU+eCj2ykdMp6i4D5keN
         OdRofXPgP8b6zCLGPdeyl1OeuKGGRl1w2tuv1Y7wW7JyDpNPVtW3F1nh+2PhjUqXo72r
         O14A==
X-Forwarded-Encrypted: i=1; AJvYcCVzk9aHOAEXkBghsm30QhU9vVFFM/NEQZ7bOEigphhjuNyWrIyBiu+2JoICIafDMqHP4ZPcVDuazEyY@vger.kernel.org
X-Gm-Message-State: AOJu0YwIW2OhtR60np7GuZAvWqzI2bwoMPlwiRqaokYJ23O3DqsRQxhw
	Uut4z8JTJDeoPebHnI3QpGX2sLxNgLRgB+hTOoZTaFaGjzuqo+fEHXvmokwOiFxbOR+Mp4JqW8L
	mULty9pJq7WPys71eF+X9X+nXnnmuU33RgqYeCDFk
X-Gm-Gg: ATEYQzxjNtxsBY21A5B6vqNEcKevLOeaIFjq1/Hqk03H6dfD0oge/qsKExve14rjsU/
	/2dixLk4ai1ISCIq8elSSVS7LRUkswu5bYgNEoo+5vOQYmQJWUn9Bqm2lxtMfQ5H7PK09bfDUox
	m1dzTGrFNOYnYbpxWy00tXmmufnLosECgamnn8wO0xZWQEZMm9QMP02Ha3kUo2CDQ8TzDGZxY9X
	GByRQpZ/BztxsW/z21RSrn2BVN0u+jvmRLogqc7XO/GooD4SwJocz8gx8RsNi8lEihX86t52UGe
	w06K2Nu4rCIEIVmkih99RWNAUcC3mPNDSkraiw==
X-Received: by 2002:aa7:d157:0:b0:66b:ea0e:1782 with SMTP id
 4fb4d7f45d1cf-66d95ac6b83mr3294a12.2.1774971287536; Tue, 31 Mar 2026 08:34:47
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>
 <f128b795-5577-40f9-8dae-936be4253642@lucifer.local> <CAJuCfpHmUop-UzxM9QN7OiAnXUzj461+9ErgtXrtve_bR0_NjA@mail.gmail.com>
In-Reply-To: <CAJuCfpHmUop-UzxM9QN7OiAnXUzj461+9ErgtXrtve_bR0_NjA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:34:34 -0700
X-Gm-Features: AQROBzCjbp_TCkkxwhu_axsyxtZ1SbbwXiNA5twqFRnYfWa0PnszaVM289IvRRY
Message-ID: <CAJuCfpF5CqSMU4yz5mgSOTbSLfMsmATGk4vcKWiqrzV3rGkZEw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
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

On Tue, Mar 31, 2026 at 8:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Mar 31, 2026 at 2:51=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@ker=
nel.org> wrote:
> >
> > On Fri, Mar 27, 2026 at 04:12:26PM -0700, Andrew Morton wrote:
> > > On Fri, 27 Mar 2026 13:54:51 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > Now that we have vma_start_write_killable() we can replace most of =
the
> > > > vma_start_write() calls with it, improving reaction time to the kil=
l
> > > > signal.
> > > >
> > > > There are several places which are left untouched by this patchset:
> > > >
> > > > 1. free_pgtables() because function should free page tables even if=
 a
> > > > fatal signal is pending.
> > > >
> > > > 2. userfaultd code, where some paths calling vma_start_write() can
> > > > handle EINTR and some can't without a deeper code refactoring.
> > > >
> > > > 3. mpol_rebind_mm() which is used by cpusset controller for migrati=
ons
> > > > and operates on a remote mm. Incomplete operations here would resul=
t
> > > > in an inconsistent cgroup state.
> > > >
> > > > 4. vm_flags_{set|mod|clear} require refactoring that involves movin=
g
> > > > vma_start_write() out of these functions and replacing it with
> > > > vma_assert_write_locked(), then callers of these functions should
> > > > lock the vma themselves using vma_start_write_killable() whenever
> > > > possible.
> > >
> > > Updated, thanks.
> >
> > Andrew - sorry I think we need to yank this and defer to next cycle,
> > there's too many functional changes here.
> >
> > (There was not really any way for me to predict this would happen ahead=
 of
> > time, unfortunately.)
>
> Ok, no objections from me. I'll post v6 removing the part Lorenzo
> objects to and you can pick it up whenever you deem appropriate.

Just saw Lorenzo's other reply about reworking some vma error handling
first. I'll wait for that rework before posting the new version.

>
> >
> > >
> > > > Changes since v5 [1]:
> > > > - Added Reviewed-by for unchanged patches, per Lorenzo Stoakes
> > > >
> > > > Patch#2:
> > > > - Fixed locked_vm counter if mlock_vma_pages_range() fails in
> > > > mlock_fixup(), per Sashiko
> > > > - Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() an=
d
> > > > mseal_apply() when vma_modify_XXX creates a new VMA as it will alre=
ady be
> > > > locked. This prevents the possibility of incomplete operation if si=
gnal
> > > > happens after a successful vma_modify_XXX modified the vma tree,
> > > > per Sashiko
> >
> > Prevents the possibility of an incomplete operation? But
> > vma_write_lock_killable() checks to see if you're _already_ write locke=
d
> > and would make the operation a no-op? So how is this even a delta?
> >
> > It's a brave new world, arguing with sashiko via a submitter... :)
>
> Yeah, this is not really a problem but I thought I would change it up
> to make it apparent that the extra vma_write_lock_killable() is not
> even called.
>
> >
> > > > - Removed obsolete comment in madvise_update_vma() and mprotect_fix=
up()
> > > >
> > > > Patch#4:
> > > > - Added clarifying comment for vma_start_write_killable() when lock=
ing a
> > > > detached VMA
> > > > - Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers fro=
m
> > > > falling back to a new VMA allocation, per Sashiko
> > > > - Added a note in the changelog about temporary workaround of using
> > > > ENOMEM to propagate the error in vma_merge_existing_range() and
> > > > vma_expand()
> > > >
> > > > Patch#5:
> > > > - Added fatal_signal_pending() check in do_mbind() to detect
> > > > queue_pages_range() failures due to a pendig fatal signal, per Sash=
iko
> > >
> > > Changes since v5:
> > >
> > >
> > >  mm/madvise.c   |   15 ++++++++++-----
> > >  mm/mempolicy.c |    9 ++++++++-
> > >  mm/mlock.c     |    2 ++
> > >  mm/mprotect.c  |   26 ++++++++++++++++----------
> > >  mm/mseal.c     |   27 +++++++++++++++++++--------
> > >  mm/vma.c       |   20 ++++++++++++++++++--
> > >  6 files changed, 73 insertions(+), 26 deletions(-)
> > >
> > > --- a/mm/madvise.c~b
> > > +++ a/mm/madvise.c
> > > @@ -172,11 +172,16 @@ static int madvise_update_vma(vm_flags_t
> > >       if (IS_ERR(vma))
> > >               return PTR_ERR(vma);
> > >
> > > -     madv_behavior->vma =3D vma;
> > > -
> > > -     /* vm_flags is protected by the mmap_lock held in write mode. *=
/
> > > -     if (vma_start_write_killable(vma))
> > > -             return -EINTR;
> > > +     /*
> > > +      * If a new vma was created during vma_modify_XXX, the resultin=
g
> > > +      * vma is already locked. Skip re-locking new vma in this case.
> > > +      */
> > > +     if (vma =3D=3D madv_behavior->vma) {
> > > +             if (vma_start_write_killable(vma))
> > > +                     return -EINTR;
> > > +     } else {
> > > +             madv_behavior->vma =3D vma;
> > > +     }
> > >
> > >       vma->flags =3D new_vma_flags;
> > >       if (set_new_anon_name)
> > > --- a/mm/mempolicy.c~b
> > > +++ a/mm/mempolicy.c
> > > @@ -1546,7 +1546,14 @@ static long do_mbind(unsigned long start
> > >                       flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagel=
ist);
> > >
> > >       if (nr_failed < 0) {
> > > -             err =3D nr_failed;
> > > +             /*
> > > +              * queue_pages_range() might override the original erro=
r with -EFAULT.
> > > +              * Confirm that fatal signals are still treated correct=
ly.
> > > +              */
> > > +             if (fatal_signal_pending(current))
> > > +                     err =3D -EINTR;
> > > +             else
> > > +                     err =3D nr_failed;
> > >               nr_failed =3D 0;
> > >       } else {
> > >               vma_iter_init(&vmi, mm, start);
> > > --- a/mm/mlock.c~b
> > > +++ a/mm/mlock.c
> > > @@ -518,6 +518,8 @@ static int mlock_fixup(struct vma_iterat
> > >               vma->flags =3D new_vma_flags;
> > >       } else {
> > >               ret =3D mlock_vma_pages_range(vma, start, end, &new_vma=
_flags);
> > > +             if (ret)
> > > +                     mm->locked_vm -=3D nr_pages;
> > >       }
> > >  out:
> > >       *prev =3D vma;
> > > --- a/mm/mprotect.c~b
> > > +++ a/mm/mprotect.c
> > > @@ -716,6 +716,7 @@ mprotect_fixup(struct vma_iterator *vmi,
> > >       const vma_flags_t old_vma_flags =3D READ_ONCE(vma->flags);
> > >       vma_flags_t new_vma_flags =3D legacy_to_vma_flags(newflags);
> > >       long nrpages =3D (end - start) >> PAGE_SHIFT;
> > > +     struct vm_area_struct *new_vma;
> > >       unsigned int mm_cp_flags =3D 0;
> > >       unsigned long charged =3D 0;
> > >       int error;
> > > @@ -772,21 +773,26 @@ mprotect_fixup(struct vma_iterator *vmi,
> > >               vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
> > >       }
> > >
> > > -     vma =3D vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma=
_flags);
> > > -     if (IS_ERR(vma)) {
> > > -             error =3D PTR_ERR(vma);
> > > +     new_vma =3D vma_modify_flags(vmi, *pprev, vma, start, end,
> > > +                                &new_vma_flags);
> > > +     if (IS_ERR(new_vma)) {
> > > +             error =3D PTR_ERR(new_vma);
> > >               goto fail;
> > >       }
> > >
> > > -     *pprev =3D vma;
> > > -
> > >       /*
> > > -      * vm_flags and vm_page_prot are protected by the mmap_lock
> > > -      * held in write mode.
> > > +      * If a new vma was created during vma_modify_flags, the result=
ing
> > > +      * vma is already locked. Skip re-locking new vma in this case.
> > >        */
> > > -     error =3D vma_start_write_killable(vma);
> > > -     if (error)
> > > -             goto fail;
> > > +     if (new_vma =3D=3D vma) {
> > > +             error =3D vma_start_write_killable(vma);
> > > +             if (error)
> > > +                     goto fail;
> > > +     } else {
> > > +             vma =3D new_vma;
> > > +     }
> > > +
> > > +     *pprev =3D vma;
> > >
> > >       vma_flags_reset_once(vma, &new_vma_flags);
> > >       if (vma_wants_manual_pte_write_upgrade(vma))
> > > --- a/mm/mseal.c~b
> > > +++ a/mm/mseal.c
> > > @@ -70,17 +70,28 @@ static int mseal_apply(struct mm_struct
> > >
> > >               if (!vma_test(vma, VMA_SEALED_BIT)) {
> > >                       vma_flags_t vma_flags =3D vma->flags;
> > > -                     int err;
> > > +                     struct vm_area_struct *new_vma;
> > >
> > >                       vma_flags_set(&vma_flags, VMA_SEALED_BIT);
> > >
> > > -                     vma =3D vma_modify_flags(&vmi, prev, vma, curr_=
start,
> > > -                                            curr_end, &vma_flags);
> > > -                     if (IS_ERR(vma))
> > > -                             return PTR_ERR(vma);
> > > -                     err =3D vma_start_write_killable(vma);
> > > -                     if (err)
> > > -                             return err;
> > > +                     new_vma =3D vma_modify_flags(&vmi, prev, vma, c=
urr_start,
> > > +                                                curr_end, &vma_flags=
);
> > > +                     if (IS_ERR(new_vma))
> > > +                             return PTR_ERR(new_vma);
> > > +
> > > +                     /*
> > > +                      * If a new vma was created during vma_modify_f=
lags,
> > > +                      * the resulting vma is already locked.
> > > +                      * Skip re-locking new vma in this case.
> > > +                      */
> > > +                     if (new_vma =3D=3D vma) {
> > > +                             int err =3D vma_start_write_killable(vm=
a);
> > > +                             if (err)
> > > +                                     return err;
> > > +                     } else {
> > > +                             vma =3D new_vma;
> > > +                     }
> > > +
> > >                       vma_set_flags(vma, VMA_SEALED_BIT);
> > >               }
> > >
> > > --- a/mm/vma.c~b
> > > +++ a/mm/vma.c
> > > @@ -531,6 +531,10 @@ __split_vma(struct vma_iterator *vmi, st
> > >       err =3D vma_start_write_killable(vma);
> > >       if (err)
> > >               goto out_free_vma;
> > > +     /*
> > > +      * Locking a new detached VMA will always succeed but it's just=
 a
> > > +      * detail of the current implementation, so handle it all the s=
ame.
> > > +      */
> > >       err =3D vma_start_write_killable(new);
> > >       if (err)
> > >               goto out_free_vma;
> > > @@ -1197,8 +1201,14 @@ int vma_expand(struct vma_merge_struct *
> > >
> > >       mmap_assert_write_locked(vmg->mm);
> > >       err =3D vma_start_write_killable(target);
> > > -     if (err)
> > > +     if (err) {
> > > +             /*
> > > +              * Override VMA_MERGE_NOMERGE to prevent callers from
> > > +              * falling back to a new VMA allocation.
> > > +              */
> > > +             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > >               return err;
> > > +     }
> > >
> > >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY=
_FLAGS);
> > >
> > > @@ -1231,8 +1241,14 @@ int vma_expand(struct vma_merge_struct *
> > >                * is pending.
> > >                */
> > >               err =3D vma_start_write_killable(next);
> > > -             if (err)
> > > +             if (err) {
> > > +                     /*
> > > +                      * Override VMA_MERGE_NOMERGE to prevent caller=
s from
> > > +                      * falling back to a new VMA allocation.
> > > +                      */
> > > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > >                       return err;
> > > +             }
> > >               err =3D dup_anon_vma(target, next, &anon_dup);
> > >               if (err)
> > >                       return err;
> > > _
> > >
