Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A951264A86
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362184; cv=pass; b=f5dOedF06qcA/JHrTVAkY4qplA/TnPlF8ZPFRKDWhd8e4eOalpBZeN4sGmyyUyfsnrmarvMcSll5JFjtgCIalJY8gjZv9MZp99v9nfct0S3xantvcTXuRjo2SOqMR9bhysD/4H//lL/wJomv0qnc8TnQBIHwz66dV5sXip6JC78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362184; c=relaxed/simple;
	bh=vGTuZZMEtyg7nu5bmzFC4/6gBVZeVwYi2WDUEiFHq58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IWW14CdVr3wYD//tQjw70GMTJaJD8gcQJSsTBnIra9DHYsNN39lhV2OzsBMh/5cui7wYK5sDfmqP+X0pQKL02xNBJH4ppQfVKoIgM9md86586ah5n2k8bw1kitN6Kg6J6I/hWipmn0X/i2QREw1K9HtlqYyzkz+WoN5IKOauGq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqYF/ltg; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqYF/ltg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5033b64256dso153761cf.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 13:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771362181; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6umzSZYJswe93+v6h+bnNBOKcepJ5GGebqc2/CYDt4jleDeg3GK74Hc0XL/psGupH
         bZcTq0UQb4YLJAJO7jiKq4fQumVMUpJ8ofRNYVXDPyJX1mjgfazKd6dpJpmY7w6Y5l7Z
         cNPzfevmktuppucjm6G6rSRx2xR6bNIG/Ruy76QSFoeZz9cJGtMOv0+NVZoRs8KBHpiF
         Lh3zLPISnrqWQbC6jR0quepSVP0d7Vi9krvrfGjbnSk6QXLBAppm1s4MF6KgOFr3CBuS
         W7GpMyggPUZW2JVL+ugpWp/h7CjFdWud+Cxy3vHlEk6GLCW6Tq/EqWiwUgnGE5Urb12g
         +ATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qg7unfpae37+olsmr8ztHQ2bOQfrmh4+RuxK8GGnbgk=;
        fh=1URzZiYYXcwpVXYl6wKB/72ErcFnu4hV4DcRjpyQuuk=;
        b=YgKj6FET/Tjnvn8cp2TP5M1IXbsQZl67fWyD3tb5pAas8QYGRdSPDt66BSVtZgiSM9
         tqfqCwE4RrXcXr6iy4bChI6rNCA7jWDzUg7wdVaMDRTpIOygjGDamory5URJppHe2FNy
         cZwPsAZRIrXGIOLS+8IPZQh10qjkWYkxZ/68wkq6pSqzirtlXqed4yqXonq1fpREaNVY
         8HqtCiQX60yJuEsuAb2HT+3AxkdzQCyaFlqwJ2Mmnez8ZgosMWDcJD7bL7dRyyAFzl5u
         8eo40/DyxfMG3aihVhxYmeYUna+BaXbttsK5oLJ12zrzPKA0Sobm5Y+XLakGm3l+HEcx
         R7rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771362181; x=1771966981; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg7unfpae37+olsmr8ztHQ2bOQfrmh4+RuxK8GGnbgk=;
        b=GqYF/ltgoGtn/XGc4ESxXq3rNmfu49xfW+Vc1x0hwczUe4vH/iXTvunbTbyspgpHbA
         mdlNz0b7G20+39krPw9XRf+rowYNQTDcXR/+wvqiSiZl6NAj/GhKkntQUOaLTAkyo+gQ
         SHIBJcOSX+ib/0tHiF/IYX2Ts/xIHRsNyVSppHy2faKUhylQXpoJdriQ1miIgCkMn+jw
         mlCJBE/tBwWuYHUUteYGuDFSQijBLjW1b9WFlbWCIcJAqenlaiPbGdyzbzHypQ2aErui
         a5FbtkVvYFjLRh0ONGIMg9H+YP4qmcEfGnn9xVd6riXJmO3BPGX/qpqviEtk2RnqQkmK
         BVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771362181; x=1771966981;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qg7unfpae37+olsmr8ztHQ2bOQfrmh4+RuxK8GGnbgk=;
        b=lxdfiKKaY3TH5EAbGMfajkjyoLH+fgCWwb8/wxus/+kBc4BKh9vPUDcMoPSyzCoACN
         4JVVmXSzWnOWpKyEOvRhcYRjb9NvEXaqfevTzNjcdo7/89NK1iloO+VGPaHip7gum1dJ
         ggOrNSg83IWn65Z0EF1+KdnStyBdTdMEp1hM96hb9GimpNSpq2LckWGetC9T63MBOhfe
         G/+mVWBE8gfleqjf+LjxE6PNiExG1c05KbMfF/tbXl5Ar695PnE8PQXh0hCtBfjSP1jD
         GwqgVUIGsQYTSpci0NIfV/DXsJDnwGazwu85BumZm18KvCZpVWJQlz2fHSpNyhEUCE+y
         l1tA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xWEgIETRDAqF8QdL0HBCJ4EjeCP/xyz8BTCs6A7EhzZS2EWP/8VRTQ1XCT/tBYFvp28617H80p6h@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXbhxLzQ+nVriobJPeASdN8Ws2hEBv8hJJyAW5j9drUPJ80u1
	swJ68cryJP40/LS+kXOYhYXBxQnOBNM5WuFMzaTJcWA9FM/Aj+UIflPFGs7oSzPCHpnHe7StRvN
	eVoIAofO2TkMO9HAAzZNAcnhYp7oJwoCQxx01B2me
