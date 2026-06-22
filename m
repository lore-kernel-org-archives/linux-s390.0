Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797D2E0413
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164131; cv=none; b=X2dhGJyak96b096r4nJFBlQhfPhUnPmcsRIZfgr89f3qDPatXSpl41VaEzB9nWc2SXe9u9YwzuZkd9JFM6MnAHoNjHt5kFsaYDb6fAEmfSaECffnw7AqVMgczIOEXme+fQ1Gsq2LBStp4aj6ERgQEPX7cgohVLQX9oisd45SskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164131; c=relaxed/simple;
	bh=lPlVQd+zWUVCvDQi7lzd9fLfWohYirAJ8Y5S3U+A7I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAjm8gWDF2yO7uobiW3Kj7OaSU8iwnZFJYT3sXOXT+GzTixQ05JJBYeAH19w50Jz77ejitkDgH/vYw8LT5qVkGMAmBZypMCQAI9XCDP1m5oNloWbGETSLpQDKIS9KRKOJGnG0B/ef4miZl/dj701iW88y1K/PzVUJMfkV2K6qRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Q/FkIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Q/FkIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC61D1F01568
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782164130;
	bh=HgImYFkLyD1hj/g9jIukArDdySmWi+kCTAd6Z7Own3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B8Q/FkIJW/bpBmMrnkXnSB5ne6L14AB91B+3DyNyXiBmOl++avYtDn60cjEw5xGB7
	 igIRuHKZr2pyv4uYU826lz0ybxYVUD7AfHHF5h9gncjBQwS3TxJZbk4OK7lmpazgur
	 P9E/iIbBjkQn4u4uQPtSsu9O/JO08x0PVWvb7w8nrBEgBJjYLfiSDz/LkN4Lsa0yyv
	 vaPotymhXR+gL14g0d5w+sXG1Uap7KvN46zlIwU204GmOTdZ4LH64O88QzX5lqQwNT
	 Sgm/JxiojQjRiP+LOl/SlYaNloX79g8MJ+yhgcAiEVBrhyr8nO11is6H/usoty6fDa
	 xIAxGO6170eJQ==
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6c6507549c3so212526137.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8odC5lINZGpLWgeyac6P4V+Zk4dgFrykhS3NR0YoyzJlpPWLRDTp4eNmxhNsN/IrepBPKbnWx9oWcE@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxNQo4nQm20Z7tmRs0g2ntRuJtDBi/Tssg1gCsnRhTptKs9y4
	wbTWBnEfHB5F6Py2lmN37RxGbw/S7A61nfXOQB2BoOxxu7zVgCv52QZBpwW7e4kz27MqQgArKFe
	sLozLMYMVMrBhHIc4kcJSdE92UGk0yRo=
X-Received: by 2002:a05:6102:3254:10b0:6cc:e6b1:7f84 with SMTP id
 ada2fe7eead31-72f85be19c5mr499665137.17.1782164129165; Mon, 22 Jun 2026
 14:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer> <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
 <ajhOUdbWsswgQyl2@casper.infradead.org> <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
 <c5soxcu245cerfljr2ddto4h7xqksfxzxti47mq6sqn6pnmnxh@th5kxapvnaj3>
