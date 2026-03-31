Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136D3F7887
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971818; cv=pass; b=BAGs6+4o4nA73Y/Yo6ZIBj4BbSKSibmTWWckt//ztJoO4mtDDSYwgvTq09u1tlT7jzyA32jQeU0aJClTlZzgkDza0XxOltnJOtvKQDTaSuD7WTkhmGzY/i9n1ZSnldu/S5aa/vfqeyDMlFaGzVT3PGfkzwyel1NjU9vWFLjLOls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971818; c=relaxed/simple;
	bh=qumz7KmMbdjWBI+aOeVYNz5F+dGZKidofPWkJEYuw3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcXyV2kxBso5Gyx0RR3wytdLqJqV7LRSFuq6sidH1etmdHEVIldbZO1tcIG3cBCEi5nKVbB1lehB39yVR2ZUtUmV0vvNkGrs/U/yw5+K9MkWFuMtIYzu53e2T8hsa9jhU76H/VlLVrW/hFH28kg1c4rnG+5o5cTLUWOfskc25eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsGGfsuG; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsGGfsuG"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so14229a12.0
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 08:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971816; cv=none;
        d=google.com; s=arc-20240605;
        b=WqsB+RcZ0PLAFyTl0WoVCd0NcLbgv6AmeEfI3iABxzbVSssYPDlYGEeD8QA9GWzuo8
         Ik8Xsd6x/hrj7bNclusIAMv/btY2ZeyC3Y0VHQfN754sdXZsvqYa3C/CUv82PpFPHxFC
         UiSjxKjfbwPECshuvP5a3GUsC34rdsFMldFlGTwZUw8b8H89KBUmlaF1fEgPpcz0vsDW
         od3OPfni8/fNmfUo79t1ME4x454Vm5JX5CDLULQF47ojxcPWKaHDTL7eMUeaBPPamKQK
         Hj6veqR9t9FHgcbA320OcFw6TXoMb01gTJw95MPpdx6KGwU5TtvvUoQn7dP7nQYtrrJB
         X/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        fh=5Nltm/KBVrGKHtQynDJVFOaB1hEhW3JAVglrL/9MtII=;
        b=j/JFtVHu/Lxg8dRVxULyxs4YyUzeWLc9dcNEXXb3ov98/Z3m8MnvOv+I2LW4sQVVA4
         D2RPzXXhcl/fUdD4E5S07rZ9dYoc3t5Ka5IioPtpZDK9KDPOj/yYemitWyEnxfhvnt5q
         NwlAtiBBAZJ21po6M+rtREGIi2jA23zVYKCyVFiOFtzuqzzBR0Z8+toLJzg3viCuJAI+
         0LyIV5fjujYlDvHBTdnAoNj1/P1rcsMhtJiercBL+YcPcJ6Hhe9bHwNmKdurJogC0QFZ
         GHU/OBqdO+hLa9C9r8vPzSzle/XL0iW+k1Hse1csgtS8UGKvpdVF3gShVe3ahrtpjR6W
         l9vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971816; x=1775576616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        b=vsGGfsuGQZDdk0qRyuGFHBmZRz7eLEte9WcaLH8F6ZPh1aee89LvB8FESARQpptzz5
         mbZT94QpbZewcYoef/MlOh7X/9efLJJvj89s1VyqUUAkah+vQTGGZX6skdxEHmOVthN/
         lcL8h6UuQT5dPeKohWiXI4cMfeAXpeCn+sWCwudny026GpCYOHyD6rUL81bt3BY/RjlJ
         5y6v+N7rLWUETu+igITZ2uyUkSnEkMr9EH6UBvFt/ZcS6iWMmkmj798+mnUA+wDtI13M
         5GDIaMcypnAE2BHuf1nBbyvb4aZh2ZHMiImYmrj6NEavLOorxvz1iYII4wLjNedFsysc
         CJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971816; x=1775576616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        b=XXp8KCmOSfcHEvuzHfqHr9zSLScgPLO5Wb3Pv+7HYI4vzRU6XS2qeAvXxcHkha9qPF
         +GNUbhYSYFyYP7pa8dTdcYgrQrLTV+B1BKs3KVuFPcIcW9PhgZyqYR7W3syqoe3f20QZ
         NO5invuk+xO6ldMWGH5msndFeUORuR8rn3ZuLQ4XFma9RQiflM9wq5LYXxCzlqaOjXhB
         Q/RyR0MPq6a+ttnMvHGa3ZAeL5jy8JlbMu/J+utqutwxQd4lQ2Ay08rN3ArYJJKVYIli
         31odkjyt6lcfYZQkMkodloLWG5eK+43s1WFHPbCwoeSW0tTkO++c84rdYfwq/yBstYP9
         CzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgI5UqZdW2eRm6tDfQlAtbNYqQVglKpvnH1t7uXHVkavoWnQEcK4DmQ0jHQ5OhX/FgEMg19iDKwAn@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDZlmFglAO+vee69d2eu5jKKMhwk92c/05ZNibK3bB+xMOfeo
	KT6rtu2aKESBGaQzGtlIrVySRQ8PkGTp5wgLQyiQy15FdSkmOvInCTwHqCXX1VbcYm6sfsCHsj0
	rKfQxfzPhZiqpgwrK+RZX8tBYfX1yRspNSH86H9EF
