Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15E37B019
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311674; cv=none; b=BQFaYYnolSsJzmaVo567Q2M0EOKFGeTgGImj09TrpKrllGJCy5eOmOcd74we+lk5OlGuKJtHtK+KY5ZqIspEyVw00alQZmpQizSYenXq9zDV2wdGcKepHT/6n8je6O1Zi88eNnGy3Mi1qAeWiQtQHj2kb2LPyUlecJZcNjS0sx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311674; c=relaxed/simple;
	bh=iB0L71j0MytHCE7YgXvjDdRBULWmjJiczlxkTOrN2Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXfGxrEagtF+/Dly6RnvJiIHdBccQqPudSB8TfN6rSsALuyJBgBDZGEp9eAGx3IHt5CpOWBjG1Cg5ZvMEPq4HlZN73tT3U5czUYOt5aCZSCcq9se9r3RqGP19723er38M7Ulm8r7GbQDXrooTVMbavRpoV1xpRV7PyFPVvq3qC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK/SOOl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK/SOOl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963931F000E9
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779311673;
	bh=1rF6qiFpXobWU7JpkXbQs61u2QeAi7J+W2nUaLHy7Vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HK/SOOl8prV9nDfcU4qR27QfrnPfAvRTe04dADtuUvM/vASUzu7erWdJn65vHYk4W
	 bMjAyFw8jd0koqYYTqCWL5jLHS8XcZFVM+/LyEnGwj77SGWYvRR04rXQOmGrntAgcn
	 0P/iTap4ezpBnCuekLA0xkC6MDE6oDtTMC7MLcKWd/AHmn0N/aeOu750e/e/80nhol
	 UKg7K7q6AP+27tw/U71YnXT8I1+gEP1D3flmj1O9i3F0KUf5DZiwCbVzoonnS4SGIV
	 gpLlyKaLa63QwhGox5IAoKUkCp0H+ALsCmUihp3rverakPWUN/meBF+cjvZIYH/FPp
	 NFKqXA8ZQ8jVw==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-913cc4d7c71so541601685a.2
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 14:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/iRF/FL/UOc6kXuyt8jeNIndIrzJJ+mJUmQBqBEVtaM4TyozJ+fPTcWDXsnGiZ5GVNfLpLZuqwYFR8@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYTAFVFDTjtMd1w4NbrvCkim3Vz8AQsgdbKC9b6TbN5d2GV3p
	zcnbRw6BhsEAL6QuERrHnEEiAXvGIenutjvOlHiZvpv6X114kerlT6x0X+6SGAvuzo5S6p/KU5f
	cZcEIJYlEQg47t3na6Zm8qDYiQv4wbh4=
X-Received: by 2002:a05:620a:4083:b0:911:1a2c:f953 with SMTP id
 af79cd13be357-911cd75d3e6mr3875314385a.20.1779311672425; Wed, 20 May 2026
 14:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com> <ag4h87CBd-gph9zX@casper.infradead.org>
In-Reply-To: <ag4h87CBd-gph9zX@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 21 May 2026 05:14:20 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ipz6n3Spqx2zj00QGF2vF70GrKqLnsMaayM8MuFibnvRKE25oqOs1hwAE
Message-ID: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:05=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, May 20, 2026 at 06:01:56AM +0800, Barry Song wrote:
> > > implied is that the per-vma locking may stall mmap_lock writes for
> > > longer than if the mmap_lock was taken in read mode?  Barry, is that
> > > correct?
> >
> > Not the case =E2=80=94 the actual situation is (if we modify the
> > current kernel to perform I/O without releasing VMA read locks):
> >
> > thread 1 PF: lock vma1 read ----  IO ----- ;
> > thread 2 PF: lock vma2 read ----- IO ----- ;
> > thread 3 PF:  lock vma3 read ---- IO ----- ;
> > thread 4 fork:  mmap_lock_write ---- lock vma1, vma2, vma3 write ;
> > thread 5 :  take mmap_lock for any read/write reason
> >
> > Now you can see that thread 4 has to wait for the I/O of
> > VMA1, VMA2, and VMA3 to complete, and thread 5 then has to
> > wait for thread 4 to release mmap_lock. Both thread 4 and
> > thread 5 can become extremely slow, because I/O may be stuck
> > anywhere in the bio/request queue or filesystem GC.
> >
> > So now we have two choices:
> >
> > 1. Change fork() to avoid taking the vma write lock for vma1/2/3 where =
possible;
> > 2. Keep the current kernel behavior and drop the VMA lock before I/O:
>
> Option 3: Say that this is a very silly thing to optimise for.  I have a
> hard time believing that any application will care about the latency of
> fork(), or the latency of page faults while it's in the middle of fork().
> Multithreaded applications just don't fork that often!

My understanding is that we should not blame applications here. This is 202=
6:
there are basically only two kinds of applications =E2=80=94 single-threade=
d and
multi-threaded =E2=80=94 and single-threaded applications are nearly extinc=
t.
