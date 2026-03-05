Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B943CE48E
	for <linux-s390@vger.kernel.org>; Thu,  5 Mar 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727153; cv=pass; b=Ua8XIxAw2LQ+RxxabIFEF5XquudZSl02wGFZAWZEFGYk7p/fFTyTmpsLlJ7GRGxrskArUYfo2vrKAlRDxEIHSuaEk5QXtSzIBi4sf16PHHesN1QOkQuqXTuRJEvID8Y+yWvNejcbmaayTxswunCIYvOdXcY7aPm20Kkypt7YYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727153; c=relaxed/simple;
	bh=/MujJWqwTRzDR/unKMY3n6kEqv4LrGhHpEymwZFABX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgNmO9tmVlGzajKD9ursBgfEdUh1LjEv0HRy+CN0Ln4ulUNp9HF58ChmSHL4GJt1JcMIjttMubbSWtwdrEockSl92dQtZYdRECWeLdfh6B7mmhGBC/NRR1FWkOBg5jy6GxAWfwZawNc0APctundYCJGxZlRCF6eNTBSsE9aZEF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsLT75oN; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsLT75oN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a355aedfso599851cf.0
        for <linux-s390@vger.kernel.org>; Thu, 05 Mar 2026 08:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727149; cv=none;
        d=google.com; s=arc-20240605;
        b=e0F3PWRtRO+6bbIJto2QbmHG0i0ski0bhhZP9Cthrp9ln3jpLqCc/D1IJ2q3pajtFW
         jw2Uuizi6jD7fu0wxzcssLs7gMt81BPGFGuKFA/1mJGPx3q5N8dpjjFX+1mPjvtTBqbK
         s6WwWsTp9t/HcwNzFKlKqHlhioXNMesbzx9gd2BfbJt9lw0+M8wDjl2U8oKhMRFUHkXg
         AhV38lyMO/O/e3eujb3gvTnkt1Hl6ylolJDQHF/1K9guxBczs/WCro45SzbAamg3+PHl
         rHdpxqi/sNGkdOMCvHPYzlUyz9JxjVisdW7czv/7fEClFG8x+9OKlGkZHb24IAyiqhFQ
         +bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D9xcduMaGwL9FwPMCpELebLrVqeCBmti/yDZTZzj9fY=;
        fh=apsp7np3KPyvyh/r/zS31ChpN6omiLt44n+jJOj0RzU=;
        b=Mj8hp54bK7l2JwJjsU5binn3pDv7h/5L80kB695c8DqTROzbx8kaD/9BXKKdiWRCbx
         kEVI9dkMoqBTx8hHnwGfaf+oqvbrWz86KSOn7ME9S4trPXTBfxC3iYjyfcZhrK3g0PUN
         WmVU1xcf+u9IkT95bQKnMzshFqeIMBWx8zP5Uo7BkpnU5CDYL5F4Z1VsGJg5rvosUIVg
         Elv7rvIM2XDDI3lFXABx5MgSwmVGyGOtKjfLn9H+jng+Rr3fpHWLv2w/g3jEqlX3qmE5
         CqLA290UQ/Kfg4J0icvBcAro8LRDs3A0+S+obuCOAHotwXDagFuXpcE2EPiLBsnhXt2o
         l5jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772727149; x=1773331949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9xcduMaGwL9FwPMCpELebLrVqeCBmti/yDZTZzj9fY=;
        b=PsLT75oNu8ep6bCNb/spFMM1OYgLrOITtmbRfje7Ir/JITX7qh96CdWYqDqbwXklv/
         d4DdJVf3K310rnRQI6qeu9uKzpeqieVKXPN/MzDu0z1WT/Fk0hnBUwBGysfNADZeY/r8
         noF7mYf+jyHAkEtm3YGfSogYYlAqBVQxi54MaVHIaXiZ0FdNVefJmaOYRqZ+e7ZKo3DX
         99qApP+Xoqi35Mq4rql12RWT8+zg0ZeYUMLETvwm56mZpfXOeMDe/ANfrDYs4qdw/B/e
         DcQVrGH2Co0yglzO6ScA7NVTld6FAG2CAfaDRQHFnwHKZ2skk4gEdjTgfYuZG82OOkNy
         mm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772727149; x=1773331949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9xcduMaGwL9FwPMCpELebLrVqeCBmti/yDZTZzj9fY=;
        b=wq3DVEA/f65SjMTpW5vbzRVSVAajjC4BSnrrQnf3Eouv7WdT1ilO+L8PI5Kai+jGm4
         hcIZeidhwPRLF5edN1gA3iHfyoqwIqO7Dmu6fBMnjgfVeRFYAw7VRqlrTnEfwB5gizcu
         NFEaJEN8EdznjHhgH4I6rBqCzycgHzJtLugCPlV4RXUYNoaxu58pCnUUAdfWak6OIYvZ
         IOQ/sOKbg73kTq76p5IIp+yqW7Ef/F4a2hbViVIbi1/tcQrU8Cco5G8/FbkOp3npf1Bg
         EDM3vFA1LnrieWuEMX7EuaPfSrlUGvwxMFDmSuS8szbqPLWHWTLd3OEIXvM4MYFiTTnf
         rQuA==