X-Gm-Gg: ATEYQzyhI2/U1JhzTRqL3s7UkdzAk+otCIbMOmxTLfNrvuq+Z9gkN8PzDR9G1vDImEm
	1tfrPkIdwbVmxSTOH1nJ2reXB8piiHGGwGFA5JzMPdcAvNAwMjckHGyeIBKk2TFcXqM/1WYKxJR
	Y0lXN0XoMvIEJTE8TBV9BRHESjZHq6KZriqGR8gx7F7tca4MOeI/rnWsJp3Ft5XFAKCIqK0T6ud
	pIjzWUMkOC9uRnFVjTf02Tq8JDnd+xUar7zP+RaEZlCpmCufhPS4PrLFnaVVsbJaH50XkU+THPc
	OsMJPVDnND9OdWFVD8XRZ0J/1oXZ99xN/z/hgA==
X-Received: by 2002:aa7:d889:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-66d95ac7d37mr3182a12.3.1774971815079; Tue, 31 Mar 2026 08:43:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-6-surenb@google.com>
 <4e1c47a9-77a2-4f29-8de5-37f9958f5885@lucifer.local>
In-Reply-To: <4e1c47a9-77a2-4f29-8de5-37f9958f5885@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:43:21 -0700
X-Gm-Features: AQROBzCrulzM_NYGi8iXSi5txAuufuUANImipjPaeV3dLXg1MucZzatFvm8IhI4
Message-ID: <CAJuCfpGpq+AiSNDEENAWQZvnDmvegu48o0C_SAixDPOWDEBUjw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] mm: use vma_start_write_killable() in process_vma_walk_lock()
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

