Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93A35CB7B
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225547; cv=none; b=ani49FDPs98KUXKKS2pB2UB9RyfqhD731SBNAw5ZnZLePSnL8hN4Cxi04vq5hsgO3awYEYG/gvfOoHNSc4kG+byxFAr86b4qHlkDXzebes9UkgvlgHCuojMjlMKxA83zRQe6tFfRlhsVo1bqBErjg9gOAnz4LF19WAWaRKa40C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225547; c=relaxed/simple;
	bh=smo6PG71gks5CdB+S9N8OQcbl9Tnm001jvZXKeMS2ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDPWx5KsuimMqgMni9DBDh2GFTuTtZ95soKX8Pt2BtVO+OZ3H8OAZgBg7Jc0tPhBAMdQuEzV5GU6K6AZ6fkq9Uau8/WRuS3lmLiW1Kz4zaLHZnMQ0mWxOIWosIFO5AAK2mQRmNnjrGKVzQQWltSTVEmj9f00bbT//wYis9Aq4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuJhnnCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuJhnnCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67121F0089C
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225545;
	bh=smo6PG71gks5CdB+S9N8OQcbl9Tnm001jvZXKeMS2ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IuJhnnCs9B9YmsKmO6m3+Qhj4z5T6+OeMhTdQehdO4b+N2yxZ83/r9ANCYX0Tb1gw
	 DMyMD1bSvprYJ53QJhpWIZp0zflRYn3U8y52c/3W7wyU+vTXkGSvxapMxD8ZMFoVrc
	 j81p9X/NkxkhnK4vwIaVlAOuf+pLyT9aF9yygdR/2/hANkFwQFOFO4wDZEIidDDq9R
	 uA6CZqNER3t3OhIApelv4GoVAkcKHuoy9ZaUjDwUGarkWsSPmhbSSWSXLZP+neWk8q
	 Uc/3dypd996tr7HIMcfSCcSuCTMwIefm47+tzU4EQvXFpy6MvKpcLMGnWevG8Go+EQ
	 PuMTrRLgsb6EQ==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d7c12e48eso44234301cf.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:19:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9uOTZZg5iQqK0q+42oZy1Z/RVj68fI4tYcj5JS1NxCTJ85PgpQaURT94ajUj4mg6ttLoiqoxuRpoxs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7tp+lRpWUq80aFkGvF3nGXPYqUFqAwd/C1CGFX0helOy3w7w
	OW+0DpZIGcRg5uFjuWKeE6TpQ9ECGtCdHJYBRqW0X50VSRezQKk5AjtqYQA4sT5JCEDn3oE9iQn
	WjLGigKZcP8C9NBpFFCkdgDb8UCKFidw=
X-Received: by 2002:a05:622a:8599:b0:50e:32cd:52fa with SMTP id
 d75a77b69052e-5164155aed1mr241957021cf.3.1779225544934; Tue, 19 May 2026
 14:19:04 -0700 (PDT)
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
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com> <agxbq1TxJdniMQT3@lucifer>
In-Reply-To: <agxbq1TxJdniMQT3@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Wed, 20 May 2026 05:18:52 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
X-Gm-Features: AVHnY4J8Vo_CuCIfUx0l4iAJBGF2Iz4ZMOGZd3FV7sXmKyNFMh0JMXgCJ8QhKkw
Message-ID: <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
>
> > >
> > > I think we either need to fix `fork()`, or keep the current
> > > behavior of dropping the VMA lock before performing I/O.
> >
> > I see. So, this problem arises from the fact that we are changing the
> > pagefaults requiring I/O operation to hold VMA lock...
> > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > any VMA modification. On the surface, that looks ok to me but I might
> > be missing some corner cases. If nobody sees any obvious issues, I
> > think it's worth a try.
>
> Not sure if you noticed but I did raise concerns ;)
>
> I wonder if you've confused the fault path and fork here, as I think Barr=
y has
> been a little unclear on that.

I think I=E2=80=99ve been absolutely clear :-)
We should either stick to the current behavior - drop
the VMA lock before doing I/O, or change fork() so that it
does not wait on vma_start_write().

Before per-VMA locks, page faults dropped mmap_lock before
doing I/O. After per-VMA locks, page faults dropped the
VMA lock before doing I/O. In both cases, fork() would not
wait for I/O in the page-fault path.

Now you guys are suggesting performing I/O while holding
the VMA lock, which means fork() must wait for that I/O to
complete. Since an application can have more than 1000
VMAs, and I/O can be stalled for an unpredictable amount
of time in the bio/request queue or filesystem GC, fork()
could end up blocked on multiple VMAs while taking
vma_start_write() for each of them.

As a result, fork() could hold mmap_lock for a very, very,
very long time. fork() itself would become extremely slow,
and any other task needing mmap_lock would also be blocked
behind it.

>
> What's being suggested in this thread is to fundamentally change fork beh=
aviour
> so it's different from the entire history of the kernel (or - presumably =
- at
> least recent history :) and permit concurrent page faults to occur on a f=
orking
> process.
>
> I absolutely object to this for being pretty crazy. I mean I'm not sure w=
e
> really want to be simultaneously modifying page tables while invoking
> copy_page_range()? No?

If you object to touching fork(), can you at least accept
keeping the existing behavior of dropping the VMA lock
before doing I/O? If you object to both approaches, then I
really do not know how we can continue :-)

Thanks
Barry