X-Forwarded-Encrypted: i=1; AJvYcCUmMpuAIv2MNxxz9j/ozTArYkv+nD4nBIZiVwxN5gpVBKBGJfQ77vGdSP/Y6EzHAJafFLZ6/GbwUSoQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2HcufeoSxR4PIPUVPo75OZI3wgeec/wAQDX9XbUkCYMEYjyC
	aN+TEDRbG+twe0GD0UEoUrWAK2ZtNP6V+RKxUvF49jiQlrkSBkItdFCHw0C+bOikhWyDVHMr5Yb
	BHamL7zl0m/nKe3B+agiiP3WyuURl6FdsCv6GvGWX
X-Gm-Gg: ATEYQzyaP9k06cqoCjvEWhOHZPAJ7zCfb3fn6I6w4oNscbn9qNlRpBGTAxOs/nremUC
	eD/Ey855wv0wGCCCAw7sK1FXCqxnqkiOcoQixS10ttCVlNyGrtag47dlA1leO8D7wStZMALD9nG
	1EWWC8OuEZukwlzp3iG7grXSYgtQ8/Iopg2Ac7rCnjci09XL7fmBEpJrLdO7CLxZe2rfIAZXhSS
	H7JdKKKZ3PEw3TfWUjcmTHDjlmXCS3hT7XRpGptIwDpi1PUdkUfNSkLw0AK3hSEEUdv4QJcB00H
	8EyhcA1ypMr8iEfWbdlg4+BtRh2iTaGthKJoetgNE/PJ6IqX
X-Received: by 2002:ac8:5710:0:b0:503:2d8f:4cd9 with SMTP id
 d75a77b69052e-508e5e5db04mr11948791cf.16.1772727147711; Thu, 05 Mar 2026
 08:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-4-surenb@google.com>
 <72ff2fc0-07fe-4964-9a1e-eccf8c7ed6a7@lucifer.local> <CAJuCfpG_bekxrHd49qyUBR2K7V8o7DrOvc-ZR7M8dAC-Hyp5ng@mail.gmail.com>
 <50987b7f-39ec-479d-9700-317cb0b95e6e@lucifer.local>
In-Reply-To: <50987b7f-39ec-479d-9700-317cb0b95e6e@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Mar 2026 08:12:16 -0800
X-Gm-Features: AaiRm50LWno2c0MkglZEwe8geA6lFAl2tQxTaGHqUvTWhHATMXzeTZ4TnJgkQRQ
Message-ID: <CAJuCfpGEqjGZcMiY7RommSzO7tOrW8Zz-Web0o16zd+HX9JU3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
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

On Wed, Mar 4, 2026 at 8:58=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kernel=
.org> wrote:
>
> On Tue, Mar 03, 2026 at 03:59:17PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Mar 2, 2026 at 7:25=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Feb 25, 2026 at 11:06:09PM -0800, Suren Baghdasaryan wrote:
> > > > Replace vma_start_write() with vma_start_write_killable() when
> > > > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > > > Adjust its direct and indirect users to check for a possible error
> > > > and handle it. Ensure users handle EINTR correctly and do not ignor=
e
> > > > it.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Have raised concerns below but also this feels like you're trying to =
do a bit
> > > too much in one patch here, probably worth splitting out based on the=
 different
