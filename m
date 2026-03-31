Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953C3D9DD8
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969579; cv=pass; b=i8VAad62NnPjCGbML2tG+KEMOvF0IcS+8YVg1uNTQkQcvTKR06e7/Ma16rNkAxixXGL7zPlM75LtBQFLyob1ez04WjkthruH+j0qiuhLZ+gnBILVwwPUL3pQl3vTIxXI55AJ2AQFRtqbrVTqktb+QzXLldTq8r9SfMUPClGK/PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969579; c=relaxed/simple;
	bh=tzXS2j2SeN7JvSrkYfqZjy4kdzgi5292Sy9hsy+srmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpKm1KIQhxIvrX+Oj54J1c3oVRthYZd7pSpCpgYfqHjjmFH9y9kOiCK+lPmvczYY15h+U+XZHDeuAjcZWH1jkTy+hVUiS/pBKbjZ7Ng+HaJ6xUdd/vnfB9lo16ZhiJoKrri98E43Ci9TAzu7lesuazsrG180bb8PAPOc+R1vUVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWbv6LZm; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWbv6LZm"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-509062d829dso563211cf.1
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 08:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969576; cv=none;
        d=google.com; s=arc-20240605;
        b=RjJ8fuReYlXAOOvcE+tB8NUYcalm0Jhw28/unXTunmC3vJXr87M/EWbYLbtALHmXVw
         oE0HBAT17NBIga0Z9M7E2w6zwnF42MuhLLI4o5tYnLgIYgmDOFdpnoXEjIxp5O3pwiQ9
         uUGkpJFEaPK44UihKp4mT3BJdKYr2EUsQBeH+DYlLwPx2C7K/YxcDU1ktal5rjMMfVC0
         dsXGKk3Ey2wG08ercyWq012EQLVSGmuQzFrXUG9n0+AJw6mmTvrufoxGzxhBrSeEcj5e
         4u5E3tKuCUoA4XVEQZdtO4T9ipKFI9qTLTjiL6KxLs+7yOBCD/osu35vVE5POO/beAqX
         hLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPhLUWPeq7nYkrn0qmrS6IUP8HvQfT6M1S21IWIT2p4=;
        fh=AmNuKU36eU1LYqwJztutHpKm0LhgkxH9KPG7Sz+CY20=;
        b=JJ91JyxI9UiAWlMMY9WiCHlxk/rccMQuTq5wk64EnI4C5iST8KwC12k5dBgJYAUzju
         q7JYj/3nt2hpYZjhbSZSCQe0V8QxD3sC2Ac+5r0Pa/Ghpik5bjpfJ37PN/7EKZ61cCdV
         p879Tk0H+I8yJ4Gv2WiHjqJakBhKDqLfN1v+AZmKwxBr1ycEbXuoLDOsl2mR/L+3/q1z
         xGxjPJoYyNXiW+ACH9SecACmwOZEKvb/11JvuhnBCnDxmr3aXOcZH9B/rSUyAC+7IJQH
         DzFRbwEXl0PxrmheYt+Iss07kAIoYlyORPQVXUX7045NUcc46y7KOsG5r02JOTxWrS8Y
         sA4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774969576; x=1775574376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPhLUWPeq7nYkrn0qmrS6IUP8HvQfT6M1S21IWIT2p4=;
        b=rWbv6LZmEdpUPUwBlOvj6dS5rIWDX6gutLKbQUxxQqV7SSsKaYE0OuzPsSccsaPXRg
         AWI0Xp8jarnhoS523SYZvjjLEmqElzJQoF89AXRiegSlYaI+aMVc7bzUMI1LcV1MLoN/
         U5BQgClFS/bKl08nHzf0DVOmXEz7L6rTjT1zG+XQ6YcahdYQSsx6SHsvnoh/VO/0VxFr
         0BooCpmLiVwtjQ9DX3JAdwm4IieF0bwUjlaenE46z9JxoAzg4+7XEWy9As01g0KKzDq8
         0MwIAcvr7DgNlOSPpxAYFgPo2XXPWcKe1uXowwVbkNBs2IS4dSVSKBr5Xah7mqGMic7/
         KVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969576; x=1775574376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPhLUWPeq7nYkrn0qmrS6IUP8HvQfT6M1S21IWIT2p4=;
        b=b09211SB7ltR2gu9/eXpyuvsb2Kt3jI/wJ+VPhyogXtQFEX3CaiinrJUxNOqkxC2P5
         Nk7P3A7R/1jMArvcPrc1uMgfP0WBlcivTEdqBASDTktBjbbMmvndIsX/wCAF0cxy1img
         GKpOsCuF4FtWqB4kvAl17o3co155ThJiudwUHSJ0rEXaOpu1YVPC4Jgv6/lyugpLIoid
         ZPUm5a8lLqw0FWxYkMy49unx9amCbd8eKJ+lbutyrEOQ9Xq9V/B2BwvmoBfHXRQtITmF
         pwoysCfAQD8snav0bRJ1tggsuLXeDxNiosbj7qH/iC8tldqqPVgHix8L0AeLDCIIZHh/
         +Atw==