X-Gm-Gg: AZuq6aKf3ap1MPe7qel8gAit+Jmor5kJknciphQKxlOyncKd5FVR1niGFQ3i5ubtB0b
	Tz9+6z3EMaEVzyLtcrUutNkKIvqW0t3m170MIDpBGObfA3Z0iOLL/ITFxQvIC0wVoSPNN7uyOGJ
	W6mGsXxFPBSBsaaZ41weaV6HDNKN175AJxmfsBVNbulVIhmdDy8RLGE6yaJpAlHmoQoQ+sgcoV+
	H4aqkQROCQext6hOwxckfq8dtX8SOBfeBHDqLABYUFa8XiB/x/Z+7vb/adjLyLhhtdL+CN++bO5
	b7HYWW3IwNq6pduPGhT7RU8w6ZR7BkzJ/kPAVg==
X-Received: by 2002:a05:622a:8c15:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-506cdb80f2fmr23179661cf.19.1771362180478; Tue, 17 Feb 2026
 13:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com> <20260217163250.2326001-3-surenb@google.com>
 <dtdfrko7uqif6flc4mefnlar7wnmrbyswfu7bvb2ar24gkeejo@ypzhmyklbeh7>
In-Reply-To: <dtdfrko7uqif6flc4mefnlar7wnmrbyswfu7bvb2ar24gkeejo@ypzhmyklbeh7>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Feb 2026 13:02:48 -0800
X-Gm-Features: AaiRm52hFtG7L6yJLkbXYH1SBTkTSuw2iS_25yQRkmcsbZ2JjkS2e-zgf6Q_wu8
Message-ID: <CAJuCfpGViU4dDaLtPR8U0C+=FXO=1TuU-hT3fypNQO3LGOjbcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: replace vma_start_write() with vma_start_write_killable()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 11:19=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [260217 11:33]:
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patch:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. process_vma_walk_lock(), which requires changes in its callers and
> > will be handled in the next patch.
> >
> > 3. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> # powerpc
> > ---
> >  arch/powerpc/kvm/book3s_hv_uvmem.c |  5 +-
> >  include/linux/mempolicy.h          |  5 +-
> >  mm/khugepaged.c                    |  5 +-
> >  mm/madvise.c                       |  4 +-
> >  mm/memory.c                        |  2 +
> >  mm/mempolicy.c                     | 23 ++++++--
> >  mm/mlock.c                         | 20 +++++--
> >  mm/mprotect.c                      |  4 +-
> >  mm/mremap.c                        |  4 +-
> >  mm/vma.c                           | 93 +++++++++++++++++++++---------
> >  mm/vma_exec.c                      |  6 +-
> >  11 files changed, 123 insertions(+), 48 deletions(-)
> >
>
> ...
>
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
>
> ...
>
> >
> >  static const struct mempolicy_operations mpol_ops[MPOL_MAX] =3D {
> > @@ -1785,9 +1793,15 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigne=
d long, start, unsigned long, le
> >               return -EINVAL;
> >       if (end =3D=3D start)
> >               return 0;
> > -     mmap_write_lock(mm);
> > +     if (mmap_write_lock_killable(mm))
> > +             return -EINTR;
> >       prev =3D vma_prev(&vmi);
> >       for_each_vma_range(vmi, vma, end) {
> > +             if (vma_start_write_killable(vma)) {
> > +                     err =3D -EINTR;
> > +                     break;
> > +             }
> > +
> >               /*
> >                * If any vma in the range got policy other than MPOL_BIN=
D
> >                * or MPOL_PREFERRED_MANY we return error. We don't reset
> > @@ -1808,7 +1822,6 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned=
 long, start, unsigned long, le
> >                       break;
> >               }
> >
> > -             vma_start_write(vma);
>
> Moving this vma_start_write() up means we will lock all vmas in the
> range regardless of if they are going to change.  Was that your
> intention?

No, I missed that this would result in unnecessary locks.

>
> It might be better to move the locking to later in the loop, prior to
> the mpol_dup(), but after skipping other vmas?

Yes, that's the right place for it. Will move.

>
> >               new->home_node =3D home_node;
> >               err =3D mbind_range(&vmi, vma, &prev, start, end, new);
>
> ...
>
> > diff --git a/mm/vma.c b/mm/vma.c
> > index bb4d0326fecb..1d21351282cf 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
>
> ...
>
> > @@ -2532,6 +2556,11 @@ static int __mmap_new_vma(struct mmap_state *map=
, struct vm_area_struct **vmap)
> >               goto free_vma;
> >       }
> >
> > +     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto free_iter_vma;
> > +
> >       if (map->file)
> >               error =3D __mmap_new_file_vma(map, vma);
> >       else if (map->vm_flags & VM_SHARED)
> > @@ -2552,8 +2581,6 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap)
> >       WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
> >  #endif
> >
> > -     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> > -     vma_start_write(vma);
> >       vma_iter_store_new(vmi, vma);
> >       map->mm->map_count++;
> >       vma_link_file(vma, map->hold_file_rmap_lock);
>
> This is a bit of a nit on the placement..
>
> Prior to this change, the write lock on the vma was taken next to where
> it was inserted in the tree.  Now the lock is taken between vma iterator
> preallocations and part of the vma setup.
>
> Would it make sense to put it closer to the vma allocation itself?  I
> think all that's needed to be set is the mm struct for the locking to
> work?

I guess locking the vma before vma_iter_prealloc() would save us
unnecessary alloc/free in case of a pending fatal signal. I'll move
the lock right after vm_area_alloc() so that the entire vma setup is
done on a locked vma.

>
>
> ...
>
> > @@ -3089,7 +3120,7 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
>
> Good luck testing this one.

Yeah... Any suggestions for tests I should use?

>
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *next;
> >       unsigned long gap_addr;
> > -     int error =3D 0;
> > +     int error;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> >
> >       if (!(vma->vm_flags & VM_GROWSUP))
> > @@ -3126,12 +3157,14 @@ int expand_upwards(struct vm_area_struct *vma, =
unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto free;
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto free;
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3160,6 +3193,7 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > +free:
> >       vma_iter_free(&vmi);
> >       validate_mm(mm);
> >       return error;
>
> Looks okay.

Thanks for the review, Liam! I'll wait a couple of days and post the
v3 with fixes.

>
> ...
>
>
>