On Tue, Mar 31, 2026 at 3:39=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 01:54:56PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it. Ensure users handle EINTR correctly and do not ignore
> > it. When queue_pages_range() fails, check whether it failed due to
> > a fatal signal or some other reason and return appropriate error.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 12 ++++++------
> >  mm/mempolicy.c     | 10 +++++++++-
> >  mm/pagewalk.c      | 22 +++++++++++++++-------
> >  3 files changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e091931d7ca1..33e5094a7842 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1774,15 +1774,15 @@ static ssize_t clear_refs_write(struct file *fi=
le, const char __user *buf,
> >       struct vm_area_struct *vma;
> >       enum clear_refs_types type;
> >       int itype;
> > -     int rv;
> > +     int err;
> >
> >       if (count > sizeof(buffer) - 1)
> >               count =3D sizeof(buffer) - 1;
> >       if (copy_from_user(buffer, buf, count))
> >               return -EFAULT;
> > -     rv =3D kstrtoint(strstrip(buffer), 10, &itype);
> > -     if (rv < 0)
> > -             return rv;
> > +     err =3D kstrtoint(strstrip(buffer), 10, &itype);
> > +     if (err)
> > +             return err;
> >       type =3D (enum clear_refs_types)itype;
> >       if (type < CLEAR_REFS_ALL || type >=3D CLEAR_REFS_LAST)
> >               return -EINVAL;
> > @@ -1824,7 +1824,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >                                               0, mm, 0, -1UL);
> >                       mmu_notifier_invalidate_range_start(&range);
> >               }
> > -             walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> > +             err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
> >               if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> >                       mmu_notifier_invalidate_range_end(&range);
> >                       flush_tlb_mm(mm);
> > @@ -1837,7 +1837,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >       }
> >       put_task_struct(task);
> >
> > -     return count;
> > +     return err ? : count;
> >  }
> >
> >  const struct file_operations proc_clear_refs_operations =3D {
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index c38a90487531..51f298cfc33b 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vm=
a_walk_ops =3D {
> >   *      (a hugetlbfs page or a transparent huge page being counted as =
1).
> >   * -EIO - a misplaced page found, when MPOL_MF_STRICT specified withou=
t MOVEs.
> >   * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK uns=
pecified.
> > + * -EINTR - walk got terminated due to pending fatal signal.
> >   */
> >  static long
> >  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned =
long end,
> > @@ -1545,7 +1546,14 @@ static long do_mbind(unsigned long start, unsign=
ed long len,
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
>
> Is that really a big deal? Does it really matter if the caller doesn't ge=
t
> -EINTR in this case? This feels like another sashiko nitpick and is addin=
g a
> bunch of additional complexity here.

I think there is a difference in that the userspace caller will never
see EINTR, as Matthew explained in an earlier version, while EFAULT
will be seen and can be handled. I don't see why we wouldn't want to
report the correct error, and the code doing that seems clear and
straight-forward to me. That was in fact your suggested solution for
not checking for EINTR :)

>
> I mean if you 'filter' error messages you might always end up with an err=
or
> that's different than the original...
>
> >               nr_failed =3D 0;
> >       } else {
> >               vma_iter_init(&vmi, mm, start);
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 3ae2586ff45b..eca7bc711617 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -443,14 +443,13 @@ static inline void process_mm_walk_lock(struct mm=
_struct *mm,
> >               mmap_assert_write_locked(mm);
> >  }
> >
> > -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> > -                                      enum page_walk_lock walk_lock)
> > +static int process_vma_walk_lock(struct vm_area_struct *vma,
> > +                              enum page_walk_lock walk_lock)
> >  {
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       switch (walk_lock) {
> >       case PGWALK_WRLOCK:
> > -             vma_start_write(vma);
> > -             break;
> > +             return vma_start_write_killable(vma);
> >       case PGWALK_WRLOCK_VERIFY:
> >               vma_assert_write_locked(vma);
> >               break;
> > @@ -462,6 +461,7 @@ static inline void process_vma_walk_lock(struct vm_=
area_struct *vma,
> >               break;
> >       }
> >  #endif
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -505,7 +505,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm,=
 unsigned long start,
> >                       if (ops->pte_hole)
> >                               err =3D ops->pte_hole(start, next, -1, &w=
alk);
> >               } else { /* inside vma */
> > -                     process_vma_walk_lock(vma, ops->walk_lock);
> > +                     err =3D process_vma_walk_lock(vma, ops->walk_lock=
);
> > +                     if (err)
> > +                             break;
> >                       walk.vma =3D vma;
> >                       next =3D min(end, vma->vm_end);
> >                       vma =3D find_vma(mm, vma->vm_end);
> > @@ -722,6 +724,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (start >=3D end || !walk.mm)
> >               return -EINVAL;
> > @@ -729,7 +732,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
> >       return __walk_page_range(start, end, &walk);
> >  }
> >
> > @@ -752,6 +757,7 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (!walk.mm)
> >               return -EINVAL;
> > @@ -759,7 +765,9 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
> >       return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
> >  }
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