X-Forwarded-Encrypted: i=1; AJvYcCXOtiBWvZZquIBYbQOqdcLutlacHeKTgXtxfiaq5zPzBHcF+b6sJy/CBdJGrZZCN2CxS17qLP5YnNlX@vger.kernel.org
X-Gm-Message-State: AOJu0YzL18c3BIfPeAnd8N5DYOWAW2MmIoePZIsFP92pkFWwbEJw0QNh
	jYRBCzJ+qqLw4i7HAcJT2ACq1R4pPzKV4r5FAssdkpuGcQNvPgmjwwoCnUjMTF0KZVJ65iGzOn0
	oigSCFafX73cuvxlfW0880CT8KKOQoOj2oXEj6PQ7
X-Gm-Gg: ATEYQzweTCiD/QzK77W0+4+lcFNUIUJV9UOf9Gf2LJtWW5TZHT8+waqRYB62pYcUkVy
	SUlCoYf+vIRN6o0Rm36BsGmamC2qZT8AwYbjD+45rAPyGovyGRtZh8CPh7Ib1PkiwIHKyME8gYL
	xh+AsR2qQ3uAmfd8TL60yrfTGnBTnNeQwyTE1mLoasSw7Yk/UR6Zy3X/koRJ4nN9IKShbe9ynfy
	ybG3sdJlm6aFMWrHDUv2QDoNJahlc5KLiO1fVcYOTYJeraz8P4AEbKAQmG87wisBeEBCEc9zvOO
	Hwxx+BFzZfm8eghp7JLhCMPC0D+fokeJPAk0Wg==
X-Received: by 2002:ac8:7f50:0:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50d2d5df51cmr17993481cf.10.1774969575456; Tue, 31 Mar 2026
 08:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>
 <f128b795-5577-40f9-8dae-936be4253642@lucifer.local>
In-Reply-To: <f128b795-5577-40f9-8dae-936be4253642@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:06:04 -0700
X-Gm-Features: AQROBzCkq9zWX_INOKKq7FRhsytABhuHOSOXWR8lJTFtOb6OteMYhMzewaRwAII
Message-ID: <CAJuCfpHmUop-UzxM9QN7OiAnXUzj461+9ErgtXrtve_bR0_NjA@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 2:51=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 04:12:26PM -0700, Andrew Morton wrote:
> > On Fri, 27 Mar 2026 13:54:51 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Now that we have vma_start_write_killable() we can replace most of th=
e
> > > vma_start_write() calls with it, improving reaction time to the kill
> > > signal.
> > >
> > > There are several places which are left untouched by this patchset:
> > >
> > > 1. free_pgtables() because function should free page tables even if a
> > > fatal signal is pending.
> > >
> > > 2. userfaultd code, where some paths calling vma_start_write() can
> > > handle EINTR and some can't without a deeper code refactoring.
> > >
> > > 3. mpol_rebind_mm() which is used by cpusset controller for migration=
s
> > > and operates on a remote mm. Incomplete operations here would result
> > > in an inconsistent cgroup state.
> > >
> > > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > > vma_start_write() out of these functions and replacing it with
> > > vma_assert_write_locked(), then callers of these functions should
> > > lock the vma themselves using vma_start_write_killable() whenever
> > > possible.
> >
> > Updated, thanks.
>
> Andrew - sorry I think we need to yank this and defer to next cycle,
> there's too many functional changes here.
>
> (There was not really any way for me to predict this would happen ahead o=
f
> time, unfortunately.)

Ok, no objections from me. I'll post v6 removing the part Lorenzo
objects to and you can pick it up whenever you deem appropriate.

>
> >
> > > Changes since v5 [1]:
> > > - Added Reviewed-by for unchanged patches, per Lorenzo Stoakes
> > >
> > > Patch#2:
> > > - Fixed locked_vm counter if mlock_vma_pages_range() fails in
> > > mlock_fixup(), per Sashiko
> > > - Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() and
> > > mseal_apply() when vma_modify_XXX creates a new VMA as it will alread=
y be
> > > locked. This prevents the possibility of incomplete operation if sign=
al
> > > happens after a successful vma_modify_XXX modified the vma tree,
> > > per Sashiko
>
> Prevents the possibility of an incomplete operation? But
> vma_write_lock_killable() checks to see if you're _already_ write locked
> and would make the operation a no-op? So how is this even a delta?
>
> It's a brave new world, arguing with sashiko via a submitter... :)

