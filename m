Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00154346AC5
	for <linux-s390@vger.kernel.org>; Sun, 17 May 2026 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007528; cv=none; b=sB/3Tt5SxjUNbfUn9x+VGaHMyZhOR6rZgFsFnEEs0DTaOTaEO0qJLCZfea6WVvUZ/S82I5KZkY8l7wxmg0PBxkgOg2O7dyBkHvox4SGnFIz0/RetPsUIouPtuc9Is9DDXcdHEHP4dZTOw2LqrLnebxkAaZtz+3PBygu1gSMmii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007528; c=relaxed/simple;
	bh=p/9AJiwpH9htKz1qH1Sl1BuAo/sVquMqqj2hIHE2j60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWOn0COsKH2fDi3Qj63IzQfE6JN6pbuzd0WbAM0S1NUmNe7c367Oy7Trl7J9/MIBtGzUe4UafMb2EK696+yFaeNMlI8fz2z6fQMm8HHtGSFp54MxVpdZYw2jC9pryiUUnNAzsf6u/yLdE1dj7lEHxFlqJKFKqiQBSSJlC9gUtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcZT9tUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcZT9tUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BAAC2BCB0
	for <linux-s390@vger.kernel.org>; Sun, 17 May 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007527;
	bh=p/9AJiwpH9htKz1qH1Sl1BuAo/sVquMqqj2hIHE2j60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IcZT9tUolcrkwWW0g0RY9HTDkbfvMUWKMC+4fxz9cOlxN5nLUbfxb37rlEv77K6Yz
	 91/W8a+pD9VIXpnwYL9jbGNNe64gmPI7/gmARH/LrsqxjAESIXXbB0hoqlAI/eOVyA
	 71yxBQAqlF7qQVourMYDTKkIlJOEhH+OOJG8NyQvxKt+Jkv+ZeuvJZZuT8Uv72hHKe
	 5Uy2D1EisdI1IXy6U24mBXVmBUDot+lzpFzHE4Dt6atMPLsp/jew4RZqdckHNc2wLr
	 FmqGPcBeg679dY+2flLU2OkyQdSmrf0RqKFym7/EfEyCQaoVLB61fYxtlxJ1BqzoTE
	 TcjhzGKbClSVA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso14183176d6.2
        for <linux-s390@vger.kernel.org>; Sun, 17 May 2026 01:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8qpXGZFYWiKiJzcag/6J6NqNByWhaXQ9nZszs7jbPAz4ICS/yk0w4dG15TmhiSMsspF/aJ0RXRFC7M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EWn3vuYe3Ip+6yE7xSKr9UcHSH9qJGUNKBHDcmAFYbHqZw0n
	fw+YxHPel9aQHC2V3iaVQleLvRoGu/y2VovjwLowt+uefhHMr5WFR5ZdDOSGhbUQ7cIgoH3KWe7
	61loD/O0HE0EJY4MO+8BlHQ1TdOeLJXk=
X-Received: by 2002:a05:6214:1c82:b0:8be:7ed5:477b with SMTP id
 6a1803df08f44-8ca0f6b95a0mr188510036d6.22.1779007526681; Sun, 17 May 2026
 01:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
In-Reply-To: <afTpoL3FklpQZNMM@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sun, 17 May 2026 16:45:15 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
X-Gm-Features: AVHnY4ICHad0vRrEOEwJ7DjNSE1jL9epFkBx0OBK2sLJbi9Nv2hHU65J8Z0HpVM
Message-ID: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>, surenb@google.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, 
	chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > 1. There is no deterministic latency for I/O completion. It depends=
 on
> > > > both the hardware and the software stack (bio/request queues and th=
e
> > > > block scheduler). Sometimes the latency is short; at other times it=
 can
> > > > be quite long. In such cases, a high-priority thread performing ope=
rations
> > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to=
 wait
> > > > for an unpredictable amount of time.
> > >
> > > But does that actually happen?  I find it hard to believe that thread=
 A
> > > unmaps a VMA while thread B is in the middle of taking a page fault i=
n
> > > that same VMA.  mprotect() and madvise() are more likely to happen, b=
ut
> > > it still seems really unlikely to me.
> >
> > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > the entire VMA=E2=80=94just a portion of it is sufficient.
>
> Yes, but that still fails to answer "does this actually happen".  How muc=
h
> performance is all this complexity in the page fault handler buying us?
> If you don't answer this question, I'm just going to go in and rip it
> all out.
>

Hi Matthew (and Lorenzo, Jan, and anyone else who may be
waiting for answers),

As promised during LSF/MM/BPF, we conducted thorough
testing on Android phones to determine whether performing
I/O in `filemap_fault()` can block `vma_start_write()`.
I wanted to give a quick update on this question.

Nanzhe at Xiaomi created tracing scripts and ran various
applications on Android devices with I/O performed under
the VMA lock in `filemap_fault()`. We found that:

1. There are very few cases where unmap() is blocked by
   page faults. I assume this is due to buggy user code
   or poor synchronization between reads and unmap().
So I assume it is not a problem.

2. We observed many cases where `vma_start_write()`
   is blocked by page-fault I/O in some applications.
   The blocking occurs in the `dup_mmap()` path during
   fork().

With Suren's commit fb49c455323ff ("fork: lock VMAs of
the parent process when forking"), we now always hold
`vma_write_lock()` for each VMA. Note that the
`mmap_lock` write lock is also held, which could lead to
chained waiting if page-fault I/O is performed without
releasing the VMA lock.

My gut feeling is that Suren's commit may be overshooting,
so my rough idea is that we might want to do something like
the following (we haven't tested it yet and it might be
wrong):

diff --git a/mm/mmap.c b/mm/mmap.c
index 2311ae7c2ff4..5ddaf297f31a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
*mm, struct mm_struct *oldmm)
        for_each_vma(vmi, mpnt) {
                struct file *file;

-               retval =3D vma_start_write_killable(mpnt);
+               /*
+                * For anonymous or writable private VMAs, prevent
+                * concurrent CoW faults.
+                */
+               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
+                                       (mpnt->vm_flags & VM_WRITE)))
+                       retval =3D vma_start_write_killable(mpnt);
                if (retval < 0)
                        goto loop_out;
                if (mpnt->vm_flags & VM_DONTCOPY) {

Based on the above, we may want to re-check whether fork()
can be blocked by page faults. At the same time, if Suren,
you, or anyone else has any comments, please feel free to
share them.

Best Regards
Barry