> > > parts you changed.
> > >
> > > > ---
> > > >  arch/s390/kvm/kvm-s390.c |  2 +-
> > > >  fs/proc/task_mmu.c       |  5 ++++-
> > > >  mm/mempolicy.c           | 14 +++++++++++---
> > > >  mm/pagewalk.c            | 20 ++++++++++++++------
> > > >  mm/vma.c                 | 22 ++++++++++++++--------
> > > >  mm/vma.h                 |  6 ++++++
> > > >  6 files changed, 50 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > > > index 7a175d86cef0..337e4f7db63a 100644
> > > > --- a/arch/s390/kvm/kvm-s390.c
> > > > +++ b/arch/s390/kvm/kvm-s390.c
> > > > @@ -2948,7 +2948,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsi=
gned int ioctl, unsigned long arg)
> > > >               }
> > > >               /* must be called without kvm->lock */
> > > >               r =3D kvm_s390_handle_pv(kvm, &args);
> > > > -             if (copy_to_user(argp, &args, sizeof(args))) {
> > > > +             if (r !=3D -EINTR && copy_to_user(argp, &args, sizeof=
(args))) {
> > >
> > > This is horribly ugly, and if we were already filtering any other ins=
tance of
> > > -EINTR (if they're even possible from copy_to_user()) why is -EINTR b=
eing
> > > treated in a special way?
> > >
> > > I honestly _hate_ this if (errcode !=3D -EINTR) { ... } pattern in ge=
neral, I'd
> > > really rather we didn't.
> > >
> > > It's going to bitrot and people are going to assume it's for some _ve=
ry good
> > > reason_ and nobody will understand why it's getting special treatment=
...
> > >
> > > Surely a fatal signal would have previously resulted in -EFAULT befor=
e which is
> > > a similar situation so most consistent would be to keep filtering no?
> >
> > Current code ignores any error coming from kvm_s390_handle_pv() and
> > proceeds with copy_to_user(), possibly overriding the former error. I
> > don't really know if this is an oversight or an intentional behavior,
> > so I wanted to minimize possible side effects. I guess I should try to
> > fix it properly (or learn why this was done this way). I'll post a
> > separate patch to error out immediately if kvm_s390_handle_pv() fails
> > and will ask s390 experts for review.
>
> Thanks!
>
> >
> > >
> > > >                       r =3D -EFAULT;
> > > >                       break;
> > > >               }
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index e091931d7ca1..1238a2988eb6 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *=
file, const char __user *buf,
> > > >               struct clear_refs_private cp =3D {
> > > >                       .type =3D type,
> > > >               };
> > > > +             int err;
> > > >
> > > >               if (mmap_write_lock_killable(mm)) {
> > > >                       count =3D -EINTR;
> > > > @@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *=
file, const char __user *buf,
> > > >                                               0, mm, 0, -1UL);
> > > >                       mmu_notifier_invalidate_range_start(&range);
> > > >               }
> > > > -             walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp)=
;
> > > > +             err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_o=
ps, &cp);
> > > > +             if (err < 0)
> > >
> > > Again with this < 0 :) let's be consistent, if (err).
> >
> > Ack.
>
> Thanks!
>
> >
> > >
> > > > +                     count =3D err;
> > > >               if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> > > >                       mmu_notifier_invalidate_range_end(&range);
> > > >                       flush_tlb_mm(mm);
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 90939f5bde02..3c8b3dfc9c56 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -988,6 +988,8 @@ queue_pages_range(struct mm_struct *mm, unsigne=
d long start, unsigned long end,
> > > >                       &queue_pages_lock_vma_walk_ops : &queue_pages=
_walk_ops;
> > >
> > > There's a comment above:
> > >
> > >  * queue_pages_range() may return:
> > >  * 0 - all pages already on the right node, or successfully queued fo=
r moving
> > >  *     (or neither strict checking nor moving requested: only range c=
hecking).
> > >  * >0 - this number of misplaced folios could not be queued for movin=
g
> > >  *      (a hugetlbfs page or a transparent huge page being counted as=
 1).
> > >  * -EIO - a misplaced page found, when MPOL_MF_STRICT specified witho=
ut MOVEs.
> > >  * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK un=
specified.
> > >  */
> > >
> > > You should add the -EINTR to it.
> >
> > Ack.
>
> Thanks!
>
> >
> > >
> > > >
> > > >       err =3D walk_page_range(mm, start, end, ops, &qp);
> > > > +     if (err =3D=3D -EINTR)
> > > > +             return err;
> > >
> > > Again, you're special casing without really any justification here. L=
et's please
> > > not special case -EINTR unless you have a _really good_ reason to.
> > >
> > > And also - if we fail to walk the page range because we couldn't get =
a VMA write
> > > lock, that's ok. The walk failed. There's nothing to unlock, because =
we didn't
> > > even get the write lock in the first place, so there's no broken stat=
e, it's as
> > > if we failed at some other point right?
> > >
> > > So I don't see why we're special casing this _at all_.
> >
> > I want to avoid possible -EINTR code override with -EFAULT in the code =
below.
> > walk_page_range() can return -EINVAL and any other error that
> > ops->pte_hole or ops->test_walk might return. We might be fine
> > treating all of them as -EFAULT but masking -EINTR seems wrong to me.
> > I don't really know a better way to deal with this but if you have a
> > good alternative I would really appreciate it.
>
> As per Matthew we needn't worry, and in any case if we want to check for =
fatal
> signal early exit we can do if (fatal_signal_pending(current)) {} I think=
?

Ok, fatal_signal_pending() seems like a better alternative. Thanks!

>
> >
> > >
> > > >
> > > >       if (!qp.first)
> > > >               /* whole range in hole */
> > > > @@ -1309,9 +1311,14 @@ static long migrate_to_node(struct mm_struct=
 *mm, int source, int dest,
> > > >                                     flags | MPOL_MF_DISCONTIG_OK, &=
pagelist);
> > > >       mmap_read_unlock(mm);
> > >
> > >
> > > >
> > > > +     if (nr_failed =3D=3D -EINTR)
> > > > +             err =3D nr_failed;
> > >
> > > Ugh please don't, that's REALLY horrible.
> > >
> > > Actually the only way you'd get a write lock happening in the walk_pa=
ge_range()
> > > is if flags & MPOL_MF_WRLOCK, menaing queue_pages_lock_vma_walk_ops a=
re used
> > > which specifies .walk_lock =3D PGWALK_WRLOCK.
> > >
> > > And this flag is only set in do_mbind(), not in migrate_to_node().
> > >
> > > So this check is actually totally unnecessary. You'll never get -EINT=
R here.
> >
> > Ah, good point. I'll drop this part.
>
> Thanks!
>
> >
> > >
> > > Maybe this code needs some refactoring though in general... yikes.
> >
> > Right.
> >
> > >
> > > > +
> > > >       if (!list_empty(&pagelist)) {
> > > > -             err =3D migrate_pages(&pagelist, alloc_migration_targ=
et, NULL,
> > > > -                     (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL=
, NULL);
> > > > +             if (!err)
> > > > +                     err =3D migrate_pages(&pagelist, alloc_migrat=
ion_target,
> > > > +                                         NULL, (unsigned long)&mtc=
,
> > > > +                                         MIGRATE_SYNC, MR_SYSCALL,=
 NULL);
> > >
> > > Given the above, this is unnecessary too.
> >
> > Ack. Will drop.
>
> Thanks!
>
> >
> > >
> > > >               if (err)
> > > >                       putback_movable_pages(&pagelist);
> > > >       }
> > > > @@ -1611,7 +1618,8 @@ static long do_mbind(unsigned long start, uns=
igned long len,
> > > >                               MR_MEMPOLICY_MBIND, NULL);
> > > >       }
> > > >
> > > > -     if (nr_failed && (flags & MPOL_MF_STRICT))
> > > > +     /* Do not mask EINTR */
> > >
> > > Useless comment... You're not explaining why, and it's obvious what y=
ou're doing.
> > >
> > > > +     if ((err !=3D -EINTR) && (nr_failed && (flags & MPOL_MF_STRIC=
T)))
> > >
> > > Weird use of parens...
> > >
> > > And again why are we treating -EINTR in a special way?
> >
> > Ah, actually I don't think I need this here. If queue_pages_range()
> > fails nr_failed gets reset to 0, so the original error won't be masked
> > as -EIO. I'll drop this part.
>
> Thanks!
>
> >
> > >
> > > >               err =3D -EIO;
> > > >       if (!list_empty(&pagelist))
> > > >               putback_movable_pages(&pagelist);
> > > > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > > > index a94c401ab2cf..dc9f7a7709c6 100644
> > > > --- a/mm/pagewalk.c
> > > > +++ b/mm/pagewalk.c
> > > > @@ -425,14 +425,13 @@ static inline void process_mm_walk_lock(struc=
t mm_struct *mm,
> > > >               mmap_assert_write_locked(mm);
> > > >  }
> > > >
> > > > -static inline void process_vma_walk_lock(struct vm_area_struct *vm=
a,
> > > > +static inline int process_vma_walk_lock(struct vm_area_struct *vma=
,
> > > >                                        enum page_walk_lock walk_loc=
k)
> > > >  {
> > > >  #ifdef CONFIG_PER_VMA_LOCK
> > > >       switch (walk_lock) {
> > > >       case PGWALK_WRLOCK:
> > > > -             vma_start_write(vma);
> > > > -             break;
> > > > +             return vma_start_write_killable(vma);
> > > >       case PGWALK_WRLOCK_VERIFY:
> > > >               vma_assert_write_locked(vma);
> > > >               break;
> > > > @@ -444,6 +443,7 @@ static inline void process_vma_walk_lock(struct=
 vm_area_struct *vma,
> > > >               break;
> > > >       }
> > > >  #endif
> > > > +     return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -487,7 +487,9 @@ int walk_page_range_mm_unsafe(struct mm_struct =
*mm, unsigned long start,
> > > >                       if (ops->pte_hole)
> > > >                               err =3D ops->pte_hole(start, next, -1=
, &walk);
> > > >               } else { /* inside vma */
> > > > -                     process_vma_walk_lock(vma, ops->walk_lock);
> > > > +                     err =3D process_vma_walk_lock(vma, ops->walk_=
lock);
> > > > +                     if (err)
> > > > +                             break;
> > > >                       walk.vma =3D vma;
> > > >                       next =3D min(end, vma->vm_end);
> > > >                       vma =3D find_vma(mm, vma->vm_end);
> > > > @@ -704,6 +706,7 @@ int walk_page_range_vma_unsafe(struct vm_area_s=
truct *vma, unsigned long start,
> > > >               .vma            =3D vma,
> > > >               .private        =3D private,
> > > >       };
> > > > +     int err;
> > > >
> > > >       if (start >=3D end || !walk.mm)
> > > >               return -EINVAL;
> > > > @@ -711,7 +714,9 @@ int walk_page_range_vma_unsafe(struct vm_area_s=
truct *vma, unsigned long start,
> > > >               return -EINVAL;
> > > >
> > > >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > > > -     process_vma_walk_lock(vma, ops->walk_lock);
> > > > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > > > +     if (err)
> > > > +             return err;
> > > >       return __walk_page_range(start, end, &walk);
> > > >  }
> > > >
> > > > @@ -734,6 +739,7 @@ int walk_page_vma(struct vm_area_struct *vma, c=
onst struct mm_walk_ops *ops,
> > > >               .vma            =3D vma,
> > > >               .private        =3D private,
> > > >       };
> > > > +     int err;
> > > >
> > > >       if (!walk.mm)
> > > >               return -EINVAL;
> > > > @@ -741,7 +747,9 @@ int walk_page_vma(struct vm_area_struct *vma, c=
onst struct mm_walk_ops *ops,
> > > >               return -EINVAL;
> > > >
> > > >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > > > -     process_vma_walk_lock(vma, ops->walk_lock);
> > > > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > > > +     if (err)
> > > > +             return err;
> > > >       return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
> > > >  }
> > > >
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index 9f2664f1d078..46bbad6e64a4 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -998,14 +998,18 @@ static __must_check struct vm_area_struct *vm=
a_merge_existing_range(
> > > >       if (anon_dup)
> > > >               unlink_anon_vmas(anon_dup);
> > > >
> > > > -     /*
> > > > -      * This means we have failed to clone anon_vma's correctly, b=
ut no
> > > > -      * actual changes to VMAs have occurred, so no harm no foul -=
 if the
> > > > -      * user doesn't want this reported and instead just wants to =
give up on
> > > > -      * the merge, allow it.
> > > > -      */
> > > > -     if (!vmg->give_up_on_oom)
> > > > -             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > > > +     if (err =3D=3D -EINTR) {
> > > > +             vmg->state =3D VMA_MERGE_ERROR_INTR;
> > >
> > > Yeah this is incorrect. You seem adament in passing through -EINTR _n=
o
> > > matter what_ :)
> >
> > You got me figured out ;)
> >
> > >
> > > There are callers that don't care at all if the merge failed, whether=
 through
> > > oom or VMA write lock not being acquired.
> >
> > Ah, I see. I was a bit puzzled by this vmg->give_up_on_oom flag. I
> > think what you are saying is that errors from
> > vma_merge_existing_range() are ignored unless this flag is set and
> > even then the only possible error is ENOMEM.
> >
> > >
> > > There's really no benefit in exiting early here I don't think, the su=
bsequent
> > > split will call vma_start_write_killable() anyway.
> >
> > But are we always calling split after the merge?
>
> We wouldn't if start =3D=3D vma->vm_start and end =3D=3D vma->vm_end but =
that'd be a nop
> anyway :) [in vma_modify(), the only caller].

I see. Ok, then this is indeed an unnecessary complexity with no
benefit. I'll drop this part.

>
> >
> > >
> > > So I think this adds a lot of complexity and mess for nothing.
> > >
> > > So can we drop all this change to the merge logic please?
> >
> > Ok but is there a good reason for this unusual error handling logic in
> > vma_merge_existing_range()?
>
> It's specifically so we can indicate _why_ the merge didn't succeed, beca=
use the
> function returns NULL. Is checked in vma_modify().
>
> Better this way than an ERR_PTR().

I think ERR_PTR() would be a more usual pattern for such cases but I
guess either way works fine.
Thanks!

>
>
> >
> > >
> > > > +     } else {
> > > > +             /*
> > > > +              * This means we have failed to clone anon_vma's corr=
ectly,
> > > > +              * but no actual changes to VMAs have occurred, so no=
 harm no
> > > > +              * foul - if the user doesn't want this reported and =
instead
> > > > +              * just wants to give up on the merge, allow it.
> > > > +              */
> > > > +             if (!vmg->give_up_on_oom)
> > > > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > > > +     }
> > > >       return NULL;
> > > >  }
> > > >
> > > > @@ -1681,6 +1685,8 @@ static struct vm_area_struct *vma_modify(stru=
ct vma_merge_struct *vmg)
> > > >       merged =3D vma_merge_existing_range(vmg);
> > > >       if (merged)
> > > >               return merged;
> > > > +     if (vmg_intr(vmg))
> > > > +             return ERR_PTR(-EINTR);
> > > >       if (vmg_nomem(vmg))
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > diff --git a/mm/vma.h b/mm/vma.h
> > > > index eba388c61ef4..fe4560f81f4f 100644
> > > > --- a/mm/vma.h
> > > > +++ b/mm/vma.h
> > > > @@ -56,6 +56,7 @@ struct vma_munmap_struct {
> > > >  enum vma_merge_state {
> > > >       VMA_MERGE_START,
> > > >       VMA_MERGE_ERROR_NOMEM,
> > > > +     VMA_MERGE_ERROR_INTR,
> > > >       VMA_MERGE_NOMERGE,
> > > >       VMA_MERGE_SUCCESS,
> > > >  };
> > > > @@ -226,6 +227,11 @@ static inline bool vmg_nomem(struct vma_merge_=
struct *vmg)
> > > >       return vmg->state =3D=3D VMA_MERGE_ERROR_NOMEM;
> > > >  }
> > > >
> > > > +static inline bool vmg_intr(struct vma_merge_struct *vmg)
> > > > +{
> > > > +     return vmg->state =3D=3D VMA_MERGE_ERROR_INTR;
> > > > +}
> > > > +
> > > >  /* Assumes addr >=3D vma->vm_start. */
> > > >  static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
> > > >                                      unsigned long addr)
> > > > --
> > > > 2.53.0.414.gf7e9f6c205-goog
> > > >
> > >
>
> Cheers, Lorenzo