Yeah, this is not really a problem but I thought I would change it up
to make it apparent that the extra vma_write_lock_killable() is not
even called.

>
> > > - Removed obsolete comment in madvise_update_vma() and mprotect_fixup=
()
> > >
> > > Patch#4:
> > > - Added clarifying comment for vma_start_write_killable() when lockin=
g a
> > > detached VMA
> > > - Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers from
> > > falling back to a new VMA allocation, per Sashiko
> > > - Added a note in the changelog about temporary workaround of using
> > > ENOMEM to propagate the error in vma_merge_existing_range() and
> > > vma_expand()
> > >
> > > Patch#5:
> > > - Added fatal_signal_pending() check in do_mbind() to detect
> > > queue_pages_range() failures due to a pendig fatal signal, per Sashik=
o
> >
> > Changes since v5:
> >
> >
> >  mm/madvise.c   |   15 ++++++++++-----
> >  mm/mempolicy.c |    9 ++++++++-
> >  mm/mlock.c     |    2 ++
> >  mm/mprotect.c  |   26 ++++++++++++++++----------
> >  mm/mseal.c     |   27 +++++++++++++++++++--------
> >  mm/vma.c       |   20 ++++++++++++++++++--
> >  6 files changed, 73 insertions(+), 26 deletions(-)
> >
> > --- a/mm/madvise.c~b
> > +++ a/mm/madvise.c
> > @@ -172,11 +172,16 @@ static int madvise_update_vma(vm_flags_t
> >       if (IS_ERR(vma))
> >               return PTR_ERR(vma);
> >
> > -     madv_behavior->vma =3D vma;
> > -
> > -     /* vm_flags is protected by the mmap_lock held in write mode. */
> > -     if (vma_start_write_killable(vma))
> > -             return -EINTR;
> > +     /*
> > +      * If a new vma was created during vma_modify_XXX, the resulting
> > +      * vma is already locked. Skip re-locking new vma in this case.
> > +      */
> > +     if (vma =3D=3D madv_behavior->vma) {
> > +             if (vma_start_write_killable(vma))
> > +                     return -EINTR;
> > +     } else {
> > +             madv_behavior->vma =3D vma;
> > +     }
> >
> >       vma->flags =3D new_vma_flags;
> >       if (set_new_anon_name)
> > --- a/mm/mempolicy.c~b
> > +++ a/mm/mempolicy.c
> > @@ -1546,7 +1546,14 @@ static long do_mbind(unsigned long start
> >                       flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelis=
t);
> >
> >       if (nr_failed < 0) {
> > -             err =3D nr_failed;
> > +             /*
> > +              * queue_pages_range() might override the original error =
with -EFAULT.
> > +              * Confirm that fatal signals are still treated correctly=
.
> > +              */
> > +             if (fatal_signal_pending(current))
> > +                     err =3D -EINTR;
> > +             else
> > +                     err =3D nr_failed;
> >               nr_failed =3D 0;
> >       } else {
> >               vma_iter_init(&vmi, mm, start);
> > --- a/mm/mlock.c~b
> > +++ a/mm/mlock.c
> > @@ -518,6 +518,8 @@ static int mlock_fixup(struct vma_iterat
> >               vma->flags =3D new_vma_flags;
> >       } else {
> >               ret =3D mlock_vma_pages_range(vma, start, end, &new_vma_f=
lags);
> > +             if (ret)
> > +                     mm->locked_vm -=3D nr_pages;
> >       }
> >  out:
> >       *prev =3D vma;
> > --- a/mm/mprotect.c~b
> > +++ a/mm/mprotect.c
> > @@ -716,6 +716,7 @@ mprotect_fixup(struct vma_iterator *vmi,
> >       const vma_flags_t old_vma_flags =3D READ_ONCE(vma->flags);
> >       vma_flags_t new_vma_flags =3D legacy_to_vma_flags(newflags);
> >       long nrpages =3D (end - start) >> PAGE_SHIFT;
> > +     struct vm_area_struct *new_vma;
> >       unsigned int mm_cp_flags =3D 0;
> >       unsigned long charged =3D 0;
> >       int error;
> > @@ -772,21 +773,26 @@ mprotect_fixup(struct vma_iterator *vmi,
> >               vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
> >       }
> >
> > -     vma =3D vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma_f=
lags);
> > -     if (IS_ERR(vma)) {
> > -             error =3D PTR_ERR(vma);
> > +     new_vma =3D vma_modify_flags(vmi, *pprev, vma, start, end,
> > +                                &new_vma_flags);
> > +     if (IS_ERR(new_vma)) {
> > +             error =3D PTR_ERR(new_vma);
> >               goto fail;
> >       }
> >
> > -     *pprev =3D vma;
> > -
> >       /*
> > -      * vm_flags and vm_page_prot are protected by the mmap_lock
> > -      * held in write mode.
> > +      * If a new vma was created during vma_modify_flags, the resultin=
g
> > +      * vma is already locked. Skip re-locking new vma in this case.
> >        */
> > -     error =3D vma_start_write_killable(vma);
> > -     if (error)
> > -             goto fail;
> > +     if (new_vma =3D=3D vma) {
> > +             error =3D vma_start_write_killable(vma);
> > +             if (error)
> > +                     goto fail;
> > +     } else {
> > +             vma =3D new_vma;
> > +     }
> > +
> > +     *pprev =3D vma;
> >
> >       vma_flags_reset_once(vma, &new_vma_flags);
> >       if (vma_wants_manual_pte_write_upgrade(vma))
> > --- a/mm/mseal.c~b
> > +++ a/mm/mseal.c
> > @@ -70,17 +70,28 @@ static int mseal_apply(struct mm_struct
> >
> >               if (!vma_test(vma, VMA_SEALED_BIT)) {
> >                       vma_flags_t vma_flags =3D vma->flags;
> > -                     int err;
> > +                     struct vm_area_struct *new_vma;
> >
> >                       vma_flags_set(&vma_flags, VMA_SEALED_BIT);
> >
> > -                     vma =3D vma_modify_flags(&vmi, prev, vma, curr_st=
art,
> > -                                            curr_end, &vma_flags);
> > -                     if (IS_ERR(vma))
> > -                             return PTR_ERR(vma);
> > -                     err =3D vma_start_write_killable(vma);
> > -                     if (err)
> > -                             return err;
> > +                     new_vma =3D vma_modify_flags(&vmi, prev, vma, cur=
r_start,
> > +                                                curr_end, &vma_flags);
> > +                     if (IS_ERR(new_vma))
> > +                             return PTR_ERR(new_vma);
> > +
> > +                     /*
> > +                      * If a new vma was created during vma_modify_fla=
gs,
> > +                      * the resulting vma is already locked.
> > +                      * Skip re-locking new vma in this case.
> > +                      */
> > +                     if (new_vma =3D=3D vma) {
> > +                             int err =3D vma_start_write_killable(vma)=
;
> > +                             if (err)
> > +                                     return err;
> > +                     } else {
> > +                             vma =3D new_vma;
> > +                     }
> > +
> >                       vma_set_flags(vma, VMA_SEALED_BIT);
> >               }
> >
> > --- a/mm/vma.c~b
> > +++ a/mm/vma.c
> > @@ -531,6 +531,10 @@ __split_vma(struct vma_iterator *vmi, st
> >       err =3D vma_start_write_killable(vma);
> >       if (err)
> >               goto out_free_vma;
> > +     /*
> > +      * Locking a new detached VMA will always succeed but it's just a
> > +      * detail of the current implementation, so handle it all the sam=
e.
> > +      */
> >       err =3D vma_start_write_killable(new);
> >       if (err)
> >               goto out_free_vma;
> > @@ -1197,8 +1201,14 @@ int vma_expand(struct vma_merge_struct *
> >
> >       mmap_assert_write_locked(vmg->mm);
> >       err =3D vma_start_write_killable(target);
> > -     if (err)
> > +     if (err) {
> > +             /*
> > +              * Override VMA_MERGE_NOMERGE to prevent callers from
> > +              * falling back to a new VMA allocation.
> > +              */
> > +             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> >               return err;
> > +     }
> >
> >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY_F=
LAGS);
> >
> > @@ -1231,8 +1241,14 @@ int vma_expand(struct vma_merge_struct *
> >                * is pending.
> >                */
> >               err =3D vma_start_write_killable(next);
> > -             if (err)
> > +             if (err) {
> > +                     /*
> > +                      * Override VMA_MERGE_NOMERGE to prevent callers =
from
> > +                      * falling back to a new VMA allocation.
> > +                      */
> > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> >                       return err;
> > +             }
> >               err =3D dup_anon_vma(target, next, &anon_dup);
> >               if (err)
> >                       return err;
> > _
> >
