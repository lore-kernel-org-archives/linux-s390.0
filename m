Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B941C2F5
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549490; cv=pass; b=NPO07mPiJshITAYkOfcbvZ2vn1wfTXKQJhnIXVkssDpLp8+f0Ifuu0hoNQhkemYPqxXdNp0323Ar5KjF5tiIFsqmOcau8FD65drVVJYkWqiUokt980HriEVWlF0vGgA/ymkfH+KgRIbNFvSUq58wxDQq73Kum2bxeeqK8Xf1jFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549490; c=relaxed/simple;
	bh=vV0FfkMOXsfsipj7YfWLpHAGdujKQ79g0MHFT4jDWso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cza76WZbF7us4hA9Rr4AnDuizFsXtbmx2ydazPd1KyTUSYSkbm04K6QgSmpe9lo8dwaLmXF/gDWBVTb1YeOEtyPDTZlKfZyXTwYb68hS4xBOaQBDkZqqbxqcueih9GBjJlZ15W4ql5LWPe2wmEGKJn+LAnrckkBDGjnmmEMvy9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivx61MaE; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivx61MaE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b6c45781aso88281cf.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 11:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549487; cv=none;
        d=google.com; s=arc-20240605;
        b=ZDK3GHcCcoc8cq+G/WZ3l1K9ePURAfcb0086RYSuOI3SEKMHslm/CMQP37DmAt5CS/
         cd+aP9xmOjPARKfefcmQmVOcLXuWDnrGJVK97IHH8hOKpvJVxHqVDgKpzgakLC+42XX6
         hSOQU839ht6ONTJteBNs5cwpW+UAf6ubGbwlA7pBIEmDYyBkZK4Ef/Skf3YGn2aCiSHK
         L1Rbd1wiBab3Hw2MltrRRZzqh74WQr9dQSPMhw2KQz8GF29KcleXLGQrXNSIm6zODER1
         p9u7F759UDxcf5PE1ERlSOO0JU8XVdVyQRT3nVAgaxOou/B5ZgL+OstmJ3z3dffjhsGj
         4l0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        fh=tRKbOIUPvfsHjh/pgy8cNhyAIOKSefF90fJHXJowxGA=;
        b=RCNmZhjOaMOfxptiZZog6ihFuq7yTk2ISVgPvMzTT23HehkwPR+rjhh8o8pUzhLJsU
         NgYOnsTwX064VqTzkek+fTKI0jckB01SOIpQFlI9Yj6FN8vTTVOYAnJ1XkPmGA5fW7GF
         iIfBDkwykbg5a14fTrk9OM0nXvNdHjM+JBc5FqAnlLaOLWtuf1LB9s6vSYb7pX1EVr8C
         Rwq3S/YiB/lh2sWkj4Q5CioZj8NiJJs8lBAtpRYkm2GnIqbe1qvCVDgOmm0scSKwY3n6
         Ai9O+AUYcjUo22GH9Am9HRWfpz9ODayEyWKDV8ClL6jnpRWZ/gPvmN2RAuUjJN5LOsqX
         gfWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774549487; x=1775154287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=ivx61MaEp/zQSux3x9+QX1b20Umy0hUiUf9oBIKs6blgAjjNfS9Za2ym9fx8hoS5Ae
         KeSdZEESFQBlIt8r1Rr8gy/L0qE2HX85PT0stEf5aU3wHylzbZxmERJoozV3u8uAXo6X
         +zGsup3KrpP90Q0Ml2ooSVmTpxx+ZlpwNOHSZAy9dzHWMiFzPceOg3xPvL3TsnxTYXGn
         GN7S/SIrKq428BIafT62c5HPqPIcHiOq8jCEbonkmgBtkpSs9yLBKCHMWO3Elq6UBOyy
         1GQFEvnUeVBDyWWTFc2MoseBFMEd8NSklddYv29BWZy59sJNLa0FGsATNEeeCAuQ7BBO
         1CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549487; x=1775154287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=gakaXuWB6rY6d0rOUlYohurMu0XuXlQh1Xhz0e+JAN1GrWmLr2+9UXSVd6j81dkPf1
         s4h3SuA4jCaGdIlfv/YC7+e2HRsH3n8svR2WXbAgXUZbFiJesdQtpRJQVy7I1hJoP8L4
         a9nHuXOHs05ZbuK/u5lnJogBWTJDKjB5r7R7XxwGqeLacGSnrXa8xMRCBhmrtGkk/F77
         ya8QLmIytK8J8exlYDiXHJ8aBKdNwXYQVPg2nmd0kkou5n+ug563kOJTBjmQatuR61MZ
         H6t0F4TtuMQ6FoVuqLDmkESDpohjz7w9BSLVgihJdyKt/DdYsqdtPk7rM7ouNG2qXeeD
         eoHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKi62yYoTTLykUleodpEe8XiT4zIOOJ0iQBStY9qoKdO6gFk/jsL7f5ayY6D+NXhnFdsM5vpZpFq7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqtGp/nRRSNM14C4ul6l+HQhdPu61UrftHNbF/n6oWzHQMXJK
	gmEPJ0ZBDEjxvKJ27UHGebnSB4VdZe0aOTAF1vHszpX+PmuBAfhay+dKjBouJUHAzu4uQQvOVHx
	OyKozkQ1365e80+Qhru/rNbtAO58HlQTi87Al/XOX