In-Reply-To: <c5soxcu245cerfljr2ddto4h7xqksfxzxti47mq6sqn6pnmnxh@th5kxapvnaj3>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 05:35:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xeRmi_EtcLUpZm49zNO3pxscd1shDcO-wbBAZheyN9jQ@mail.gmail.com>
X-Gm-Features: AVVi8CfVr0XrKkWqf7CvIbBvspzJJaewjz-ymsw_zXuVPurYIavkpzh5F1y4IKg
Message-ID: <CAGsJ_4xeRmi_EtcLUpZm49zNO3pxscd1shDcO-wbBAZheyN9jQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>, Hongru Zhang <zhanghongru06@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:50=E2=80=AFPM Liam R. Howlett <liam@infradead.or=
g> wrote:
>
> On 26/06/22 08:15AM, Barry Song wrote:
> > On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> > > > Just checking in on the followup plans. IIUC the RFC mentioned will
> > > > try to implement the solution we discussed at LSFMM: splitting
> > > > VM_FAULT_RETRY into two flags - one for retrying under per-VMA lock=
s
> > > > and another one to fallback to mmap_lock.
> > >
> > > I continue to hate this idea.  I don't believe that those who were
> > > pushing for it have ever tried to understand the whole fault path.
> > > It's utterly byzantine.
> > >
> > > I defy anyone to make sense of this:
> > >
> > >         /*
> > >          * NOTE! This will make us return with VM_FAULT_RETRY, but wi=
th
> > >          * the fault lock still held. That's how FAULT_FLAG_RETRY_NOW=
AIT
> > >          * is supposed to work. We have way too many special cases..
> > >          */
> > >         if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> > >                 return 0;
> > >
> > >         *fpin =3D maybe_unlock_mmap_for_io(vmf, *fpin);
> > >         if (vmf->flags & FAULT_FLAG_KILLABLE) {
> > >                 if (__folio_lock_killable(folio)) {
> > >                         /*
> > >                          * We didn't have the right flags to drop the
> > >                          * fault lock, but all fault_handlers only ch=
eck
> > >                          * for fatal signals if we return VM_FAULT_RE=
TRY,
> > >                          * so we need to drop the fault lock here and
> > >                          * return 0 if we don't have a fpin.
> > >                          */
> > >                         if (*fpin =3D=3D NULL)
> > >                                 release_fault_lock(vmf);
> > >                         return 0;
> > >                 }
> > >
> > > Wed need to simplify the fault path, not add additional complexity.
> > > Josef has said he wouldn't've done the lock dropping had we had per-V=
MA
> > > locks.  We should rip it out.
> >
> > I think you have agreed that, at least for anon vma, we can
> > keep the current policy, since anon vma is much more volatile
> > than file vma.
>
> I don't think any of the above has to do with anon vmas.  Does any anon
> vma handling have anything to do with your problem?

Hi Liam,

I think there may be a misunderstanding about the motivation behind
this series.

Currently, for both file-backed and anonymous VMAs, when a page fault
cannot lock the required folios=E2=80=94for example, because a folio is und=
er
I/O during a major fault=E2=80=94the fault handler drops any locks it is
holding (either per-VMA locks or the mmap lock) and retries the fault
under the mmap_lock. This page-fault retry pattern requiring the
mmap_lock can lead to significant mmap_lock contention.

The entire purpose of this series is to avoid reacquiring the mmap_lock
where possible, while ensuring that the implementation does not
introduce new priority inversion issues or unnecessary complexity.

We have two possible approaches:

1. Keep the page-fault retry path, but retry under the per-VMA lock
whenever possible. In this case, we would need a flag to indicate
whether the retry should be performed under the per-VMA lock or the
mmap_lock.

2. Remove the page-fault retry path entirely. Instead, wait for the
folio to become lockable while retaining the locks currently held,
and continue the fault handling without retrying the page fault.

Approach 1 is the direction taken by both the current patch and the
RFC that was suggested.

Approach 2 is a potential alternative, but I have never posted an RFC
proposing it.

For Approach 1, the primary concern seems to be the added complexity.

For Approach 2, my concern is the increased risk of priority
inversion. With this approach, we may end up holding a lock while
waiting for I/O completion, potentially for a considerable amount of
time. As a result, a concurrent VMA writer, along with any subsequent
mmap_lock acquirers blocked behind it, could be stalled for an
extended period.

If there is an approach 3, it could be:
for file VMAs, we take approach 2; for anonymous VMAs, we take
approach 1.

>
> This would be needed if anon vmas were being faulted while being
> unmapped or merged?  Do we really need a fast path for that?  Note that
> anon vmas cannot be merged if the vma chain... you know what, I wonder
> how many people know what I'm talking about here... Let's just say that
> they can't be merged if they were around for a fork.

In terms of fork(), this is the concern I raised when considering
approach 2=E2=80=94holding the VMA lock while performing I/O, since a
concurrent fork would need to acquire the VMA write lock.

I had Hongru add some tracing code and run it against the top 200
Android applications in the China market. All of them are heavily
multi-threaded. Unfortunately, we found that 82 of these 200 Android
applications call fork(), and some even call fork() from multiple
threads.

So, although it may be technically a bad idea to call fork() in a
multi-threaded application, it appears that in practice it is still
widely used in real-world applications.

I guess Hongru (Cc-ed) will share his observations later today or
tomorrow.

>
> So, then, we're looking at anon vmas taking the mmap lock on:
> 1. single task anon vmas being expanded and faulted at the same time
> 2. single task anon vmas being unmapped and faulted at the same time
>
> I think that's it?

Yes and no. It could also include mprotect, UFFDIO_REGISTER,
UFFDIO_UNREGISTER, and setting VMA names, etc.

Note that Java GC may also invoke UFFDIO_REGISTER and
UFFDIO_UNREGISTER on Java heaps.

Note that priority inversion can still occur between threads that are
not operating on the same VMA if we take approach 2.

For example:

Thread A: page fault in vma1, holding the VMA lock and waiting for I/O.

Thread B: concurrent write on vma1 (takes mmap_lock and then waits for
the VMA write lock);

Thread C: concurrent write on vma2 or do VMA iteration (acquires
mmap_lock).

In this scenario, Thread C may end up indirectly waiting for Thread A.

>
> But maybe I missed something critical about your use case here?
>
> I don't understand why you are involving anon vmas in this discussion,
> so I must have missed something with your IO completion issue.  Is there
> an anon vma causing your priority inversion?

As explained, the primary goal is to reduce mmap_lock contention by
avoiding taking the mmap_lock whenever possible, while ensuring that
the implementation does not introduce new priority inversion issues.

>
> > Concurrent page faults and VMA modifications can happen more
> > often than with file VMAs.
>
> But it's only a problem for anon vmas with per-vma locking if it's the
> same vma (or the vma lock sequence counter overflows, but let's say
> that's a statistically insignificant non-zero value).
>
> >
> > For file vmas, how much code can we actually remove, given that
> > the first page fault might already be holding mmap_lock?
>
> How much complexity can we remove and maintain the performance, might be
> a better question.

Right, thanks for improving the question.

>
> > It could be the case that lock_vma_under_rcu() fails, and then
> > on the first page fault we end up holding mmap_lock before
> > retrying. So are we also going to rip out the lock release,
> > even if it risks holding mmap_lock for a long time?
> >
> >         vma =3D lock_vma_under_rcu(mm, addr);
> >         if (!vma)
> >                 goto lock_mmap;
> >        ...
> > lock_mmap:
> >
> >         vma =3D lock_mm_and_find_vma(mm, addr, regs);
> >         if (unlikely(!vma)) {
> >                 fault =3D 0;
> >                 si_code =3D SEGV_MAPERR;
> >                 goto bad_area;
> >         }
> >
> > If we still need to keep the page fault retry code there, it
> > doesn't seem like "ripping out" really reduces complexity in
> > the page fault code?
>
> This seems unrelated to be above complexity that might be the target of
> removal?

I think it is highly related. If we take approach 2=E2=80=94holding locks t=
o
perform I/O and removing the page-fault retry path=E2=80=94we need to
consider whether the same behavior should also apply when we are
already holding the mmap_lock. We should understand the full picture
before focusing on a specific part in isolation.

Thanks
Barry