X-Gm-Gg: ATEYQzxd6mnac9ds1LI8d8jDhynpgvxjTf8uK2PUQ6IYulT1CV8kdm8Npl2uo2zRkG1
	5ai9jdy2JAbR9dRxi5yyjjSfsOIinXK5PSU3lV/beB8CbpfWx20rdw4Y7IJuOikcPB3loTJQ22q
	h+H1q50Zng9p+zKEkLaExEmoHXaDUJIAWaMlK93SX6m+prGFjFGCYmIiZjobsF/GTmcCSLorepr
	8BxdaAz7gbZrNio+vTd58Gg47BcMDl85WGKIe4MVeDJiP9YAbU41ylLBQ/9hO4+WfpUwaxb2JfE
	82N5FTMPhJY141jBDZtBggK1Wp9BYaTL7g==
X-Received: by 2002:a05:622a:93:b0:50b:71e4:878c with SMTP id
 d75a77b69052e-50ba1e41c39mr1037271cf.15.1774549486349; Thu, 26 Mar 2026
 11:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
In-Reply-To: <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Mar 2026 11:24:35 -0700
X-Gm-Features: AQROBzDeN__PRe-Y7mIO9LZxPL3s1KNrdWWWOsbo7He0DKFlde5Dab9lnrvUpiU
Message-ID: <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
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

On Thu, Mar 26, 2026 at 2:18=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> -cc old email
>
> (Gentle reminder to please send all new stuff to ljs@kernel.org - at some
> point I'm going to set a rule to ignore kernel mail sent to the old addre=
ss
> so, if you need a response you should send to the new :)

Ack, sorry about that and thanks for all the reviews, Lorenzo!

I noticed Sashiko's concerns at [1] and a number of them are false
positives but I see at least one new claim which might be legit. I'll
check if it holds water.

[1] https://sashiko.dev/#/patchset/20260326080836.695207-1-surenb%40google.=
com

>
>
> On Thu, Mar 26, 2026 at 01:08:30AM -0700, Suren Baghdasaryan wrote:
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patchset:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> > and operates on a remote mm. Incomplete operations here would result
> > in an inconsistent cgroup state.
> >
> > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
> >
> > Changes since v4 [1]:
> > - added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the c=
ode
> > stayed the same)
> > - split patch 2 into 3 parts, per Lorenzo Stoakes
> > - converted vma_start_write() in mseal_apply(), per Sashiko
> > - changed vma_start_write_killable() error handling in
> > set_mempolicy_home_node(), per Lorenzo Stoakes
> > - added comment why mm->locked_vm is fine even when we exit early,
> > per Sashiko
> > - moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
> > and Lorenzo Stoakes
> > - set give_up_on_oom on error in vma_merge_existing_range() to propagat=
e
> > the error, per Lorenzo Stoakes
> > - moved validate_mm() out of the error path in expand_upwards(),
> > per Lorenzo Stoakes
> > - dropped the patch changing S390 error handling, per Sashiko and
> > Lorenzo Stoakes
> > - reworked error handling in clear_refs_write(), per Lorenzo Stoakes
> > - uninlined process_vma_walk_lock() while changing its return type,
> > per Lorenzo Stoakes
> >
> > [1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.c=
om/
> >
> > Suren Baghdasaryan (6):
> >   mm/vma: cleanup error handling path in vma_expand()
> >   mm: use vma_start_write_killable() in mm syscalls
> >   mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
> >   mm/vma: use vma_start_write_killable() in vma operations
> >   mm: use vma_start_write_killable() in process_vma_walk_lock()
> >   KVM: PPC: use vma_start_write_killable() in
> >     kvmppc_memslot_page_merge()
> >
> >  arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
> >  fs/proc/task_mmu.c                 |  12 +--
> >  mm/khugepaged.c                    |   5 +-
> >  mm/madvise.c                       |   4 +-
> >  mm/memory.c                        |   2 +
> >  mm/mempolicy.c                     |  12 ++-
> >  mm/mlock.c                         |  28 ++++--
> >  mm/mprotect.c                      |   5 +-
> >  mm/mremap.c                        |   8 +-
> >  mm/mseal.c                         |   5 +-
> >  mm/pagewalk.c                      |  22 +++--
> >  mm/vma.c                           | 146 +++++++++++++++++++++--------
> >  mm/vma_exec.c                      |   6 +-
> >  13 files changed, 190 insertions(+), 70 deletions(-)
> >
> >
> > base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
